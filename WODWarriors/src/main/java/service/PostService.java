package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.PostUserVO;
import vo.PostVO;

@Service
public class PostService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<PostVO> getAllPosts() {
		String sql = "SELECT * FROM POSTS";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PostVO.class));
	}

	public PostVO selectOnePost(int postIdx) {
		String sql = "SELECT * FROM POSTS WHERE idx = ?";
		PostVO post = jdbcTemplate.queryForObject(sql, new Object[]{postIdx}, new BeanPropertyRowMapper<>(PostVO.class));
		return post;
	}

	public PostUserVO selectOnePostWithUserInfo(int postIdx) {
		String sql = "SELECT " +
				"    p.idx AS postIdx, " +
				"    p.startdate AS startDate, " +
				"    p.starttime AS startTime, " +
				"    p.title AS title, " +
				"    p.location AS location, " +
				"    p.recruitment AS recruitment, " +
				"    p.description AS description, " +
				"    p.regdate AS regDate, " +
				"    p.user_idx AS userIdx, " +
				"    p.ispast AS isPast, " +
				"    p.exercise_option_id AS exerciseOptionId, " +
				"    u.name AS userName, " +
				"    u.email AS userEmail " +
				"FROM " +
				"    posts p " +
				"JOIN " +
				"    users u ON p.user_idx = u.idx " +
				"WHERE " +
				"    p.idx = ?";

		return jdbcTemplate.queryForObject(sql, new Object[]{postIdx}, new BeanPropertyRowMapper<>(PostUserVO.class));
	}

	public int createPost(PostVO post, int userIdx, String exercise, String exerciseOption) {
		String find_option_id = "SELECT option_id FROM exercise_options WHERE exercise_type = ? AND option_value = ?";
		Integer option_id = jdbcTemplate.queryForObject(find_option_id, new Object[]{exercise, exerciseOption}, Integer.class);

		String sql = "INSERT INTO posts (idx, startdate, starttime, title, location, recruitment, description, regdate, user_idx, ispast, exercise_option_id) "
				+ "VALUES (SEQ_POSTS_IDX.nextVal, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?)";

		jdbcTemplate.update(sql, post.getStartdate(), 
				post.getStarttime(), 
				post.getTitle(), 
				post.getLocation(), 
				post.getRecruitment(), 
				post.getDescription(),
				userIdx,
				post.getIsPast(),
				option_id);

		String selectNewPostIdxSql = "SELECT SEQ_POSTS_IDX.currval FROM dual";
		return jdbcTemplate.queryForObject(selectNewPostIdxSql, Integer.class);
	}

	public boolean updatePost(PostVO post, int userIdx, String exercise, String exerciseOption) {
        String find_option_id = "SELECT option_id FROM exercise_options WHERE exercise_type = ? AND option_value = ?";
        Integer option_id = jdbcTemplate.queryForObject(find_option_id, new Object[]{exercise, exerciseOption}, Integer.class);

        String sql = "UPDATE posts SET startdate = ?, starttime = ?, title = ?, location = ?, recruitment = ?, description = ?, ispast = ?, exercise_option_id = ? WHERE idx = ? AND user_idx = ?";
        return jdbcTemplate.update(sql, post.getStartdate(), 
                post.getStarttime(), 
                post.getTitle(), 
                post.getLocation(), 
                post.getRecruitment(), 
                post.getDescription(),
                post.getIsPast(),
                option_id,
                post.getIdx(),
                userIdx) > 0;
    }
	
    public boolean deletePost(int postIdx, int userIdx) {
        try {
            // recruitments 테이블에서 post_idx가 일치하는 모든 행을 삭제
            String deleteRecruitmentSql = "DELETE FROM recruitments WHERE post_idx = ?";
            int deletedRecruitments = jdbcTemplate.update(deleteRecruitmentSql, postIdx);
            
            // posts 테이블에서 post_idx와 user_idx가 일치하는 행을 삭제
            String deletePostSql = "DELETE FROM posts WHERE idx = ? AND user_idx = ?";
            int deletedPosts = jdbcTemplate.update(deletePostSql, postIdx, userIdx);

            return deletedRecruitments > 0 && deletedPosts > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	public int getUserIdByEmail(String email) {
		String sql = "SELECT idx FROM USERS WHERE email = ?";
		return jdbcTemplate.queryForObject(sql, new Object[]{email}, Integer.class);
	}

	public void updatePastStatus() {
		List<PostVO> posts = getAllPosts();
		List<Object[]> batchUpdateArgs = new ArrayList<Object[]>();

		for (PostVO post : posts) {
			int isPast = post.isStartDateTimeInThePast();
			if (post.getIsPast() != isPast) {
				post.setIsPast(isPast);
				batchUpdateArgs.add(new Object[]{post.getIsPast(), post.getIdx()});
			}
		}

		jdbcTemplate.batchUpdate("UPDATE POSTS SET isPast = ? WHERE idx = ?", batchUpdateArgs);
	}

}











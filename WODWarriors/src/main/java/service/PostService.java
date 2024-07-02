package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.PostVO;

@Service
public class PostService {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<PostVO> getAllPosts() {
        String sql = "SELECT * FROM POSTS";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PostVO.class));
    }

    public boolean createPost(PostVO post, int userIdx, String exercise, String exerciseOption) {
    	String find_option_id = "SELECT option_id FROM exercise_options WHERE exercise_type = ? AND option_value = ?";
    	Integer option_id = jdbcTemplate.queryForObject(find_option_id, new Object[]{exercise, exerciseOption}, Integer.class);
    	
    	String sql = "INSERT INTO posts (idx, startdate, starttime, title, location, recruitment, description, regdate, user_idx, ispast, exercise_option_id) "
                + "VALUES (SEQ_POSTS_IDX.nextVal, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?)";
    	return jdbcTemplate.update(sql, post.getStartdate(), 
						                post.getStarttime(), 
						                post.getTitle(), 
						                post.getLocation(), 
						                post.getRecruitment(), 
						                post.getDescription(),
						                userIdx,
						                post.getIsPast(),
						                option_id) > 0;
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











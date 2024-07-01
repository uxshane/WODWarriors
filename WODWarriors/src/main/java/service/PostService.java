package service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.NoticeVO;
import vo.PostVO;

@Service
public class PostService {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<PostVO> getAllPosts() {
        String sql = "SELECT * FROM POSTS";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PostVO.class));
    }

    public boolean createPost(PostVO post, int userIdx) {
    	String sql = "INSERT INTO posts (idx, startdate, starttime, title, location, recruitment, description, regdate, user_idx) "
    				+ "VALUES (SEQ_POSTS_IDX.nextVal, ?, ?, ?, ?, ?, ?, sysdate, ?)";
        return jdbcTemplate.update(sql, post.getStartdate(), 
        								post.getStarttime(), 
        								post.getTitle(), 
        								post.getLocation(), 
        								post.getRecruitment(), 
        								post.getDescription(),
        								userIdx) > 0;
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











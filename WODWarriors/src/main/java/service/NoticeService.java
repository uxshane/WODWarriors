package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.NoticeVO;

@Service
public class NoticeService {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<NoticeVO> getAllNotices() {
        String sql = "SELECT * FROM NOTICES";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(NoticeVO.class));
    }

    public void saveNotice(NoticeVO notice) {
        String sql = "INSERT INTO NOTICES (id, title, content, date, user_id) VALUES (SEQ_NOTICES_IDX.NEXTVAL, ?, ?, sysdate, ?)";
        jdbcTemplate.update(sql, notice.getTitle(), notice.getContent(), notice.getUserId());
    }
    
    public int getUserIdByEmail(String email) {
        String sql = "SELECT idx FROM USERS WHERE email = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{email}, Integer.class);
    }
	
}

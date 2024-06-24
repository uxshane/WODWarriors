package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.UserVO;

@Service
public class UserService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int registerUser(UserVO user) {
		String sql = "INSERT INTO USERS (idx, name, email, password, isAdmin) "
				   + "VALUES (seq_users_idx.nextVal, ?, ?, ?, ?)";
		int res = jdbcTemplate.update(sql, user.getName(), user.getEmail(), 
										   user.getPassword(), user.getIsAdmin());
		return res;
	}
	
    public UserVO getUserByEmail(String email) {
        String sql = "SELECT * FROM USERS WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{email},
            								   new BeanPropertyRowMapper<>(UserVO.class));
        } catch (Exception e) {
            return null;
        }
    }
    
    
	
}














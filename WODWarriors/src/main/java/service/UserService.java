package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.UserVO;

@Service
public class UserService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int registerUser(UserVO user) {
		String sql = "INSERT INTO USERS (idx, name, email, password) "
				   + "VALUES (seq_user_idx.nextVal, ?, ?, ?)";
		int res = jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword());
		return res;
	}
	
}














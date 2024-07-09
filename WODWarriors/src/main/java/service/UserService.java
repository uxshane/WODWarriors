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

	public UserVO selectOneUser(int userIdx) {
		String sql = "SELECT * FROM USERS WHERE userIdx = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new Object[]{userIdx},
					new BeanPropertyRowMapper<>(UserVO.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int registerUser(UserVO user) {
		String sql = "INSERT INTO USERS (idx, name, email, password) "
				+ "VALUES (seq_user_idx.nextVal, ?, ?, ?)";
		int res = jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword());
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














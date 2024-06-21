package table;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class UserTable {
	
	@Autowired
	private JdbcTemplate jdbcTemplate; 
	
	public UserTable() {}
	
	@PostConstruct
	public void init() {
		if (!isUserTableExists()) {
			System.out.println("테이블이 존재하지 않음. 만드는중...");
			createUserTable();
		}
	}
	
	public boolean isUserTableExists() {
		String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'USERS'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
	}
	
	public void createUserTable() {
		String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_USERS_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence seq_USERS_idx");
    	}
    	
        String sql = "CREATE TABLE USERS ("
                + "idx NUMBER PRIMARY KEY, "
                + "name VARCHAR2(100), "
                + "email VARCHAR2(100), "
                + "password VARCHAR2(100))";
        jdbcTemplate.execute(sql);
	}
	
}


















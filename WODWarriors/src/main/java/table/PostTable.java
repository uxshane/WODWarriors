package table;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class PostTable {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@PostConstruct
	public void init() {
		if (!isPostTableExists()) {
			System.out.println("Posts테이블이 존재하지 않음. 만드는중...");
			createPostTable();
		}
	}
	
	public boolean isPostTableExists() {
		String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'POSTS'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
	}
	
	public void createPostTable() {
		String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_POSTS_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence SEQ_POSTS_IDX");
    	}
    	
    	String sql = "CREATE TABLE POSTS ("
    	        + "idx NUMBER PRIMARY KEY, "
    	        + "startdate VARCHAR2(50) NOT NULL, "
    	        + "starttime VARCHAR2(50) NOT NULL, "
    	        + "title VARCHAR2(255) NOT NULL, "
    	        + "location VARCHAR2(255) NOT NULL, "
    	        + "recruitment NUMBER NOT NULL, "
    	        + "description CLOB NOT NULL, "
    	        + "regdate DATE DEFAULT SYSDATE, "
    	        + "user_idx NUMBER NOT NULL, "
    	        + "isPast NUMBER(1) DEFAULT 0 NOT NULL, "
    	        + "EXERCISE_OPTION_ID NUMBER, "
    	        + "CONSTRAINT fk_user_id_posts FOREIGN KEY (user_idx) REFERENCES USERS(idx), "
    	        + "CONSTRAINT FK_EXERCISE_OPTION FOREIGN KEY (EXERCISE_OPTION_ID) REFERENCES EXERCISE_OPTIONS(OPTION_ID))";
        jdbcTemplate.execute(sql);
	}
	
}
package table;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class RecruitmentTable {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@PostConstruct
	public void init() {
		if (!isRecruitmentTableExists()) {
			System.out.println("Recruitments테이블이 존재하지 않음. 만드는중...");
			createRecruitmentTable();
		}
	}
	
	public boolean isRecruitmentTableExists() {
		String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'RECRUITMENTS'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
	}
	
	public void createRecruitmentTable() {
		String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_RECRUITMENTS_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence SEQ_RECRUITMENTS_IDX");
    	}
    	
    	String sql = "CREATE TABLE RECRUITMENTS ("
    	        + "idx NUMBER PRIMARY KEY, "
    	        + "post_idx NUMBER NOT NULL, "
    	        + "user_idx NUMBER NOT NULL, "
    	        + "join_user_idx NUMBER NOT NULL, "
    	        + "regdate DATE DEFAULT sysdate, "
    	        + "CONSTRAINT FK_POST_IDX FOREIGN KEY (post_idx) REFERENCES POSTS(idx))";
        jdbcTemplate.execute(sql);
	}
	
}

package table;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class NoticeTable {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@PostConstruct
	public void init() {
		if (!isNoticeTableExists()) {
			System.out.println("Notices테이블이 존재하지 않음. 만드는중...");
			createNoticeTable();
		}
	}
	
	public boolean isNoticeTableExists() {
		String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'NOTICES'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
	}
	
	public void createNoticeTable() {
		String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_NOTICES_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence SEQ_NOTICES_IDX");
    	}
    	
    	String sql = "CREATE TABLE NOTICES ("
    	        + "idx NUMBER PRIMARY KEY, "
    	        + "title VARCHAR2(255) NOT NULL, "
    	        + "content CLOB NOT NULL, "
    	        + "regdate DATE DEFAULT SYSDATE, "
    	        + "user_idx NUMBER NOT NULL, "
    	        + "CONSTRAINT fk_user_id_notices FOREIGN KEY (user_idx) REFERENCES USERS(idx))";
        jdbcTemplate.execute(sql);
	}
	
}

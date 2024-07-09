package table;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class Exercise_OptionsTable {
	
	List<Object[]> exercise_list;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@PostConstruct
	public void init() {
		if (!isExercise_OptionsTableExists()) {
			System.out.println("Exercise_options테이블이 존재하지 않음. 만드는중...");
			createExercise_OptionsTable();
			setExercise_list();
			System.out.println("만들기 성공!");
			insertDataIntoExercise_OptionsTable();
		}
	}
	
	public boolean isExercise_OptionsTableExists() {
		String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'EXERCISE_OPTIONS'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
	}
	
	public void createExercise_OptionsTable() {
		String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_EXERCISE_OPTIONS_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence SEQ_EXERCISE_OPTIONS_IDX");
    	}
    	
    	String sql = "CREATE TABLE EXERCISE_OPTIONS ("
    			   + "option_id NUMBER PRIMARY KEY, "
    			   + "EXERCISE_TYPE VARCHAR2(50) NOT NULL, "
    			   + "OPTION_VALUE VARCHAR2(100) NOT NULL, "
    			   + "OPTION_DESCRIPTION VARCHAR2(255))";
        jdbcTemplate.execute(sql);
	}
	
	public void setExercise_list() {
		exercise_list = new ArrayList<Object[]>();
		
		exercise_list.add(new String[]{"running", "5km", "5km 달리기"});
		exercise_list.add(new String[]{"running", "10km", "10km 달리기"});
		exercise_list.add(new String[]{"running", "15km", "15km 달리기"});
		exercise_list.add(new String[]{"bodybuilding", "upper", "상체 운동"});
		exercise_list.add(new String[]{"bodybuilding", "lower", "하체 운동"});
		exercise_list.add(new String[]{"yoga", "10", "10분 요가"});
		exercise_list.add(new String[]{"yoga", "30", "30분 요가"});
		exercise_list.add(new String[]{"yoga", "60", "60분 요가"});
		exercise_list.add(new String[]{"hiking", "easy", "쉬움"});
		exercise_list.add(new String[]{"hiking", "medium", "중간"});
		exercise_list.add(new String[]{"hiking", "hard", "어려움"});
	}
	
	private void insertDataIntoExercise_OptionsTable() {
    	String sql = "INSERT INTO EXERCISE_OPTIONS (option_id, EXERCISE_TYPE, OPTION_VALUE, OPTION_DESCRIPTION) VALUES "
    			   + "(SEQ_EXERCISE_OPTIONS_IDX.nextVal, ?, ?, ?)";
    	
    	jdbcTemplate.batchUpdate(sql, exercise_list);
    }
	
}
package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import vo.RecruitmentPostUserVO;
import vo.RecruitmentVO;

@Service
public class RecruitmentService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<RecruitmentPostUserVO> getRecruitmentPostUserJoinTable(int post_idx) {
		String sql = "SELECT " +
				"    r.idx AS recruitmentIdx, " +
				"    r.post_idx AS recruitmentPostIdx, " +
				"    r.user_idx AS recruitmentUserIdx, " +
				"    r.join_user_idx AS joinUserIdx, " +
				"    r.regdate AS recruitmentRegDate, " + // 추가된 필드
				"    p.idx AS postTableIdx, " +
				"    p.startdate AS startDate, " +
				"    p.starttime AS startTime, " +
				"    p.title AS title, " +
				"    p.location AS location, " +
				"    p.recruitment AS recruitment, " +
				"    p.description AS description, " +
				"    p.regdate AS postRegDate, " +
				"    p.user_idx AS postUserIdx, " +
				"    p.ispast AS isPast, " +
				"    p.exercise_option_id AS exerciseOptionId, " +
				"    u.name AS userName, " +
				"    u.email AS userEmail " +
				"FROM " +
				"    recruitments r " +
				"JOIN " +
				"    posts p ON r.post_idx = p.idx " +
				"JOIN " +
				"    users u ON r.join_user_idx = u.idx " +
				"WHERE " +
				"    r.post_idx = ?";

		return jdbcTemplate.query(sql, new Object[]{post_idx}, new BeanPropertyRowMapper<>(RecruitmentPostUserVO.class));
	}

	public boolean insertApplicant(int postIdx, int userIdx, int join_user_idx) {
		if (isApplicant(postIdx, join_user_idx)) {
	        return false; // 이미 신청한 경우 false 반환
	    }
		String sql = "INSERT INTO recruitments (idx, post_idx, user_idx, join_user_idx) VALUES (seq_recruitments_idx.nextVal, ?, ?, ?)";
		int result = jdbcTemplate.update(sql, postIdx, userIdx, join_user_idx);
		return result > 0;
	}
	
	public boolean deleteApplicant(int postIdx, int userIdx) {
		if (!isApplicant(postIdx, userIdx)) {
	        return false; // 이미 없는 경우 false 반환
	    }
		
        String sql = "DELETE FROM recruitments WHERE post_idx = ? AND join_user_idx = ?";
        int result = jdbcTemplate.update(sql, postIdx, userIdx);
        return result > 0;
    }

	//미사용
	public RecruitmentVO getAllApplicantsInSelectedPost(int post_idx) {
		String sql = "SELECT * FROM RECRUITMENTS WHERE post_idx = ?";
		return jdbcTemplate.queryForObject(sql, new Object[]{post_idx}, new BeanPropertyRowMapper<>(RecruitmentVO.class));
	}

	public int getApplicantCount(int post_idx) {
		String sql = "SELECT COUNT(*) FROM RECRUITMENTS WHERE post_idx = " + post_idx + "";
		int count = jdbcTemplate.queryForInt(sql);
		return count;
	}
	
	public boolean isApplicant(int postIdx, int userIdx) {
        String sql = "SELECT COUNT(*) FROM recruitments WHERE post_idx = ? AND join_user_idx = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{postIdx, userIdx}, Integer.class);
        return count != null && count > 0;
    }
	
	

}













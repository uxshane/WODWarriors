package vo;

import java.util.Date;

public class RecruitmentVO {

	private int idx, post_idx, user_idx, join_user_idx;
	private Date regdate;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getPost_idx() {
		return post_idx;
	}

	public void setPost_idx(int post_idx) {
		this.post_idx = post_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getJoin_user_idx() {
		return join_user_idx;
	}

	public void setJoin_user_idx(int join_user_idx) {
		this.join_user_idx = join_user_idx;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
}

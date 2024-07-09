package vo;

import java.util.Date;

public class NoticeVO {

	private int id;
	private String title;
	private String content;
	private Date regdate;
	private int userId;

	// 기본 생성자
	public NoticeVO() {
	}

	// 모든 필드를 포함한 생성자
	public NoticeVO(int id, String title, String content, Date regdate, int userId) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.userId = userId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
package vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class PostVO {
    private int idx;
    private String startdate;
    private String starttime;
    private String title;
    private String location;
    private int recruitment;
    private String description;
    private Date regdate;
    private int user_idx;
    private int isPast;
    private int exercise_option_id;

    // Getters and Setters
    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getRecruitment() {
        return recruitment;
    }

    public void setRecruitment(int recruitment) {
        this.recruitment = recruitment;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public int getUser_idx() {
        return user_idx;
    }

    public void setUser_idx(int user_idx) {
        this.user_idx = user_idx;
    }

	public int getIsPast() {
		return isPast;
	}

	public void setIsPast(int isPast) {
		this.isPast = isPast;
	}
	
	public int getExercise_option_id() {
		return exercise_option_id;
	}

	public void setExercise_option_id(int exercise_option_id) {
		this.exercise_option_id = exercise_option_id;
	}

	// 현재 시간과 startdate 및 starttime 비교 메서드
    public int isStartDateTimeInThePast() {
        LocalDate date = LocalDate.parse(startdate, DateTimeFormatter.ISO_LOCAL_DATE);
        LocalTime time = LocalTime.parse(starttime, DateTimeFormatter.ISO_LOCAL_TIME);
        LocalDateTime startDateTime = LocalDateTime.of(date, time);

        // 현재 한국 시간을 가져옴
        ZonedDateTime nowInSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
        LocalDateTime now = nowInSeoul.toLocalDateTime();

        return startDateTime.isBefore(now) ? 1 : 0;
    }
    
}














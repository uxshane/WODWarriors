package vo;

import java.util.Date;

public class PostUserVO {
    // Post table columns
    private int postIdx;
    private String startDate;
    private String startTime;
    private String title;
    private String location;
    private int recruitment;
    private String description;
    private Date regDate;
    private int userIdx;
    private int isPast;
    private int exerciseOptionId;

    // User table columns
    private String userName;
    private String userEmail;

    // Getters and Setters
    public int getPostIdx() {
        return postIdx;
    }

    public void setPostIdx(int postIdx) {
        this.postIdx = postIdx;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
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

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public int getUserIdx() {
        return userIdx;
    }

    public void setUserIdx(int userIdx) {
        this.userIdx = userIdx;
    }

    public int getIsPast() {
        return isPast;
    }

    public void setIsPast(int isPast) {
        this.isPast = isPast;
    }

    public int getExerciseOptionId() {
        return exerciseOptionId;
    }

    public void setExerciseOptionId(int exerciseOptionId) {
        this.exerciseOptionId = exerciseOptionId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}


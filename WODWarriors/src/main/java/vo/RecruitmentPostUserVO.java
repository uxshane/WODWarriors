package vo;

import java.util.Date;

public class RecruitmentPostUserVO {
    // Recruitment table columns
    private int recruitmentIdx;
    private int recruitmentPostIdx;
    private int recruitmentUserIdx;
    private int joinUserIdx;
    private Date recruitmentRegDate;  // 추가된 필드

    // Post table columns
    private String startDate;
    private String startTime;
    private String title;
    private String location;
    private int recruitment;
    private String description;
    private Date postRegDate;
    private int postUserIdx;
    private int isPast;
    private int exerciseOptionId;

    // User table columns
    private String userName;
    private String userEmail;

    // Getters and Setters

    public int getRecruitmentIdx() {
        return recruitmentIdx;
    }

    public void setRecruitmentIdx(int recruitmentIdx) {
        this.recruitmentIdx = recruitmentIdx;
    }

    public int getRecruitmentPostIdx() {
        return recruitmentPostIdx;
    }

    public void setRecruitmentPostIdx(int recruitmentPostIdx) {
        this.recruitmentPostIdx = recruitmentPostIdx;
    }

    public int getRecruitmentUserIdx() {
        return recruitmentUserIdx;
    }

    public void setRecruitmentUserIdx(int recruitmentUserIdx) {
        this.recruitmentUserIdx = recruitmentUserIdx;
    }

    public int getJoinUserIdx() {
        return joinUserIdx;
    }

    public void setJoinUserIdx(int joinUserIdx) {
        this.joinUserIdx = joinUserIdx;
    }

    public Date getRecruitmentRegDate() {
        return recruitmentRegDate;
    }

    public void setRecruitmentRegDate(Date recruitmentRegDate) {
        this.recruitmentRegDate = recruitmentRegDate;
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

    public Date getPostRegDate() {
        return postRegDate;
    }

    public void setPostRegDate(Date postRegDate) {
        this.postRegDate = postRegDate;
    }

    public int getPostUserIdx() {
        return postUserIdx;
    }

    public void setPostUserIdx(int postUserIdx) {
        this.postUserIdx = postUserIdx;
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

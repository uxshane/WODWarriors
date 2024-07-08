<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>번개 상세</title>
    <style>
        body {
            background-color: #FFFFFF;
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 20px;
            padding: 20px;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header img {
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }
        .header-title {
            font-size: 24px;
            font-weight: bold;
        }
        .header button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .header .exit-button {
            background-color: #FF0000;
        }
        .content {
            margin-top: 20px;
        }
        .content-item {
            margin: 10px 0;
            display: flex;
            align-items: center;
        }
        .content-item img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .content-title {
            font-size: 20px;
            font-weight: bold;
            margin-top: 10px;
        }
        .applicant-list {
            margin-top: 20px;
        }
        .applicant-list-item {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .applicant-list-item img {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .applicant-name {
            font-size: 16px;
        }
        .applicant-tag {
            background-color: #000;
            color: white;
            padding: 2px 5px;
            border-radius: 3px;
            margin-left: 5px;
        }
    </style>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
    
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            history.pushState(null, null, location.href);

            window.addEventListener('popstate', (event) => {
                location.href = 'testmap.do';
            });
        });
    </script>
</head>

<body>
    <div class="container">
        <div class="header">
            <div style="display: flex; align-items: center;">
                <div class="header-title">번개 상세</div>
            </div>
            <c:choose>
                <c:when test="${isApplicant}">
                    <form action="leave_activity.do" method="post">
                        <input type="hidden" name="postIdx" value="${postUser.postIdx}">
                        <button type="submit" class="exit-button">나가기</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form action="join_activity.do" method="post">
                        <input type="hidden" name="postIdx" value="${postUser.postIdx}">
                        <button type="submit">참여하기</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="content">
            <div class="content-title">${postUser.title}</div>
            <div class="content-item">
                <img src="resources/images/clock.png" alt="Time">
                <span>${postUser.startDate} ${postUser.startTime}</span>
            </div>
            <div class="content-item">
                <img src="resources/images/marker.png" alt="Location">
                <span>${postUser.location}</span>
            </div>
            <div class="content-item">
                <img src="resources/images/people.png" alt="People">
                <span>
                    <c:if test="${not empty join_users}">${ join_users.size() }</c:if>
                    <c:if test="${empty join_users}">0</c:if>
                    / ${postUser.recruitment}
                </span>
            </div>
            <div class="content-item">
                <img src="resources/images/person.png" alt="User">
                <span>${postUser.userName}</span>
            </div>
            <div class="content-item">
                <span>${postUser.description}</span>
            </div>
        </div>
        <div class="applicant-list">
            <h3>신청자 목록</h3>
            <c:if test="${not empty join_users}">
                <c:forEach var="user" items="${join_users}">
                    <div class="applicant-list-item">
                        <img src="resources/images/user.png" alt="Applicant">
                        <span class="applicant-name">${user.userName}</span>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty join_users}">
                아직 신청자가 없습니다
            </c:if>
        </div>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동 모두보기</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f5f7fa;
    font-family: 'Roboto', sans-serif;
}

.container {
    background-color: #fff;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    width: 100%;
    text-align: center;
    position: relative;
}

h1, h2 {
    margin: 20px 0;
    font-weight: 700;
    color: #333;
}

.post-board-container {
    width: 100%;
    max-height: 500px;
    overflow-y: auto;
    padding: 20px;
    border-radius: 10px;
    background-color: #f9f9f9;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.post-board-container::-webkit-scrollbar { 
    display: none;  /* Chrome, Safari, Opera */
}

.post {
    border: 2px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    margin: 20px 0;
    cursor: pointer;
    background-color: #e0f7fa;
    transition: transform 0.3s, background-color 0.3s;
}

.post.user-post {
    background-color: #ffecb3;
}

.post:hover {
    transform: translateY(-5px);
    background-color: #d0f4f7;
}

.post h3 {
    margin: 0 0 10px;
    font-size: 24px;
}

.post p {
    margin: 10px 0 0;
    font-size: 16px;
}

.post small {
    display: block;
    margin-top: 10px;
    color: #666;
}

.logout-button {
    position: absolute;
    top: 20px;
    right: 20px;
    background-color: #ff4d4d;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.logout-button:hover {
    background-color: #e60000;
}
</style>

<script>
function navigateToPostDetail(postIdx) {
    var url = 'post_detail.do?postIdx=' + postIdx;
    window.location.href = url;
}
</script>

</head>

<body>
    <div class="container">
        <h1>WOD Warriors</h1>

        <h2>운동 모두보기</h2>

        <div class="post-board-container">
            <div class="post-board">
                <c:forEach var="post" items="${posts}">
                <c:if test="${ userIdx == post.user_idx }">
                    <div class="post user-post" onclick="navigateToPostDetail(${post.idx})">
                        <h3>${post.title}</h3>
                        <p>${post.description}</p>
                        <p><small>위치 : ${post.location}</small></p>
                        <small>${post.startdate} / ${post.starttime}</small>
                    </div>
                </c:if>
                <c:if test="${ userIdx != post.user_idx }">
                    <div class="post" onclick="navigateToPostDetail(${post.idx})">
                        <h3>${post.title}</h3>
                        <p>${post.description}</p>
                        <p><small>위치 : ${post.location}</small></p>
                        <small>${post.startdate} / ${post.starttime}</small>
                    </div>
                </c:if>
                </c:forEach>
            </div>
        </div>

        <c:if test="${not empty sessionScope.loggedInUser}">
            <button class="logout-button"
                onclick="location.href='<c:url value='/logout.do'/>'">Logout</button>
        </c:if>
        <div class="footer-container">
            <jsp:include page="footer.jsp"/>
        </div>
    </div>
</body>
</html>

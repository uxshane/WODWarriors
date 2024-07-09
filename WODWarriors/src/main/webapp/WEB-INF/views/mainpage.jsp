<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/style.css'/>">

<style>
.fixed-button {
	position: fixed;
	bottom: 250px;
	right: 600px;
	background-color: #00aaff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 50%;
	font-size: 24px;
	cursor: pointer;
	z-index: 1000;
}

.icon-container {
	display: flex;
	justify-content: space-around;
	margin: 20px;
}

.icon {
	font-size: 40px;
	cursor: pointer;
}

.icon.active {
	color: skyblue;
}

.icon-bar {
	display: flex;
	justify-content: space-around;
	margin-bottom: 20px;
}

.icon-bar a img {
	width: 40px;
	height: 40px;
}

.notice-board {
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	margin-bottom: 20px;
}

.notice {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.notice h3 {
	margin: 0;
}

.notice p {
	margin: 10px 0 0;
}

.notice small {
	color: #999;
}
</style>

</head>

<body>
	<div class="container">
		<h1>WOD Warriors</h1>

		<h2>공지사항</h2>

		<div class="notice-board">
			<c:forEach var="notice" items="${notices}">
				<div class="notice">
					<h3>${notice.title}</h3>
					<p>${notice.content}</p>
					<small>${notice.date}</small>
				</div>
			</c:forEach>
		</div>

		<c:if test="${isAdmin}">
			<button class="fixed-button"
				onclick="location.href='/writeNotice.do'">+</button>
		</c:if>

		<jsp:include page="footer.jsp" />

		<c:if test="${not empty sessionScope.loggedInUser}">
			<button class="logout-button"
				onclick="location.href='<c:url value='/logout.do'/>'">Logout</button>
		</c:if>
	</div>

</body>
</html>
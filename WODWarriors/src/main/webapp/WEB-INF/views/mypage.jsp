<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<link rel="stylesheet" href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">

<style>
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f0f0f0;
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
}

h1, h2 {
    margin: 20px 0;
    font-weight: 700;
    color: #333;
}

.user-info {
    margin: 20px 0;
    text-align: left;
}

.user-info h3 {
    margin: 10px 0;
    font-size: 24px;
    color: #333;
}

.user-info p {
    margin: 5px 0;
    font-size: 16px;
    color: #666;
}

.logout-button {
    margin-top: 20px;
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
</head>

<body>
    <div class="container">
        <h1>마이페이지</h1>
        <div class="user-info">
            <h3>사용자 정보</h3>
            <p><strong>이름 : </strong> ${user.name}</p>
            <p><strong>이메일 : </strong> ${user.email}</p>
            <p><strong>관리자 유/무 : </strong> ${user.isAdmin}</p>
        </div>
        <button class="logout-button" onclick="location.href='<c:url value='/logout.do'/>'">Logout</button>
        
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</body>
</html>

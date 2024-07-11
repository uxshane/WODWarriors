<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

.icon-bar {
    display: flex;
    justify-content: center;
    background-color: #fff;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
}

.icon {
    font-size: 40px;
    cursor: pointer;
    margin: 0 20px;
    color: #888;
    transition: color 0.3s ease;
}

.icon.active,
.icon:hover {
    color: #007bff;
}

.fixed-button {
    position: fixed;
    bottom: 90px;
    right: 50px;
    background-color: #00aaff;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 50%;
    font-size: 24px;
    cursor: pointer;
    z-index: 1000;
    transition: background-color 0.3s ease;
}

.fixed-button:hover {
    background-color: #007bff;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var icons = document.querySelectorAll('.icon');
    icons.forEach(function(icon) {
        icon.addEventListener('click', function() {
            icons.forEach(function(i) {
                i.classList.remove('active');
            });
            icon.classList.add('active');
        });
    });
});

function checkLoginAndRedirect(url) {
    var isLoggedIn = ${not empty sessionScope.loggedInUser};
    if (isLoggedIn) {
        location.href = url;
    } else {
        alert("로그인이 필요합니다.");
        location.href = "<c:url value='/login.do'/>";
    }
}
</script>

</head>
<body>
<div class="icon-bar">
    <div class="icon" onclick="location.href='<c:url value='/main.do'/>'">
        <i class='bx bx-home'></i>
    </div>
    <div class="icon" onclick="checkLoginAndRedirect('<c:url value='/register_lightning.do'/>')">
        <i class='bx bx-calendar'></i>
    </div>
    <div class="icon" onclick="location.href='<c:url value='/testmap.do'/>'">
        <i class='bx bx-group'></i>
    </div>
    <div class="icon" onclick="location.href='<c:url value='/settings.do'/>'">
        <i class='bx bx-cog'></i>
    </div>
</div>

</body>
</html>

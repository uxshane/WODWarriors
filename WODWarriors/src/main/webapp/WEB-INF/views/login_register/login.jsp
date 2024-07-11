<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
    max-width: 400px;
    width: 100%;
    text-align: center;
}

h2 {
    margin-bottom: 30px;
    font-size: 28px;
    color: #333;
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin: 10px 0 5px;
    font-size: 14px;
    color: #555;
    text-align: left;
}

input {
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

button {
    padding: 12px;
    border: none;
    border-radius: 5px;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #0056b3;
}

.links {
    margin-top: 20px;
}

.links a {
    display: block;
    margin: 5px 0;
    padding: 10px;
    border-radius: 5px;
    text-decoration: none;
    color: #007bff;
    transition: background-color 0.3s ease;
}

.links a:hover {
    background-color: #f0f0f0;
}

.error-message {
    color: red;
    margin-top: 10px;
}
</style>

<script>
function login(f) {
    const email = f.email;
    const password = f.password;

    if (!email.value.includes('@')) {
        email.setCustomValidity("유효한 이메일 주소를 입력하세요.");
        email.reportValidity();
        return false;
    } else {
        email.setCustomValidity("");
    }

    if (password.value.length < 6) {
        password.setCustomValidity("비밀번호는 6자 이상이어야 합니다.");
        password.reportValidity();
        return false;
    } else {
        password.setCustomValidity("");
    }

    f.action = "verify_login.do";
    f.method = "post";
    f.submit();
}
</script>

</head>
<body>
<div class="container">
    <h2>로그인</h2>
    <form action="<c:url value='/login'/>" method="post">
        <label for="email">이메일</label>
        <c:if test="${not empty email}">
            <input type="email" id="email" name="email" value="${ email }" required>
        </c:if>
        <c:if test="${empty email}">
            <input type="email" id="email" name="email" required>
        </c:if>

        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <button type="button" onclick="login(this.form)">이메일 로그인</button>
    </form>
    <div class="links">
        <a href="<c:url value='/find_password.do'/>">비밀번호를 잃어버리셨나요?</a>
        <p>아직 계정이 없으신가요?</p>
        <a href="<c:url value='/register.do'/>">이메일로 가입하기</a>
        <a href="<c:url value='/main.do'/>">메인으로 가기</a>
    </div>
</div>
</body>
</html>

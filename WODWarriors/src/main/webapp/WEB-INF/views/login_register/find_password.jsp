<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
    margin-bottom: 20px;
    font-weight: 700;
    color: #333;
}

label {
    display: block;
    margin-bottom: 10px;
    font-weight: 500;
    color: #555;
}

input[type="email"] {
    width: calc(100% - 22px); /* 100% 너비에서 패딩 값과 보더 값을 뺌 */
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box; /* 너비 계산을 위한 속성 추가 */
}

button {
    width: 100%;
    padding: 10px;
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

.error-message {
    color: red;
    margin-top: 10px;
}

.success-message {
    color: green;
    margin-top: 10px;
}

a {
    display: block;
    margin-top: 20px;
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
}

a:hover {
    text-decoration: underline;
}
</style>

<script>
    function send_email(f) {
        const email = f.email;

        if (!email.value.includes('@')) {
            email.setCustomValidity("유효한 이메일 주소를 입력하세요.");
            email.reportValidity();
            return false;
        } else {
            email.setCustomValidity("");
        }

        f.action = "/send_email_password.do";
        f.method = "post";
        f.submit();
    }
</script>
</head>
<body>
    <div class="container">
        <h2>비밀번호 찾기</h2>
        <form>
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required placeholder="이메일 주소를 입력해주세요.">
            <button type="button" onclick="send_email(this.form)">메일 보내기</button>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>
        </form>
        <a href="<c:url value='/login.do'/>">로그인하러 가기</a>
    </div>
</body>
</html>

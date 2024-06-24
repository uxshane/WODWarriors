<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
	    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
	    
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
                <div class="error-message" style="color: red; margin-top: 10px;">${error}</div>
            </c:if>

            <button type="button" onclick="login(this.form)">이메일 로그인</button>
        </form>
        <div class="links">
            <a href="<c:url value='/find_password.do'/>">비밀번호를 잃어버리셨나요?</a>
            <p>아직 계정이 없으신가요?</p>
            <a href="<c:url value='/register.do'/>">이메일로 가입하기</a>
            <a href="<c:url value='/main.do'/>">메인으로 가기</a>
        </div>
        <div class="social-login">
            <a href="#" class="btn-kakao">카카오 로그인</a>
            <a href="#" class="btn-apple">Apple 로그인</a>
        </div>
    </div>
	</body>
</html>






















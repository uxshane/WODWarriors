<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
		
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
	            //gitignore 파일 적용 테스트
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
					<div class="error-message" style="color: red; margin-top: 10px;">${error}</div>
				</c:if>
				<c:if test="${not empty message}">
					<div class="success-message" style="color: green; margin-top: 10px;">${message}</div>
				</c:if>
		</form>
			<a href="<c:url value='/login.do'/>">로그인하러 가기</a>
	    </div>
	</body>
</html>













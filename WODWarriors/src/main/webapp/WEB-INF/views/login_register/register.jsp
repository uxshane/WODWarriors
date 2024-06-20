<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
		
		<script>
			function register(f) {
				const email = f.email;
	            const password = f.password;
	            const name = f.name;
	            const agree = f.agree;

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

	            if (name.value.trim() === '') {
	                name.setCustomValidity("이름을 입력하세요.");
	                name.reportValidity();
	                return false;
	            } else {
	                name.setCustomValidity("");
	            }

	            if (!agree.checked) {
	                agree.setCustomValidity("개인정보보호방침에 동의해야 합니다.");
	                agree.reportValidity();
	                return false;
	            } else {
	                agree.setCustomValidity("");
	            }
				
	            f.action = "/login.do";
	            f.method = "get";
	            f.submit();
			}
			
		</script>
		
	</head>

	<body>
<body>
    <div class="container">
        <h2>회원가입</h2>
        <form action="<c:url value='/register'/>" method="post">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>

            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>

            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>

            <div class="checkbox">
                <input type="checkbox" id="agree" name="agree" required>
                <label for="agree">개인정보보호방침에 동의합니다</label>
            </div>

            <button type="button" onclick="register(this.form)">이메일 회원가입</button>
        </form>
        <div class="links">
            <p>이미 가입하셨나요?</p>
            <a href="<c:url value='/login.do'/>">로그인하러 가기</a>
            <a href="<c:url value='/main.do'/>">메인으로 가기</a>
        </div>
    </div>
	</body>
</html>
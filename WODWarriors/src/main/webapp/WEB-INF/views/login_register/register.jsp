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
	            const verificationCode = f.verificationCode;

	            if (!email.value.includes('@')) {
	                email.setCustomValidity("유효한 이메일 주소를 입력하세요.");
	                email.reportValidity();
	                return false;
	            } else {
	                email.setCustomValidity("");
	            }
	            
	            if (verificationCode && verificationCode.value.trim() === '') {
	                verificationMessage.style.display = "block";
	                return false;
	            } else {
	                verificationMessage.style.display = "none";
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
				
	            f.action = "register.do";
	            f.method = "post";
	            f.submit();
			}
			
			function sendVerificationCode() { // 추가된 부분
	            const email = document.getElementById("email").value;
	            if (!email.includes('@')) {
	                alert("유효한 이메일 주소를 입력하세요.");
	                return;
	            }

	            // AJAX 요청으로 인증코드 전송
	            const xhr = new XMLHttpRequest();
	            xhr.open("POST", "sendVerificationCode.do", true);
	            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	            xhr.onreadystatechange = function() {
	                if (xhr.readyState === 4 && xhr.status === 200) {
	                    alert("인증코드가 이메일로 전송되었습니다.");
	                    const verificationCodeField = document.getElementById("verificationCodeField");
	                    if (!verificationCodeField) {
	                        const emailField = document.getElementById("emailField");
	                        const newField = document.createElement("div");
	                        newField.id = "verificationCodeField";
	                        newField.innerHTML = `
	                            <label for="verificationCode">인증코드</label>
	                            <input type="text" id="verificationCode" name="verificationCode" required>
	                        `;
	                        emailField.parentNode.insertBefore(newField, emailField.nextSibling);
	                    }
	                }
	            };
	            xhr.send("email=" + encodeURIComponent(email));
	        }
			
		</script>
		
	</head>

	<body>
<body>
    <div class="container">
        <h2>회원가입</h2>
        <form action="<c:url value='/register'/>" method="post">
             <div id="emailField">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
                <button type="button" onclick="sendVerificationCode()">본인인증</button>
            </div>
            <div id="verificationMessage" style="color: red; display: none;">인증코드를 입력하세요.</div>

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
        
        <c:if test="${not empty error}">
            <div class="error-message" style="color: red; margin-top: 10px;">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="success-message" style="color: green; margin-top: 10px;">${message}</div>
            <script>
                setTimeout(function() {
                	var f = document.createElement("form");
                    f.method = "POST";
                    f.action = "login.do";

                    var emailField = document.createElement("input");
                    emailField.type = "hidden";
                    emailField.name = "email";
                    emailField.value = "${email}";
                    f.appendChild(emailField);

                    document.body.appendChild(f);
                    f.submit();
                }, 1000);
            </script>
        </c:if>
        
        <div class="links">
            <p>이미 가입하셨나요?</p>
            <a href="<c:url value='/login.do'/>">로그인하러 가기</a>
            <a href="<c:url value='/main.do'/>">메인으로 가기</a>
        </div>
    </div>
	</body>
</html>
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
	        function validateAndSubmit(f) {
	            const email = f.email;
	
	            if (!email.value.includes('@')) {
	                email.setCustomValidity("유효한 이메일 주소를 입력하세요.");
	                email.reportValidity();
	                return false;
	            } else {
	                email.setCustomValidity("");
	            }
	
	            f.action = "/find-password.do";
	            f.method = "post";
	            f.submit();
	            //gitignore 파일 적용 테스트
	        }
		</script>
	</head>
	<body>
	
	</body>
</html>
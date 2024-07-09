<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
		<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
		
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
				margin: 0 10px;
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
		</script>
		
		<script>
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
			<i class="fas fa-home"></i>
		</div>
		<div class="icon"
			onclick="checkLoginAndRedirect('<c:url value='/register_lightning.do'/>')">
			<i class="fas fa-calendar-alt"></i>
		</div>
		<div class="icon"
			onclick="location.href='<c:url value='/testmap.do'/>'">
			<i class="fas fa-users"></i>
		</div>
		<div class="icon"
			onclick="location.href='<c:url value='/settings.do'/>'">
			<i class="fas fa-cog"></i>
		</div>
	</div>
</body>
</html>
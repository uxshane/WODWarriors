<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
            
            .notice-board {
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            
            .notice {
                border-bottom: 1px solid #ddd;
                padding: 10px 0;
            }
            
            .notice h3 {
                margin: 0;
            }
            
            .notice p {
                margin: 10px 0 0;
            }
            
            .notice small {
                color: #999;
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

</head>
	
<body>
	<div class="container">
		<h1>WOD Warriors</h1>
		
		<div class="icon-bar">
			<div class="icon" onclick="location.href='<c:url value='/main.do'/>'"><i class="fas fa-home"></i></div>
            <div class="icon" onclick="location.href='<c:url value='/schedule.do'/>'"><i class="fas fa-calendar-alt"></i></div>
            <div class="icon" onclick="location.href='<c:url value='/friends.do'/>'"><i class="fas fa-users"></i></div>
            <div class="icon" onclick="location.href='<c:url value='/settings.do'/>'"><i class="fas fa-cog"></i></div>
		</div>
		
		<h2>공지사항</h2>
		
		<div class="notice-board">
			<c:forEach var="notice" items="${notices}">
				<div class="notice">
					<h3>${notice.title}</h3>
					<p>${notice.content}</p>
					<small>${notice.date}</small>
				</div>
			</c:forEach>
		</div>
		
		<c:if test="${isAdmin}">
			<button class="fixed-button" onclick="location.href='/writeNotice.do'">+</button>
		</c:if>
	</div>
</body>
</html>
























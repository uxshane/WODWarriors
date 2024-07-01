<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%-- <script src="<c:url value='/resources/js/httpRequest.js'/>"></script> --%>
    
    <!-- 날짜, 시간, 장소 선택을 도와주는 jquery를 이용한 함수들 -->
    <script src="resources/js/datetime.js"></script>
    
    <script>
	    function validateForm(f) {
	        var dateInput = document.getElementById('date');
	        var timeInput = document.getElementById('time');
	        var titleInput = document.getElementById('title');
	        var locationInput = document.getElementById('location');
	        var recruitmentInput = document.getElementById('recruitment');
	        var descriptionInput = document.getElementById('description');
	
	        // 날짜 유효성 검사
	        if (dateInput.value == '') {
	            dateInput.setCustomValidity('날짜를 입력해주세요.');
	            dateInput.reportValidity();
	            return false;
	        } else {
	            dateInput.setCustomValidity('');
	        }
	
	        // 시간 유효성 검사
	        if (timeInput.value == '') {
	            timeInput.setCustomValidity('시간을 입력해주세요.');
	            timeInput.reportValidity();
	            return false;
	        } else {
	            timeInput.setCustomValidity('');
	        }
	
	        // 제목 유효성 검사
	        if (titleInput.value == '') {
	            titleInput.setCustomValidity('제목을 입력해주세요.');
	            titleInput.reportValidity();
	            return false;
	        } else {
	            titleInput.setCustomValidity('');
	        }
	
	        // 장소 유효성 검사
	        if (locationInput.value == '') {
	            locationInput.setCustomValidity('장소를 입력해주세요.');
	            locationInput.reportValidity();
	            return false;
	        } else {
	            locationInput.setCustomValidity('');
	        }
	
	        // 모집인원 유효성 검사
	        if (recruitmentInput.value == '' || recruitmentInput.value <= 0) {
	            recruitmentInput.setCustomValidity('모집인원을 올바르게 입력해주세요.');
	            recruitmentInput.reportValidity();
	            return false;
	        } else {
	            recruitmentInput.setCustomValidity('');
	        }
	
	        // 설명 유효성 검사
	        if (descriptionInput.value == '') {
	            descriptionInput.setCustomValidity('설명을 입력해주세요.');
	            descriptionInput.reportValidity();
	            return false;
	        } else {
	            descriptionInput.setCustomValidity('');
	        }
	
	        // AJAX 요청을 통해 데이터 전송
	        var params = {
		        startdate: dateInput.value,
		        starttime: timeInput.value,
		        title: titleInput.value,
		        location: locationInput.value,
		        recruitment: recruitment.value,
		        description: descriptionInput.value
    		};
	        
	        fetch("createPost.do", {
	        	method: "POST",
	        	headers: {'Content-Type': 'application/x-www-form-urlencoded'},
	        	body: new URLSearchParams(params).toString()
	        })
	        .then(response => {
	        	return response.json();
	        })
	        .then(data => {
	        	handleResponse(data);
	        })
	        .catch(error => {
	        	console.error('There has been a problem with your fetch operation:', error);
	        });
	        
	    }
	    
	    function handleResponse(response) {
	    	console.log(response);
	    	var messageDiv = document.getElementById('message');
	        if (response.status === 'success') {
	            messageDiv.innerHTML = "<div class='message success'>"+response.message+"</div>";
	            setTimeout(function() {
	                window.location.href = "testmap.do";
	            }, 1000);
	        } else {
	            messageDiv.innerHTML = "<div class='message error'>"+response.error+"</div>";
	            setTimeout(function() {
	                window.location.href = "register_lightning.do";
	            }, 1000);
	        }
	    }

    </script>
  
     <style>
        .datetime-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .datetime-container input {
            width: 48%;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
    
</head>
<body>
    <div class="container">
        <h2>운동번개 등록</h2>
        <div id="message"></div>
        <form>
            <div class="datetime-container">
                <div>
                    <label for="date">일정 (날짜)</label>
                    <input type="text" id="date" name="date" required>
                </div>
                <div>
                    <label for="time">시간</label>
                    <input type="text" id="time" name="time" required>
                </div>
            </div>
            <div>
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="location">장소</label>
                <input type="text" id="location" name="location" required readonly>
            </div>
            <div>
                <label for="recruitment">모집인원</label>
                <input type="number" id="recruitment" name="recruitment" required>
            </div>
            <div>
                <label for="description">설명</label>
                <textarea id="description" name="description" rows="20" cols="60" required></textarea>
            </div>
            <button type="button" onclick="validateForm(this.form)">등록</button>
        </form>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>번개 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css'/>">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/datetime.js"></script>
    
    <script>
	    function showOptions() {
	        var selectedExercise = document.querySelector('input[name="exercise"]:checked').value;
	        var optionsDiv = document.getElementById('exerciseOptions');
	        var html = '';
	
	        if (selectedExercise === 'running') {
	            html += '<label>거리 선택:</label><br>';
	            html += '<input type="radio" name="runningDistance" value="5km"> 5km<br>';
	            html += '<input type="radio" name="runningDistance" value="10km"> 10km<br>';
	            html += '<input type="radio" name="runningDistance" value="15km"> 15km<br>';
	        } else if (selectedExercise === 'bodybuilding') {
	            html += '<label>부위 선택:</label><br>';
	            html += '<input type="radio" name="bodybuildingPart" value="upper"> 상체<br>';
	            html += '<input type="radio" name="bodybuildingPart" value="lower"> 하체<br>';
	        } else if (selectedExercise === 'yoga') {
	            html += '<label>시간 선택:</label><br>';
	            html += '<input type="radio" name="yogaDuration" value="10"> 10분<br>';
	            html += '<input type="radio" name="yogaDuration" value="30"> 30분<br>';
	            html += '<input type="radio" name="yogaDuration" value="60"> 60분<br>';
	        } else if (selectedExercise === 'hiking') {
	            html += '<label>난이도 선택:</label><br>';
	            html += '<input type="radio" name="hikingDifficulty" value="easy"> 쉬움<br>';
	            html += '<input type="radio" name="hikingDifficulty" value="medium"> 중간<br>';
	            html += '<input type="radio" name="hikingDifficulty" value="hard"> 어려움<br>';
	        }
	
	        optionsDiv.innerHTML = html;
	    }


	    function validateForm(f) {
	        var dateInput = document.getElementById('date');
	        var timeInput = document.getElementById('time');
	        var titleInput = document.getElementById('title');
	        var locationInput = document.getElementById('location');
	        var recruitmentInput = document.getElementById('recruitment');
	        var descriptionInput = document.getElementById('description');
	        var selectedExerciseElement = document.querySelector('input[name="exercise"]:checked');
	        var selectedExercise;
	        var exerciseOption;

	        // 날짜 유효성 검사
	        if (dateInput.value === '') {
	            dateInput.setCustomValidity('날짜를 입력해주세요.');
	            dateInput.reportValidity();
	            return false;
	        } else {
	            dateInput.setCustomValidity('');
	        }

	        // 시간 유효성 검사
	        if (timeInput.value === '') {
	            timeInput.setCustomValidity('시간을 입력해주세요.');
	            timeInput.reportValidity();
	            return false;
	        } else {
	            timeInput.setCustomValidity('');
	        }

	        // 제목 유효성 검사
	        if (titleInput.value === '') {
	            titleInput.setCustomValidity('제목을 입력해주세요.');
	            titleInput.reportValidity();
	            return false;
	        } else {
	            titleInput.setCustomValidity('');
	        }

	        // 장소 유효성 검사
	        if (locationInput.value === '') {
	            locationInput.setCustomValidity('장소를 입력해주세요.');
	            locationInput.reportValidity();
	            return false;
	        } else {
	            locationInput.setCustomValidity('');
	        }

	        // 모집인원 유효성 검사
	        if (recruitmentInput.value === '' || recruitmentInput.value < 0) {
	            recruitmentInput.setCustomValidity('모집인원을 올바르게 입력해주세요.');
	            recruitmentInput.reportValidity();
	            return false;
	        } else {
	            recruitmentInput.setCustomValidity('');
	        }

	        // 운동 종류 선택 유효성 검사
	        if (!selectedExerciseElement) {
	            alert('운동 종류를 선택해주세요.');
	            return false;
	        }
	        selectedExercise = selectedExerciseElement.value;

	        // 운동 종류 및 옵션 유효성 검사
	        if (selectedExercise === 'running') {
	            exerciseOption = document.querySelector('input[name="runningDistance"]:checked');
	        } else if (selectedExercise === 'bodybuilding') {
	            exerciseOption = document.querySelector('input[name="bodybuildingPart"]:checked');
	        } else if (selectedExercise === 'yoga') {
	            exerciseOption = document.querySelector('input[name="yogaDuration"]:checked');
	        } else if (selectedExercise === 'hiking') {
	            exerciseOption = document.querySelector('input[name="hikingDifficulty"]:checked');
	        }

	        if (!exerciseOption) {
	            alert('운동 옵션을 선택해주세요.');
	            return false;
	        }

	        // 설명 유효성 검사
	        if (descriptionInput.value === '') {
	            descriptionInput.setCustomValidity('설명을 입력해주세요.');
	            descriptionInput.reportValidity();
	            return false;
	        } else {
	            descriptionInput.setCustomValidity('');
	        }

	        // AJAX 요청을 통해 데이터 전송
	        var params = {
	            idx: ${postUser.postIdx},
	            startdate: dateInput.value,
	            starttime: timeInput.value,
	            title: titleInput.value,
	            location: locationInput.value,
	            recruitment: recruitmentInput.value,
	            description: descriptionInput.value,
	            exercise: selectedExercise,
	            exerciseOption: exerciseOption.value
	        };

	        fetch("update_my_post.do", {
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
	            messageDiv.innerHTML = "<div class='message success'>" + response.message + "</div>";
	            setTimeout(function() {
	                window.location.href = "post_detail.do?postIdx=" + response.postIdx; // 성공 시 수정된 게시물의 상세 페이지로 이동
	            }, 1000);
	        } else {
	            messageDiv.innerHTML = "<div class='message error'>" + response.message + "</div>";
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
            width: 120px;
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
        input[name="exercise"] {
            display: inline-block;
            margin-right: 10px;
        }
        .submit-button {
            background-color: #28a745; /* 초록색 */
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>운동번개 수정</h2>
        <div id="message"></div>
        <form>
            <div class="datetime-container">
                <div>
                    <label for="date">일정 (날짜)</label>
                    <input type="date" id="date" name="date" value="${postUser.startDate}">
                </div>
                <div>
                    <label for="time">시간</label>
                    <input type="time" id="time" name="time" value="${postUser.startTime}">
                </div>
            </div>
            <div>
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${postUser.title}">
            </div>
            <div>
                <label>운동 종류:</label><br>
                <input type="radio" id="running" name="exercise" value="running" onclick="showOptions()" <c:if test="${postUser.exerciseOptionId == 1}">checked</c:if>> 런닝
                <input type="radio" id="bodybuilding" name="exercise" value="bodybuilding" onclick="showOptions()" <c:if test="${postUser.exerciseOptionId == 2}">checked</c:if>> 바디빌딩
                <input type="radio" id="yoga" name="exercise" value="yoga" onclick="showOptions()" <c:if test="${postUser.exerciseOptionId == 3}">checked</c:if>> 요가
                <input type="radio" id="hiking" name="exercise" value="hiking" onclick="showOptions()" <c:if test="${postUser.exerciseOptionId == 4}">checked</c:if>> 등산
            </div>
            <div id="exerciseOptions"></div>
            <div>
                <label for="location">장소</label>
                <input type="text" id="location" name="location" value="${postUser.location}" readonly>
            </div>
            <div>
                <label for="recruitment">모집인원</label>
                <input type="number" id="recruitment" name="recruitment" value="${postUser.recruitment}">
            </div>
            <div>
                <label for="description">설명</label>
                <textarea id="description" name="description" rows="20" cols="60">${postUser.description}</textarea>
            </div>
            <button type="button" class="submit-button" onclick="validateForm(this.form)">수정하기</button>
        </form>
        
        <jsp:include page="footer.jsp"/>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <style>
        body {
            background-color: #FFFFFF;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message {
            text-align: center;
        }
    </style>
    <script>
        setTimeout(function() {
            window.location.href = "testmap.do";
        }, 1000);
    </script>
</head>
<body>
    <div class="message">
        <h1>이미 참여자이거나, 등록 실패했습니다</h1>
        <p>2초 후에 페이지가 이동됩니다.</p>
    </div>
</body>
</html>
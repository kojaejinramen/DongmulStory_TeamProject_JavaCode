<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Error Page</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<style>
    .error-container {
        text-align: center;
        padding-top: 10%;
        margin-bottom: 120px;
    }
    h1 {
        font-size: 5rem;
        font-weight: bold;
    }
    h3 {
        padding-top: 1rem;
    }
</style>
</head>
<body>
    <!-- 상단 목록 -->
    <div class="top-index">
        <%@ include file="topIndex.jsp" %>
    </div>

    <!-- 에러 메시지 -->
    <div class="error-container">
        <h1>Oops!</h1>
        <h3>에러가 발생했습니다.</h3>
        <p>비정상적인 접근을 감지하였습니다.</p>
        <a href="/shop/">홈페이지로 돌아가기</a>
    </div>
    
    <div class="bottom-index">
		<%@ include file="bottom.jsp" %>
	</div>
</body>
</html>

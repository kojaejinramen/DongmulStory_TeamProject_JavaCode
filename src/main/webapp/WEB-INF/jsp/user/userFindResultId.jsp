<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>아이디 찾기 결과</title>
<style type="text/css">
 .main{
 	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	color: #574d00;
	border: 5px solid #f3e268; /* 테두리 노랑색으로 변경 */
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
	background-color: #fef5cc; 
	text-align: center;
 }

button {
	padding: 10px 20px;
	/* 버튼 주위에 10px의 상/하 안배치(padding)와 20px의 좌/우 안배치(padding)를 설정 */
	background-color: #f8ca84; /* 버튼의 배경색은 밝은 오렌지 색상 */
	border: none; /* 버튼의 테두리를 없앰 */
	color: #fff; /* 버튼의 텍스트 색상은 흰색(화이트) */
	border-radius: 5px; /* 버튼의 테두리를 둥글게 5px로 설정 */
	cursor: pointer; /* 마우스 커서를 버튼 위로 올렸을 때 손가락 커서로 변경 */
	outline: none; /* 버튼에 초점이 있을 때(outline) 기본적인 테두리를 제거 */
}

button:hover {
	background-color: #fdd29b;
	/* Lighter yellow button background on hover */
}
</style>
</head>

<body>
	<!-- 상단 목록 -->
	<div class="top-index">
	  <%@ include file="../topIndex.jsp" %>
	</div>
	<div class="banner-index">
		<%@ include file="../bannerIndex.jsp" %>
	</div>
	
	<main class="main">
	    <h3>찾은 아이디</h3>
		    <div>회원님의 아이디는 "<span style="color: #ff8000; font-weight: bold;">${findId}</span>" 입니다.</div>
		    &nbsp;&nbsp;&nbsp;&nbsp;
		    <br>
		    <div>
		        <button type="button" onclick="location.href='/user/login'">로그인</button>
		        <button type="button" onclick="location.href='/user/findpwd'">비밀번호 찾기</button>
		    </div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
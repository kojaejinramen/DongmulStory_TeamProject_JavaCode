<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마이페이지</title>
<style>
	.main {
		font-family: 'Arial', sans-serif;
		background-color: #fffcd8; /* Pale yellow background */
		color: #574d00; /* Dark yellow text color */
		max-width: 600px;
		margin: 20px auto;
		padding-top: 20px;
		padding-bottom: 40px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		text-align: center;
		border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
	}
	h2 {
		color: #ff6600; /* 제목 글자색 귀여운 주황색으로 변경 */
		font-size: 40px;
	}
	
	button {
		background-color: #ffe14f; /* Yellow button background */
	    color: black;
	    font-weight: 900;
	    border: none;
	    padding: 10px 20px;
	    font-size: 20px;
	    cursor: pointer;
	    margin-top: 10px;
	    text-align: center;
	    width: 150px;
	    
	}
	
	button:hover {
	     background-color: black; /* Lighter yellow button background on hover */
	    color: yellow; /* Yellow button text color */
	}
	
	.button-container {
		display: flex;
		justify-content: center;
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
	  	<h2>Admin Page</h2>
		<div style="text-align: center;">
			<button type="button" onclick="location.href='/shop/add'">상품등록</button>
			<button type="button" onclick="location.href='/order/paylist'">배송관리</button>
		</div>
		<div style="text-align: center;">
			<button type="button" onclick="location.href='/order/admin/list/user'">매출관리</button>
			<button type="button" onclick="location.href='/user/list'">유저관리</button>
		</div>
		<div style="text-align: center;">
			<button type="button" onclick="location.href='/review/list/page/1'">리뷰관리</button>
			<button type="button" onclick="location.href='/qna/list/new'">Q&A관리</button>
      	</div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
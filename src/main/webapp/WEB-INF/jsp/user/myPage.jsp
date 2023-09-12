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
	background-color: #fef5cc; /* Pale yellow background */
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	text-align: center;
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
}

h2 {
	color: #ff6600; /* 제목 글자색 귀여운 주황색으로 변경 */
}

label {
	font-weight: bold;
	text-align: left;
	color: #574d00;
}

input[type="password"] {
	border: 2px solid #f3e268; /* Light yellow password input border */
	padding: 5px;
}

input[type="text"] {
	border: 2px solid #f3e268; /* Light yellow password input border */
	padding: 5px;
}

table {
	padding-left: 110px;
	width: 100%;
}

th, td {
	padding: 5px;
	text-align: left;
}

th {
	width: 120px;
}

button {
	background-color: #f8ca84; /* Yellow button background */
	color: #fff; /* Dark yellow button text color */
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px; /* 버튼의 테두리를 둥글게 5px로 설정 */
	outline: none; /* 버튼에 초점이 있을 때(outline) 기본적인 테두리를 제거 */
	margin-top: 25px;
	text-align: center;
}

button:hover {
	background-color: #fdd29b;
	/* Lighter yellow button background on hover */
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
	  	<h2>My Page</h2>
		<table>
      <tr>
      <th><label for="userId">🐕 아이디 🐕 </label></th>
      <td>${user.userId}</td>
      </tr>
      
      <tr>
      <th><label for="userName">🐈 이름 🐈 </label></th>
      <td> ${user.userName} </td>
      </tr>
      
      <tr>
      <th><label for="userPhone">🦔 전화번호 🦔 </label></th>
      <td> ${user.userPhone} </td>
      </tr>
      
      <tr>
      <th><label for="userEmail">🐢 이메일 🐢 </label></th>
      <td>${user.userEmail}@${user.userEmailDomain} </td>
      </tr>
      
      <tr>
      <th>🦜 주소 🦜</th>
      <td>
      우편번호 <input name="userAddress1" id="userAddress1" type="text"
            value="${user.userAddress1}" readonly="readonly"> <br>
            ${user.userAddress2}, <br>
            ${user.userAddress3}
      </td>
      </tr>
      
   </table>
		<div>
			<button type="button" onclick="location.href='/user/mypageCheck'">MY 정보변경</button>
			<button type="button" onclick="location.href='/order/paylist'">MY 주문내역</button>
			<button type="button" onclick="location.href='/review/list/page/1'">MY 리뷰관리</button>
			<button type="button" onclick="location.href='/qna/selfList/new'">MY Q&A관리</button>
      	</div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
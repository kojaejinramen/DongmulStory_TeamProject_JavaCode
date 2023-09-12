<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
 main { text-align: center; }
 table {margin: auto auto;}
 th { border: 1px solid black;}
 td { border: 1px solid black;}
</style>
<meta charset="utf-8">
<title>동물이야기 회원 목록</title>
</head>

<body>
	<!-- 상단 목록 -->
	<div class="top-index">
	  <%@ include file="../topIndex.jsp" %>
	</div>

	<main class="main">
		<h3>동물이야기 회원 목록</h3>
		<table style="">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>상세주소</th>
			</tr>
			<c:forEach var="user" items="${list}">
			<tr>
				<td>${user.userId}</td>
				<td>${user.userName}</td>
				<td>${user.userPhone}</td>
				<td>${user.userEmail}</td>
				<td>${user.userAddress1}</td>
				<td>${user.userAddress2}</td>
				<td>${user.userAddress3}</td>
			</tr>
			</c:forEach>
		</table>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
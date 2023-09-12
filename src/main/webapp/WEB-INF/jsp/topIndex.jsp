<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>title</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function goMyPage(){
	if(${userId eq NULL}){
		alert('먼저 로그인 해주세요.');
		location.href="/user/login";
	}
	else {
		location.href="/user/mypage";
	}
}
function goAdminPage(){
	if(${userId eq NULL}){
		alert('먼저 로그인 해주세요.');
		location.href="/user/login";
	}
	else {
		location.href="/user/adminpage";
	}
}
function goCart(){
	if(${userId eq NULL}){
		alert('먼저 로그인 해주세요.');
		location.href="/user/login";
	}
	else {
		location.href="/cart/list";
	}
}

function goChatting(){
	if(${userId eq NULL}){
		alert('먼저 로그인 해주세요.');
		location.href="/user/login";
	}
	else {
		location.href="/ws/in";
	}
}

function logout_form(userId) {
	
	$.ajax({
		url : "/user/logout",
		data : {"userId":userId},
		method : "post",
		cache : false,  
		dataType : 'json', 
		success : function( res ) {
			if(!res) {
				alert('로그아웃 실패')
			}
			location.href="/shop/";
		}, 
		error : function(err) {
			alert('에러:' + err);
		}
	});
	return false;
}
</script>
<style type="text/css">
body {
	width: 1050px;
	margin: 0 auto;
	background-color: #fcfcfc;
}
/* Style for topIndex.jsp */
#login {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: #f2f2f2;
	padding: 8px;
	border-radius: 4px;
	font-size: 14px;
}

#title {
	height: fit-content;
	width: fit-content;
	margin: 0 auto;
	padding: 0 20px;
	background-color: white;
}
b {
	margin-left: 2px;
}
a {
	text-decoration: none;
}
#x {
	text-decoration: none;
	color: black;
}

#x:hover { text-decoration: underline; }
.welcome {
	margin-top: 2px;
	font-weight: bolder;
	color: black;
}
</style>
</head>
<body>
	<div id="login">
		<c:if test="${userId eq NULL}">
	   <b><a id="x" href="/user/login">로그인</a></b>
	   <b><a id="x" href="/user/add">회원가입</a></b>
	  </c:if>
	  
	  <c:if test="${userId ne NULL}">
	  	<b><a id="x" href="javascript:logout_form('${userId}');">로그아웃</a></b>
	  </c:if>
	  <c:if test="${userId ne 'dongmul'}">
	  	<b><a id="x" href="javascript:goMyPage();">마이페이지</a></b>
	  </c:if>
	  <c:if test="${userId eq 'dongmul'}">
  	  	<b><a id="x" href="javascript:goAdminPage();">관리자페이지</a></b>
	  </c:if>
	  <c:if test="${userId ne 'dongmul'}">
	  	<b><a id="x" href="javascript:goCart();">장바구니</a></b>
	  </c:if>
	  <c:if test="${userId eq 'dongmul'}">
	  	<b><a id="x" href="/order/admin/list/user">매출관리</a></b>
	  </c:if>
	  <b><a id="x" href="/qna/list/new">Q&A</a></b>
	  <b><a id="x" href="javascript:goChatting()">채팅문의</a></b>
	  <c:if test="${userId ne NULL}">
	  	<div class="welcome">
	  		👉 
	  		<c:if test="${userId eq 'dongmul'}">
	  			관리자
	  		</c:if>
	  		<c:if test="${userId ne 'dongmul'}">
	  			${userId}	  			
	  		</c:if>
	  		님 환영합니다 (●ˇ∀ˇ●)
	  	</div>
	  </c:if>
	</div>
	<div id="title">
		<a href="/shop/">
			<img alt="동물이야기" src="/files/title.gif" width="100%" height="200px">
		</a>
	</div>
	<hr>
</body>
</html>

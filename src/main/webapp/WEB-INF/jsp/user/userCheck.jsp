<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 확인 폼</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function form_check() {
	    var password = $("#password").val();
	    $.ajax({
	        url: "/user/mypageCheck",
	        data: { "password": password },
	        method: "post",
	        cache: false,
	        dataType: 'json',
	        success: function (response) {
	            if (response.success) {
	                // 비밀번호가 일치하는 경우, myPageUpdateForm으로 이동합니다.
	                window.location.href = "/user/mypageUpdate";
	            } else {
	                // 비밀번호가 일치하지 않는 경우, 에러 메시지를 표시합니다.
	                $("#errorMsg").text(response.errorMsg);
	            }
	        },
	        error: function (err, status, xhr) {
	            alert('에러:' + err);
	        }
	    });
	    return false;
	}
</script>
<style type="text/css">
.main {
	background-color: #fef5cc; /* Pale yellow background */
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	color: #574d00;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
	font-weight: bold;
}

h2 {
	text-align: center;
	color: #ff6600;
}

table {
	padding-left: 140px;

}

th {
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
	margin-top: 10px;
	text-align: center;
	width: auto;
	height: auto;
}

button:hover {
	background-color: #fdd29b;
	/* Lighter yellow button background on hover */
}

input[type="password"] {
	border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
	padding: 5px;
	margin-right: 1em;
	margin-bottom: 12px;
	display: inline-block;
	width: 120px;
}

#errorMsg { text-align: center;
	text
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
		<h2>회원 정보 확인</h2>
		<table>
		<tr>
		<th>아이디 :</th> 
		<td>${user.userId}</td>
		</tr>
		<tr>
			<form onsubmit="return form_check();">
				<th><label for="password" style="font-weight: bold;">비밀번호 : </label></th>
				<td><input type="password" name="password" id="password" required>
				<button type="submit">확인</button></td>
			</form>
		</tr>	
		</table>
		<div id="errorMsg" style="color: red;"></div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>

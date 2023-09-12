<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>동물이야기 비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	
	var emailVerified = false; // 이메일 인증 상태를 추적하는 플래그

	function login() {
		
		var name = document.getElementById("userName").value;
		var id = document.getElementById("userId").value;
		var email = document.getElementById("userEmail").value;
		
		if (name == "") {
			alert("이름을 입력해주세요!")
			return false;
		}

		else if (id == "") {
			alert("아이디를 입력해주세요!")
			return false;
		}

		else if (email == "") {
			alert("이메일을 입력해주세요!")
			return false;
		}

		else if (!emailVerified) {
			alert("이메일 인증확인을 해주세요!"); // 이메일이 확인되지 않은 경우 알림 표시
			return false; 
		}
		
		var formdata = $('#findPwdForm').serialize();

		$.ajax({
			url : "/user/findPwd",
			data : formdata,
			method : "post",
			cache : false,
			dataType : 'json',
			success : function(res) {
				if (res.found) {
					//alert("비밀번호는 " + res.userPwd + " 입니다.");
					location.href = "/user/resultPwd?userPwd=" + res.userPwd;
				} else {
					alert("비밀번호 찾기 실패");
				}
			},
			error : function(err) {
				alert('에러:' + err);
			}
		});
		return false;
	}

	// 이메일 인증확인 버튼
	function checkEmail() {
		var userEmail = $('#userEmail').val();
		var userEmailDomain = $('#userEmailDomain').val();

		if (userEmail === "" || userEmailDomain === "") {
			alert("이메일 또는 이메일 도메인을 입력해주세요.");
			return;
		}

		var regex = /^[a-zA-Z0-9]+$/;
		if (!regex.test(userEmail)) {
			alert("이메일은 영어와 숫자만 사용할 수 있습니다.");
			return;
		}

		$.ajax({
			url : "/mail/html",
			data : {
				"userEmail" : userEmail,
				"userEmailDomain" : userEmailDomain
			},
			method : "get",
			cache : false,
			dataType : 'json',
			success : function(res) {
				if (res.sent) {
					alert('입력하신 이메일 주소로 인증 메일을 보냈습니다.\n인증메일을 열고 링크를 클릭해주세요.');
					timer = setInterval(auth_check, 1000);
					auth_check();
				} else {
					alert('유효하지 않은 이메일을 입력하였습니다');
				}
			},
			error : function(err) {
				alert('에러:' + err);
			}
		});
	}

	var timer = null;

	function auth_check() {
		var userEmail = $('#userEmail').val();
		var userEmailDomain = $('#userEmailDomain').val();

		$.ajax({
			url : '/mail/auth_check',
			method : 'get',
			data : {
				"userEmail" : userEmail,
				"userEmailDomain" : userEmailDomain
			},
			cache : false,
			dataType : 'json',
			success : function(res) {
				if (res.auth) {
					clearInterval(timer);
					alert('이메일 인증 성공!');
					emailVerified = true; // 이메일이 인증되었음을 표시
				}
			},
			error : function(xhr, status, err) {
				alert('에러:' + err);
			}
		})
	}
</script>

<script type="text/javascript">
	$(function() {
	    $('#select').change(function() {
	        if ($('#select').val() == 'directly') {
	            $('#userEmailDomain').attr("disabled", false);
	            $('#userEmailDomain').val("");
	            $('#userEmailDomain').focus();
	        } else {
	            $('#userEmailDomain').val($('#select').val());
	        }
	    })
	});
</script>

<style type="text/css">
.main {
	font-family: 'Arial', sans-serif;
	background-color: #fef5cc; /* 배경색 연노랑색으로 변경 */
	max-width: 700px;
	margin: 20px auto;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
}

h3 {
	color: #574d00; /* 제목 글자색 주황색으로 변경 */
	text-align: center;
}

form div {
	margin-bottom: 10px;
}

label {
	font-weight: bold;
	color: #574d00;
	padding-left: 35px;
}

input[type="text"], input[id="userEmailDomain"], input[type="password"],
	select[id="select"] {
	border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
	padding: 5px;
	margin-right: 4px;
	display: inline-block;
	width: 140px;
}

input[id="userEmailDomain"] {
	width: 20%
}

#but {
	padding: 7px 13px;
	/* 버튼 주위에 10px의 상/하 안배치(padding)와 20px의 좌/우 안배치(padding)를 설정 */
	background-color: #f8ca84; /* 버튼의 배경색은 밝은 오렌지 색상 */
	border: none; /* 버튼의 테두리를 없앰 */
	color: #fff; /* 버튼의 텍스트 색상은 흰색(화이트) */
	border-radius: 5px; /* 버튼의 테두리를 둥글게 5px로 설정 */
	cursor: pointer; /* 마우스 커서를 버튼 위로 올렸을 때 손가락 커서로 변경 */
	outline: none; /* 버튼에 초점이 있을 때(outline) 기본적인 테두리를 제거 */
}

#sub {
	padding: 10px 20px;
	/* 버튼 주위에 10px의 상/하 안배치(padding)와 20px의 좌/우 안배치(padding)를 설정 */
	background-color: #f8ca84; /* 버튼의 배경색은 밝은 오렌지 색상 */
	border: none; /* 버튼의 테두리를 없앰 */
	color: #fff; /* 버튼의 텍스트 색상은 흰색(화이트) */
	border-radius: 5px; /* 버튼의 테두리를 둥글게 5px로 설정 */
	cursor: pointer; /* 마우스 커서를 버튼 위로 올렸을 때 손가락 커서로 변경 */
	outline: none; /* 버튼에 초점이 있을 때(outline) 기본적인 테두리를 제거 */
	margin-top: 10px;
	margin-left: 330px;
	text-align: center;
}

#sub:hover, #but:hover {
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
		<h3>동물이야기 비밀번호 찾기</h3>
		<form id="findPwdForm" onsubmit="return login();">
			<div>
				<label for="userName">고객명 : </label>
				<input type="text" id="userName" name="userName">
			</div>
			
			<div>
				<label for="userId">아이디 : </label>
				<input type="text" id="userId" name="userId">
			</div>
			
			<div>
				<label for="userEmail">이메일 : </label><input type="text" name="userEmail" id="userEmail" value="" placeholder="이메일 입력"> 
		 		<span>@</span>
		 		<input id="userEmailDomain" name="userEmailDomain" placeholder="이메일을 선택하세요."> 
		 		<select id="select">
		            <option value="" disabled selected>E-Mail 선택</option>
		            <option value="naver.com" id="naver.com">naver.com</option>
		            <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
		            <option value="gmail.com" id="gmail.com">gmail.com</option>
		            <option value="nate.com" id="nate.com">nate.com</option>
		            <option value="directly" id="textEmail">직접 입력하기</option>
		        </select>
		        <button id="but" type="button" onclick="checkEmail()">인증</button>
			</div>
			<button id="sub" type="submit">찾기</button>
		</form>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마이페이지 수정 폼</title>

<style>

/* 헤더 스타일 */
h2 {
	color: #ff6600; /* 제목 글자색 주황색으로 변경 */
	text-align: center;
}

/* 폼 스타일 */
form {
	max-width: 400px; /* 폼의 최대 너비를 400px로 설정 */
	margin: 20px auto; /* 폼을 수평 가운데 정렬합니다. */
	padding: 20px; /* 폼 주위에 20px의 안배치(padding)를 설정 */
	background-color: #fef5cc; /* 폼의 배경색은 연한 연노랑 (Light pastel yellow) */
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	text-align: center; /* 내용들을 수평으로 가운데 정렬 */
}

/* 입력창을 가운데로 정렬 */
input[type="text"] {
	border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
	padding: 5px;
	margin-top: 5px;
	margin-right: 4px;
	display: inline-block;
	width: 140px;
	margin-right: 4px;
}

button {
	padding: 10px 20px;
	/* 버튼 주위에 10px의 상/하 안배치(padding)와 20px의 좌/우 안배치(padding)를 설정 */
	background-color: #f8ca84;
	border: none; /* 버튼의 테두리를 없앰 */
	color: #fff; /* 버튼의 텍스트 색상은 흰색(화이트) */
	border-radius: 5px; /* 버튼의 테두리를 둥글게 5px로 설정 */
	cursor: pointer; /* 마우스 커서를 버튼 위로 올렸을 때 손가락 커서로 변경 */
	outline: none; /* 버튼에 초점이 있을 때(outline) 기본적인 테두리를 제거 */
}

button:hover {
	background-color: #fdd29b;
	/* 마우스를 올렸을 때 버튼의 배경색을 약간 더 진한 오렌지 색상으로 변경 */
}

label {
	font-weight: bold;
	color: #574d00;
}

table {
	width: 100%;
	padding-left: 15px;
}

th, td {
	padding: 5px;
	text-align: left;
}

th {
	width: 185px;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

// 우편번호 검색해서 주소 입력
function findAddr() {
   new daum.Postcode({
      oncomplete : function(data) {

         console.log(data);

         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
         // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var roadAddr = data.roadAddress; // 도로명 주소 변수
         var jibunAddr = data.jibunAddress; // 지번 주소 변수
         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('userAddress1').value = data.zonecode;
         if (roadAddr !== '') {
            document.getElementById("userAddress2").value = roadAddr;
         } else if (jibunAddr !== '') {
            document.getElementById("userAddress2").value = jibunAddr;
         }
      }
   }).open();
}


// 회원정보 수정 (비밀번호/이메일/주소)
function update() {
   
   var pwd = document.getElementById("userPwd").value;
   var pwdCheck = document.getElementById("userPwdCheck").value;
   var address1 = document.getElementById("userAddress1").value;
   
      if(pwd=="")
      {
         alert("비밀번호를 입력해주세요!")
         return false;
      }
      else if (pwdCheck == "") 
      {
         alert("비밀번호 확인을 입력해주세요!");
         return false;
      }
      else if (pwd != pwdCheck) 
      {
         alert("비밀번호가 동일하지 않습니다. 다시 입력해주세요");
         return false;
      }
      else if(address1=="")
      {
         alert("주소를 입력해주세요!")
         return false;
      }
   
   var formdata = $('#updateUser').serialize();
   var userPwd = $('#userPwd').val();
   
   // 비밀번호 유효성 검사를 위한 정규 표현식
    var passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$/;

    // 비밀번호가 유효한지 확인
    if (!passwordRegex.test(userPwd)) {
        alert("비밀번호는 영어/숫자/특수문자(@ $ ! % * # ? &)를 최소 1개씩 포함하여 8자 이상 16자 이하여야 합니다.");
        return false;
    }
   if (userPwd.length < 8 || userPwd.length > 16) {
        alert("비밀번호는 8자 이상 16자 이하로 입력해야 합니다.");
        return false;
    }
   
   $.ajax({
      url : "/user/mypageUpdate",
      data : formdata,
      method : "post",
      cache : false,
      dataType : 'json',
      success : function(res) {
         if (res.updated) {
            alert("수정 되었습니다.")
            location.href = "/user/mypage";
         } else {
            alert("수정 실패");
         }
      },
      error : function(err) {
         alert('우편번호가 올바르지 않습니다.');
      }
   });
   return false;
}


// 회원탈퇴   
function delete_user(userId) {
   if (!confirm('회원 탈퇴를 진행하시겠습니까?'))
      return true;

   var data = {
      'userId' : userId
   };

   $.ajax({
      url : '/user/deleteUser',
      data : data,
      method : "post",
      cache : false,
      dataType : 'json',
      success : function(res) {
         if (res.deleted) {
            alert("회원 탈퇴가 되었습니다 ^_ㅠ");
            location.href = "/user/login";
         } else {
            alert("회원 탈퇴 실패")
         }
      },
      error : function(err, status, xhr) {
         alert('에러:' + err);
      }
   });
   return false;
}

</script>

</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>
	<div class="banner-index">
		<%@ include file="../bannerIndex.jsp"%>
	</div>

	<main class="main">
		<form id="updateUser" onsubmit="return update();">
			<h2>회원정보 수정</h2>
			<table>
				<tr>
					<th><label for="userId">🐕 아이디 🐕 </label></th>
					<td><input type="hidden" name="userId" value="${user.userId}">${user.userId}</td>
				</tr>

				<tr>
					<th><label for="userPwd">🐈 새 비밀번호 🐈 </label></th>
					<td><input type="text" id="userPwd" name="userPwd"
						value="${user.userPwd}"></td>
				</tr>

				<tr>
					<th><label for="userPwdCheck">🐆 새 비밀번호 확인 🐆 </label></th>
					<td><input type="text" id="userPwdCheck" name="userPwdCheck"
						value="${user.userPwd}"></td>
				</tr>

				<tr>
					<th><label for="userName"> 🐀 이름 🐁 </label></th>
					<td><input type="hidden" name="userName"
						value="${user.userName}"> ${user.userName}</td>
				</tr>

				<tr>
					<th><label for="userPhone">🦔 전화번호 🦔 </label></th>
					<td><input type="hidden" name="userPhone"
						value="${user.userPhone}"> ${user.userPhone}</td>
				</tr>

				<tr>
					<th><label for="userEmail"> 🐢 이메일 🐢</label></th>
					<td><input type="hidden" id="userEmail" name="userEmail"
						value="${user.userEmail}"> <input type="hidden"
						id="userEmailDomain" name="userEmailDomain"
						value="${user.userEmailDomain}">${user.userEmail}@${user.userEmailDomain}
					</td>
				</tr>

				<tr>
					<th>🦜 주소 🦜</th>
					<td>우편번호 <input name="userAddress1" id="userAddress1"
						type="text" placeholder="우편번호" value="${user.userAddress1}"
						onclick="findAddr()" readonly> <br> <input
						name="userAddress2" id="userAddress2" type="text" placeholder="주소"
						value="${user.userAddress2}" readonly> <br> <input
						type="text" name="userAddress3" id="userAddress3"
						placeholder="상세주소" value="${user.userAddress3}">
					</td>
				</tr>

			</table>

			<br>
			<button type="submit">수정</button>
			<button type="button"
				onclick="javascript:delete_user('${user.userId}')">회원탈퇴</button>

		</form>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>동물이야기 회원 가입</title>
<style type="text/css">
#userAddMain {
	margin: 20px auto;
	background-color: #fef5cc; /* 귀여운 노랑색 배경 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	padding: 20px;
	border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
}

h2 {
	text-align: center;
	color: #ff6600; /* 제목 글자색 귀여운 주황색으로 변경 */
}

label {
	font-weight: bold;
	margin-left: 10px;
	color: #574d00;
}

button {
	background-color: #f8ca84; /* 버튼 배경색 노랑색으로 변경 */
	color: #fff; /* 버튼 글자색 주황색으로 변경 */
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	margin-top: 10px;
	border-radius: 5px;
	outline: none;
}

button:hover {
	background-color: #fdd29b; /* 마우스 오버 시 버튼 배경색 연한 노랑색으로 변경 */
}

div[id="divBtn"] {
	text-align: center;
}

div[id="agree"] {
	text-align: left;
	padding-left: 120px;
}

#agree_all {
	margin-bottom: 20px;
}

a {
	text-decoration: none; /* 링크 밑줄 제거 */
	color: #574d00; /* 링크 글자색 주황색으로 변경 */
}

a:hover {
	text-decoration: underline; /* 링크 마우스 오버 시 밑줄 추가 */
}

input[type="text"], input[type="password"], select {
	border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
	padding: 5px;
	margin-bottom: 7px; /* 상자 간 간격을 조절하기 위한 속성 추가 */
	width: 20%; /* 입력 상자가 가로로 꽉 차도록 설정 */
}

input[id="userEmailDomain"] {
	border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
	padding: 5px;
	margin-bottom: 7px; /* 상자 간 간격을 조절하기 위한 속성 추가 */
	width: 20%; /* 입력 상자가 가로로 꽉 차도록 설정 */
}

table {
	padding-left: 120px;
	width: 100%;
}

th, td {
	padding: 5px;
	text-align: left;
}

th {
	width: 120px;
}

#userAddress2 {
	width: 200px; /* 주소 입력2 상자를 더 길게 */
}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

var idChecked = false, emailChecked = false;

// 회원가입 버튼
function userAdd() {
   
   var id = document.getElementById("userId").value;
   var pwd = document.getElementById("userPwd").value;
   var pwdCheck = document.getElementById("userPwdCheck").value;
   var name = document.getElementById("userName").value;
   var phone = document.getElementById("userPhone").value;
   var email = document.getElementById("userEmail").value;
   var address1 = document.getElementById("userAddress1").value;
   var agree1 = $('input[name="agree"][value="1"]').prop('checked');
    var agree2 = $('input[name="agree"][value="2"]').prop('checked');
    var agree3 = $('input[name="agree"][value="3"]').prop('checked');
    
   if(id=="")
   {
         alert("아이디를 입력해주세요!")
         return false;
   }
   else if(pwd=="")
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
   else if(name=="")
   {
         alert("이름을 입력해주세요!")
         return false;
   }
   else if(phone=="")
   {
         alert("번호를 입력해주세요!")
         return false;
   }
   else if(email=="")
   {
         alert("메일을 입력해주세요!")
         return false;
   }
   else if(address1=="")
   {
         alert("주소를 입력해주세요!")
         return false;
   }
   else if (!agree1 || !agree2 || !agree3) {
       alert("필수 약관에 동의해주세요.");
       return false;
   }
       var userPwd = $('#userPwd').val();
       var userPhone = $('#userPhone').val();

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
      
      if (userPhone.length !== 13 && userPhone.length !== 12) {
         alert("올바른 전화번호를 입력해주세요. ")
         return false;
      }
      
    if(!idChecked) return alert("아이디 중복확인 버튼을 눌러주세요!");
    if(!emailChecked) return alert("이메일 인증확인을 해주세요!");
      
   if(!confirm("동물이야기 회원이 되겠습니까?")) return false;
   
   var data = $('#userAdd').serialize();
      
   $.ajax({
      url : "/user/add",
      data : data,
      method : "post",
      cache : false,
      dataType : 'json',
      success : function( res ) {
            if(res.cause!=null){
               alert(res.cause);
            }
            else{
               alert(res.added ? '회원 가입 성공 🥰' : '가입 실패 ^_ㅠ');
               location.href="/user/login";            
            }
         },
         error:function(err, status, xhr) {
            alert('에러:' + err);
         }
      });
      return false;
   }

</script>

<script>
//우편번호 검색해서 주소 입력
   function findAddr(){
      new daum.Postcode({
           oncomplete: function(data) {
              
              console.log(data);
              
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
               // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var roadAddr = data.roadAddress; // 도로명 주소 변수
               var jibunAddr = data.jibunAddress; // 지번 주소 변수
               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('userAddress1').value = data.zonecode;
               if(roadAddr !== ''){
                   document.getElementById("userAddress2").value = roadAddr;
               } 
               else if(jibunAddr !== ''){
                   document.getElementById("userAddress2").value = jibunAddr;
               }
           }
       }).open();
   }
</script>

<script type="text/javascript">
   // 아이디 중복확인 버튼
   function checkDuplicateId() {
       var userId = $('#userId').val();
       if (userId === "") {
           alert("아이디를 입력하세요.");
           return;
       }
   
       if (userId.length < 5 || userId.length > 20) {
           alert("아이디는 5자 이상 20자 이하로 입력해야 합니다.");
           return false;
       }
       
       var regex = /^[a-zA-Z0-9]+$/;
       if (!regex.test(userId)) {
           alert("아이디는 영어와 숫자만 사용할 수 있습니다.");
           return;
       }
       
       $.ajax({
           url : "/user/checkId",
           data : {"userId": userId},
           method : "get",
           cache : false,
           dataType : 'json',
           success : function (res) {
               if (res.isDuplicate) {
                   alert("중복된 아이디입니다. 다른 아이디를 입력해주세요.");
               } else {
                     idChecked = true;
                   alert("사용 가능한 아이디입니다.");
               }
           
           },
           error : function (err) {
               alert('에러:' + err);
           }
       });
   }

</script>

<script type="text/javascript">
   // 이메일 중복확인 버튼
   function checkDuplicateEmail() {
       var userEmail = $('#userEmail').val();
       var userEmailDomain = $('#userEmailDomain').val();
   
       if (userEmail === "" || userEmailDomain === "") {
         alert("이메일 또는 이메일 도메인을 입력해주세요.");
         return;
      }
      
       var regex = /^(?:[a-zA-Z0-9]+(?:[-_][a-zA-Z0-9]+)*)?$/; // 영문과 숫자 사이에 - _ 포함가능
       if (!regex.test(userEmail)) {
           alert("올바른 이메일 형식을 입력해주세요.");
           return;
       }
       
       $.ajax({
           url : "/user/checkEmail",
           data : {
               "userEmail": userEmail,
               "userEmailDomain": userEmailDomain
           },
           method : "get",
           cache : false,
           dataType : 'json',
           success : function (res) {
               if (res.isDuplicate) {
                   alert("중복된 이메일입니다. 다른 이메일을 입력해주세요.");
               } else {
                   checkEmail(); // 이메일 인증확인 전송
               }
           },
           error : function (err) {
               alert('에러:' + err);
           }
       });
   }

// 이메일 인증확인 버튼
   function checkEmail() {
       var userEmail = $('#userEmail').val();
       var userEmailDomain = $('#userEmailDomain').val();
   
       $.ajax({
           url : "/mail/html",
           data : {
               "userEmail": userEmail,
               "userEmailDomain": userEmailDomain
           },
           method : "get",
           cache : false,
           dataType : 'json',
           success : function (res) {
               if (res.sent) {
            	   alert('입력하신 이메일 주소로 인증 메일을 보냈습니다.\n인증메일을 열고 링크를 클릭해주세요.');
                   timer = setInterval(auth_check, 1000);
               } else {
            	   alert('유효하지 않은 이메일을 입력하였습니다');
               }
           },
           error : function (err) {
               alert('에러:' + err);
           }
       });
   }
   
	var timer = null;
   
   function auth_check()
   {
	   var userEmail = $('#userEmail').val();
       var userEmailDomain = $('#userEmailDomain').val();
       
      $.ajax({
         url:'/mail/auth_check',
         method:'get',
         data:{ 
        	 "userEmail": userEmail,
             "userEmailDomain": userEmailDomain
        	 },
         cache:false,
         dataType:'json',
         success : function(res){
            if(res.auth) {
               clearInterval(timer);
               alert('이메일 인증 성공!');
               emailChecked = true;
            }
         },
         error : function(xhr,status,err){
            alert('에러:' + err);
         }
      })
   }
   
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

   //전화번호 입력 필드의 값을 변환하여 자동으로 하이픈(-)이 추가되도록 처리
  function phoneFormat(userPhone) {
    // 특수문자 제거
    const value = userPhone.replace(/[^0-9]/g, '');
    
    // 숫자를 총 11자리로 제한 (최대)
    if (value.length > 11) {
        value = value.slice(0, 11);
    }

    let firstLength;
    let secondLength;

    // 지역번호(02 등) 또는 휴대전화 접두사(010 등)에 따라 분기
    if (value.startsWith('02')) { // 서울 지역번호인 경우
        firstLength = 2;
        secondLength = value.length === 10 ? 4 : 4; // 번호 길이에 따라 분기
    } else { // 그 외의 경우 (대부분 휴대전화)
        firstLength = 3;
        secondLength = 4;
    }

   return [
       value.slice(0, firstLength), 
       value.slice(firstLength, firstLength + secondLength),
       value.slice(firstLength + secondLength),
	   ].filter(Boolean).join('-'); 
	}
	
	function onPhoneChange(event) {
		  const userPhone = event.target;
		   userPhone.value = phoneFormat(userPhone.value);

		   if (userPhone.value.startsWith('02')) {
		       userPhone.maxLength = 12;
		   } else {
		       userPhone.maxLength = 13;
		   }
	}
</script>

<script>
   $(function() {
     // "모두 동의합니다" 체크박스 클릭 이벤트
     $('#agree_all').click(function() {
       // 모든 동의 체크박스 가져오기
       var agreeChk = $('input[name="agree"]');
       // "모두 동의합니다" 체크박스의 상태에 따라 모든 동의 체크박스 상태 변경
       agreeChk.prop('checked', this.checked);
     });
   
     // 개인정보 동의 체크박스 클릭 이벤트
     $('input[name="agree"]').click(function() {
       // 모든 동의 체크박스 개수
       var totalAgreeChkCount = $('input[name="agree"]').length;
       // 선택된 동의 체크박스 개수
       var checkedAgreeChkCount = $('input[name="agree"]:checked').length;
       // "모두 동의합니다" 체크박스 상태 변경
       $('#agree_all').prop('checked', totalAgreeChkCount === checkedAgreeChkCount);
     });
   });
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
	<main id="userAddMain">
		<h2>회원 가입</h2>

		<form id="userAdd" onsubmit="return userAdd();">
			<table>
				<tr>
					<th><label for="userId">아이디</label></th>
					<td><input type="text" name="userId" id="userId" required
						placeholder="ID" oninput="idChecked=false;">
						<button type="button" onclick="checkDuplicateId()">중복 확인</button>
						<br> <span style="color: red; font-size: small;"> ※ 5자
							이상 20자 이하의 영어 / 숫자를 사용해서 입력해주세요.</span></td>
				</tr>
				<tr>
					<th><label for="userPwd">비밀번호</label></th>
					<td><input type="password" name="userPwd" id="userPwd"
						required placeholder="Password"> <br> <span
						style="color: red; font-size: small;"> ※ 8자리 이상 16자리 이하의 영어
							/ 숫자 / 특수문자(@,$,!,%,*,#,?,&)를 사용해서 입력해주세요.</span></td>
				</tr>
				<tr>
					<th><label for="userPwdCheck">비밀번호 확인</label></th>
					<td><input type="password" name="userPwdCheck"
						id="userPwdCheck" required placeholder="Password Check"></td>
				</tr>
				<tr>
					<th><label for="userName">회원 이름</label></th>
					<td><input type="text" name="userName" id="userName" required
						placeholder="Name"></td>
				</tr>
				<tr>
					<th><label for="userPhone">전화 번호</label></th>
					<td><input type="text" name="userPhone" id="userPhone"
						placeholder="Phone" required oninput="onPhoneChange(event);"></td>
				</tr>
				<tr>
					<th><label for="userEmail">이메일</label></th>
					<td><input type="text" name="userEmail" id="userEmail"
						value="" placeholder="E-mail" oninput="emailChecked=false;">
						<span>@</span> <input id="userEmailDomain" name="userEmailDomain"
						placeholder="이메일을 선택하세요." oninput="emailChecked=false;"> <select
						id="select">
							<option value="" disabled selected>E-Mail 선택</option>
							<option value="naver.com" id="naver.com">naver.com</option>
							<option value="hanmail.net" id="hanmail.net">hanmail.net</option>
							<option value="gmail.com" id="gmail.com">gmail.com</option>
							<option value="nate.com" id="nate.com">nate.com</option>
							<option value="directly" id="textEmail">직접 입력</option>
					</select>
						<button type="button" onclick="checkDuplicateEmail()">인증 확인</button>
				</tr>
				<tr>
					<th><label for="userAddress1">주소</label></th>
					<td><input name="userAddress1" id="userAddress1" type="text"
						placeholder="Zip Code" readonly onclick="findAddr()"> <input
						name="userAddress2" id="userAddress2" type="text"
						placeholder="Address" readonly> <br> <input
						type="text" name="userAddress3" id="userAddress3"
						placeholder="Detailed Address"></td>
				</tr>
			</table>

			<br>

			<div id="agree">
				<label for="agree_all"> <input type="checkbox"
					name="agree_all" id="agree_all"> <span>💗모두 동의합니다</span>
				</label> <br> <label for="agree"> <input type="checkbox"
					name="agree" value="1"> <span>이용약관 동의<strong>
							(필수)</strong></span>
				</label> <br> <label for="agree"> <input type="checkbox"
					name="agree" value="2"> <span>개인정보 수집 동의<strong>
							(필수)</strong></span>
				</label> <br> <label for="agree"> <input type="checkbox"
					name="agree" value="3"> <span>개인정보 이용 동의<strong>
							(필수)</strong></span>
				</label> <br> <label for="agree"> <input type="checkbox"
					name="agree" value="4"> <span>이벤트, 혜택정보 수신동의<strong
						class="select_disable"> (선택)</strong></span>
				</label>
			</div>
			<br>

			<div id="divBtn">
				<button type="button" onclick="userAdd();">회원가입</button>
				<button type="button" onclick="location.href='/shop/'">회원가입
					취소</button>
			</div>
			<br>
		</form>
	</main>
	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>

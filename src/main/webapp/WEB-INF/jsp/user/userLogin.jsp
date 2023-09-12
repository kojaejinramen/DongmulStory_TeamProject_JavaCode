<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>동물이야기 로그인</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
   function login() {
       var formdata = $('#loginForm').serialize();
   
       $.ajax({
           url : "/user/login",
           data : formdata,
           method : "post",
           cache : false,
           dataType : 'json',
           success : function (res) {
               if (res.login) {
                   alert("로그인 성공");
                   location.href = "/shop/";
               } else {
                   alert("아이디 또는 비밀번호를 확인해 주세요");
               }
           },
           error : function (err) {
               alert('에러:' + err);
           }
       });
       return false;
   }
</script>

<style type="text/css">
   .main {
        font-family: 'Arial', sans-serif;
        background-color: #fef5cc; /* 배경색 노랑색으로 변경 */
        color: #574d00; /* 글자색 주황색으로 변경 */
        width: 700px;
        margin: 20px auto;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        padding: 20px;
       text-align: center;
       border-radius: 10px; /* 폼의 테두리를 둥글게 10px로 설정합니다. */
    }

    h3 {
        color: #574d00; /* 제목 글자색 주황색으로 변경 */
    }

    form div {
        margin-bottom: 10px;
        text-align: center;
    }

   table { 
	   width: 225px;
	   margin: auto auto;
	   }
   
    input[type="text"],
    input[type="password"] {
        border: 2px solid #f3e268; /* 입력창 테두리 노랑색으로 변경 */
        padding: 8px;
    }

    button {
        background-color: #f8ca84; /* 버튼 배경색 노랑색으로 변경 */
        color: #fff; /* 버튼 글자색 주황색으로 변경 */
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 5px;
        border-radius: 5px;
        outline: none;
        width: 145px;
    }
	label {
		margin-right: 16px;
	}
    button:hover {
        background-color: #fdd29b; /* 마우스 오버 시 버튼 배경색 연한 노랑색으로 변경 */
    }

    #but button {
    	background-color: #ccc;
    	color: #574d00;
    }
    
	#but button:hover {
        background-color: #dddddd; /* 마우스 오버 시 버튼 배경색 연한 회색으로 변경 */
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
      <h3>동물이야기 로그인</h3>
      <form id="loginForm" onsubmit="return login();">
        <table>
        <tr>
        	<th><label for="userId">👤</label></th>            
        	<td><input type="text" id="userId" name="userId" placeholder="아이디"></td>
        </tr>
        <tr>
        	<th><label for="userPwd">🗝</label></th>
            <td><input type="password" id="userPwd" name="userPwd" placeholder="비밀번호"></td>
        </tr>
    </table>
         
         <div>
          	<br>
            <button type="submit">로그인</button>
            <button type="reset">취소</button>
            <br>
            <div id="but">
            <button type="button" onclick="location.href='/user/add'">회원가입</button>
            <button type="button" onclick="location.href='/user/findid'">아이디 찾기</button>
            <button type="button" onclick="location.href='/user/findpwd'">비밀번호 찾기</button>
            </div>
         </div>
      </form>
   </main>
   
   <div class="bottom-index">
      <%@ include file="../bottom.jsp" %>
   </div>
</body>
</html>

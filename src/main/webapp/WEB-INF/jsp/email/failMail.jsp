<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>이메일 인증 실패</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
    }
    .container {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        text-align: center;
    }
    h1 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    p {
        font-size: 16px;
        margin-bottom: 20px;
    }
    .button {
        display: inline-block;
        padding: 10px 20px;
        font-size: 16px;
        background-color: #dc3545; /* 수정: 실패 색상 */
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
    }
    .button:hover {
        background-color: #bb2b39; /* 수정: 실패 색상 */
    }
</style>
</head>
<body>
<div class="container">
    <h1>이메일 인증 실패</h1>
    <p>이메일 인증에 실패하였습니다.</p>
    <a href="#" onclick="closeWindow();" class="button">창 닫기</a>
</div>

<script type="text/javascript">
function closeWindow() {
    window.close();
}
</script>
</body>
</html>

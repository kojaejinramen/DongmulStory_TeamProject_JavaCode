<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>bottomIndex</title>
<style>
	
  /* div 요소들을 옆으로 배치하는 CSS 스타일 */
  .bottom {
    display: flex; /* flexbox를 사용하여 가로 레이아웃 생성 */
    justify-content: space-between; /* div 요소들 사이에 간격 추가 */
    max-width: 1200px; /* 내용물의 최대 너비를 제한합니다. */
    margin: 0 auto; /* 내용물을 수평으로 가운데 정렬합니다. */
  }

  /* information div들을 동일한 너비로 조정 */
  .bottom > div {
    flex-basis: calc(33.33% - 10px); /* 화면 너비의 1/3을 차지하도록 설정합니다. */
    padding: 10px;
    border: none; /* 박스 경계선 제거 */
    font-size: 14px; /* 글씨 크기를 14px로 설정합니다. */
    color: #888; /* 글씨 색을 회색(#888)으로 설정합니다. */
    text-align: center; /* 텍스트들 가운데 정렬 */
  }

  /* 첫 번째 div에만 밑줄 추가 */
  .bottom > div:first-child {
    text-decoration: underline; 
  }
  
  #logo {
  	margin-top: 10px;
  }
  
   .logo-image {
        width: 35px;
        height: 35px;
        border-radius: 50%; /* 50%로 설정하여 동그랗게 만듭니다 */
        overflow: hidden; /* 넘치는 부분을 숨깁니다 */
        object-fit: cover;
        margin-right: 5px; 
    }
</style>
</head>
<body>
<main>
<hr>
<div class="bottom">
  <div>
    <div id="img">
      <img alt="동물이야기" src="/files/동물이야기.jpg" width="250px" height="80px">
    </div>
    <div><strong>사업자등록번호</strong></div><div>402-01-23456</div>
  </div>
  <div>
    <div id="information_1">
      <div><strong>문자전용 고객센터</strong></div>
      <div>010-1234-5678</div>
      <div>누락/오배송/파손 등 사진접수</div>
      <div>주문사이트, 주문자명, 내용메모 남겨주시면 빠른처리 하도록 하겠습니다. (거래명세서참조)</div>
    </div>
  </div>
  <div>
    <div id="information_2">
      <div><strong>쇼핑몰 고객센터</strong></div>
      <div>1544-1234</div>
      <div>월~금 PM 06:00 마감</div>
      <div>주말/공휴일 휴무</div>
      <div>Fax : 02-1234-5689</div>
      <div>Mail : dongmul@gmail.com</div>
    </div>
  </div>
  <div>
    <div id="information_3">
      <div><strong>상호</strong></div><div>(주)동물이야기</div>
      <div><strong>계좌번호</strong></div><div>농협 352-1234-5678-33</div>
      <div><strong>주소</strong></div><div>서울 관악구 신림동 123-45</div>
      	<div id="logo" >
     	 <a href="http://www.facebook.com"><img class="logo-image" alt="페이스북" src="/files/페이스북.jpg"></a>
     	 <a href="http://www.instagram.com"><img class="logo-image" alt="인스타그램" src="/files/인스타그램.png"></a>
     	 <a href="http://section.blog.naver.com/BlogHome.naver?directoryNo=0&currentPage=1&groupId=0"><img class="logo-image" alt="네이버블로그" src="/files/네이버.jpeg"></a>
     	 <a href="http://www.youtube.com"><img class="logo-image" alt="유튜브" src="/files/유튜브.jpg"></a>
    	</div>
    </div>
  </div>
</div>
</main>
</body>
</html>

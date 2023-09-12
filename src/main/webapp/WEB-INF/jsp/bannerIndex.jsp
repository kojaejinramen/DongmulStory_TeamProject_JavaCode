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
// 최근본 상품 기능

// 로그인 정보에 따라 최근 본 상품 다르게 담기
var userId = "${userId}";

// 사용자 식별 정보를 기반으로 로컬 스토리지 키를 생성
var storageKey = "myValues_" + userId;

$(document).ready(function() {
     var storedValues = JSON.parse(localStorage.getItem(storageKey)) || [];
    
     // 데이터가 4개 이상일때만 가장 오래된 데이터를 삭제 
     if (storedValues.length >4) {
        storedValues.shift();
     }
     
     var $cookieValueWrapper = $("#cookieValueWrapper");
     $cookieValueWrapper.empty();
      
     console.log(storedValues);
     
     for (var i = storedValues.length - 1; i >= 0; i--) {
       var value = storedValues[i];
       var $itemWrapper = $("<div>").addClass("item");
       
    	// 상품 이름이 너무 길면 자르기
       var truncatedName = value.itemName.length > 25 ? value.itemName.slice(0, 25) + '...' : value.itemName;
       
       var $valueElement = $("<div>").text(truncatedName);
       var $imageElement = $("<img>").attr("src", value.image);
       var $linkElement = $("<a>").attr("href","/shop/detail/"+value.animal+"/"+value.typeNum+"/"+value.pageNum+"/"+value.itemNum);
       
       $linkElement.append($valueElement);
       $linkElement.append($imageElement);
       $itemWrapper.append($linkElement);
       
       $cookieValueWrapper.append($itemWrapper);
       
     }
     
  	// 지우기 버튼 클릭 시, localStorage 데이터를 삭제하고 화면 갱신
     $("#clearButton").click(function() {
        localStorage.removeItem(storageKey);
        $cookieValueWrapper.empty();
        $("#recentlyViewedWrapper").hide(); // 최근 본 상품 숨기기
     });
  	
     // 초기 로딩 시 최근본 상품 목록이 비어있으면 버튼 숨김
     if (storedValues.length === 0) {
         $("#recentlyViewedWrapper").hide(); // 최근본 상품 숨기기
     } else {
         toggleClearButtonVisibility(true);
     }
   });

//최근 본 상품 지우기 버튼의 표시 여부를 변경하는 함수
function toggleClearButtonVisibility(isVisible) {
    var clearButton = $("#clearButton");
    if (isVisible) {
        clearButton.show();
    } else {
        clearButton.hide();
    }
}

</script>
<style type="text/css">
	/* 배너 목록 스타일 */
	ul.banner-list {
		list-style-type: none;
		margin: 0;
		padding: 0;
		display: flex;
		gap: 3.5em; /* 배너 간격 */
		justify-content: center;
		background-color: #f2f2f2;
	}

	/* 배너 글씨 스타일 */
	.banner-list li{
		transition: color 0.3s; /* 색상 변경에 애니메이션 효과 추가 */
	}

	
	/* 각 동물별 배너에 대한 스타일 */
	#dog.banner-item:hover, #dog.banner-item a:hover {
		cursor: pointer;
	  	color: white;
	}
	#cat.banner-item:hover, #cat.banner-item a:hover {
		cursor: pointer;
	  	color: orange;
	}
	#mouse.banner-item:hover, #mouse.banner-item a:hover {
		cursor: pointer;
	  	color: gray;
	}
	#dragon.banner-item:hover, #dragon.banner-item a:hover {
		cursor: pointer;
	  	color: green;
	}
	#bird.banner-item:hover, #bird.banner-item a:hover {
		cursor: pointer;
	  	color: red;
	}

	/* 목록 항목(버튼) 스타일 */
	ul.banner-list li {
		text-align:center;
		font-size:large;
		border-radius: 4px;
		position: relative; /* To handle hidden list position */
		padding: 12px 20px; /* Increased padding */
	}
	
	/* 활성화된 항목 스타일(선택된 카테고리) */
	ul.banner-list li.active {
		background-color: #4CAF50;
		color: white;
	}
	/* 숨겨진 목록 스타일 */
	.hidden-list {
		display: none;
		position: absolute;
		top: calc(100%); /* Position below the parent item with 4px gap */
		left: 0;
		background-color: #fff;
		box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
		z-index: 1;
		white-space: nowrap; /* Prevent line breaks within the hidden list */
		list-style-type: none;
		padding: 0;
		margin: 0 auto;
		width: 100%;
	}
	.hidden-list li {
		border: 1px solid #ddd;
	}
	
	/* 숨겨진 목록 항목 스타일 */
	.hidden-list a {
		display: block; /* Display hidden list items as block elements */
		color:black;
		font-weight:normal;
		text-decoration: none;
	}
	#dog {width:15%; background-color: #bbbbbb; padding: 2px 0; font-weight:bold;}
	#cat {width:15%; background-color: #ffffde; padding: 2px 0; font-weight:bold;}
	#mouse {width:15%; background-color: #ffdfdf; padding: 2px 0; font-weight:bold;}
	#dragon {width:15%; background-color: #ddeeff; padding: 2px 0; font-weight:bold;}
	#bird {width:15%; background-color: #deeede; padding: 2px 0; font-weight:bold;}
	
.floating-wrapper {
       
      position: fixed;
      margin: 63px 2px;
      right: 10px; /* 오른쪽 위치 조정///////  최근본 박스 */
      top: 10px; /* 위쪽 위치 조정 */
      width: 180px; /* 플로팅 요소의 너비 */
      padding: 10px; /* 내부 여백 */
      background-color: #f1f1f1; /* 배경색 */
      border: 1px solid #ddd; /* 테두리 스타일 */
      border-radius: 5px; /* 테두리 둥글게 */
      font-size: 13px;
      text-align: center;
    }

    .floating-wrapper .item {
      margin-bottom: 10px; /* 각 요소 사이의 간격 */
    }

    .floating-wrapper .item img {
   max-width: 50%;
  max-height: 100px; /* 이미지의 최대 높이를 150px로 조정 */
  object-fit: contain; /* 이미지가 비율을 유지하면서 컨테이너에 맞게 조정되도록 함 */
    }
    
    .floating-wrapper a {
		color: blue;
		text-decoration: underline;    	
    }
    .floating-wrapper a:hover {
		color: black;    	
    }
    
    .clear-button {
   background-color: #f44336;
   border: none;
   color: white;
   padding: 8px 16px;
   text-align: center;
   text-decoration: none;
   display: inline-block;
   font-size: 13px;
   border-radius: 4px;
   cursor: pointer;
   margin-top: 10px;
   width: 100%;
}

.clear-button:hover {
   background-color: #f47766;
   color: white;
}

</style>
</head>
<body>
  <!-- 배너 목록 -->
  <ul class="banner-list">
  	<div id="dog" class="banner-item">
    <li onmouseover="showSubList('dog')" onmouseout="hideSubList('dog')" 
    						onclick="location.href='/shop/list/dog/1/1'">
    🐶강아지
      <ul class="hidden-list" id="dog-sublist">
        <a href="/shop/list/dog/1/1"><li>사료</li></a>
        <a href="/shop/list/dog/2/1"><li>간식</li></a>
        <a href="/shop/list/dog/3/1"><li>집</li></a>
        <a href="/shop/list/dog/4/1"><li>옷</li></a>
        <a href="/shop/list/dog/5/1"><li>장난감</li></a>
        <a href="/shop/list/dog/6/1"><li>기타</li></a>
        <!-- 추가적인 강아지 종류를 여기에 추가할 수 있습니다 -->
      </ul>
     </li>
    </div>
    
    <div id="cat" class="banner-item">
    <li onmouseover="showSubList('cat')" onmouseout="hideSubList('cat')"
    						onclick="location.href='/shop/list/cat/1/1'">
    😻고양이
      <ul class="hidden-list" id="cat-sublist">
      	<a href="/shop/list/cat/1/1"><li>사료</li></a>
        <a href="/shop/list/cat/2/1"><li>간식</li></a>
        <a href="/shop/list/cat/3/1"><li>집</li></a>
        <a href="/shop/list/cat/4/1"><li>옷</li></a>
        <a href="/shop/list/cat/5/1"><li>장난감</li></a>
        <a href="/shop/list/cat/6/1"><li>기타</li></a>
        <!-- 추가적인 고양이 종류를 여기에 추가할 수 있습니다 -->
      </ul>
    </li>
    </div>
    
    <div id="mouse" class="banner-item">
    <li onmouseover="showSubList('mouse')" onmouseout="hideSubList('mouse')"
    						onclick="location.href='/shop/list/mouse/1/1'">
    🐹햄스터
      <ul class="hidden-list" id="mouse-sublist">
      	<a href="/shop/list/mouse/1/1"><li>사료</li></a>
        <a href="/shop/list/mouse/2/1"><li>간식</li></a>
        <a href="/shop/list/mouse/3/1"><li>집</li></a>
        <a href="/shop/list/mouse/4/1"><li>옷</li></a>
        <a href="/shop/list/mouse/5/1"><li>장난감</li></a>
        <a href="/shop/list/mouse/6/1"><li>기타</li></a>
        <!-- 추가적인 설치류를 여기에 추가할 수 있습니다 -->
      </ul>
    </li>
    </div>
    
    <div id="dragon" class="banner-item">
    <li onmouseover="showSubList('dragon')" onmouseout="hideSubList('dragon')"
    						onclick="location.href='/shop/list/dragon/1/1'">
      🐸개구리
      <ul class="hidden-list" id="dragon-sublist">
     	<a href="/shop/list/dragon/1/1"><li>사료</li></a>
        <a href="/shop/list/dragon/2/1"><li>간식</li></a>
        <a href="/shop/list/dragon/3/1"><li>집</li></a>
        <a href="/shop/list/dragon/4/1"><li>옷</li></a>
        <a href="/shop/list/dragon/5/1"><li>장난감</li></a>
        <a href="/shop/list/dragon/6/1"><li>기타</li></a>
        <!-- 추가적인 파충류를 여기에 추가할 수 있습니다 -->
      </ul>
    </li>
    </div>
    
    <div id="bird" class="banner-item">
    <li onmouseover="showSubList('bird')" onmouseout="hideSubList('bird')"
							onclick="location.href='/shop/list/bird/1/1'">
    🐦앵무새
      <ul class="hidden-list" id="bird-sublist">
        <a href="/shop/list/bird/1/1"><li>사료</li></a>
        <a href="/shop/list/bird/2/1"><li>간식</li></a>
        <a href="/shop/list/bird/3/1"><li>집</li></a>
        <a href="/shop/list/bird/4/1"><li>옷</li></a>
        <a href="/shop/list/bird/5/1"><li>장난감</li></a>
        <a href="/shop/list/bird/6/1"><li>기타</li></a>
        <!-- 추가적인 조류를 여기에 추가할 수 있습니다 -->
      </ul>
    </li>
    </div>
  </ul>
  <c:if test="${userId ne NULL && userId ne 'dongmul'}">
  <div class="floating-wrapper" id="recentlyViewedWrapper" >
      <div class="title">(최근 본 상품)</div>
       <div id="cookieValueWrapper" class="cookie-Value-Wrapper">
    
       </div>
       <button id="clearButton" class="clear-button">최근 본 상품 지우기</button>
    </div> 
  </c:if>
 <script>
  function showSubList(category) {
    // 모든 숨겨진 목록을 감춥니다
    var hiddenLists = document.getElementsByClassName('hidden-list');
    for (var i = 0; i < hiddenLists.length; i++) {
      hiddenLists[i].style.display = 'none';
    }

    // 선택한 카테고리의 숨겨진 목록을 보여줍니다
    var sublist = document.getElementById(category + '-sublist');
    if (sublist) {
      sublist.style.display = 'block';
    }
  }

  function hideSubList(category) {
    // 선택한 카테고리의 숨겨진 목록을 숨깁니다
    var sublist = document.getElementById(category + '-sublist');
    if (sublist) {
      sublist.style.display = 'none';
    }
  }
  
//숨겨진 목록 칸에 각각 다른 마우스 오버 효과 추가

  function addMouseOverEffect(hiddenListItems, backgroundColor) {
	  for (var i = 0; i < hiddenListItems.length; i++) {
	    hiddenListItems[i].addEventListener('mouseover', function () {
	      this.style.backgroundColor = backgroundColor;
	      this.style.boxShadow = '0 8px 16px rgba(0, 0, 0, 0.2)';
	    });
	    hiddenListItems[i].addEventListener('mouseout', function () {
	      this.style.backgroundColor = 'transparent';
	      this.style.boxShadow = 'none';
	    });
	  }
	}

	var hiddenListItemsDog = document.querySelectorAll('#dog-sublist li');
	var hiddenListItemsCat = document.querySelectorAll('#cat-sublist li');
	var hiddenListItemsMouse = document.querySelectorAll('#mouse-sublist li');
	var hiddenListItemsDragon = document.querySelectorAll('#dragon-sublist li');
	var hiddenListItemsBird = document.querySelectorAll('#bird-sublist li');

	addMouseOverEffect(hiddenListItemsDog, '#bbbbbb');
	addMouseOverEffect(hiddenListItemsCat, '#ffffde');
	addMouseOverEffect(hiddenListItemsMouse, '#ffdfdf');
	addMouseOverEffect(hiddenListItemsDragon, '#ddeeff');
	addMouseOverEffect(hiddenListItemsBird, '#deeede');
  
</script>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" crossorigin="anonymous" />
<head>
<meta charset="utf-8">
<title>Shopping List</title>
<c:choose>
	<c:when test="${animal eq 'dog'}">
		<c:set var="color" value="#bbbbbb"/>
	</c:when>
	<c:when test="${animal eq 'cat'}">
		<c:set var="color" value="#ffffde"/>
	</c:when>
	<c:when test="${animal eq 'mouse'}">
		<c:set var="color" value="#ffdfdf"/>
	</c:when>
	<c:when test="${animal eq 'dragon'}">
		<c:set var="color" value="#ddeeff"/>
	</c:when>
	<c:when test="${animal eq 'bird'}">
		<c:set var="color" value="#deeede"/>
	</c:when>
</c:choose>
<style type="text/css">
	#menu {width: 1000px; text-align: center; margin: 0 auto; }
	#menu > button {width: 140px; padding: 7px; margin: 0 10px; border-color: black; background-color: #eee; border: 0; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 20px; /* 둥근 테두리 */}
	#menu > #change {width: 140px; padding: 7px; margin: 0 10px; border-color: black; background-color: ${color}; border: none; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 20px; /* 둥근 테두리 */}
	#menu > button > d {font-weight: bold; width: 80px; color: #555; padding: 5px 10px;}
	#menu > #change > d {font-weight: 900; width: 80px; color: black; padding: 5px 10px;}
	#search {display: inline-block;}
	#search > button {padding: 3px 10px; border: none; background-color: ${color}; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);}
	#searchResult {display: inline-block; margin-left: 10px;}
	.main {width:1000px;  padding: 10px 10px; margin: 20px auto; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 20px; /* 둥근 테두리 */}
	#itemBox{width: 220px; height: 300px; padding: 0px 1px; margin: 20px 0px; border:0; background-color: ${color}; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); border-radius: 5px; /* 둥근 테두리 */}
    #itemNameBox {
        display: inline-block;
        width: 90%;
        margin-bottom: 10px;
        border: 2px solid black;
        border-radius: 20px;
        background-color:white;
        padding: 5px 5px;
        font-weight:bold;
        overflow: hidden; /* 넘치는 텍스트를 숨깁니다. */
        white-space: nowrap; /* 텍스트가 한 줄을 넘어가도록 하지 않습니다. */
        text-overflow: ellipsis; /* 넘치는 부분을 생략 부호(...)로 표시합니다. */
    }
    #itemBox:hover > #itemNameBox{
	    white-space: normal; /* 마우스 호버 시 텍스트를 여러 줄로 표시하여 전체 내용을 보여줍니다. */
	}
	#itemImgBox {display:inline-block; width: 214px; height: 200px; background-color: white;}
	#itemImg {width: 100%; height: 200px;}
	#itemPriceBox {display:inline-block; }
    /* 상품들을 한 줄에 4개씩 배치하고 왼쪽 정렬하는 CSS 스타일 */
	.container {
	    width: 1000px; /* 상품들을 포함하는 컨테이너의 너비를 지정합니다. */
	    margin: 0 auto; /* 컨테이너를 가운데 정렬합니다. */
	    height: 700px;
	}
	
	.items {
	    width: calc(25% - 30px); /* 한 줄에 4개씩 배치하기 위한 너비 계산. 여백을 고려하여 30px 빼줍니다. */
	    margin: 10px; /* 상품 버튼 사이의 간격을 조정합니다. */
	    display: inline-block; /* 상품들을 인라인 블록 요소로 배치합니다. */
	    text-align: left; /* 내용을 왼쪽 정렬합니다. */
	}

	.page-box {
		width: 960px;
		margin: 20px auto;
		text-align: center;
		padding: 10px;
	}

	.page-box a {
		padding: 6px 0;
		margin: 0 5px;
		color: black;
		text-decoration: none;
	}

	.page-box b {
		display: inline-block;
    	width: 50px;
    	border-radius: 20px; /* 둥근 테두리 */
    	color: black;
    	font-weight: bold;
    	background-color: ${color};
		
	}
	button:hover {
	    cursor: pointer;
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
	<div id="menu">
		<c:if test="${typeNum eq 1 }">
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>	
			<button type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
		<c:if test="${typeNum eq 2 }">
			<button type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
		<c:if test="${typeNum eq 3 }">
			<button type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
		<c:if test="${typeNum eq 4 }">
			<button type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
		<c:if test="${typeNum eq 5 }">
			<button type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
		<c:if test="${typeNum eq 6 }">
			<button type="button" onclick="location.href='/shop/list/${animal}/1/1'"><d>사료</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/2/1'"><d>간식</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/3/1'"><d>집</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/4/1'"><d>옷</d></button>
			<button type="button" onclick="location.href='/shop/list/${animal}/5/1'"><d>장난감</d></button>
			<button id="change" type="button" onclick="location.href='/shop/list/${animal}/6/1'"><d>기타</d></button>
		</c:if>
	</div>
	
	<div>
	<form action="/shop/searchList/${animal}/${typeNum}/1" method="get">
		<fieldset>
			<legend>검색</legend>
			<div id="search">
				<select name="category">
					<option value="name"><d>상품명</d></option>
					<option value="contents"><d>내용</d></option>
					<option value="price"><d>가격</d></option>
				</select>&nbsp;
				<input name="keyword" type="text">
				<button type="submit">검색</button>
				<button type="reset">취소</button>
			</div>
			<div id="searchResult">
			<c:if test="${category != null}">
			<c:set var="go_list" value="/shop/list/${animal}/${typeNum}/1"/>
				<c:choose>
					<c:when test="${category eq 'name'}">
						<nav>[ 상품명 : ${keyword} ](으)로 검색한 결과 <button type="button" onclick="location.href='${go_list}'">[X]</button></nav>
					</c:when>
					<c:when test="${category eq 'contents'}">
						<nav>[ 내용 : ${keyword} ](으)로 검색한 결과 <button type="button" onclick="location.href='${go_list}'">[X]</button></nav>
					</c:when>
					<c:when test="${category eq 'price'}">
						<nav>[ 가격 : ${keyword} ](으)로 검색한 결과 <button type="button" onclick="location.href='${go_list}'">[X]</button></nav>
					</c:when>
				</c:choose>
			</c:if>
			</div>
		</fieldset>
	</form>
	</div>
	
	
	<div class="container">
		<c:forEach var="map" items="${pageInfo.list}">
			<div class="items">
				<c:if test="${category ne null}">
					<c:url var="url" value="/shop/detail/${animal}/${typeNum}/${pageNum}/${map.itemNum}?category=${category}&keyword=${keyword}"/>
				</c:if>	
				<c:if test="${category eq null}">
					<c:url var="url" value="/shop/detail/${animal}/${typeNum}/${pageNum}/${map.itemNum}"/>
				</c:if>
				<button id="itemBox" type="button" onclick="location.href='${url}'">			
					<div id="itemNameBox">${map.itemName}</div>
					<div id="itemImgBox"><img id="itemImg" alt="상품 이미지" src="/files/${animal}/${map.ShowFile}"></div>
					<div id="itemPriceBox">가격 : <b><fmt:formatNumber value="${map.itemPrice}" pattern="#,###"/>원</b></div> 
				</button>
			</div>
		</c:forEach>
	</div>
	
	<div class="page-box">
		<c:if test="${pageInfo.hasPreviousPage}">
			<c:if test="${category == null}">
				<a href="/shop/list/${animal}/${typeNum}/${pageInfo.prePage}"><i class="fas fa-chevron-left"></i></a>
			</c:if>
			<c:if test="${category != null}">
				<a href="/shop/searchList/${animal}/${typeNum}/${pageInfo.prePage}?category=${category}&keyword=${keyword}"><i class="fas fa-chevron-left"></i></a>
			</c:if>
		</c:if>
		<c:forEach var="p" items="${pageInfo.navigatepageNums}">
			<c:choose>
				<c:when test="${p eq pageInfo.pageNum}"> 
					<b style="margin:5px 5px;">${p}</b>
				</c:when>
				<c:otherwise> 
					<c:if test="${category == null}">
						<a href="/shop/list/${animal}/${typeNum}/${p}">${p}</a>		
					</c:if>
					<c:if test="${category != null}">
						<a href="/shop/searchList/${animal}/${typeNum}/${p}?category=${category}&keyword=${keyword}">${p}</a>	
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pageInfo.hasNextPage}">
			<c:if test="${category == null}">
				<a href="/shop/list/${animal}/${typeNum}/${pageInfo.nextPage}"><i class="fas fa-chevron-right"></i></a>
			</c:if>
			<c:if test="${category != null}">
				<a href="/shop/searchList/${animal}/${typeNum}/${pageInfo.nextPage}?category=${category}&keyword=${keyword}"><i class="fas fa-chevron-right"></i></a>
			</c:if>
		</c:if>
	</div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>

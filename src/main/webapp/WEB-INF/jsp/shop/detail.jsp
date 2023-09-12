<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Detail Form</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	// 최근 본 상품 데이터 담기
	$(document).ready(function() {
	    var itemName = "${map.itemName}";
	   	var image = "/files/${animal}/${map.ShowFile}";
	    var itemNum = "${map.itemNum}";
	    var animal = "${animal}"
	    var typeNum = "${typeNum}"
	    var pageNum = "${pageNum}"
	   	// 로그인 정보얻어옴
	   	var userId = "${userId}";
	   	// 사용자 식별 정보를 기반으로 로컬 스토리지 키를 생성(아이디마다 다르게 최근 본 상품 담기)
	   	var storageKey = "myValues_" + userId;
	    var storedValues = JSON.parse(localStorage.getItem(storageKey)) || [];
	    // 데이터가 4개 이상일때만 가장 오래된 데이터를 삭제 
	    if (storedValues.length >4) { 
	       storedValues.shift();
	    }
	    storedValues = storedValues.filter(function(value) {
	         return value.itemName !== itemName;
	       });
	    var newdata= {
	    		itemName: itemName,
	         	image: image,
	         	itemNum: itemNum,
	          	animal: animal,
	          	typeNum: typeNum,
	          	pageNum: pageNum
	    };
	    storedValues.push(newdata);
	    localStorage.setItem(storageKey, JSON.stringify(storedValues));
	    // 최근본 상품 목록 렌더링
	    var $cookieValueWrapper = $("#cookieValueWrapper");
	    $cookieValueWrapper.empty();
	    
	    for (var i = storedValues.length - 1; i >= 0; i--) {
	       var value = storedValues[i];
	       var $itemWrapper = $("<div>").addClass("item");
	       var $valueElement = $("<div>").text(value.itemName);
	       var $imageElement = $("<img>").attr("src", value.image);
	       var $linkElement = $("<a>").attr("href","/shop/detail/"+value.animal+"/"+value.typeNum+"/"+value.pageNum+"/"+value.itemNum);
	       $linkElement.append($valueElement);
	       $linkElement.append($imageElement);
	       $itemWrapper.append($linkElement);
	       $cookieValueWrapper.append($itemWrapper);
	    }
	});
	
	function go_cart() {
		if(!confirm('위 상품을 장바구니에 추가하시겠습니까?')) return ;
		
		if(${userId eq null}){
			alert('먼저 로그인 해주세요.');
			return location.href="/user/login";
		}
		
		var cartQuantity = parseInt(document.getElementById('cartQuantity').value); // 아이템 수량을 가져옴
		
	      if (cartQuantity < 1) {
	          alert('장바구니에 담을 수량은 1개 이상이어야 합니다.'); // 수량이 1 미만인 경우 경고 메시지 표시
	          return;
	      }
		
	      if (cartQuantity > 100) {
	          alert('최대 담을 수 있는 수량은 100개 입니다.'); // 수량이 100 초과할 경우 경고 메시지 표시
	          return;
	      }	
		
		var cartData = $('#cart').serialize();
		
		$.ajax({
			url : "/cart/add",
			data : cartData,
			method : 'post',
			dataType : 'json',
			success : function (res) {
				alert(res.result ? "장바구니에 해당 상품이 성공적으로 추가되었습니다." : "***error : 장바구니에 해당 상품을 담는데 실패하였습니다./n로그인을 하지 않으셨다면 로그인 후 이용해 주시기 바랍니다.***");
				if(res.result){
					if(confirm('장바구니로 이동 하시겠습니까?')){
						location.href="/cart/list";
					}
				}
				else {
					location.href="/user/login";
				}
			},
			error: function (err) {
				alert(err);
			}
		});
	}
	
	function go_order(userId,itemNum) {
	     if(!confirm('위 상품을 구매 하시겠습니까?')) return ;
	     
	     if(${userId eq null}){
	        alert('먼저 로그인 해주세요.');
	        return location.href="/user/login";
	     }
	     var cartQuantity = parseInt(document.getElementById('cartQuantity').value); // 아이템 수량을 가져옴
	
	      if (cartQuantity < 1) {
	          alert('구매 수량은 1개 이상이어야 합니다.'); // 수량이 1 미만인 경우 경고 메시지 표시
	          return;
	      }
	     
	      if (cartQuantity > 100) {
	          alert('최대 구매 수량은 100개 입니다.'); // 수량이 100 초과할 경우 경고 메시지 표시
	          return;
	      }
	      
	     $.ajax({
	        url : "/cart/add/oneItem",
	        data: {
	           "cartUserId":userId,
	           "cartItemNum":itemNum,
	           "cartQuantity":cartQuantity
	        },
	        method : 'post',
	        dataType : 'json',
	        success : function (res) {
	           if(res.result){
	                 location.href="/order/lastlist/oneItem?num="+res.num;
	              }
	           },
	        error: function (err) {
	           alert(err);
	        }
	    });
	}
	
	function delete_check(itemNum,url) {
		if(!confirm('위 상품을 영구 삭제하시겠습니까?')) return ;
		
		$.ajax({
			url : "/shop/deleteAll",
			data : {"itemNum" : itemNum},
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function(res){
				alert(res.result ? "상품을 영구적으로 삭제했습니다." : "***error : 상품 삭제에 실패하였습니다.***");
				if(res.result) location.href= url;
			},
			error : function(err){
				alert(err);
			}
		});
	}
</script>
<style type="text/css">
	.main {
		background-color: #eeeeee;
		padding: 5px 100px;
		width: 800px;
		margin: 20px auto;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	#returnButten {
		margin-left: 0;
		margin-bottom: 20px;
		background-color: white;
		width: fit-content;
	}
	
	#returnButten>a {
		color: #33a6b8;
		padding: 5px 5px;
	}
	
	#returnButten>a:hover {
		background-color: #f0f0f0;
		color: black;
	}
	
	button {
		font-size: large;
		padding: 5px 5px;
		background-color: white;
		border: 0;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	#table {
		width: 100%;
		margin: 40px 0;
	}
	
	td>div {
		margin: 10px auto;
		font-weight: bolder;
		font-size: large;
	}
	/* 장바구니 담기 버튼 */
	button {
		font-size: 18px; /* 수량 글씨 크기를 18px로 설정 */
		padding: 10px 10px; /* 버튼의 내부 여백을 수정 */
		background-color: white;
		border: 0;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	/* 마우스를 올렸을 때의 버튼 스타일 */
	button:hover {
		background-color: #f0f0f0;
		color: black;
		cursor: pointer;
	}
	
	/* 수량 input 박스 */
	input[name="cartQuantity"] {
		font-size: 18px; /* 수량 input의 글씨 크기를 18px로 설정 */
		padding: 10px; /* input 내부 여백을 수정 */
		border: 1px solid #ccc; /* 테두리 스타일을 추가하여 시각적으로 구분 */
		border-radius: 5px; /* 둥근 테두리 */
	}
	
	#review {
		background-color: white;
		text-align: center;
	}
	
	#reviewtable {
		width: 100%;
		margin: 0px auto;
		padding: 2px 2px;
		border: none;
	}
	
	#rth {
		height: 50px;
		background-color: #DDD;
		font-size: large;
	}
	
	#rtd {
		height: 72px;
	}
</style>
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
		<c:choose>
			<c:when test="${category ne null}">
				<c:url var="url"
					value="/shop/searchList/${animal}/${typeNum}/${pageNum}">
					<c:param name="category" value="${category}" />
					<c:param name="keyword" value="${keyword}" />
				</c:url>
			</c:when>
			<c:otherwise>
				<c:url var="url" value="/shop/list/${animal}/${typeNum}/${pageNum}" />
			</c:otherwise>
		</c:choose>

		<table id="table">
			<thead>
				<tr>
					<td><img alt="상품 이미지" src="/files/${animal}/${map.ShowFile}"
						width="300px" height="300px"></td>
					<td>
						<div id="returnButten">
							<a href="${url}">🔙 리스트로 돌아가기</a>
						</div>
						<div>상품 번호 : ${map.itemNum}</div>
						<div>상품 이름 : ${map.itemName}</div>
						<div>
							상품 가격 :
							<fmt:formatNumber value="${map.itemPrice}" pattern="#,###" />
							원
						</div>
						<div>상품 설명 :</div>
						<div>${map.itemContents}</div>
						<form id="cart">
							<input type="hidden" name="cartUserId" value="${userId}">
							<input type="hidden" name="cartItemNum" value="${map.itemNum}">
							<input type="number" id="cartQuantity" name="cartQuantity"
								value="1" min="1" max="999">
							<button type="button" onclick="return go_order('${userId}',${map.itemNum})">구매 하기</button>
							<button type="button" onclick="return go_cart()">장바구니 담기</button>
						</form>
					</td>
				</tr>
			</thead>
			<c:if test="${userId eq 'dongmul' }">
				<tbody>
					<tr>
						<td
							style="text-align: center; color: red; padding-bottom: 20px; background-color: #dddddd;"
							colspan="2">
							<h2>관리자 전용 버튼</h2>
							<button type="button"
								onclick="location.href='/shop/update/${animal}/${typeNum}/${pageNum}/${itemNum}?category=${category}&keyword=${keyword}'">상품
								수정</button>
							<button type="button"
								onclick="return delete_check(${itemNum},'${url}')">상품
								삭제</button>
						</td>
					</tr>
				</tbody>
			</c:if>
			<tfoot>
				<c:forEach var="img" items="${imgList}">
					<tr>
						<td colspan="2"><img alt="상품 이미지"
							src="/files/${animal}/${img}" width="800px" height="100%">
						</td>
					</tr>
				</c:forEach>
			</tfoot>
		</table>
		<c:if test="${not empty reviews}">
			<a href="/review/list/${map.itemNum}/page/1"><div colspan="5"
					style="text-align: center; background-color: #555; width: fit-content; padding: 10px 15px; color: white; text-decoration: underline; margin-left: 680px;">리뷰
					더보기</div></a>
			<div id="review">
				<table id="reviewtable">
					<tr id="rth">
						<th>사진</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>평점</th>
					</tr>
					<c:forEach var="r" items="${reviews}">
						<tr id="rtd">
							<td><c:if test="${not empty r.rfileFakeName}">
									<img style="border-radius: 50%; width: 50px; height: 50px;"
										id="img" src="/files/review/${r.rfileFakeName}">
								</c:if> <c:if test="${r.rfileFakeName eq null}">
									<img style="border-radius: 50%; width: 50px; height: 50px;"
										id="img" src="/files/공룡.png">
								</c:if></td>
							<td><a href="/review/detail/get/${r.reviewOrderNum}">${r.reviewTitle}...</a></td>
							<td>${r.reviewUserId}</td>
							<td>${r.reviewDate}</td>
							<td style="font-size: x-large; color: red;">${r.reviewGrade}<d
									style="font-size: small; color: #999;">/5</d></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
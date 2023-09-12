<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 상세보기 페이지</title>
<style type="text/css">
	#main {
		width: 500px;
		margin: 0.3em auto;
		padding: 1em;
		background-color: #fff;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}
	
	h3 {
		text-align: center;
		font-size: 1.8rem;
		margin-bottom: 1em;
		color: #333;
	}
	
	table {
		width: 500px;
		text-align: center;
		border-collapse: collapse;
		border: 1px solid #ccc;
	}
	
	th, td {
		padding: 1em 0.5em;
		border-bottom: 1px solid #ccc;
		color: #555;
	}
	
	th {
		text-align: center;
		width: 30%;
		background-color: #f2f2f2;
	}
	
	td {
		width: 70%;
		vertical-align: middle;
	}
	
	.img-container {
		position: relative;
		display: inline-block;
		width: 350px;
		height: 320px;
	}
	
	.img-container>div>#rfile {
		position: absolute;
		top: 50%;
		transform: translateX(-50%) translateY(-50%); /* 가운데로 이동 */
		max-width: 300px;
		max-height: 300px;
	}
	
	.prev, .next {
		position: absolute;
		top: 50%;
		transform: translateY(-50%);
		background-color: rgba(0, 0, 0, 0.5);
		color: white;
		padding-bottom: 5px;
		width: 40px;
		text-align: center;
		font-size: x-large;
		font-weight: 900;
		opacity: 0.2; /* 투명도 (0~1) */
		transition: opacity 0.3s ease-in-out; /* 0.3초 동안 변화함 */
	}
	
	.prev {
		left: -20px;
	}
	
	.next {
		right: -20px;
	}
	
	.img-container:hover .prev {
		opacity: 1;
		cursor: pointer;
	}
	
	.img-container:hover .next {
		opacity: 1;
		cursor: pointer;
	}
	
	button {
		padding: 0.8em 1.5em;
		background-color: #ccc;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		font-size: 1rem;
		transition: background-color 0.3s ease-in-out;
	}
	
	button:first-child {
		background-color: #33a6b8;
		color: #fff;
	}
	
	button:hover {
		background-color: #268c9e;
	}
	
	#star {
		color: red; /* Add red color to the emoji symbols */
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	//페이지 오픈시 첫번때 리뷰 사진만 보여줌
	$(document).ready(function () {
	   $(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김
	   
	   //setInterval(nextSlide, 4000); //4초(4000)마다 다음 슬라이드로 넘어감
	   
	});
	
	//이전 슬라이드
	function prevSlide() {
	   $(".mySlideDiv").hide(); //모든 div 숨김
	   var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
	   var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
	   
	   //반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
	   $(".mySlideDiv").each(function(index,item){ 
	      if($(this).hasClass("active")) {
	         currentIndex = index;
	      }
	        
	   });
	   
	   //새롭게 나타낼 div의 index
	   var newIndex = 0;
	    
	   if(currentIndex <= 0) {
	      //현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
	      newIndex = allSlide.length-1;
	   } else {
	      //현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
	      newIndex = currentIndex-1;
	   }

	   //모든 div에서 active 클래스 제거
	   $(".mySlideDiv").removeClass("active");
	    
	   //새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
	   $(".mySlideDiv").eq(newIndex).addClass("active");
	   $(".mySlideDiv").eq(newIndex).show();

	}

	//다음 슬라이드
	function nextSlide() {
	   $(".mySlideDiv").hide();
	   var allSlide = $(".mySlideDiv");
	   var currentIndex = 0;
	   
	   $(".mySlideDiv").each(function(index,item){
	      if($(this).hasClass("active")) {
	         currentIndex = index;
	      }
	        
	   });
	   
	   var newIndex = 0;
	   
	   if(currentIndex >= allSlide.length-1) {
	      //현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
	      newIndex = 0;
	   } else {
	      //현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
	      newIndex = currentIndex+1;
	   }

	   $(".mySlideDiv").removeClass("active");
	   $(".mySlideDiv").eq(newIndex).addClass("active");
	   $(".mySlideDiv").eq(newIndex).show();
	   
	}
	

	function delReview(reviewNum) {
	    if(!confirm('현재 리뷰를 삭제할까요?')) return;
	    
	    $.ajax({
	        url: '/review/delete',
	        data: { "reviewNum" : reviewNum},
	        method: 'post',
	        cache: false,
	        dataType: 'json',
	        success: function (res) {
	            alert(res.deleted ? '삭제 성공' : '삭제 실패');
	            if(res.deleted){
	            	location.href="/review/list/page/1";
	            }
	        },
	        error: function (xhr, status, err) {
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

	<main id="main">
		<h3>상세 리뷰</h3>
		<table>
			<c:if test="${rfileList ne null}">
				<tr>
					<td colspan="2">
						<div class="img-container">
							<c:forEach items="${rfileList}" var="rfile" varStatus="loop">
								<c:if test="${loop.index eq 0}">
									<div class="mySlideDiv fade active">
										<img id="rfile" alt="Not Found Images"
											src="/files/review/${rfile}">
									</div>
								</c:if>
								<c:if test="${loop.index ne 0}">
									<div class="mySlideDiv fade">
										<img id="rfile" alt="Not Found Images"
											src="/files/review/${rfile}">
									</div>
								</c:if>
							</c:forEach>
							<c:if test="${rfileList.size() > 1}">
								<a class="prev" onclick="prevSlide()">☜</a>
								<a class="next" onclick="nextSlide()">☞</a>
							</c:if>
						</div>
					</td>
				</tr>
			</c:if>

			<tr>
				<th>작성자</th>
				<td>${review.reviewUserId}</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td>${review.itemName}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${review.reviewDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="5" id="contents">
					<div>${review.reviewContents}</div>
				</td>
			</tr>
			<tr>
				<th>평점</th>
				<td><c:choose>
						<c:when test="${review.reviewGrade == 5}">
							<span id="star">★★★★★</span>
						</c:when>
						<c:when test="${review.reviewGrade == 4}">
							<span id="star">★★★★</span>
						</c:when>
						<c:when test="${review.reviewGrade == 3}">
							<span id="star">★★★</span>
						</c:when>
						<c:when test="${review.reviewGrade == 2}">
							<span id="star">★★</span>
						</c:when>
						<c:when test="${review.reviewGrade == 1}">
							<span id="star">★</span>
						</c:when>
					</c:choose></td>
			</tr>
			<tr>
				<td colspan="2"><c:if
						test="${review.reviewUserId eq userId || userId eq 'dongmul'}">
						<button type="button"
							onclick="location.href='/review/update/${review.reviewOrderNum}'">수정</button>
						<button type="button"
							onclick="javascript:delReview(${review.reviewNum})">삭제</button>
						<button type="button"
							onclick="location.href='/review/list/page/1'">리뷰목록</button>
					</c:if></td>
			</tr>
		</table>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>

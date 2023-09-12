<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 목록 페이지</title>
<style type="text/css">
	#main {
		width: 80%;
		margin: 2em auto;
		padding: 1em;
		background-color: #fff;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}
	h2 {
		text-align: center;
		font-size: 1.8rem;
		margin-bottom: 1em;
		color: #333;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		border: 1px solid #ccc;
	}
	th, td {
		padding: 0.5em 0.5em;
		border-bottom: 1px solid #ccc;
		color: #555;
	}
	th {
		text-align: center;
		background-color: #f2f2f2;
	}
	td {
		text-align: center;
	}
	a {
		color: #33a6b8;
		text-decoration: none;
	}
	a:hover {
		text-decoration: underline;
	}
	#reviewImg {
		width: 50px;
		height: 50px;
		border-radius: 50%;
		object-fit: cover;
	}
	#pagination {
		width: 100%;
		margin: 1em auto;
		text-align: center;
	}
	#pageNum, #pagination a {
		display: inline-block;
		margin: 0 5px;
		padding: 5px 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
		background-color: #fff;
		color: #333;
	}
	#pagination a:hover {
		background-color: #33a6b8;
		color: #fff;
		border-color: #33a6b8;
	}
	#star {
    	color: red; /* Add red color to the emoji symbols */
	}
	button {
		padding: 0.8em 1.5em;
		background-color: #33a6b8;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		font-size: 1rem;
		transition: background-color 0.3s ease-in-out;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
	  <%@ include file="../topIndex.jsp" %>
	</div>
	
	<main id="main">
		<c:if test="${notItem eq null}">
			<h2>상품 리뷰 목록</h2>
		</c:if>
		<c:if test="${notItem eq 'dongmul'}">
			<h2>관리자 리뷰 관리</h2>
		</c:if>
		<c:if test="${notItem ne null and notItem ne 'dongmul'}">
			<h2>개인 리뷰 관리</h2>
		</c:if>
		<table>
			<thead>
				<tr>
					<th>상품번호</th>
					<th>상품명</th>
					<th>사진</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>평점</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="r" items="${pageInfo.list}">	
					<tr>
						<td>${r.reviewItemNum}</td>
						<td>${r.itemName}</td>
						<td>
							<c:if test="${r.ShowFile eq null}">
		                    	<img id="reviewImg" src="/files/공룡.png">
		                  	</c:if>
			                <c:if test="${r.ShowFile ne null}">
			                	<img id="reviewImg" src="/files/review/${r.ShowFile}">
			                </c:if>
						</td>
						<td><strong><a href="/review/detail/get/${r.reviewOrderNum}">${r.reviewTitle}...</a></strong></td>
						<td>${r.reviewUserId}</td>
						<td style="width: 90px;">${r.reviewDate}</td>
						<td>
			            <c:choose>
			              <c:when test="${r.reviewGrade == 5}">
			                <span id="star">★★★★★</span>
			              </c:when>
			              <c:when test="${r.reviewGrade == 4}">
			                <span id="star">★★★★</span>
			              </c:when>
			              <c:when test="${r.reviewGrade == 3}">
			                <span id="star">★★★</span>
			              </c:when>
			              <c:when test="${r.reviewGrade == 2}">
			                <span id="star">★★</span>
			              </c:when>
			              <c:when test="${r.reviewGrade == 1}">
			                <span id="star">★</span>
			              </c:when>
			            </c:choose>
			          </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<p>
		<nav id="nav1">
		<button type="button" onclick="location.href='/shop/'">메인으로</button>
		<button type="button" onclick="location.href='/order/paylist'">리뷰작성</button>
		</nav>
		
		<div id="pagination">
			<c:forEach var="pn" items="${pageInfo.navigatepageNums}">
				<c:choose>
					<c:when test="${pn==pageInfo.pageNum}">
						<span id="pageNum">${pn}</span>
					</c:when>
					<c:otherwise>
						<c:url value="/review/list/{itemNum}/page/${pn}" var="pgURL"></c:url>
						<a href="${pgURL}">${pn}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		</p>
	</main>	
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
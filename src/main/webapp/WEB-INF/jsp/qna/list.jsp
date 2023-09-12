<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	crossorigin="anonymous" />
<head>
<meta charset="utf-8">
<title>Q&A List</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function login_check(){
		if(${userId eq NULL}){
			alert('먼저 로그인 해주세요.');
			location.href="/user/login";
		}
		else {
			location.href="/qna/add";
		}
	}
	
	function lock_check(lock, author, qnaNum, userId){
		if(userId == ''){
			alert('먼저 로그인 해주세요.');
			location.href="/user/login";
			return;
		}
		 if (userId == 'dongmul') {
	        location.href = "/qna/detail/" + qnaNum;
	        return; // 리다이렉션 이후에는 더 이상 코드를 실행하지 않도록 return 합니다.
	    }

	    if (lock == 0 && userId != author) {
	        alert('비밀글은 작성자만 확인할 수 있습니다.');
	        return;
	    }
	    
		location.href="/qna/detail/"+qnaNum;
	}
</script>
<style type="text/css">
	.qna_main {
		background-color: #ffe4e1; /* 연분홍색 배경색 */
		width: 1000px;
		margin: 20px auto;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px; /* 둥근 테두리 */
		padding-bottom: 1px;
	}
	
	#qna_title {
		display: inline-block;
		background-color: white;
		font-size: 40px;
		font-weight: bold;
		width: 280px;
		height: fit-content;
		text-align: center;
		padding: 5px 0px;
		padding-bottom: 12px;
		margin: 20px 350px;
		border-top: 6px double #ff7777;
		border-bottom: 6px double #ff7777;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
		border-radius: 100px; /* 둥근 테두리 */
	}
	
	#qna_self_title {
		display: inline-block;
		background-color: white;
		font-size: 20px;
		font-weight: bold;
		width: 320px;
		height: fit-content;
		text-align: center;
		padding: 5px 0px;
		padding-bottom: 12px;
		margin: 20px 350px;
		border-top: 6px double #ff7777;
		border-bottom: 6px double #ff7777;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
		border-radius: 100px; /* 둥근 테두리 */
	}
	
	#button {
		width: fit-content;
		margin-left: 854px;
		margin-bottom: 10px;
	}
	
	#qna_a>#qna_button {
		display: inline-block;
		border: 2px solid #ffbbbb;
		width: 140px;
		padding: 5px 0;
		text-align: center;
		font-size: large;
		font-weight: bold;
		background-color: white;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	#qna_head {
		text-align: center;
		font-size: large;
		font-weight: bold;
		margin-bottom: 15px;
	}
	
	#qna_head>div {
		background-color: white;
		display: inline-block;
		border: 2px solid #ffbbbb;
		padding: 5px 0;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	#qna_head>a>div {
		background-color: white;
		display: inline-block;
		border: 2px solid #ffbbbb;
		padding: 5px 0;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	#t1 {
		width: 7%;
	}
	
	#t2 {
		width: 55%;
	}
	
	#t3 {
		width: 13%;
	}
	
	#t4 {
		width: 13%;
	}
	
	#t5 {
		width: 7%;
	}
	
	#qna_body {
		background-color: white;
		min-height: 200px;
		text-align: center;
		font-size: large;
		font-weight: bold;
		text-align: center;
	}
	
	.line {
		border-bottom: 10px solid #ffe4e1;
		width: 1000px;
	}
	
	.line div {
		display: inline-block;
		padding: 8px 0;
		margin: 4px 2px;
	}
	
	.line #b1 {
		width: 7%;
	}
	
	.line #b2 {
		width: 53.5%;
		text-align: left;
		padding-left: 15px;
	}
	
	.line #b3 {
		width: 13%;
	}
	
	.line #b4 {
		width: 13%;
	}
	
	.line #b5 {
		width: 7%;
	}
	
	#showAnswer {
		color: gray;
		font-size: 15px;
	}
	
	#qna_bottom {
		background-color: white;
		color: white;
		width: 600px;
		padding: 6px 0;
		margin: 20px auto;
		text-align: center;
		font-weight: bold;
		border-radius: 10px; /* 둥근 테두리 */
	}
	
	.page-number {
		margin-left: 10px;
	}
	
	.page-number i {
		margin: 0 5px; /* 아이콘 양쪽에 5px의 마진을 추가 */
	}
	
	#now-Page {
		display: inline-block;
		width: 50px;
		background-color: #FFDDDD;
		border-radius: 20px; /* 둥근 테두리 */
		color: black;
		font-weight: bold;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main class="qna_main">
		<c:if test="${self eq null}">
			<div id="qna_title">
				<a style="color: black" href="/qna/list/new">Q&A</a>
			</div>
		</c:if>

		<c:if test="${self ne null}">
			<div id="qna_self_title">
				<b><a style="color: black" href="/qna/selfList/new">${self}
						님 Q&A 관리</a></b>
			</div>
		</c:if>

		<div id="button">
			<a id="qna_a" href="javascript:login_check()">
				<div id="qna_button" style="margin-bottom: 5px;">
					<d>Q&A 쓰기</d>
				</div>
			</a>
			<c:if test="${self eq null}">
				<a id="qna_a" href="/qna/selfList/new">
					<div id="qna_button">
						<d>나의 글 목록</d>
					</div>
				</a>
			</c:if>
			<c:if test="${self ne null}">
				<a id="qna_a" href="/qna/list/new">
					<div id="qna_button">
						<d>전체 글 목록</d>
					</div>
				</a>
			</c:if>
		</div>

		<div id="qna_head">
			<div id="t1">글번호</div>
			<div id="t2">제목</div>
			<div id="t3">작성자</div>

			<c:if test="${self eq null}">
				<c:set var="url" value="list" />
			</c:if>
			<c:if test="${self ne null}">
				<c:set var="url" value="selfList" />
			</c:if>

			<c:if test="${order eq 'new'}">
				<a href="/qna/${url}/old">
					<div id="t4">날짜🔻</div>
				</a>
			</c:if>
			<c:if test="${order eq 'old'}">
				<a href="/qna/${url}/new">
					<div id="t4">날짜🔺</div>
				</a>
			</c:if>
			<c:if test="${order eq 'hit'}">
				<a href="/qna/${url}/new">
					<div id="t4">날짜</div>
				</a>
			</c:if>
			<c:if test="${order ne 'hit'}">
				<a href="/qna/${url}/hit">
					<div id="t5">조회</div>
				</a>
			</c:if>
			<c:if test="${order eq 'hit'}">
				<div id="t5">조회🔻</div>
			</c:if>
		</div>

		<div id="qna_body">
			<c:forEach var="i" items="${qnaList.list}">
				<div class="line">
					<div id="b1">${i.qnaNum}</div>
					<a
						href="javascript:lock_check(${i.qnaLock},'${i.qnaUserId}',${i.qnaNum},'${userId}')">
						<div id="b2">
							<c:if test="${i.qnaLock eq 0}">
								<d>🔒</d>
							</c:if>
							<c:if test="${i.qnaCategory eq '공지'}">
								<nav
									style="display: inline-block; color: red; width: fit-content">📢
									[${i.qnaCategory}]</nav>
							</c:if>
							<c:if test="${i.qnaCategory ne '공지'}">
								<nav
									style="display: inline-block; color: black; width: fit-content">[${i.qnaCategory}]
								</nav>
							</c:if>
							<b style="color: black;">${i.qnaTitle}</b>
							<c:if test="${i.qnaAnswer ne NULL}">
								<d id="showAnswer">[답변완료]</d>
							</c:if>
							<!-- ex: 🔒| [상품] 상품문의드립니다. [답변완료] -->
						</div>
					</a>
					<div id="b3">
						<c:if test="${i.qnaUserId eq 'dongmul'}">
							<b style="color: red;">관리자</b>
						</c:if>
						<c:if test="${i.qnaUserId ne 'dongmul'}">
					${i.qnaUserId}				
				</c:if>
					</div>
					<div id="b4">${i.qnaDate}</div>
					<div id="b5">${i.qnaHit}</div>
				</div>
			</c:forEach>
		</div>

		<!-- 페이지 번호 표시 -->
		<div id="qna_bottom" style="text-align: center;">
			<c:if test="${qnaList.pageNum > 1}">
				<a class="page-number" href="?pageNum=${qnaList.pageNum - 1}"><i
					style="color: black" class="fas fa-chevron-left"></i></a>
			</c:if>

			<c:forEach var="page" begin="1" end="${qnaList.pages}">
				<c:if test="${page == qnaList.pageNum}">
					<span class="page-number"
						style="background-color: white; padding: 3px; border-radius: 3px;">
						<div id="now-Page">${page}</div>
					</span>
				</c:if>
				<c:if test="${page != qnaList.pageNum}">
					<a class="page-number" href="?pageNum=${page}"> <font
						color="black">${page}</font>
					</a>
				</c:if>
			</c:forEach>

			<c:if test="${qnaList.pageNum < qnaList.pages}">
				<a class="page-number" href="?pageNum=${qnaList.pageNum + 1}"><i
					style="color: black" class="fas fa-chevron-right"></i></a>
			</c:if>
		</div>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
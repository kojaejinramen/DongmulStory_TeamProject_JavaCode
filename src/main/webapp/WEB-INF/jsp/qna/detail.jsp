<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Q&A Detail</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function delete_check(qnaNum) {
		
		if(!confirm('정말로 게시글을 삭제하시겠습니까?')) return ;
		
		$.ajax({
			url : "/qna/delete",
			data : {"qnaNum" : qnaNum},
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function (res) {
				alert(res.result ? "게시글이 정상적으로 삭제되었습니다." : "게시글 삭제에 실패하였습니다.");
				if(res.result){
					location.href="/qna/list/new";
				}
			},
			error: function (err) {
				alert(err);
			}
		});
	}
	
	function answer_check() {
		if(!confirm('해당 답변을 저장 혹은 수정하시겠습니까?')) return ;
		var formData = $('#form').serialize();
		
		$.ajax({
			url : "/qna/answer",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function (res) {
				alert(res.result ? "답변이 정상적으로 저장 혹은 수정되었습니다." : "예상치 못한 문제로 인해 실패하였습니다.\n지속적으로 문제 발생시 개발팀에 문의 바랍니다.");
				if(res.result){
					location.href="/qna/detail/${i.qnaNum}";
				}
			},
			error: function (err) {
				alert(err);
			}
		});
	}
</script>
<style type="text/css">
	.main {
		width: 1000px;
		margin: 20px auto;
	}
	
	.all {
		background-color: #ffe4e1; /* 연분홍색 배경색 */
		width: 1000px;
		margin: 0px auto;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px; /* 둥근 테두리 */
	}
	
	#qna_list {
		display: inline-block;
		background-color: #ffe4e1;
		border: 3px solid #ffbbbb;
		border-radius: 30px;
		font-size: 1em;
		font-weight: 600;
		color: blue;
		padding: 10px 10px;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
	}
	
	.title>h {
		font-size: xx-large;
		font-weight: bold;
	}
	
	.title {
		display: inline-block;
		width: fit-content;
		min-width: 700px;
		font-size: small;
		color: #555;
		background-color: white;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 20px; /* 둥근 테두리 */
		padding: 15px 20px;
		margin: 10px;
		margin-left: 15px;
		border-bottom: 6px double #ff7777;
		border-top: 6px double #ff7777;
	}
	
	.inline-div {
		display: inline-block;
		float: right;
		color: black;
	}
	
	#contents {
		font-size: 15pt;
		border-top: 5px solid #ffbbbb;
		border-bottom: 5px solid #ffbbbb;
		background-color: white;
		padding: 20px 30px;
		margin: 30px 0;
		min-height: 200px;
	}
	
	a>.inline-div {
		display: inline-block;
		border: 2px solid #ffbbbb;
		width: 100px;
		padding: 5px 0;
		text-align: center;
		font-size: large;
		font-weight: bold;
		background-color: white;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 10px;
		margin-top: 15px;
		margin-right: 8px;
	}
	
	#answer {
		display: inline-block;
		border: 2px solid #ffbbbb;
		width: 100px;
		padding: 5px 0;
		text-align: center;
		font-size: large;
		font-weight: bold;
		background-color: #ffbbbb;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 10px;
		margin-top: 15px;
		margin-right: 8px;
		width: 800px;
		margin: 10px 100px;
		margin-bottom: 30px;
	}
	
	#answer_go {
		width: 80%;
		margin: 5px auto;
		padding: 5px 0;
		text-align: center;
		border: 5px solid #ff9999;
		font-size: 30px;
		color: black;
		background-color: #ffe4e1;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 10px;
	}
	
	fieldset, legend {
		background-color: white;
		border-radius: 10px;
		text-align: left;
		border: 3px solid #bbb;
	}
	
	legend {
		background-color: white;
		border-radius: 10px;
		padding: 5px 10px;
		margin-left: 30px;
		font-size: 20px;
		border: 3px solid #777;
		color: #555;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main class="main">
		<a href="/qna/list/new"><div id="qna_list">Q&A 리스트로 돌아가기</div></a>
		<div class="all">
			<div class="title">
				<h> <c:if test="${i.qnaLock eq 0}">
					<d>🔒</d>
				</c:if> [${i.qnaCategory}] ${i.qnaTitle} </h>
				<br>
				<d>작성자 : ${i.qnaUserId}</d>
				<br>
				<d>${i.qnaDate} 조회 ${i.qnaHit}</d>
			</div>
			<c:if test="${i.qnaUserId eq userId || userId eq 'dongmul'}">
				<a href="/qna/update/${i.qnaNum}">
					<div class="inline-div">수정</div>
				</a>
				<a href="javascript:delete_check(${i.qnaNum});">
					<div class="inline-div">삭제</div>
				</a>
			</c:if>

			<div id="contents">${i.qnaContents}</div>

			<c:if test="${i.qnaAnswer ne 'dongmul'}">
				<div id="answer">
					<fieldset>
						<legend>답변</legend>
						${i.qnaAnswer}
					</fieldset>
				</div>
			</c:if>
			<c:if test="${userId eq 'dongmul'}">
				<div id="answer">
					<fieldset>
						<legend>답변</legend>
						<form id="form">
							<input type="hidden" name="qnaNum" value="${i.qnaNum }">
							<textarea rows="5px;" cols="110px;" name="qnaAnswer">${i.qnaAnswer}</textarea>
							<br> <a href="javascript:answer_check();">
								<div id="answer_go">수정 & 저장</div>
							</a>
						</form>
					</fieldset>
				</div>
			</c:if>

		</div>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
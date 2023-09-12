<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Q&A Update</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function update_check() {
		if (document.getElementById("qnaTitle").value == "") {
			alert('제목을 작성하여야 게시글이 저장됩니다.\n제목은 20글자 이내로 해주시기 바랍니다.');
			return false;
		}
		if (document.getElementById("qnaTitle").value.length > 20) {
			alert('제목은 20글자 이내로 해주시기 바랍니다.');
			return false;
		}
		if (document.getElementById("qnaContents").value == "") {
			alert('내용을 작성하여야 게시글이 저장됩니다.');
			return false;
		}

		if (!confirm('게시글을 수정하면 조회수와 관리자 답변이 초기화됩니다.\n계속 진행하시겠습니까?'))
			return;
		var formData = $('#form').serialize();

		$.ajax({
			url : "/qna/update",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function(res) {
				alert(res.result ? "게시글이 정상적으로 수정되었습니다." : "게시글 수정에 실패하였습니다.");
				if (res.result) {
					location.href = "/qna/detail/${i.qnaNum}";
				}
			},
			error : function(err) {
				alert(err);
			}
		});
	}
	
	function reset() {
		if (confirm('지금까지 작성하신 내용이 삭제됩니다.\n계속 진행하시겠습니까?')) {
			location.reload();
		}
		return;
	}
	
</script>
<style type="text/css">
	/* Main container */
	.main {
		line-height: 1.6;
		width: 1000px;
		margin: 20px auto;
	}
	
	/* Q&A Title */
	#qna_deatail {
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
	
	/* Q&A Main Container */
	.qna_main {
		background-color: #ffe4e1;
		text-align: center;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px; /* 둥근 테두리 */
	}
	
	/* Q&A Title */
	#qna_title {
		display: inline-block;
		background-color: white;
		font-size: 2em;
		font-weight: bold;
		width: fit-content;
		height: fit-content;
		text-align: center;
		padding: 15px 50px;
		margin: 20px 0;
		border-top: 6px double #ff7777;
		border-bottom: 6px double #ff7777;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 100px;
	}
	
	/* Buttons */
	.inline-div {
		display: inline-block;
		text-align: center;
		font-size: large;
		font-weight: bold;
	}
	
	.inline-div>a+a {
		margin-left: 10px;
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
	}
	
	fieldset {
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 10px;
		margin-right: 480px;
		background-color: #ffbbbb;
	}
	
	select {
		border: 1px solid #ffbbbb;
		margin-top: 15px;
		padding: 5px 5px;
		padding-bottom: 7px;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 5px;
		font-size: 1.2em;
	}
	
	/* Title */
	#title2 {
		margin-left: 10px;
		font-size: 1.2em;
	}
	
	#title2>input {
		border: 1px solid #ffbbbb;
		margin-left: 10px;
		font-size: 0.8em;
		width: 30em;
		padding: 10px 5px;
		border-radius: 5px;
	}
	
	/* Contents */
	textarea {
		border: 2px solid #ffbbbb;
		padding: 15px 15px;
		margin: 30px 0px;
		margin-top: 10px;
		box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
		border-radius: 10px;
		font-weight: bold;
	}
</style>
</head>
<body>

	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main class="main">
		<a href="/qna/detail/${i.qnaNum}"><div id="qna_deatail">Q&A
				글로 돌아가기</div></a>
		<form id="form">
			<input type="hidden" name="qnaUserId" value="${i.qnaUserId }">
			<input type="hidden" name="qnaNum" value="${i.qnaNum }">
			<div class="qna_main">
				<div id="qna_title">게시글 수정</div>
				<br>

				<div class="inline-div" id="type">
					<fieldset>
						<legend>Type</legend>
						<input type="radio" name="qnaLock" id="qnaLock1" value="1" checked>
						<label for="qnaLock1">공개</label> <input type="radio"
							name="qnaLock" id="qnaLock0" value="0"> <label
							for="qnaLock0">비밀</label>
					</fieldset>
				</div>

				<c:if test="${i.qnaUserId eq userId || userId eq 'dongmul'}">
					<a href="javascript:update_check();"><div class="inline-div">저장</div></a>
					<a href="javascript:reset();"><div class="inline-div">취소</div></a>
				</c:if>
				<br>
				<div class="inline-div" id="category">
					<select name="qnaCategory" id="qnaCategorySelect">
						<c:if test="${userId eq 'dongmul'}">
							<option value="공지"
								<c:if test="${i.qnaCategory eq '공지'}">selected</c:if>>공지</option>
						</c:if>
						<option value="자유"
							<c:if test="${i.qnaCategory eq '자유'}">selected</c:if>>자유</option>
						<option value="상품"
							<c:if test="${i.qnaCategory eq '상품'}">selected</c:if>>상품</option>
						<option value="배송"
							<c:if test="${i.qnaCategory eq '배송'}">selected</c:if>>배송</option>
					</select>
				</div>

				<div class="inline-div" id="title2">
					<label>제목 : </label><input type="text" id="qnaTitle"
						name="qnaTitle" value="${i.qnaTitle }">
				</div>
				<br>
				<div>
					<textarea id="qnaContents" name="qnaContents" rows="30" cols="100%">${i.qnaContents}</textarea>
				</div>
			</div>
		</form>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>

</body>
</html>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Q&A Add</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function add_check() {
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
	
		if (!confirm('위 내용으로 게시글을 작성하시겠습니까?')) return;
		var formData = $('#form').serialize();
		
		$.ajax({
			url : "/qna/add",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function (res) {
				alert(res.result ? "게시글이 정상적으로 등록되었습니다." : "게시글 작성에 실패하였습니다.");
				if (res.result) {
					location.href = "/qna/list/new";
				}
			},
			error: function (err) {
				alert(err);
			}
		});
	}
</script>
<style type="text/css">
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
	
	/* List 페이지에서 사용한 스타일과 동일하게 적용 */
	.qna_main {
		background-color: #ffe4e1;
		text-align: center;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px; /* 둥근 테두리 */
	}
	
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
	
	.inline-div {
		display: inline-block;
	}
	
	.inline-div>b {
		color: gray;
		font-size: small;
		font-weight: lighter;
	}
	
	.main {
		text-align: center;
		font-size: large;
		font-weight: bold;
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

	<main class="all">
		<a href="/qna/list/new"><div id="qna_list">Q&A 리스트로 돌아가기</div></a>
		<div class="qna_main">
			<div id="qna_title">Q&A 작성</div>

			<!-- Q&A 작성 폼 추가 -->
			<div class="main">
				<form id="form">
					<input type="hidden" name="qnaUserId" value="${userId}">

					<div class="inline-div" id="type">
						<fieldset>
							<legend>Type</legend>
							<input type="radio" name="qnaLock" id="qnaLock1" value="1" checked>
							<label for="qnaLock1">공개</label>
							<input type="radio" name="qnaLock" id="qnaLock0" value="0">
							<label for="qnaLock0">비밀</label>
						</fieldset>
					</div>

					<a href="javascript:add_check();">
						<div class="inline-div">등록</div>
					</a> <br>

					<div class="inline-div" id="category">
						<select name="qnaCategory">
							<c:if test="${userId eq 'dongmul'}">
								<option value="공지">공지</option>
							</c:if>
							<option value="자유">자유</option>
							<option value="상품">상품</option>
							<option value="배송">배송</option>
						</select>
					</div>

					<div class="inline-div" id="title2">
						<label for="qnaTitle">제목 : </label>
						<input type="text" name="qnaTitle" id="qnaTitle" 
							placeholder="제목은 20자 이내로 작성해주십시오." onfocus="clearPlaceholder()">
					</div>


					<div>
						<textarea name="qnaContents" id="qnaContents" rows="20" cols="100%"></textarea>
					</div>
				</form>
			</div>
		</div>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>

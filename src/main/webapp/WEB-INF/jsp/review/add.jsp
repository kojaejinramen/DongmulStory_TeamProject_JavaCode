<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 쓰기 폼</title>
<style type="text/css">
	#main {
		width: 40%;
		margin: 2em auto;
		padding: 2em;
		background-color: #fff;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}
	
	h2 {
		text-align: center;
		font-size: 1.8rem;
		color: #333;
	}
	
	table {
		width: 100%;
		margin-bottom: 1.5em;
		border-collapse: collapse;
	}
	
	th, td {
		padding: 1em 0.5em;
		border-bottom: 1px solid #ccc;
		color: #555;
	}
	
	th {
		text-align: center;
		width: 30%;
		vertical-align: top;
	}
	
	td {
		width: 70%;
	}
	
	textarea, select, input[type="file"] {
		width: 100%;
		padding: 0.5em;
		border: 1px solid #ccc;
		border-radius: 4px;
		background-color: #f8f8f8;
		transition: border-color 0.3s ease-in-out;
	}
	
	textarea:focus, select:focus, input[type="file"]:focus {
		outline: none;
		border-color: #33a6b8;
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
	
	button:last-child {
		background-color: #ccc;
		color: #fff;
	}
	
	button:hover {
		background-color: #268c9e;
	}
	
	.button-row {
		text-align: center;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
function saveReview() {
	if(!confirm('리뷰를 등록 하시겠습니까?')) return;
	
	var contents = $("textarea[name='contents']").val();
    if (contents.length < 10) {
        alert("리뷰 내용은 10자 이상이어야 합니다.");
        return false;
    }
	
	var formData = new FormData($('form')[0]);
	
	$.ajax({
		url : "/review/add",
		data : formData,
		method : 'post',
		dataType : 'json',
		cache : false,
		contentType : false,
		processData : false,
		enctype : "multipart/form-data",
		success : function (res) {
			alert(res.added ? "리뷰 등록 성공!!" : "리뷰 등록 실패!!");
			if(res.added){
				location.href="/review/list/${map.orderItemNum}/page/1";
			}
		},
		error: function (err) {
			alert(err);
		}
	});
}
</script>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main id="main">
		<h2>리뷰 등록</h2>
		<form id="form" onsubmit="return saveReview();">
			<input type="hidden" name="orderNum" value="${orderNum}"> <input
				type="hidden" name="userId" value="${userId}"> <input
				type="hidden" name="itemNum" value="${map.orderItemNum}">
			<table>
				<tr>
					<th>상품</th>
					<td>${map.orderItemNum}.${map.orderItemName}</td>
				</tr>
				<tr>
					<th>리뷰 내용</th>
					<td><textarea name="contents" cols="50px" rows="10px"
							placeholder="상품에 대한 고객님의 솔직한 리뷰를 작성해 주세요.      (10자 이상)"></textarea>
					</td>
				</tr>
				<tr>
					<th>평점</th>
					<!-- 추가: 평점 입력 -->
					<td><select id="grade" name="grade" required>
							<option value="5">
								<d id="imo">😍 5점 😍</d>
							</option>
							<option value="4">
								<d id="imo">😄 4점 😄</d>
							</option>
							<option value="3">
								<d id="imo">🙂 3점 🙂</d>
							</option>
							<option value="2">
								<d id="imo">😠 2점 😠</d>
							</option>
							<option value="1">
								<d id="imo">😡 1점 😡</d>
							</option>
					</select></td>
				</tr>
				<tr>
					<th>파일 올리기</th>
					<td><input type="file" name="files" multiple="multiple"></td>
				</tr>
				<tr>
					<td colspan="2" class="button-row">
						<button type="button" onclick="return saveReview()">저장</button>
						<button type="button"
							onclick="location.href='/order/detail/${orderNum}'">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Shop Add Form</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function showImagePreview(inputNumber) {
		var fileInput = document.getElementById('fileInput' + inputNumber);
		var imagePreview = document
				.getElementById('imagePreview' + inputNumber);

		// Clear previous preview (if any)
		imagePreview.innerHTML = '';

		for (var i = 0; i < fileInput.files.length; i++) {
			var img = document.createElement('img');
			img.src = URL.createObjectURL(fileInput.files[i]);
			img.width = 150; // Set desired width for the preview image
			imagePreview.appendChild(img);
		}
	}
	function add_check() {
		var nameInput = document.getElementById('name');
		var priceInput = document.getElementById('price');
		var contentsInput = document.getElementById('contents');
		var fileInput = document.getElementById('fileInput1');
		// 상품명을 작성하지 않았을 경우
		if (nameInput.value.trim() === '') {
			alert('상품명을 등록해주세요.');
			return false; // 작동 중단
		}
		// 가격을 작성하지 않았을 경우
		if (priceInput.value.trim() === '') {
			alert('상품의 가격을 등록해주세요.');
			return false; // 작동 중단
		}
		// 상세를 작성하지 않았을 경우
		if (contentsInput.value.trim() === '') {
			alert('상품의 상세 정보를 등록해주세요.');
			return false; // 작동 중단
		}
		// 파일을 선택하지 않았을 경우
		if (fileInput.files.length === 0) {
			alert('상품의 메인 사진을 등록해주세요.');
			return false; // 작동 중단
		}

		if (!confirm('위 내용으로 상품을 등록하시겠습니까?'))
			return;

		var formData = new FormData($('#form')[0]);

		$.ajax({
			url : "/shop/add",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			contentType : false,
			processData : false,
			enctype : "multipart/form-data",
			success : function(res) {
				alert(res.result ? "상품을 정상적으로 등록하였습니다." : "***error : 상품 등록에 실패하였습니다.***");
				if (confirm('관리자 메인화면으로 가시겠습니까?.')) {
					location.href = "/user/adminpage";
				}
			},
			error : function(err) {
				alert(err);
			}
		});
	}
</script>

<style type="text/css">
	.main {
		background-color: white;
		width: 1000px;
		margin: 20px auto;
		padding: 20px 20px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px; /* 둥근 테두리 */
	}
	
	h3 {
		font-size: 24px;
		color: #ff7777;
		margin-bottom: 20px;
		text-align: center;
	}
	
	table {
		width: 100%;
	}
	
	th, td {
		padding: 10px;
	}
	
	th {
		width: 20%;
		text-align: right;
		vertical-align: top;
		color: #ff7777;
	}
	
	select {
		width: 15%;
		text-align: center;
		font-size: large;
	}
	
	input, textarea {
		width: 80%;
		padding: 8px 0px;
		padding-left: 8px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	
	button {
		background-color: #ff7777;
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bold;
		margin-right: 10px;
	}
	
	button:hover {
		background-color: #ff5555;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main class="main">
		<h3>상품 등록</h3>
		<form id="form">
			<table>
				<tr>
					<th>동물 타입</th>
					<td><select name="animalNum">
							<option value="1">강아지</option>
							<option value="2">고양이</option>
							<option value="3">설치류</option>
							<option value="4">파충류</option>
							<option value="5">조류</option>
					</select></td>
				</tr>
				<tr>
					<th>상품 타입</th>
					<td><select name="typeNum">
							<option value="1">사료</option>
							<option value="2">간식</option>
							<option value="3">집</option>
							<option value="4">옷</option>
							<option value="5">장난감</option>
							<option value="6">기타</option>
					</select></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" id="name" name="name"
						placeholder="등록하실 상품명을 작성해주세요."></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="number" id="price" name="price"
						placeholder="상품의 가격을 입력해주세요."></td>
				</tr>
				<tr>
					<th>상세 정보</th>
					<td><textarea rows="5" id="contents" name="contents"
							placeholder="상품의 상세 정보를 작성해주세요."></textarea></td>
				</tr>
				<tr>
					<th>메인이미지</th>
					<td>
						<div id="imagePreview1"></div> <!-- The preview image for file 1 will be shown here -->
						<div class="file-upload-btn-wrapper">
							<input type="file" id="fileInput1" name="files"
								onchange="showImagePreview(1)">
						</div>
					</td>
				</tr>
				<tr>
					<th>설명이미지</th>
					<td>

						<div class="file-upload-btn-wrapper">
							<div id="imagePreview2"></div>
							<!-- The preview image for file 2 will be shown here -->
							<input type="file" id="fileInput2" name="files"
								onchange="showImagePreview(2)">
							<div id="imagePreview3"></div>
							<!-- The preview image for file 3 will be shown here -->
							<input type="file" id="fileInput3" name="files"
								onchange="showImagePreview(3)">
							<div id="imagePreview4"></div>
							<!-- The preview image for file 4 will be shown here -->
							<input type="file" id="fileInput4" name="files"
								onchange="showImagePreview(4)">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<button type="button" onclick="return add_check()">저장</button>
						<button type="submit">취소</button>
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

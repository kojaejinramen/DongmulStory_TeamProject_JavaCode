<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Update Form</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
   function delete_check(itemNum, url) {
      if(!confirm('위 상품을 영구 삭제하시겠습니까?')) return ;
      
      $.ajax({
         url : "/shop/deleteAll",
         data : {"itemNum" : itemNum},
         method : 'post',
         dataType : 'json',
         cache : false,
         success : function(res){
            alert(res.result ? "상품을 성공적으로 삭제했습니다." :
            	"***error : 상품 삭제에 실패하였습니다.***");
            if(res.result) location.href= url;
         },
         error : function(err){
            alert(err);
         }
      });
   }
   function deleteImg_check(animal, img) {
      if(!confirm('선택하신 이미지 파일을 영구 삭제하시겠습니까?')) return ;
      
      $.ajax({
         url : "/shop/deleteImg",
         data : {"animal":animal,
               "img" : img},
         method : 'post',
         dataType : 'json',
         cache : false,
         success : function(res){
            alert(res.result ? "이미지 파일을 영구적으로 삭제했습니다." : "***error : 이미지 파일 삭제에 실패하였습니다.***");
            if(res.result) location.reload();
         },
         error : function(err){
            alert(err);
         }
      });
   }
   function update_check(){
      if(!confirm('위 내용으로 상품을 수정하시겠습니까?')) return ;
      
      var formData = new FormData($('#updateForm')[0]);
      
      $.ajax({
         url : "/shop/update",
         data : formData,
         method : 'post',
         dataType : 'json',
         cache : false,
         contentType : false,
         processData : false,
         enctype : "multipart/form-data",
         success : function (res) {
            alert(res.result ? "상품 수정 성공" : "상품 수정 실패...");
            if(res.result) location.reload();
         },
         error: function (err) {
            alert(err);
         }
      });
   }
</script>
<style type="text/css">
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
	}
	
	.main {
		background-color: white;
		padding: 20px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
		border-radius: 20px;
		max-width: 1000px;
		margin: 20px auto;
	}
	
	h1 {
		font-size: 24px;
		color: #ff7777;
		text-align: center;
		margin-bottom: 20px;
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
		width: 100%;
		padding: 8px;
		font-size: 16px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	
	input[type="text"], input[type="number"], textarea {
		width: 100%;
		padding: 8px;
		font-size: 16px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	
	textarea {
		resize: vertical;
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
	
	.img {
		max-width: 100%;
		height: auto;
		display: block;
		margin: 10px auto;
		border: 1px solid #ccc;
		border-radius: 5px;
		box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	}
	
	a {
		color: #ff5555;
		text-decoration: none;
		margin-left: 5px;
	}
	
	a:hover {
		text-decoration: underline;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>
	
	<main class="main">
		<form id="updateForm">
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
			<button type="button" onclick="location.href='${url}'">리스트로
				돌아가기</button>
			<h1>상품 수정</h1>
			<table>
				<thead>
					<tr>
						<td><img class="img" alt="상품 이미지"
							src="/files/${animal}/${map.ShowFile}" width="300px"
							height="300px"></td>
						<td><input type="hidden" name="animalNum"
							value="${map.itemAnimalNum}"> <input type="hidden"
							name="num" value="${map.itemNum}"> 상품 번호 : ${map.itemNum}<br>
							상품 이름 : <input type="text" name="name" value="${map.itemName}"><br>
							상품 가격 : <input type="number" name="price"
							value="${map.itemPrice}"><br> 상품 설명 : <textarea
								rows="20" cols="80" name="contents">${map.itemContents}</textarea><br>
						</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="img" items="${imgList}">
						<tr>
							<td colspan="2"><img alt="상품 이미지"
								src="/files/${animal}/${img}" width="250px" height="100%">
								<a href="javascript:deleteImg_check('${animal}','${img}');">[X]</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="2"><input type="file" multiple="multiple"
							name="files"></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>
							<button type="button" onclick="return update_check();">수정
								완료</button>
							<button type="reset">수정 취소</button>
						</td>
						<td>
							<button type="button"
								onclick="return delete_check(${itemNum},'${url}');">상품
								삭제</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
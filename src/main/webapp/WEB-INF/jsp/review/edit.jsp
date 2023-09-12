<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 수정 페이지</title>
<style type="text/css">
	#main {
		width: 40%;
		margin: 1em auto;
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
		width: 100%;
		text-align: center;
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
		width: 50%;
		background-color: #f2f2f2;
	}
	td {
	  	width: 70%;
	}
	select{
		width: 93%;
		padding: 0.5em;
		border: 1px solid #ccc;
		border-radius: 4px;
	} 
	textarea {
		width: 90%;
		padding: 0.5em;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	.delfile_button{
		display: inline-block;
		background-color: gray;
		color: white;
		text-align: center;
		width: fit;
		height: fit;
		padding: 0px 5px;
		font-size: large;
		font-weight: bold;
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
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function updateReview() {
		if(!confirm("현재 리뷰를 수정 할까요?")) return;
		var formdata = new FormData($('#editForm')[0]);
		$.ajax({
			url:'/review/update',
			method:'post',
			enctype:'multipart/form-data',
			processData:false,
			contentType:false,
			timeout:3000,
			data:formdata,
			cache:false,
			dataType:'json',
			success:function(res){
				alert(res.updated ? '리뷰 수정 성공':'리뷰 수정 실패');
				if(res.updated){
					location.href="/review/detail/get/${review.reviewOrderNum}";
				}
				
			},
			error:function(xhr,status,err){
				alert('에러:' + err);
			}
		});
		return false;
	}
	
	function deleteFile(rfileFakeName) {
		if(!confirm("해당 사진을 삭제하시겠습니까?")) return;
		$.ajax({
			url:'/review/deleteFile',
			method:'post',
			data:{"fakeName":rfileFakeName},
			cache:false,
			dataType:'json',
			success:function(res){
				alert(res.deleted ? '리뷰 사진이 삭제되었습니다.':'Error : 사진 삭제 실패..');
				if(res.deleted){
					location.reload();
				}
			},
			error:function(xhr,status,err){
				alert('에러:' + err);
			}
		});
	}
</script>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
	  <%@ include file="../topIndex.jsp" %>
	</div>
	
	<main id="main">
		<h3>리뷰 수정</h3>
		<form id="editForm" onsubmit="return updateReview()">
				<input type="hidden" name="num" value="${review.reviewNum}">
			<table>
				<tr>
					<th>상품번호</th>
					<td>${review.reviewNum}</td>
					<th>작성자</th>
					<td>${review.reviewUserId}</td>
				</tr>
				<tr>
					<th>사진</th>
					<td colspan="3">
						<c:if test="${rfileList ne null}">
							<c:forEach items="${rfileList }" var="rfile">
								<img style="width : 200px;" alt="Not Found Images" src="/files/review/${rfile}">
								<a href="javascript:deleteFile('${rfile}');"><div class="delfile_button">X</div></a>
							</c:forEach>
						</c:if>
						<br>
						<input type="file" name="files"  multiple>
					</td>
				</tr>
				<tr>
					<th>평점</th>
					<td colspan="3">
						<select id="grade" name="grade" >
			               <option value="5" <c:if test="${review.reviewGrade == 5}">selected</c:if>>
			               		<d id="imo">😍 5점 😍</d>
			               	</option>
			               <option value="4" <c:if test="${review.reviewGrade == 4}">selected</c:if>>
			               		<d id="imo">😄 4점 😄</d>
			               	</opstion>
			               <option value="3" <c:if test="${review.reviewGrade == 3}">selected</c:if>>
			               		<d id="imo">🙂 3점 🙂</d>
			               	</option>
			               <option value="2" <c:if test="${review.reviewGrade == 2}">selected</c:if>>
			               		<d id="imo">😠 2점 😠</d>
			               	</option>
			               <option value="1" <c:if test="${review.reviewGrade == 1}">selected</c:if>>
			               		<d id="imo">😡 1점 😡</d>
			               </option>
		            	</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="reviewContents" colspan="3">
						<textarea name="contents" cols="50px" rows="8px">${review.reviewContents}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align:center;">
						<button type="submit" >수정</button>
						<button type="reset">취소</button>
						<button type="button" onclick="location.href='/review/detail/get/${review.reviewOrderNum}'">돌아가기</a></button> 
					</td>
				</tr>
			</table>
		</form>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
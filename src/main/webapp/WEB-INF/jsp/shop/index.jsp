<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Shop Index Form</title>
<style type="text/css">
	.main {
		margin: 10px 0;
	}
	
	.main a:hover {
		box-shadow: 0 0 10px rgba(0, 0, 0, 1);
		cursor: pointer;
	}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>
	<div class="banner-index">
		<%@ include file="../bannerIndex.jsp"%>
	</div>
	
	<main class="main">
		<!-- Your content below -->
		<div style="display: flex; justify-content: center;">
			<a href="/shop/list/dog/1/1"
				style="display: inline-block; margin: 10px;"> <img
				src="/files/dog0.png" alt="강아지" width="195" height="100%">
			</a> <a href="/shop/list/cat/1/1"
				style="display: inline-block; margin: 10px;"> <img
				src="/files/cat0.png" alt="고양이" width="195" height="100%">
			</a> <a href="/shop/list/mouse/1/1"
				style="display: inline-block; margin: 10px;"> <img
				src="/files/mouse0.png" alt="햄스터" width="195" height="100%">
			</a> <a href="/shop/list/dragon/1/1"
				style="display: inline-block; margin: 10px;"> <img
				src="/files/dragon0.png" alt="개구리" width="195" height="100%">
			</a> <a href="/shop/list/bird/1/1"
				style="display: inline-block; margin: 10px;"> <img
				src="/files/bird0.png" alt="앵무새" width="195" height="100%">
			</a>
		</div>
	</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>

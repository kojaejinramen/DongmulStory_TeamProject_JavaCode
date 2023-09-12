<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" crossorigin="anonymous" />
<head>
<meta charset="utf-8">
<title>판매매출관리폼</title>
<style type="text/css">
    /* Main container */
    .main {
        max-width: 1000px;
        background-color: #fff;
        padding: 20px;
        margin: 20px auto;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        border-radius: 20px; /* 둥근 테두리 */
    }

    h2 {
        color: #FF69B4;
        text-align: center;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }
    th, td {
        padding: 8px;
        text-align: center;
        border-bottom: 1px solid #CCCCCC;
    }
    th {
        background-color: #FFC0CB;
    }
    #user tr:nth-child(even) {
        background-color: #F2F2F2;
    }
    #item tr:nth-child(even) {
        background-color: #F2F2F2;
    }
    #date tr:nth-child(even) {
        background-color: #F2F2F2;
    }

    button {
        background-color: #FF69B4;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: block;
        width: 60px;
        font-size: 16px;
        margin: 10px auto;
        cursor: pointer;
        border-radius: 5px;
    }
    button a {
        color: white;
        text-decoration: none;
    }
    button:hover {
        background-color: #FF1493;
    }

    .tab-container {
        margin: 20px auto;
    }
    .nav-tabs {
        display: flex;
        justify-content: center;
        align-items: center;
        list-style: none;
        margin-top: 20px;
        margin-bottom: 30px;
        background-color: #FFC0CB;
        border-radius: 10px;
        padding: 10px;
    }
    .nav-item {
        margin-right: 10px;
        margin-left: 10px;
    }
    .nav-link {
        font-size: 18px;
        color: #FFFFFF;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 10px;
        border: none;
        background-color: transparent;
        transition: background-color 0.3s ease;
        position: relative;
        font-weight: bold;
    }
    .nav-link.active, .nav-link:hover {
        background-color: #FF69B4;
        color: #FFFFFF;
    }
    .nav-link::before {
        content: "";
        position: absolute;
        top: 0;
        left: -10px;
        width: 0;
        height: 0;
        border-style: solid;
        border-width: 10px 10px 0 0;
        border-color: #FFFFFF transparent transparent transparent;
    }
    .nav-link.active::before, .nav-link:hover::before {
        border-color: #FF69B4 transparent transparent transparent;
    }
    
    .right-align {
        text-align: right;
    }
    
    .search-button {
        background-color: #FF69B4;
        border: none;
        color: white;
        padding: 5px 10px;
        font-size: 14px;
        cursor: pointer;
        border-radius: 5px;
        display: inline-block;
    }
    .search-button:hover {
        background-color: #FF1493;
    }
    
	/* 동물별 스타일 */
    .강아지 {background-color: #dddddd;}
    .고양이 {background-color: #ffffde;}
    .햄스터 {background-color: #ffdfdf;}
    .개구리 {background-color: #ddeeff;}
    .앵무새 {background-color: #deeede;}
	    
    #adminList_bottom {
    	text-align: center;
    	width: 600px;
    	margin: 0 auto;
    	padding: 5px 2px;
    	font-size: large;
        border-radius: 20px; /* 둥근 테두리 */
    }
    
    #otherPage {
    	display: inline-block;
    	width: 30px;
    	border-radius: 20px; /* 둥근 테두리 */
    	color: black;
    	font-weight: bold;
    }
    
    #adminList_bottom a {
    	color: black;
    }
    
    .page-number b {
    	display: inline-block;
    	width: 50px;
    	color: white;
    	background-color: #FFC0CB;
    	border-radius: 20px; /* 둥근 테두리 */
    }
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // 기간 선택 폼 제출 이벤트 리스너 등록
        $("#dateForm").on("submit", function(e) {
            e.preventDefault(); // 폼의 기본 동작(페이지 리로딩) 방지

            // 선택한 시작 날짜와 종료 날짜 가져오기
            var startDate = new Date($("#startDate").val());
            var endDate = new Date($("#endDate").val());

            // 테이블 업데이트를 위해 서버에서 모든 데이터를 받아옴
            fetchTabData("date", startDate, endDate);
        });

        function fetchTabData(tabName, startDate, endDate) {
            // 기존 테이블 내용 제거
            $("date" + option + " table").empty();

            // 서버로 탭 정보를 전달하여 모든 데이터를 가져오도록 요청
            $.ajax({
                url: "/order/admin/list/" + option, // 서버의 컨트롤러 URL 설정
                method: "GET",
                success: function(data) {
                    // 데이터를 받아와서 해당 탭에 맞는 테이블을 업데이트
                    var table = $("<table>");
                    table.append("<tr><th>주문번호</th><th>주문일자</th><th>상품명</th><th>총매출</th></tr>");

                    // 시작 날짜와 종료 날짜 사이의 데이터만 필터링하여 테이블에 추가
                    data.forEach(function(item) {
                        var orderDate = new Date(item.orderDate);

                        // 데이터의 주문일자가 선택한 기간에 포함되는지 확인
                        if (orderDate >= startDate && orderDate <= endDate) {
                            var dataRow = $("<tr>");
                            dataRow.append("<td>" + item.orderNum + "</td>");
                            dataRow.append("<td>" + item.orderDate + "</td>");
                            dataRow.append("<td>" + item.itemName + "</td>");
                            dataRow.append("<td>" + item.sumPrice + "원</td>");
                            table.append(dataRow);
                        }
                    });

                    // 해당 탭에 테이블 추가
                    $("date" + tabName).append(table);
                },
                error: function(xhr, status, error) {
                    console.log("Error occurred while fetching tab data.");
                }
            });
        }
    });
</script>
</head>
<body class="body">
    <!-- 상단 목록 -->
    <div class="top-index">
      <%@ include file="../topIndex.jsp" %>
    </div>
    <div class="banner-index">
       <%@ include file="../bannerIndex.jsp" %>
    </div>

    <main class="main">
    <h2>판매관리목록</h2>
    <form id="listform">
        <!-- 탭 추가 -->
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="user">유저별</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="item">상품별</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" data-toggle="tab" href="date" onclick="fetchTabData('date')">기간별</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="animal">동물별</a>
            </li>
        </ul>

        <!-- 유저별 탭 -->
		<c:if test="${option eq 'user'}">
		    <div id="user">
		        <table style="margin-bottom: 30px;">
		            <tr>
		                <th>고객번호</th>
		                <th>고객ID</th>
		                <th>전화번호</th>
		                <th>총 매출</th>
		            </tr>
		            <c:forEach var="a" items="${adminList.list}">
		                <tr>
		                    <td>${a.userNum}</td>
		                    <td>
		                        <a style="color:blue; " href="/order/admin/paylist/${a.userId}" target="_blank">${a.userId}</a>
		                    </td>
		                    <td>${a.userPhone}</td>
		                    <td><fmt:formatNumber value="${a.sumPrice}" pattern="#,###"/>원</td>
		                </tr>
		            </c:forEach>
		        </table>
		    </div>
		</c:if>

        <!-- 상품별 탭 -->
        <c:if test="${option eq 'item'}">
        <div id="item">
        <table style="margin-bottom: 30px;">
            <tr>
                <th>상품 번호</th>
                <th>상품명</th>
                <th>총 구매 횟수</th>
                <th>총 매출</th>
            </tr>
            <c:forEach var="a" items="${adminList.list}">
                <tr>   
                    <td>${a.itemNum}</td>
                    <td>${a.itemName}</td>
                    <td>${a.sumQty}</td>
                    <td><fmt:formatNumber value="${a.sumPrice}" pattern="#,###"/>원</td>
                </tr>
            </c:forEach>
        </table>
        </div>
        </c:if>

        <!-- 기간별 탭 -->
        <c:if test="${option eq 'date'}">
            <div id="date">
                <!-- 기간 선택 폼 -->
                <form id="dateForm" style="display: flex; align-items: center;">
                <div id="search">
                    <label for="startDate" style="margin-right: 10px;">시작 날짜:</label>
                    <input type="date" id="startDate" name="startDate" value="${startDateFormatted}" required style="margin-right: 10px;">
                    <label for="endDate" style="margin-right: 10px;">종료 날짜:</label>
                    <input type="date" id="endDate" name="endDate"  value="${endDateFormatted}" required style="margin-right: 10px;">
                    <button type="submit" class="search-button">검색</button>
                </div>
                </form>
                
                <!-- 선택한 기간을 표시 (포매팅된 형식) -->
				<div style="margin-top: 10px;">
				    <c:if test="${not empty startDate and not empty endDate}">
				        <p>선택한 기간: ${startDateFormatted} ~ ${endDateFormatted}</p>
				    </c:if>
				</div>

                <!-- 여기에 기간별 매출 정보를 보여줄 테이블을 추가 -->
                <table style="margin-bottom: 30px;">
                    <tr>
                        <th>주문 일자</th>
                        <th>구매 총 횟수</th>
                        <th>총 매출</th>
                    </tr>

                    <!-- 기간별 항목을 순회하며 테이블에 출력 -->
                    <c:forEach var="a" items="${adminList.list}">
                        <tr>
                            <td>${a.orderDate}</td>
                            <td>${a.sumQty}</td>
                            <td><fmt:formatNumber value="${a.sumPrice}" pattern="#,###"/>원</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:if>

           <!-- 동물별 탭 -->
        <c:if test="${option eq 'animal'}">
            <div id="animal">
                <!-- 여기에 동물별 매출 정보를 보여줄 테이블을 추가 -->
                <table style="margin-bottom: 30px;">
                    <tr>
                        <th>동물 종류</th>
                        <th>상품 종류</th>
                        <th>총 구매 횟수</th>
                        <th>총 매출</th>
                    </tr>

                    <!-- 동물별 항목을 순회하며 테이블에 출력 -->
                    <c:forEach var="a" items="${adminList.list}">
                        <tr class="${a.animalName}">
                            <td>${a.animalName}</td>
                            <td>${a.typeName}</td>
                            <td>${a.sumQty}</td>
                            <td><fmt:formatNumber value="${a.sumPrice}" pattern="#,###"/>원</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:if>
    </form>
    
    <!-- 페이지 번호 표시 -->
   <div id="adminList_bottom">
	    <c:if test="${adminList.pageNum > 1}">
	        <a class="page-number" href="?pageNum=${adminList.pageNum - 1}">
	            <i class="fas fa-chevron-left"></i>
	        </a>
	    </c:if>
	    
	    <c:forEach var="page" begin="1" end="${adminList.pages}">
	        <c:if test="${page == adminList.pageNum}">
	            <span class="page-number">
	                <b>${page}</b>
	            </span>
	        </c:if>
	        <c:if test="${page != adminList.pageNum}">
	            <a class="page-number" href="?pageNum=${page}">
	                <div id="otherPage">${page}</div>
	            </a>
	        </c:if>
	    </c:forEach>
	    
	    <c:if test="${adminList.pageNum < adminList.pages}">
	        <a class="page-number" href="?pageNum=${adminList.pageNum + 1}">
	            <i class="fas fa-chevron-right"></i>
	        </a>
	    </c:if>
	</div>
    </main>

   <div class="bottom-index">
      <%@ include file="../bottom.jsp" %>
   </div>
</body>
</html>

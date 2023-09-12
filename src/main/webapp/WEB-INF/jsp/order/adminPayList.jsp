<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" crossorigin="anonymous" />
<head>
<meta charset="utf-8">
<title>관리자 구매내역 관리 폼</title>
<style type="text/css">
    .main {
        max-width: 1000px;
        background-color: #fff;
        padding: 20px;
        margin: 20px auto;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        border-radius: 20px;
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

    .page-number b {
        padding: 5px 5px;
        padding-left: 7px;
        text-align: center;
        margin: 0px 10px;
        color: white;
    }
    a {
    	text-decoration: none;
    }
    
    
</style>
</head>
<body class="body">


<div class="main">
    <h2>[${userId}] 고객님 결제내역 목록</h2>
    <h3 style="color: red;">모든 주문상태를 불러옵니다. (교환, 환불, 반품 포함)</h3>
    <table>
        <tr>
            <th>결제번호</th>
            <th>상품이름</th>
            <th>상품가격</th>
            <th>상품수량</th>
            <th>결제일자</th>
        </tr>
        <c:forEach var="pay" items="${adminPayList.list}" varStatus="status">
           <c:if test="${status.index == 0 || pay.orderGroup ne adminPayList.list[status.index - 1].orderGroup}">
		    <tr style="background-color: #FFFFE0; color: black; line-height: 0.5;">
		        <td colspan="5" style="text-align: left;"><b>주문번호: ${pay.orderGroup}</b></td>
		    </tr>
		   </c:if>
            <tr style="background-color: #FFFFFF;">
                <td>${pay.orderNum}</td>
                <td>${pay.orderItemName}</td>
                <td><fmt:formatNumber value="${pay.orderItemPrice}" pattern="#,###"/>원</td>
                <td>${pay.orderQuantity}개</td>
                <td>${pay.orderDate}</td>
            </tr>
        </c:forEach>
    </table>
	
	<div class="totalAmount" style="text-align: right;">
	    <b><p>총 결제 금액: <fmt:formatNumber value="${sumPrice}" pattern="#,###"/>원</p></b>
	</div>

    <div style="text-align: center; ">
        <c:if test="${adminPayList.pageNum > 1}">
        <a class="page-number" href="?pageNum=${adminPayList.pageNum - 1}" style="margin-right: 15px;"> 
        	<i class="fas fa-chevron-left"></i>
        </a>
    </c:if>
    
    <c:forEach var="page" begin="1" end="${adminPayList.pages}">
        <c:if test="${page == adminPayList.pageNum}">
            <span class="page-number" style="background-color: #FF69B4; border-radius: 20px; margin: auto 15px;">
                <b><font color="#FFFFE0">${page}</font></b>
            </span>
        </c:if>
        <c:if test="${page != adminPayList.pageNum}">
            <a class="page-number" href="?pageNum=${page}"><font color="#FF69B4">${page}</font></a>
        </c:if>
    </c:forEach>
    
    <c:if test="${adminPayList.pageNum < adminPayList.pages}">
        <a class="page-number" href="?pageNum=${adminPayList.pageNum + 1}" style="margin-left: 15px;">
        	<i class="fas fa-chevron-right"></i>
        </a>
    </c:if>
    </div>
</div>

</body>
</html>
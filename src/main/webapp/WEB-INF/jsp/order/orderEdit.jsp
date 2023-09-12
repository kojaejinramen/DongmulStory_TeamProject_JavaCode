<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주문상세수정폼</title>
<style>
    .main {
        background-color: #FFFFFF;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    	border-radius: 20px; /* 둥근 테두리 */
        margin: 20px auto;
        width: 1000px;
        text-align: center;
    }

    h2 {
        color: #FF69B4;
        margin-top: 0;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #CCCCCC;
    }

    th {
        background-color: #FFC0CB;
    }

    tr:nth-child(even) {
        background-color: #F2F2F2;
    }

    button {
        background-color: #FF69B4;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-right: 10px;
        margin-bottom: 10px;
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
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

function update() {
    if (!confirm('정말로 수정 하시겠습니까?')) return;

    var formData = $('#updateForm').serialize();

    $.ajax({
        url: "/order/update",
        data: formData,
        method: 'post',
        dataType: 'json',
        cache: false,
        success: function(res) {
            alert(res.updated ? "수정 성공" : "수정 실패");
            location.href = "/order/detail/${e.orderNum}";
        },
        error: function(err) {
            alert(err);
        }
    });
}
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
<form id="updateForm">
    <h2>주문상태 수정</h2>
    <input type="hidden" name="orderNum" value="${e.orderNum}">
    <table>
    		
    		<tr>
                <th>주문자</th>
                <td>${e.userName}</td>
            </tr>
    
    		<tr>
                <th>수령인</th>
                <td>${e.orderUserName}</td>
            </tr>
    		
    		<tr>
                <th>전화번호</th>
                <td>${e.orderPhone}</td>
            </tr>
            
            <tr>
                <th>주소</th>
                <td>${e.orderAddress2} ${e.orderAddress3} </td>
            </tr>
    
            <tr>
                <th>상품명</th>
                <td>${e.itemName}</td>
            </tr>
            <tr>
                <th>상품가격</th>
                <td><fmt:formatNumber value="${e.itemPrice}" pattern="#,###원"/></td>
            </tr>
            <tr>
                <th>상품수량</th>
                <td>${e.orderQuantity}개</td>
            </tr>
            <tr>
                <th>총가격</th>
                <td><fmt:formatNumber value="${e.totalAmount}" pattern="#,###원"/></td>
            </tr>
            <tr>
             <th>배송입력사항</th>
                <td>${e.orderNote}</td>
            </tr>
            <tr>
                <th>주문상태</th>
               <td>
               	<select name="orderState">
				    <option value="결제확인중" <c:if test="${e.orderState eq '결제확인중'}">selected</c:if>>결제확인중</option>
				    <option value="배송준비중" <c:if test="${e.orderState eq '배송준비중'}">selected</c:if>>배송준비중</option>
				    <option value="배송중" <c:if test="${e.orderState eq '배송중'}">selected</c:if>>배송중</option>
				    <option value="배송완료" <c:if test="${e.orderState eq '배송완료'}">selected</c:if>>배송완료</option>
				    <option disabled>--------</option>
				    <option value="교환접수" <c:if test="${e.orderState eq '교환접수'}">selected</c:if>>교환접수</option>
				    <option value="교환회수중" <c:if test="${e.orderState eq '교환회수중'}">selected</c:if>>교환회수중</option>
				    <option value="교환배송중" <c:if test="${e.orderState eq '교환배송중'}">selected</c:if>>교환배송중</option>
				    <option value="교환완료" <c:if test="${e.orderState eq '교환완료'}">selected</c:if>>교환완료</option>
				    <option disabled>--------</option>
				    <option value="반품접수" <c:if test="${e.orderState eq '반품접수'}">selected</c:if>>반품접수</option>
				    <option value="반품회수중" <c:if test="${e.orderState eq '반품회수중'}">selected</c:if>>반품회수중</option>
				    <option value="반품배송중" <c:if test="${e.orderState eq '반품배송중'}">selected</c:if>>반품배송중</option>
				    <option value="반품완료" <c:if test="${e.orderState eq '반품완료'}">selected</c:if>>반품완료</option>
				    <option disabled>--------</option>
				    <option value="환불접수" <c:if test="${e.orderState eq '환불접수'}">selected</c:if>>환불접수</option>
				    <option value="환불회수중" <c:if test="${e.orderState eq '환불회수중'}">selected</c:if>>환불회수중</option>
				    <option value="환불완료" <c:if test="${e.orderState eq '환불완료'}">selected</c:if>>환불완료</option>
				    <option disabled>--------</option>
				    <option value="구매확정" <c:if test="${e.orderState eq '구매확정'}">selected</c:if>>구매확정</option>
				</select>
				</td>
            </tr>
            <tr>
                <th>결제일자</th>
                <td>${e.orderDate}</td>
            </tr>
    </table>
    <button type="button" onclick="return update();">저장</button>
    </form>
</main>
	
	<div class="bottom-index">
		<%@ include file="../bottom.jsp" %>
	</div>
</body>
</html>
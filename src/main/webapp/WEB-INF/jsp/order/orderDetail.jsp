<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주문상세폼</title>
<style type="text/css">
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
    
   .button-group{
       margin-bottom: 20;
   }
    
    .right-align {
        text-align: right;
    }
    
     /* 리뷰쓰기 버튼 스타일 */
    .write-button {
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

    .write-button:hover {
        background-color: #FF1493;
    }
    
     /* 리뷰수정 버튼 스타일 */
    .review-button {
        background-color: #aaa;
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
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

function confirmExchange() {
    if (confirm("정말로 교환하시겠습니까?")) {
        exchangeOrder();
    }
}

function exchangeOrder() {
    $.ajax({
        url: "/order/exchangeOrder",
        method: "POST",
        data: { orderNum: ${d.orderNum} },
        success: function (response) {
            if (response.updated) {
                // 상태 변경 성공
                alert("교환접수가 완료되었습니다.\n배송지 변경 시 고객센터: 1544-1234로 연락주세요.");
                // 디테일 창 reload
                location.reload();
            } else {
                // 상태 변경 실패
                alert("상태 변경에 실패했습니다.");
            }
        },
        error: function (xhr, status, error) {
            // 에러 처리
            alert("오류 발생: " + error);
        }
    });
}
    
    
    function confirmReturn() {
        if (confirm("정말로 반품하시겠습니까?")) {
            returnOrder();
        }
    }

    function returnOrder() {
        $.ajax({
            url: "/order/returnOrder", // 교환 처리를 담당하는 서버의 URL
            method: "POST",
            data: { orderNum: ${d.orderNum} }, // 교환 처리할 주문 번호 전송
            success: function (response) {
                if (response.updated) {
                    // 상태 변경 성공
                    alert("반품접수가 완료되었습니다.\n배송지 변경 시 고객센터: 1544-1234로 연락주세요.");
                    // 디테일 창 reload
                    location.reload();
                } else {
                    // 상태 변경 실패
                    alert("상태 변경에 실패했습니다.");
                }
            },
            error: function (xhr, status, error) {
                // 에러 처리
                alert("오류 발생: " + error);
            }
        });
        
    }
    
    function confirmRefund() {
        if (confirm("정말로 환불하시겠습니까?")) {
            refundOrder();
        }
    }

    function refundOrder() {
        $.ajax({
            url: "/order/refundOrder", // 교환 처리를 담당하는 서버의 URL
            method: "POST",
            data: { orderNum: ${d.orderNum} }, // 교환 처리할 주문 번호 전송
            success: function (response) {
                if (response.updated) {
                    // 상태 변경 성공
                    alert("환불접수가 완료되었습니다.\n계좌번호 변경 시 고객센터: 1544-1234로 연락주세요.");
                    // 디테일 창 reload
                    location.reload();
                } else {
                    // 상태 변경 실패
                    alert("상태 변경에 실패했습니다.");
                }
            },
            error: function (xhr, status, error) {
                // 에러 처리
                alert("오류 발생: " + error);
            }
        });
        
    }

    console.log(${d.check});
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
    <h2>주문상세 내역</h2>
    
    <div class="right-align">
    <strong><span style="color: #FF69B4;">
    [</span><a href="/order/paylist" style="color: #FF69B4; text-decoration: none;">목록으로 돌아가기</a><span style="color: #FF69B4;">]</span></strong>
   </div>
    
    <table>
          <tr>
                <th>주문자</th>
                <td>${d.userName}</td>
            </tr>
    
            <tr>
                <th>상품명</th>
                <td>${d.itemName}</td>
            </tr>
            <tr>
                <th>상품가격</th>
                <td><fmt:formatNumber value="${d.itemPrice}" pattern="#,###원"/></td>
            </tr>
            <tr>
                <th>상품수량</th>
                <td>${d.orderQuantity}개</td>
            </tr>
            
            <tr>
                <th>총가격</th>
                <td><fmt:formatNumber value="${d.totalAmount}" pattern="#,###원"/></td>
            </tr>
            
            <tr>
                <th>수령인</th>
                <td>${d.orderUserName}</td>
            </tr>
          
          <tr>
                <th>전화번호</th>
                <td>${d.orderPhone}</td>
            </tr>
            
            <tr>
                <th>주소</th>
                <td>${d.orderAddress2} ${d.orderAddress3} </td>
            </tr>
            
            <tr>
                <th>배송입력사항</th>
                <td>${d.orderNote}</td>
            </tr>
           
            <tr>
                <th>결제일자</th>
                <td>${d.orderDate}</td>
            </tr>
            
            
             <tr>
                <th>주문상태</th>
                <td><b><span style="color: red">${d.orderState}</span></b></td>
           </tr>
     </table>
        
  <c:set var="canExchange" value="${d.orderState != '구매확정'}"/>
   <c:if test="${userId != 'dongmul'}"> <!-- userId가 'dongmul'이 아닌 경우에만 버튼 그룹 표시 -->
       <div class="button-group">
           <c:if test="${canExchange}">
               <button onclick="confirmExchange()">교환</button>
           </c:if>
           <c:if test="${canExchange}">
               <button onclick="confirmReturn()">반품</button>
           </c:if>
           <c:if test="${canExchange}">
               <button onclick="confirmRefund()">환불</button>
           </c:if>
       </div>
   </c:if>
       
     <!-- "구매확정" 상태인 경우에만 "리뷰쓰기" 버튼을 보여줌 -->
     <c:choose>
       <c:when test="${d.orderState eq '구매확정' && d.check ne null}">
           <td><a class="review-button" href="/review/update/${d.orderNum}">리뷰수정</a></td>
       </c:when>
       <c:when test="${d.orderState eq '구매확정' && userId ne 'dongmul'}">
           <td><a class="write-button" href="/review/add/${d.orderNum}">리뷰쓰기</a></td>
       </c:when>
    </c:choose>
   
   <c:if test="${userId eq 'dongmul'}">
       <!-- 수정 버튼 (ID가 'dongmul'일 경우에만 표시) -->
       <button type="button" onclick=" location.href='/order/edit/${d.orderNum}'">수정</button>
       <button type="button" onclick=" location.href='/order/detail/${d.orderNum}'">취소</button>
   </c:if>
</main>

   <div class="bottom-index">
      <%@ include file="../bottom.jsp" %>
   </div>
</body>
</html>
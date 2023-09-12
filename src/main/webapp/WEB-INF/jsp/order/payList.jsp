<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" crossorigin="anonymous" />
<head>
<meta charset="utf-8">
<title>결제내역목록폼</title>
<style type="text/css">
   .main {
       background-color: #FFFFFF;
       padding: 20px;
       box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
       border-radius: 20px; /* 둥근 테두리 */
       width: 1000px;
       margin: 20px auto;
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
   
   tr {
       margin-bottom: 20px;
   }
   
   td{
       padding: 10px 15px;
   }
   th {
      text-align: left;
      height: 40px;
       background-color: #FFC0CB;
       padding-left: 10px;
   }
   
   tr:nth-child(even) {
       background-color: #F2F2F2;
   }
   
   button {
       background-color: #FF69B4;
       border: none;
       width: 100px;
       cursor: pointer;
       border-radius: 5px;
       padding: 10px;
       margin: 1px 0;
   }
   button d {
      color: white;
      text-align: center;
      font-size: 16px;
   }
   button:hover {
       background-color: #FF1493;
   }
   
   /* 이전 그룹과 다음 그룹이 다를 경우에만 아래 스타일 적용 */
   tr.orderGroupRow:not(:first-child) td {
       border-top: 2px solid #CCCCCC; /* 이전 그룹의 마지막 행의 위쪽 테두리 설정 */
   }
   
   /* 이전 그룹과 다음 그룹이 다를 경우에만 아래 스타일 적용 */
   tr.orderGroupRow:last-child td {
       border-bottom: 2px solid #CCCCCC; /* 마지막 행의 아래쪽 테두리 설정 */
   }
   
   /* 페이지 번호 사이에 간격*/
   .page-number {
        margin: 5px;
    }
    .right-align {
        text-align: right;
    }
    #grade{
    	color: red;
    }

   /* 리뷰쓰기 버튼 스타일 */
   button.write-button {
       background-color: #aaa; /* 밝은 회색 */
   }

   /* 리뷰수정 버튼 스타일 */
   button.review-button {
       background-color: #aaa; /* 밝은 회색 */
   }
   .black-bold-text {
        font-weight: bold;
    }
    
    
    .paylist-page a {
		padding: 6px 0;
		margin: 0 5px;
		color: black;
		text-decoration: none;
	}
    
    .paylist-page b{ 
    	display: inline-block;
    	width: 50px;
    	background-color: #FF69B4;
    	border-radius: 20px; /* 둥근 테두리 */
    	color: white;
    	font-weight: bold;
    }
    
    .page-number {
    	font-weight: bold;
    }
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

function deleteIt(orderNum){
    if(!confirm('정말로 주문을 취소하시겠습니까?')) return ;
        
    $.ajax({
        url : "/order/delete",
        data : {"orderNum":orderNum},
        method : 'post',
        dataType : 'json',
        cache : false,
        success : function (res) {
            alert(res.deleted ? "주문취소 성공" : "주문취소 실패");
            location.href="/order/paylist";
        },
        error: function (err) {
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
    <h2>
    <c:choose>
        <c:when test="${userId eq 'dongmul'}">
            관리자 배송관리 목록
        </c:when>
        <c:otherwise>
            [${userId}]고객님 결제내역 목록
        </c:otherwise>
    </c:choose>
	</h2>
   <table style="margin-bottom: 30px;">
        <tr>
            <th style="width: 12%; padding-left:0; text-align: center;">결제일자</th>
            <th style="width: 53%">상품이름</th>
            <th style="width: 10%; text-align: center;">상품가격</th>
            <th style="width: 10%; text-align: center;">상품수량</th>
            <th colspan="2" style="width: 15%"></th>
        </tr>
        
        <!-- 결제내역 항목을 순회하며 테이블에 출력 -->
      <c:forEach var="pay" items="${payList.list}" varStatus="status">
          <!-- 이전 항목의 orderGroup과 현재 항목의 orderGroup이 다른 경우에만 그룹 정보를 출력 -->
          <c:if test="${status.index == 0 || pay.orderGroup ne payList.list[status.index - 1].orderGroup}">
              <tr>
                  <td colspan="7" style="text-align: left; padding-left:5px; background-color: #FFFFE0; color: black;">
                     <b>🛒 주문번호: ${pay.orderGroup}</b>
                  </td>
              </tr>
          </c:if>
            
            <!-- 결제내역 항목 -->
            <tr class="orderGroupRow" style="background-color: #FFFFFF;">
                <td style="text-align: center;">${pay.orderDate}</td>
                <c:set var="grade"/>
				<c:if test="${pay.check ne null}">
				    <c:set var="stars">
				        <c:forEach var="c" begin="1" end="${pay.check}">
				            ★
				        </c:forEach>
				    </c:set>
				    <c:set var="grade" value="&nbsp;&nbsp;&nbsp;(평점: ${stars})" />
				</c:if>
				<td style="text-align: left; border-left: 2px solid #ccc">${pay.orderItemName}<d id="grade">${grade}</d></td>
                <td style="text-align: right; font-size: 15px;">
				<fmt:formatNumber value="${pay.orderItemPrice}" pattern="#,###원"/></td>
                <td style="text-align: right;">${pay.orderQuantity}개</td>
                <td colspan="2" style="text-align: center;">
                
                <button onclick="location.href='/order/detail/${pay.orderNum}'">
			    <d>
			        <c:choose>
			            <c:when test="${userId eq 'dongmul'}">
			                 <span class="black-bold-text">${pay.orderState}</span>
			            </c:when>
			            <c:otherwise>
			                상세보기
			            </c:otherwise>
			        </c:choose>
			    </d>
			</button>
                
               <!-- 주문상태가 구매확정이 아니라면 주문취소 버튼을 보여줌 -->
			   <c:if test="${pay.orderState != '구매확정'}">
			      <button onclick="return deleteIt(${pay.orderNum})"><d>주문취소</d></button>
			   </c:if>
			   
			   <!-- 관리자는 리뷰쓰기 버튼을 안보여줌 -->
			   <c:if test="${userId ne 'dongmul'}">
				   <!-- 주문상태가 구매확정인 경우에만 리뷰쓰기 버튼을 보여줌 -->
				   <c:if test="${pay.orderState eq '구매확정' and pay.check eq null}">
				      <button class="write-button" onclick="location.href='/review/add/${pay.orderNum}'"><d>리뷰쓰기</d></button>
				   </c:if>
			   </c:if>
			   
			   <!-- 리뷰를 이미 작성한 상태일 때, 리뷰수정 버튼을 보여줌 -->
			   <c:if test="${pay.orderState eq '구매확정' and pay.check ne null}">
			      <button class="review-button" onclick="location.href='/review/update/${pay.orderNum}'"><d>리뷰수정</d></button>
			   </c:if>
            
            </td>
            </tr>
        </c:forEach>
    </table>
    
   <!-- 페이지 번호 표시 -->
   <div class="paylist-page" style="text-align: center;">
    <c:if test="${payList.pages > 1}">
        <c:if test="${payList.pageNum > 1}">
            <a class="page-number" href="?pageNum=${payList.pageNum - 1}">
                <i class="fas fa-chevron-left"></i> <!-- Previous page arrow -->
            </a>
        </c:if>
        <c:forEach var="page" begin="1" end="${payList.pages}">
            <c:if test="${page == payList.pageNum}">
                <span class="page-number">
                    <b>${page}</b>
                </span>
            </c:if>
            <c:if test="${page != payList.pageNum}">
                <a class="page-number" href="?pageNum=${page}"><font color="#FF69B4">${page}</font></a>
            </c:if>
        </c:forEach>
        <c:if test="${payList.pageNum < payList.pages}">
            <a class="page-number" href="?pageNum=${payList.pageNum + 1}">
                <i class="fas fa-chevron-right"></i> <!-- Next page arrow -->
            </a>
        </c:if>
    </c:if>
</div>
   </main>
      
   <div class="bottom-index">
      <%@ include file="../bottom.jsp" %>
   </div>
</body>
</html>
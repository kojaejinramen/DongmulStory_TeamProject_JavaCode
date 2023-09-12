<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>결제폼</title>

<style>
   .main {
   		font-family: Arial,
   		sans-serif; 
   		margin: 20px auto;
   		padding: 20px; 
   		background-color: #f9f9f9;
   		box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    	border-radius: 20px; /* 둥근 테두리 */
   	}
   h1 {margin-bottom: 20px; text-align: center; color: #ff69b4;}
   h2 {margin-bottom: 20px; text-align: center; color: #ff69b4;}
   h3 {margin-bottom: 20px; text-align: center; color: #ff69b4;}
   form {max-width: 400px; margin: 0 auto; background-color: #fff; padding: 20px;
         border-radius: 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);}
   table {width: 100%;}
   table th, table td {padding: 8px;}
   table th {text-align: right; width: 120px; color: #ff69b4;}
   table td input[type="text"] {width: 100%; padding: 6px; border: 1px solid #ccc; border-radius: 4px;}
   select {width: 100%; padding: 6px; border: 1px solid #ccc; border-radius: 4px;}
   button {padding: 10px 20px; background-color: #ff69b4; color: #fff; border: none; 
           border-radius: 4px; cursor: pointer; margin-bottom: 10px;}
   button:hover {background-color: #FF1493; color: #fff;}
   #infoInput {margin-top: 10px;}
   .table-container {border: 1px solid #ccc; border-radius: 4px; padding: 10px; margin-bottom: 20px;}
   .table-container table {width: 100%; border-collapse: collapse;}
   .table-container th,
   .table-container td {padding: 8px; border-bottom: 1px solid #ccc;}
   .table-container th {text-align: left; color: #ff69b4;}
   .table-container td {vertical-align: top;}
  table.order-item-table {
     width: 100%;
     border-collapse: collapse;
     margin-bottom: 20px;
   }

   table.order-item-table th,
   table.order-item-table td {
     padding: 8px;
     text-align: left;
     border-bottom: 1px solid #ccc;
   }

   table.order-item-table th {
     background-color: #ff69b4;
     color: #fff;
   }

   table.order-item-table tr:nth-child(even) {
     background-color: #f2f2f2;
   }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

var selectedPaymentMethod = ""; // 선택한 결제 수단을 저장하는 변수

// 선택한 결제 수단 설정
function selectPaymentMethod(method) {
    selectedPaymentMethod = method;
    if (selectedPaymentMethod === "무통장입금") {
        showBank(); // 무통장입금 선택 시, 무통장 계좌 정보 표시
    } else {
        showNone(); // 다른 결제 수단 선택 시, 무통장 계좌 정보 숨김
    }
}

// 결제
function add() {
	
	var orderPhone = $('#orderPhone').val();
	
	if (orderPhone.length !== 13 && orderPhone.length !== 12) {
        alert("올바른 전화번호를 입력해주세요. ")
        return;
     }
	
    if (!selectedPaymentMethod) {
        alert("결제 수단을 선택해주세요.");
        return;
    }

    if (selectedPaymentMethod === "무통장입금") {
        if (!confirm('위 내용으로 결제를 진행하시겠습니까?')) return;

        var formData = $('#addform').serialize();
        formData += "&date=" + new Date();

        $.ajax({
            url: "/order/saveOrderlist",
            data: formData,
            method: 'post',
            dataType: 'json',
            cache: false,
            success: function (res) {
                alert(res.saved ? "결제 성공" : "결제 실패...");
                if (res.saved) {
                    location.href = "/order/paylist";
                }
            },
            error: function (err) {
                alert(err);
            }
        });
    } else {
        // 무통장입금이 아닌 다른 결제 수단 선택 시, 저장 로직은 실행되지 않음
        alert("무통장입금을 선택하셨을 때만 결제가 진행됩니다.");
    }
}


// 우편번호
	function searchAddress() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            // 검색 결과를 가져와서 원하는 input 태그에 적용
	            document.getElementsByName("orderAddress1")[0].value = data.zonecode;
	            document.getElementsByName("orderAddress2")[0].value = data.address;
	        },
	    }).open();
	}
	
//배송사항메세지	
	function handleInfoOption(selectElement) {
		var infoInput = document.getElementById("infoInput");
		if (selectElement.value === "직접입력") {
		    infoInput.style.display = "block";
		    selectElement.name = ""; // 기존 orderNote 이름 제거
	        infoInput.children[0].name = "orderNote"; // 직접 입력 필드에 orderNote 이름 부여
		} else {
		    infoInput.style.display = "none";
		    selectElement.name = "orderNote"; // 기존 상태 복구
	        infoInput.children[0].name = ""; // 직접 입력 필드에서 orderNote 이름 제거
		}
	}

//무통장입금계좌
	function showBank() {
	    var bankInfoTable = document.getElementById("bankInfoTable");
	    bankInfoTable.style.display = "block";
	 
	}

//나머지 미구현
	function showNone() {
		document.getElementById("bankInfoTable").style.display = "none";
		 if (!document.querySelector('input[name="paymentMethod"]:checked')) {
		        alert("무통장입금을 선택해주세요.");
		return;
		 }
	}
	
	 //전화번호 입력 필드의 값을 변환하여 자동으로 하이픈(-)이 추가되도록 처리
	  function phoneFormat(orderPhone) {
	    // 특수문자 제거
	    const value = orderPhone.replace(/[^0-9]/g, '');
	    
	    // 숫자를 총 11자리로 제한 (최대)
	    if (value.length > 11) {
	        value = value.slice(0, 11);
	    }

	    let firstLength;
	    let secondLength;

	    // 지역번호(02 등) 또는 휴대전화 접두사(010 등)에 따라 분기
	    if (value.startsWith('02')) { // 서울 지역번호인 경우
	        firstLength = 2;
	        secondLength = value.length === 10 ? 4 : 4; // 번호 길이에 따라 분기
	    } else { // 그 외의 경우 (대부분 휴대전화)
	        firstLength = 3;
	        secondLength = 4;
	    }

	   return [
	       value.slice(0, firstLength), 
	       value.slice(firstLength, firstLength + secondLength),
	       value.slice(firstLength + secondLength),
		   ].filter(Boolean).join('-'); 
		}
		
		function onPhoneChange(event) {
		   const orderPhone = event.target;
		   orderPhone.value = phoneFormat(orderPhone.value);

		   if (orderPhone.value.startsWith('02')) {
			   orderPhone.maxLength = 12;
		   } else {
			   orderPhone.maxLength = 13;
		   }
		}
	
</script>

</head>
<body>

	<!-- 상단 목록 -->
	<div class="top-index">
	  <%@ include file="../topIndex.jsp" %>
	</div>
	<div class="banner-index">
		<%@ include file="../bannerIndex.jsp" %>
	</div>

<main class="main">
	<h2>결제창</h2>
	<form id="addform">
	<input type="hidden" name="orderUserId" value="${userId}">
	<c:forEach var="userInfo" items="${list}" begin="0" end="0">
		<table>
			<tr>
				<th>받는사람</th>
				<td>
					<input type="text" name="orderUserName" value="${userInfo.userName}">
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="text" id="orderPhone" name="orderPhone" value="${userInfo.userPhone}" required oninput="onPhoneChange(event);" >
				</td>
			</tr>
			<tr>
                <th>우편번호</th>
                <td>
                    <input type="text" name="orderAddress1" value="${userInfo.userAddress1}">
                    <button type="button" onclick="searchAddress()">주소 검색</button>
                </td>
            </tr>
			
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="orderAddress2" value="${userInfo.userAddress2}">
				</td>
			</tr>
			
			<tr>
				<th>상세주소</th>
				<td>
					<input type="text" name="orderAddress3" value="${userInfo.userAddress3}">
				</td>
			</tr>
			<tr>
		    <th>배송입력사항</th>
		    <td>
		        <select onchange="handleInfoOption(this)" name="orderNote">
		            <option value="문 앞에 놔주세요">문 앞에 놔주세요</option>
		            <option value="집 앞에 놔주세요">집 앞에 놔주세요</option>
		            <option value="배송 전 연락주세요">배송 전 연락주세요</option>
		            <option value="직접입력">직접입력</option>
		        </select>
		        <div id="infoInput" style="display: none;">
		            <input type="text" name="orderNoteCustom">
		        </div>
		    </td>
		</tr>
	             <tr style="display: none;">
	             <th>주문상태</th>
	             <td>
	                 <input type="text" name="orderState" value="결제확인중">
	             </td>
	           </tr>
	      </table>
	</c:forEach>
		
	
	
	<table class="order-item-table">
	<h3>**주문상품 정보**</h3>
		<tr>
			<th>상품이름</th>
			<th>상품가격</th>
			<th>상품수량</th>
			<th>총 가격</th>
		</tr>
		<c:set var="sum" value="0"/>
		<c:forEach var="order" items="${list}">
		<input type="hidden" name="cartNum" value="${order.cartNum}">
			<tr>
			     <tr style="display: none;">
				<td>
					<input type="text" name="orderItemNum" value="${order.itemNum}" readonly>
				</td>
				</tr>
				<td>
					<input type="text" name="orderItemName" value="${order.itemName}" readonly>
				</td>
				<td>
					<input type="text" name="orderItemPrice" value="${order.itemPrice}" readonly>
				</td>
				<td>
					<input type="text" name="orderQuantity" value="${order.cartQuantity}" readonly>
				</td>
				<td>
					<input type="text" name="totalAmount" value="${order.itemPrice * order.cartQuantity}" readonly>
				</td>
			</tr>
		<c:set var="sum" value="${sum + order.itemPrice * order.cartQuantity}"/>
		</c:forEach>
		<tr>
			<td colspan="4">배송비 3,000원</td>
			<c:set var="sum" value="${sum + 3000}"/>
		</tr>
	</table>
	<hr>
	<div>최종 결제 금액 : <fmt:formatNumber value="${sum}" pattern="#,###원"/></div>
	<br>
	
	
	<div class="button-container">
		<button class="custom-button" type="button" onclick="selectPaymentMethod('무통장입금')" name="무통장입금">무통장입금</button>
		<button class="custom-button" type="button" onclick="selectPaymentMethod('카드(미구현)')">카드(미구현)</button>
		<button class="custom-button" type="button" onclick="selectPaymentMethod('카카오페이(미구현)')">카카오페이(미구현)</button>
		<button class="custom-button" type="button" onclick="selectPaymentMethod('네이버페이(미구현)')">네이버페이(미구현)</button>
		<button class="custom-button" type="button" onclick="selectPaymentMethod('페이코(미구현)')">페이코(미구현)</button>
	</div>
	
	<div id="bankInfoTable" style="display: none;" class="table-container">
		<table>
			<tr>
				<th>예금주</th>
				<td>(주)동물이야기</td>
			</tr>
			<tr>
				<th>계좌번호</th>
				<td>농협은행 352-1234-5678-33</td>
			</tr>
		</table>
	</div>
	
	<table>
		<tr>
			<td colspan="2">
				<button type="button" onclick="return add()">결제</button>
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
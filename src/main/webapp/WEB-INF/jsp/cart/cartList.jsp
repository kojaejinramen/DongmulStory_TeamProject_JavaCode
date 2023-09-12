<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>장바구니 목록</title>
<style>
.container {
	max-width: 1000px;
	margin: 20px auto;
	padding: 20px;
	background-color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	border-radius: 10px; /* 둥근 테두리 */
	font-size: medium;
}

h3 {
	margin-bottom: 20px;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

th {
	background-color: #f1f1f1;
	font-weight: bold;
	text-align: left;
}

tr:hover {
	background-color: #f9f9f9;
}

.link {
	margin-top: 20px;
	text-align: center;
}

.link button {
	display: inline-block;
	margin-right: 10px;
	padding: 8px 16px;
	text-decoration: none;
	background-color: #007bff;
	color: #fff;
	border-radius: 4px;
	border: none;
	font-size: 18px;
	transition: background-color 0.3s;
	cursor: pointer;
}

/* Change the background color to a darker shade on hover */
.link button:hover {
	background-color: #0056b3;
}

#del {
	color: red;
	text-decoration: none;
}

#del:hover {
	text-decoration: underline;
}

/* Adjustments */
#sel {
	width: 100px;
}

#num {
	text-align: center;
}

#qty {
	width: 35px;
}

tfoot {
	text-align: center;
}

#sum {
	font-weight: bold;
	font-size: 18px;
	padding: 10px;
}

#totalPrice {
	font-size: 24px;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: underline;
}

.button-link {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 4px;
	border: 1px solid #ccc;
	text-decoration: none;
	color: #333;
	font-size: 14px;
	cursor: pointer; /* 마우스 커서를 손가락 모양으로 변경 */
	transition: background-color 0.3s, border-color 0.3s;
	/* 효과 적용을 위한 트랜지션 속성 추가 */
}

.button-link:hover {
	text-decoration: none;
	background-color: #f9f9f9;
}

.quantity-button {
	display: inline-block;
	width: 17px;
	height: 20px;
	text-align: center;
	line-height: 17px;
	background-color: #f1f1f1;
	border: 1px solid #ccc;
	text-decoration: none;
	color: #333;
	font-weight: bold;
	border-radius: 50%;
	margin: 0 2px;
}

.quantity-button:hover {
	text-decoration: none;
}

.change {
	display: inline-block;
	padding: 6px 12px;
	text-decoration: none;
	background-color: #007bff;
	color: #fff;
	border-radius: 4px;
	border: none;
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
}

.cancel {
	display: inline-block;
	padding: 6px 12px;
	background-color: #f9f9f9;
	border-radius: 4px;
	border: 1px solid #ccc;
	text-decoration: none;
	color: #333;
	font-size: 12px;
	font-weight: bold;
	cursor: pointer; /* 마우스 커서를 손가락 모양으로 변경 */
}

.qty {
	width: 25px;
	text-align: center;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
    
    function removeSelectedItems() {
        if (!confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?")) return;

        var selectedItems = [];
        $("input[name=num]:checked").each(function() {
            selectedItems.push($(this).val());
        });

        if (selectedItems.length === 0) {
            alert("고객님의 장바구니에서 삭제하실 상품을 선택해주십시오.");
            return;
        }

        $.ajax({
            url: "/cart/delete",
            data: JSON.stringify(selectedItems),
            method: "post",
            contentType: "application/json",
            cache: false,
            dataType: 'json',
            success: function (res) {
                if (res.deleted) {
                    alert('장바구니에서 요청하신 상품을 삭제하였습니다.');
                    location.reload();
                } else {
                    alert('예상치 못한 문제로 인해 상품 삭제에 실패하였습니다.\n지속적인 문제 발생 시 판매자에서 문의하시기를 바랍니다.');
                }
            },
            error: function (xhr, status, error) {
                alert('에러:' + error);
            }
        });
    }
    
    function orderSelectedItems() {
        var selectedItems = [];
        $("input[name=num]:checked").each(function() {
            selectedItems.push($(this).val());
        });

        if (selectedItems.length === 0) {
            alert("선택하신 상품이 없습니다.\n정상적인 주문을 원하시면 주문하실 상품을 먼저 선택해주세요.");
            return false;
        }
        return true;
    }
    
 	// 버튼 비활성화
    function disableAllQuantityButtons() {
    var quantityButtons = document.querySelectorAll('.quantity-change-button a');
    quantityButtons.forEach(function(button) {
        button.style.pointerEvents = 'none';
        button.style.opacity = 0.5;
    	});
	}
    
	// 수량 설정
    function showForm(cartNum) {
    	 var quantityInfoTable = document.getElementById("QuantityInfoTable"+ cartNum);
	    quantityInfoTable.style.display = "block";
	    
	    var quantityChangeButton = document.getElementById("quantityChangeButton"+ cartNum);
	    quantityChangeButton.style.display = "none";
	    
	    truncateProductNames(); 
	    disableAllQuantityButtons();
	}
    
    function apply_cart(cartNum, userId) {
		
    	var cartQuantity = $('#qty' + cartNum).val();
        
        if (cartQuantity <= 0) {
            alert("올바른 수량을 입력해주세요.");
            return; 
        } else if (cartQuantity > 100) {
            alert("최대 수량은 100개 입니다.");
            return; 
        }

		if(!confirm("해당 상품의 수량을 변경하시겠습니까?")) return;
		
		 // 장바구니 항목의 수량을 가져옵니다.
	    var cartQuantity = $('#qty'+cartNum).val();
		 
		$.ajax(
				{
					url:'/cart/update',
					method:'post',
					 data: {"cartNum":cartNum,
						 "cartQuantity":cartQuantity,
						 "cartUserId":userId},
					cache:false,
					dataType:'json',
					success:function(res){
						location.reload(); 
					},
					error:function(xhr,status,err){
						alert(status + "/" + err);
					}
				}		 
			 );
	}
    
        function checkAll() {
            if ($("#cboxAll").is(':checked')) {
                $("input[name=num]").prop("checked", true);
            } else {
                $("input[name=num]").prop("checked", false);
            }
        }

       
    </script>

<script type="text/javascript">
    // 전체 총가격
    $(document).ready(function() {
        calculateTotalPrice();
    });

    function calculateTotalPrice() {
        var totalPrice = 0;

        $("tbody tr").each(function() {
            var priceText = $(this).find("td:eq(2)").text();
            var price = parseFloat(priceText.replace(/,/g, ""));

            var quantity = parseInt($(this).find("input[type='text']").val());
            if (!isNaN(price) && !isNaN(quantity)) {
                totalPrice += price * quantity;
            }
        });

        var formattedTotalPrice = numberWithCommas(totalPrice) + "원";
        $("#totalPrice").text(formattedTotalPrice);
    }
    function numberWithCommas(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
 // 페이지 로드 시 초기화 함수 호출
    window.onload = function() {
      initializeButtons();
    };

    function initializeButtons() {
      const inputElements = document.querySelectorAll('.qty');
      
      inputElements.forEach(inputElement => {
        const currentValue = parseInt(inputElement.value);
        const decreaseButton = inputElement.previousElementSibling;

        // - 버튼을 초기 상태에서 비활성화 (처음에 수량 1일때 - 비활성화)
        if (currentValue === 1) {
          decreaseButton.style.pointerEvents = 'none';
          decreaseButton.style.opacity = 0.5;
        } else {
          decreaseButton.style.pointerEvents = 'auto';
          decreaseButton.style.opacity = 1;
        }
      });
    }

    function changeQuantity(inputId, changeAmount) {
      const inputElement = document.getElementById(inputId);
      const currentValue = parseInt(inputElement.value);
      const newValue = currentValue + changeAmount;
      
      // 수량이 1 미만으로 내려가지 않도록 유효성 검사
      if (newValue >= 1 && newValue <= 100) {
          inputElement.value = newValue;
      } else if (newValue > 100) {
          alert("수량은 최대 100 이하여야 합니다.");
          inputElement.value = 100; // 100로 변경
      }

      const decreaseButton = inputElement.previousElementSibling;
      
      // - 버튼을 누를 때, 수량이 1이면 비활성화
      if (newValue === 1) {
        decreaseButton.style.pointerEvents = 'none';
        decreaseButton.style.opacity = 0.5;
      } else {
        decreaseButton.style.pointerEvents = 'auto';
        decreaseButton.style.opacity = 1;
      }
    }
    
    // 상품명을 일정 길이로 자르고 "..."을 추가하는 함수
    function truncateProductNames() {
        const maxTitleLength = 25; // 최대 글자수 설정

        const itemNames = document.querySelectorAll('.item-name');
        itemNames.forEach(itemName => {
            const originalText = itemName.textContent;
            if (originalText.length > maxTitleLength) {
				const truncatedText = originalText.substring(0, maxTitleLength) + "...";
                itemName.textContent = truncatedText;
            }
        });
    }
</script>
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
		<form id="orderForm" action="/order/lastlist" method="post"
			onsubmit="return orderSelectedItems()">
			<div class="container">
				<h3>
					[ <a href=/user/mypage>${userId}</a> ] 고객님 장바구니
				</h3>

				<table>
					<thead>
						<tr>
							<th id="sel"><input type="checkbox" id="cboxAll"
								name="cboxAll" onclick="checkAll();"> 전체선택</th>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>주문 관리</th>
							<th>총 가격</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cart" items="${itemCart}">
							<tr>
								<td><input type="checkbox" name="num" id="num${cart.cartNum}" value="${cart.cartNum}"></td>
								<td><a class="item-name" href="/shop/detail/${cart.itemAnimalName}/${cart.itemTypeNum}/${pageNum}/${cart.itemNum}">${cart.itemName}</a></td>
								<td><fmt:formatNumber value="${cart.itemPrice}" pattern="#,###" /></td>
								<td>${cart.cartQuantity}</td>
								<td>
									<div id="QuantityInfoTable${cart.cartNum}"
										style="display: none;" class="table-container">
										<table>
											<tr>
												<td>
													<a class="quantity-button" href="javascript:void(0);" onclick="changeQuantity('qty${cart.cartNum}', -1)">-</a> 
													<input class="qty" type="text" id="qty${cart.cartNum}" value="${cart.cartQuantity}"> 
													<a class="quantity-button" href="javascript:void(0);" onclick="changeQuantity('qty${cart.cartNum}', 1)">+</a>
													
													<button class="change" id="but${cart.cartNum}" type="button" onclick="javascript:apply_cart(${cart.cartNum}, '${userId}')">변경</button>
													<button class="cancel" type="button" onclick="location.href='/cart/list'">취소</button>
												<td>
											</tr>
										</table>
									</div>
									
									<div class="quantity-change-button">
										<a class="button-link" id="quantityChangeButton${cart.cartNum}" onclick="location.href='javascript:showForm(${cart.cartNum})';">수량변경</a>
									</div>
								</td>
								
								<td><fmt:formatNumber value="${cart.itemPrice * cart.cartQuantity}" pattern="#,###" /></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td id="sum" colspan="6">전체 총 가격 : <span id="totalPrice"></span></td>
						</tr>
					</tfoot>
				</table>

				<div class="link">
					<button type="button" onclick="location.href='/shop/'">쇼핑 계속하기</button>
					<button type="button" onclick="location.href='javascript:removeSelectedItems()'">삭제</button>
					<button type="submit">주문</button>
				</div>
			</div>
		</form>
	</main>

	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>

</body>
</html>

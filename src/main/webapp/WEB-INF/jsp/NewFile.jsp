<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>## title ##</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function () {
	   $(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김
	   
	   //setInterval(nextSlide, 4000); //4초(4000)마다 다음 슬라이드로 넘어감
	   
	});

	//이전 슬라이드
	function prevSlide() {
	   $(".mySlideDiv").hide(); //모든 div 숨김
	   var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
	   var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
	   
	   //반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
	   $(".mySlideDiv").each(function(index,item){ 
	      if($(this).hasClass("active")) {
	         currentIndex = index;
	      }
	        
	   });
	   
	   //새롭게 나타낼 div의 index
	   var newIndex = 0;
	    
	   if(currentIndex <= 0) {
	      //현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
	      newIndex = allSlide.length-1;
	   } else {
	      //현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
	      newIndex = currentIndex-1;
	   }

	   //모든 div에서 active 클래스 제거
	   $(".mySlideDiv").removeClass("active");
	    
	   //새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
	   $(".mySlideDiv").eq(newIndex).addClass("active");
	   $(".mySlideDiv").eq(newIndex).show();

	}

	//다음 슬라이드
	function nextSlide() {
	   $(".mySlideDiv").hide();
	   var allSlide = $(".mySlideDiv");
	   var currentIndex = 0;
	   
	   $(".mySlideDiv").each(function(index,item){
	      if($(this).hasClass("active")) {
	         currentIndex = index;
	      }
	        
	   });
	   
	   var newIndex = 0;
	   
	   if(currentIndex >= allSlide.length-1) {
	      //현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
	      newIndex = 0;
	   } else {
	      //현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
	      newIndex = currentIndex+1;
	   }

	   $(".mySlideDiv").removeClass("active");
	   $(".mySlideDiv").eq(newIndex).addClass("active");
	   $(".mySlideDiv").eq(newIndex).show();
	   
	}



	</script>

</head>
<body>
<table>
   <tr>
     <th> 책읽기 </th>
   </tr>
   <tr>
      <td>
         <div class="slideshow-container">
            <div class="mySlideDiv fade active">
               <img src="/files/lol.jpg" alt="Image 1" style="max-width: 1000px; max-height: 400px;">
            </div>
            <div class="mySlideDiv fade">
               <img src="/files/loia.jpg" alt="Image 2" style="max-width: 1000px; max-height: 400px;">
            </div>
            <div class="mySlideDiv fade">
               <img src="/files/loiai.jpg" alt="Image 3" style="max-width: 1000px; max-height: 400px;">
            </div>
            <a class="prev" onclick="prevSlide()">&#10094;</a>
            <a class="next" onclick="nextSlide()">&#10095;</a>
         </div>
      </td>
   </tr>
</table>
</body>
</html>
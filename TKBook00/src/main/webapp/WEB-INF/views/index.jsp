<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> <!-- autocomplete 사용하기 위해서 필요한 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f9ef2afba501ac440ebc14fc5c60d205"></script>	
  <script type="text/javascript">
	$(document).ready(function(){
  		if(${!empty msgType}){
  			$("#messageType").attr("class", "modal-content panel-success")
  			$("#myMessage").modal("show");
  		}
  	// 책 검색 버튼이 클릭 되었을 때 처리
 		$("#search").click(function(){
 			var bookname=$("#bookname").val();
 			if(bookname==""){
 				alert("책 제목을 입력하세요");
 				return false;//이벤트 멈춤
 			}
 			//kakao 책 검색 openAPI를 연동하기(키를발급)
 			//URL : https://dapi.kakao.com/v3/search/book?target=title
 			//헤더 : Authorization: KakaoAK ${REST_API_KEY}     268e231707b97ea27e7a47b9b5d65a92
 			$.ajax({
 				url : "https://dapi.kakao.com/v3/search/book?target=title",
 				headers	: {Authorization : "KakaoAK 268e231707b97ea27e7a47b9b5d65a92"},
 				type : "get",
 				data : {"query" : bookname},
 				dataType : "json",
 				success : bookPrint,
 				error : function(){ alaert("error");}
 			});
 			$(document).ajaxStart(function(){ $(".loding-progres").show(); }); //ajax함수가 실행되는 순간 시작되는
 			$(document).ajaxStop(function(){ $(".loding-progres").hide(); });
 		});//클릭 끝
 		// input box에 책 제목이 입력되면 자동으로 검색을 하는 기능
 		$("#bookname").autocomplete({//bookname 박스의 글자가 변경 입력되면
 			source : function(){  
 				var bookname=$("#bookname").val();
 			$.ajax({
 				url : "https://dapi.kakao.com/v3/search/book?target=title",
 				headers	: {Authorization : "KakaoAK 268e231707b97ea27e7a47b9b5d65a92"},
 				type : "get",
 				data : {"query" : bookname},
 				dataType : "json",
 				success : bookPrint,
 				error : function(){ alaert("error");}
 				});
 				
 			}, 
 			minLength : 1 //최소 글자
 		});
 		// 지도 mapBtn 클릭시 지도가 보이도록 하기
 		$("#mapBtn").click(function(){
 			var address=$("#address").val();
 			if(address==''){
 				alert("주소를 입력하세요");
 				return false;
 			}
 			$.ajax({
 				url : "https://dapi.kakao.com/v2/local/search/address.json",
 				headers : {"Authorization" : "KakaoAK 268e231707b97ea27e7a47b9b5d65a92"},
 				type : "get",
 				data : {"query" : address},
 				dataType : "json",
 				success : mapView,
 				error : function(){ alert("error"); }
 			});
 		});
 	}); 
	function bookPrint(data){
 		var bList="<table class='table table-hover'>";
 		bList+="<thead>";
 		bList+="<tr>";
 		bList+="<th>책이미지</th>";
 		bList+="<th>책가격</th>";
 		bList+="</tr>";
 		bList+="</thead>";
 		bList+="<tbody>";
 		$.each(data.documents, function(index, obj){
	 		var image=obj.thumbnail;
	 		var price=obj.price;
	 		var url=obj.url;
 			bList+="<tr>";
	 		bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
	 		bList+="<td>"+price+"</td>";
	 		bList+="</tr>";
 		});
	 		bList+="</tbody>";
	 		bList+="</table>";
	 		$("#bookList").html(bList);
 	};
 	function mapView(data){
 		var x= data.documents[0].x; // 경도
 		var y= data.documents[0].y; //위도
 		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
 	    mapOption = { 
 	        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
 	        level: 10 // 지도의 확대 레벨
 	    };
 	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
 	var map = new kakao.maps.Map(mapContainer, mapOption); 
   
 	// 마커가 표시될 위치입니다 
 	var markerPosition  = new kakao.maps.LatLng(y, x); 
 	// 마커를 생성합니다
 	var marker = new kakao.maps.Marker({
 	    position: markerPosition
 	});
 	// 마커가 지도 위에 표시되도록 설정합니다
 	marker.setMap(map);
 	
	 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
 	var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
 	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
 	// 인포윈도우를 생성합니다
 	var infowindow = new kakao.maps.InfoWindow({
 	    content : iwContent,
 	    removable : iwRemoveable
 	});
 	// 마커에 클릭이벤트를 등록합니다
 	kakao.maps.event.addListener(marker, 'click', function() {
 	      // 마커 위에 인포윈도우를 표시합니다
 	      infowindow.open(map, marker);  
 	});
 	}
  </script>

</head>
<body>
<div class="container">
<jsp:include page="common/header.jsp"/>

  <br/>
  <br/>
  <div class="panel panel-default">
		<div>
			<img src="${contextPath }/resources/Images/main.jpg" style="width: 100%; height: 500px" />
		</div>
    <div class="panel-body">
	     <ul class="nav nav-tabs">
			  <li class="active"><a data-toggle="tab" href="#home">도서문고 소개</a></li>
			  <li><a data-toggle="tab" href="#menu1">도서검색</a></li>
			  <li><a data-toggle="tab" href="#menu2">지도</a></li>
		</ul>

	<div class="tab-content">
	  <div id="home" class="tab-pane fade in active">

	  </div>

	  <div id="menu1" class="tab-pane fade">
 	  			   <br/>
				   <div>
						<input type="text" id="bookname" placeholder="Search"/>
						<div>
							<a type="button" id="search">Go</a>
						</div>
					</div>
					<div style="display: none;">프로그래스 바 만들기
						<div role="status">
							<span >Loding</span>
						</div>
					</div>
					<div id="bookList" style="overflow: scroll; height: 500px; padding: 10px">
						여기에 검색된 책 목록을 출력하세요.
					</div>


 		 <!--  <div class="card" style="min-height : 500px; max-height: 1000px;">
				<div class="card-body">
					<h4>BOOK SEARCH</h4>
					<div class="input-group mb-3">
							<input type="text" class="form-control" id="bookname" placeholder="Search"/>
							<div class="input-group-append">
								<a type="button" class="btn btn-secondary" id="search">Go</a>
							</div>
					</div>
					<div class="loding-progres" style="display: none;">프로그래스 바 만들기
						<idv class="spinner-border text-secondary" role="status">
							<span class="sr-only">Loding</span>
						</idv>
					</div>
					<div id="bookList" style="overflow: scroll; height: 500px; padding: 10px">
						여기에 검색된 책 목록을 출력하세요.
					</div>
				</div>
			</div>  -->
	  </div>

	  <div id="menu2" class="tab-pane fade">
		   <div>
			<div>
				<div>
					<p>MAP VIEW</p>
					<div>
						<input type="text" id="address" placeholder="Search"/>
						<div>
							<button type="button" id="mapBtn">Go</button>
						</div>
					</div>
					<div id="map" style="width:100%; height:150px;"></div>
				</div>
			</div>
		</div> 
	  </div>
	</div>

    </div>
    <div class="panel-footer">(김태경)</div>
  </div>
</div>
</div>
<!-- 실패 메세지 출력(모달) -->
    <div id="myMessage" class="modal fade" role="dialog">
	  	<div class="modal-dialog">

	    <!-- Modal content-->
	    <div id="messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType }</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg }</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>

	  </div>
	</div>
</body>
</html>
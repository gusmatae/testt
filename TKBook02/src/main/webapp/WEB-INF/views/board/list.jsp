<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script><!-- j쿼리만 바꿈-->
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> <!-- autocomplete 사용하기 위해서 필요한 -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 	
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f9ef2afba501ac440ebc14fc5c60d205"></script>	
	<script type="text/javascript">
	 	$(document).ready(function(){
	 		var result = '${result}';
	 		checkModal(result);
	 		
	 		$("#regBtn").click(function(){
	 			location.href="${cpath}/board/register";
	 		});
	 		//페이지 번호 클릭시 이동 하기
	   	var pageFrm=$("#pageFrm"); //폼을 가져온다.
	   	$(".paginate_button a").on("click", function(e){ //클릭 시 이벤트
	   		e.preventDefault(); // on했을 때 이동하면 안되므로 a tag의 기능을 막는 부분
	   		var page=$(this).attr("href"); // 페이지번호
	   		pageFrm.find("#page").val(page);
	   		pageFrm.attr("action","${cpath}/board/list"); //뒤로가기 후 페이지 눌렀을 때 상세보기 안나오게 하려 추가
	   		pageFrm.submit(); // /controller/board/list   		
	   	});    	
	 		// 상세보기 클릭 시 이동하기
	   	$(".move").on("click", function(e){//move라는 이동버튼을 클릭했을 때
	   		e.preventDefault(); // on했을 때 이동하면 안되므로 a tag의 기능을 막는 부분
	   		var idx= $(this).attr("href"); //href에 있는 값을 가져와서 
	   		var tag="<input type='hidden' name='idx' value='"+idx+"'/>"; //hidden으로 idx를 하나 만들어주고
	   		pageFrm.append(tag);//만든 것을 추가
	   		pageFrm.attr("action","${cpath}/board/get");//Form action 경로를 설정. (attr은 가져오거나 설정할 때 사용하는 함수)
	   		pageFrm.attr("method","get");
	   		pageFrm.submit();
	   	});
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
	 	function checkModal(result){
	 		if(result==''){
	 			return;
	 		}
	 		if(parseInt(result)>0){
	 			// 새로운 다이얼로그 창 띄우기
	 			$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
	 		}
	 		$("#myModal").modal("show");
	 	}
	 	function goMsg(){
	 		alert("삭제된 게시물입니다");
	 	}
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
<!-- 메뉴 bar -->
	<nav class="navbar navbar-expand-sm bg-light">
	
	  <!-- Links -->
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${cpath}/board/index">홈으로</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${cpath}/board/list">게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">Link 3</a>
	    </li>
	  </ul>
	
	</nav>
	  	<!-- 메뉴 bar 끝 -->
  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
  		  <div class="container">
		    <h1>Spring</h1>
		    <p>Spring</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
		  <div class="col-lg-2">
		  		<jsp:include page="../common/left.jsp"/> 
		  </div>
		  <div class="col-lg-7">
 	    <table class="table table-hover ">
	    <thead>
		    <tr>
				<th>번호</th>	
				<th>제목</th>	
				<th>작성자</th>	
				<th>작성일</th>	
				<th>조회수</th>	
		    </tr>
	    </thead>
    	<c:forEach var="vo" items="${list }">
    		 <tr>
				<td>${vo.idx }</td>	
				<td>
					<c:if test="${vo.boardLevel>0 }">
						<c:forEach begin="1" end="${vo.boardLevel }">
							<span style="padding-left: 10px"></span>
						</c:forEach>
						<i class="bi bi-arrow-return-right"></i>
					</c:if>
					<c:if test="${vo.boardLevel>0 }">
						<c:if test="${vo.boardAvailable==1 }">
							<a class="move" href="${vo.idx}"><c:out value='[RE]${vo.title }'/></a>
						</c:if>
						<c:if test="${vo.boardAvailable==0 }">
							<a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
						</c:if>
					</c:if>
					<c:if test="${vo.boardLevel==0 }">
						<c:if test="${vo.boardAvailable==1 }">
							<a class="move" href="${vo.idx}"><c:out value='${vo.title }'/></a>
						</c:if>
						<c:if test="${vo.boardAvailable==0 }">
							<a href="javascript:goMsg()">삭제된 게시물입니다.</a>
						</c:if>
					</c:if>
				</td>	
				<td>${vo.writer }</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate }"/></td>	
				<td>${vo.count }</td>
		    </tr>
    	</c:forEach>
    	<c:if test="${!empty mvo }">
	    	<tr>
	    		<td colspan="5">
	    			<button id="regBtn" class="btn btn-sm btn-secondary pull-right">글쓰기</button>
	    		</td>
	    	</tr>
    	</c:if>
    </table>
    <!-- 검색메뉴 -->
    <form class="form-inline" action="${cpath}/board/list" method="post"><!-- type 과 keyword 두개를 서버에 보냄 criteria VO에 넣는게 좋을 듯함-->
	   <div class="container">
		    <div class="input-group mb-3">
		      <div class="input-group-append">
				<select name="type" class="form-control">
			  		<option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option><!-- 삼항은 값 유지 -->
			  		<option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
			  		<option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
			  	</select>
			  </div>
			  <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}"><!-- value는 값 유지 -->
			  <div class="input-group-append">
			    <button class="btn btn-success" type="submit">Search</button>
			  </div>
			</div>
	   </div>
	</form>
    
    
    <!-- 페이징 Start-->

    	<ul class="pagination justify-content-center">
    	
    <!-- 이전 처리 -->
    <c:if test="${pageMaker.prev}">
    	<li class="paginate_button previous page-item">
    		<a class="page-link" href="${pageMaker.startPage-1}">Previous</a>
    	</li>
    </c:if>
    
    <!-- 페이지번호 처리-->
    	  <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${pageNum}">${pageNum}</a></li>

    	  </c:forEach>
    <!-- 다음 처리-->
    <c:if test="${pageMaker.next}">
    	<li class="paginate_button next page-item">
    		<a class="page-link" href="${pageMaker.endPage+1}">Next</a>
    	</li>
    </c:if>
    
		</ul>

    <!-- END -->
    <form id="pageFrm" action="${cpath}/board/list" method="post"><!-- 키워드 값이 한글로 갈 경우 깨질 수도 있으므로 post방식으로 체인지 -->
   		 <!-- 게시물 번호(idx) 추가 -->
    	<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/><!--위의 href의 값들이 들어가야-->
    	<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/><!-- 서버에서 정해(준).. -->
    	<input type="hidden" name="type" value="${pageMaker.cri.type}"/><!-- 다음페이지를 눌러도 출력값 유지하도록 서버에 보내고 받음 -->
    	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/><!-- 다음페이지를 눌러도 출력값 유지 서버에 보내고 받음 -->
    	
    </form>
    <!-- Modal 추가 -->
		    <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">Message</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      <div class="modal-body">
		      
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		  </div>
		  <div class="col-lg-3">
		  	<jsp:include page="../common/right.jsp"/> 
		  </div>
		</div>
    </div> 
    <div class="card-footer">(김태경)</div>
   </div>
</body>
</html>

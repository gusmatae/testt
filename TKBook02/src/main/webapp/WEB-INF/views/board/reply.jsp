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
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 	
 <script type="text/javascript">
  	$(document).ready(function(){
  		$("button").on("click", function(){  
  			var formData=$("#frm");
  			var btn=$(this).data("btn"); //data-btn="reply" btn에는 reply가 들어간다
  			if(btn=='reply'){
  				formData.attr("action", "${cpath}/board/reply");
  			}else if(btn=='list'){
  				var formData1=$("#frm1");
  				formData1.attr("action", "${cpath}/board/list");
  				formData1.submit();
  				return;
  			}else if(btn='reset'){
  				formData[0].reset();//폼이 여러개일 가능성이 있으므로 몇번째 폼인지 정해줘야 한다.
  				return;
  			}
  				formData.submit();
  		});
  	});
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
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
		  <div class="col-lg-2">
		  	<jsp:include page="../common/left.jsp"/>
		  </div>
		  <div class="col-lg-7"><!-- content -->
			  <form id="frm" method="post">
	    		<input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
		   		<input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/><!-- 설정을 해두어서 넘기지 않아도 상관없음 -->    
	 	    	<input type="hidden" name="type" value="${cri.type}"/><!-- 검색 값 유지 -->
	    		<input type="hidden" name="keyword" value="${cri.keyword}"/><!-- 검색 값 유지 -->
		    	<!-- 넘어가는 idx는 부모글의 idx -->
		    	<input type="hidden" id="idx" name="idx" value="${vo.idx }"/>
		    	<input type="hidden" id="memID" name="memID" value="${mvo.memID }"/>
	    		<div class="form-group">
	    			<label>제목</label>
	    			<input type="text" id="title" name="title" class="form-control" value="<c:out value='${vo.content }'/>">
	    		</div>
	    		<div class="form-group">
	    			<label>답변</label>
					<textarea rows="10" id="content" name="content" class=form-control></textarea>
	    		</div>
	    		<div class="form-group">
	    			<label>작성자</label>
	    			<input type="text" readonly="readonly" id="writer" name="writer" class="form-control" value="${mvo.memName }"/>
	    		</div>
	    		<button type="button" data-btn="reply" class="btn btn-secondary btn-sm">답변</button>
	    		<button type="button" data-btn="reset" class="btn btn-secondary btn-sm">취소</button>
	    		<!-- <button type="button" class="btn btn-default btn-sm" onclick="location.href='${cpath}/board/list'">목록</button>  -->
	    		<button type="button" data-btn="list" class="btn btn-secondary btn-sm">목록</button>
	    	</form>
	    	<form id="frm1" method="get">
	    		<input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
		   		<input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/><!-- 설정을 해두어서 넘기지 않아도 상관없음 --> 
	    		<input type="hidden" name="type" value="${cri.type}"/><!-- 검색 값 유지 -->
	    		<input type="hidden" name="keyword" value="${cri.keyword}"/><!-- 검색 값 유지 -->
	    	</form>
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

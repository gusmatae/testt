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
		    <h1>Spring Framework~~</h1>
		    <p>Spring 프로젝트</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
		  <div class="col-lg-2">
		  	<jsp:include page="../common/left.jsp"/>
		  </div>
		  <div class="col-lg-7">
			  <form action="${cpath }/board/register" method="post">
	    		<input type="hidden" name="memID" value="${mvo.memID }"/>
	    		<div class="form-group">
	    			<label>제목</label>
	    			<input type="text" name="title" class="form-control"/>
	    		</div>
	    		<div class="form-group">
	    			<label>내용</label>
					<textarea rows="10" name="content" class=form-control></textarea>
	    		</div>
	    		<div class="form-group">
	    			<label>작성자</label>
	    			<input type="text" readonly="readonly" name="writer" class="form-control" value="${mvo.memName }"/>
	    		</div>
	    		<button type="submit" class="btn btn-secondary btn-sm">등록</button>
	    		<button type="reset"class="btn btn-secondary btn-sm">취소</button>
	    	</form>
		  </div>
		  <div class="col-lg-3">
		  	<jsp:include page="../common/right.jsp"/>
		  </div>
		</div>
    </div> 
    <div class="card-footer">Spring 프로젝트</div>
   </div>
</body>
</html>

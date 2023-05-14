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
  			}else if(btn=='modify'){
  				formData.attr("action", "${cpath}/board/modify");
  			}else if(btn=='list'){
  				formData.find("#idx").remove();
  				formData.attr("action", "${cpath}/board/list");
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
		  <div class="col-lg-7"><!-- content -->
			  <table class="table table-bordered">
	    		<tr>
		    		<td>번호</td>
		    		<td><input type="text" class="form-control" name="idx" readonly="readonly" value="${vo.idx }"/></td>
	    		</tr>
	    		<tr>
		    		<td>제목</td>
		    		<td><input type="text" class="form-control" name="title" readonly="readonly" value="<c:out value='${vo.title }'/>"/></td>
	    		</tr>
	    		<tr>
		    		<td>내용</td>
		    		<td><textarea rows="10" class="form-control" name="content" readonly="readonly"/><c:out value='${vo.content }'/></textarea></td>
	    		</tr>
			   	<tr>
		    		<td>작성자</td>
		    		<td><input type="text" class="form-control" name="writer" readonly="readonly" value="${vo.writer }"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" style="text-align : center;">
	    				<c:if test="${!empty mvo }">
		    				<button data-btn="reply" class="btn btn-sm btn-primary">답글</button>
		    				<button data-btn="modify" class="btn btn-sm btn-success">수정</button>
	    				</c:if>
	    				<c:if test="${empty mvo }">
		    				<button disabled="disabled" class="btn btn-sm btn-primary">답글</button>
		    				<button disabled="disabled" class="btn btn-sm btn-success">수정</button>
	    				</c:if>
	    				<button data-btn="list" class="btn btn-sm btn-info">목록</button>
	    			</td>
	    		</tr>
	    	</table>
	    	<form id="frm" method="get" action="">
	    		<input type="hidden" id="idx" name="idx" value="<c:out value='${vo.idx}'/>"/>
	    		<input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
	    		<input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/><!-- 설정을 해두어서 넘기지 않아도 상관없음 -->
	    		<input type="hidden" name="type" value="${cri.type}"/><!-- 상세보기 후 목록갔을 때 유지 -->
	    		<input type="hidden" name="keyword" value="${cri.keyword}"/><!-- 상세보기 후 목록갔을 때 유지 -->
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <div class="panel panel-default">
    <div class="panel-heading">로그인 화면</div>
    <div class="panel-body"><!-- 바디 시작 -->

	   <div class="row">
	    <c:forEach var="product" items="${blist}">
	    <div class="col-sm-4">
	      <div class="thumbnail">
	        <img src="${contextPath}/resources/book/${product.bkImage}" alt="Product 1">
	        <div class="caption">
	          <p><span class="glyphicon glyphicon-book"></span><strong>도서 명 : </strong>${product.bkNm}</p>
	          <p><strong>내용 :</strong> ${product.bkContent}</p>
	          <p><strong>가격 :</strong> ${product.bkPrice}원</p>
	          <p><strong>등록일 :</strong> ${product.bkCreDt.split(' ')[0]}</p>
	          <p><a href="${contextPath}/odJoinForm.do?memID=${mvo.member.memID}&bkCd=${product.bkCd}&bkNm=${product.bkNm}&bkImage=${product.bkImage}" class="btn btn-primary" role="button">상품 구매</a></p>
	          <p><a href="${contextPath}/bkDelete.do?bkImage=${product.bkImage}" class="btn btn-primary" role="button">삭제</a></p>
	        </div>
	      </div>
	    </div>
	    </c:forEach>
	  </div>
<%-- 	  <input type=text value="${mvo.member.memID}"> --%>
    	<%-- <c:forEach var="product" items="${blist}">
    		${product}
    	</c:forEach> --%>

    	<%-- <img src="${contextPath}/resources/book/상품1.jpg"> --%>
    </div><!-- 바디 끝 -->

    <div class="panel-footer">(김태경)</div>
  </div>
</div>

</body>
</html>
<!--  
<c:forEach var="user" items="${list}">
  <p>${user.username}</p>
  <p>${user.email}</p>
</c:forEach>
-->
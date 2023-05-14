<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <h2>주문 목록</h2>
  <div class="panel panel-default">
    <div class="panel-heading">주문 목록</div>
    <div class="panel-body">
	    <table class="table">
	        <thead>
	          <tr>
	            <th>주문번호</th>
	            <th>수령인 이름</th>
	            <th>수령인 주소</th>
	            <th>수령인 번호</th>
	            <th>주문 일자</th>
	          </tr>
	        </thead>
	        <tbody>
		        <c:forEach var="odlist" items="${odlist}">
		        <c:if test="${odlist.memID eq mvo.member.memID}">
			          <tr>
			            <td>${odlist.orIdx}</td>
			            <td>${odlist.recvNm}</td>
			            <td>${odlist.recvAddr}</td>
			            <td>${odlist.recvPN}</td>
			            <td>${odlist.orDate.split(' ')[0]}</td>
			          </tr>
			      </c:if>
		          </c:forEach>
	        </tbody>
	      </table>
    </div>
    <div class="panel-footer">(김태경)</div>
  </div>
</div>

</body>
</html>
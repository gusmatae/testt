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
  <script type="text/javascript">
	function goInsert(){
  		document.frm.submit(); //전송
  	}
  </script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>상품 주문 Form 페이지</h2>
  <div class="panel panel-default">
    <div class="panel-heading">상품 주문 Form 페이지</div>
    <div class="panel-body">
    	<img src="${contextPath}/resources/book/${bkImage}" alt="이미지설명" width="250" height="250">
    	<br/><br/>
    	<form action="${contextPath }/orRegister.do" name="frm" method="post">
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
    			<tr>
	    			<td style="width:110px; vertical-align: middle">주문 아이디</td>
	    			<td><input type="text" id="memID" name="memID" class="form-control" maxlength="20" placeholder="아이디를 입력하세요" value="${od.memID}"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">상품코드</td>
	    			<td><input type="text" id="bkCd" name="bkCd" class="form-control" maxlength="20" placeholder="아이디를 입력하세요" value="${od.bkCd}"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">상품이름</td>
	    			<td><input type="text" id="bkNm" name="bkNm" class="form-control" maxlength="20" placeholder="아이디를 입력하세요" value="${od.bkNm}"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">수령인 이름</td>
	    			<td><input type="text" id="recvNm" name="recvNm" class="form-control" maxlength="20" placeholder="수령인를 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">수령인 주소</td>
	    			<td><input type="text" id="recvAddr" name="recvAddr" class="form-control" maxlength="20" placeholder="수령인 주소를 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">수령인 Phone</td>
	    			<td><input type="text" id="recvPN" name="recvPN" class="form-control" maxlength="20" placeholder="수령인 휴대폰번호를 입력하세요"></td>  
    			</tr>
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<sapn id="passMessage" style="color: red"></sapn><input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goInsert()">
    				</td>
    			</tr>
    		</table>
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><!-- 토큰 넘겨주기 -->
    	</form>
    </div>

    <!-- 중복확인창(모달) -->
    <div id="myModal" class="modal fade" role="dialog">
	  	<div class="modal-dialog">

	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p> 
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
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
    <div class="panel-footer">(김태경)</div>
  </div>
</div>

</body>
</html>
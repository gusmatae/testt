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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
	function goInsert(){
  		var bkNm=$("#bkNm").val();
  		if(bkNm==null || bkNm==""){
  			alert("책 이름을 입력하세요");
  			return false;
  		}
  		document.frm.submit(); //전송
  	}
  </script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <div class="panel panel-default">
    <div class="panel-heading">로그인 화면</div>
    <div class="panel-body"><!-- 바디 --> <!-- bkCd 안넘겨도 됨 ,bkNm,bkPrice,bkContent,bkImage,bkCreDt안보내도 됨 -->
   	   <form action="${contextPath}/bkRegister.do?${_csrf.parameterName}=${_csrf.token}" name="frm" method="post" enctype="multipart/form-data">
    		<input type="hidden" id="memPassword" name="memPassword" value=""/>
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
    			<tr>
	    			<td style="width:110px; vertical-align: middle">도서 이름</td>
	    			<td><input type="text" id="bkNm" name="bkNm" class="form-control" maxlength="20" placeholder="책 이름을 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">도서 가격</td>
	    			<td><input type="text" id="bkPrice" name="bkPrice" class="form-control" maxlength="20" placeholder="책 이름을 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">도서 설명</td>
	    			<td><input type="text" id="bkContent" name="bkContent" class="form-control" maxlength="100" placeholder="책 이름을 입력하세요"></td>  
    			</tr>
    			<tr>
		            <td style="width: 110px; vertical-align: middle;">사진 업로드</td>
		            <td colspan="2">
		              <span class="btn btn-default">
		                이미지를 업로드하세요.<input type="file" name="memProfile"/>
		              </span>
		            </td>            
                </tr> 
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<sapn id="passMessage" style="color: red"></sapn><input type="button" class="btn btn-primary btn-sm pull-right" value="상품 등록" onclick="goInsert()">
    				</td>
    			</tr>
    		</table>
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><!-- 토큰 넘겨주기 -->
    	</form>
    </div><!-- 바디 끝--->
    <div class="panel-footer">(김태경)</div>
  </div>
</div>

</body>
</html>
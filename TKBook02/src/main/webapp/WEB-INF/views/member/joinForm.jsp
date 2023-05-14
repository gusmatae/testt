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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- j쿼리만 바꿈-->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 	
  <script type="text/javascript">
 	$(document).ready(function(){
 		if(${!empty msgType}){
 	/* 		if(${msgType eq "실패 메세지"}){
 			}else{
			  				
 			} */
 			$("#messageType").attr("class", "modal-content panel-warning")
 			$("#myMessage").modal("show");
 			}
 		});
	function registerCheck(){
  		var memID = $("#memID").val();
  		console.log(document.frm.memID.value);
  		$.ajax({
  			url : "${cpath}/memRegisterCheck",
  			type : "get",
  			data : {"memID" : memID},
  			success : function(result){
  				//중복유무 출력(result=1 : 사용할수있는 아이디, 0: 사용할수없는 아이디)
  				 if(result==1){
  					 $("#checkMessage").html("사용할 수 있는 아이디입니다.");
  				 	 $("#checkType").attr("class", "modal-content panel-success")
  				 }else{
  					 $("#checkMessage").html("사용할 수 없는 아이디입니다.");  					 
  				 	 $("#checkType").attr("class", "modal-content panel-warning")
  				 }
  				$("#myModal").modal("show");
  			},
  			error : function(){ alert("error"); }
  		});
  	}
 	function passwordCheck(){
 		var memPassword1 = $("#memPassword1").val();
 		var memPassword2 = $("#memPassword2").val();
 		if(memPassword1 != memPassword2){
 			$("#passMessage").html("비밀번호가 서로 일치하지 않습니다");
 		}else{
 			$("#passMessage").html("비밀번호 일치");
 			$("#memPassword").val(memPassword1);
 		}
 	}
 	function goInsert(){
 		var memAge=$("#memAge").val();
 		if(memAge==null || memAge=="" || memAge==0){
 			alert("나이를 입력하세요");
 			return false;
 		}

 		document.frm.submit(); //전송
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
		  <!-- 회원가입 폼 -->
		  <form action="${cpath}/memRegister" name="frm" method="post">
    		<input type="hidden" id="memPassword" name="memPassword" value=""/>
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
    			<tr>
	    			<td style="width:150px; vertical-align: middle">아이디</td>
	    			<td><input type="text" id="memID" name="memID" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>  
	    			<td style="width:150px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td><!-- 타입 버튼 안걸어주면 서브밋타고 간다 -->  			
    			</tr>
    			<tr>
	    			<td style="width:150px; vertical-align: middle">비밀번호</td>
	    			<td colspan="2"><input type="password" id="memPassword1" onkeyup="passwordCheck()" name="memPassword1" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:150px; vertical-align: middle">비밀번호확인</td>
	    			<td colspan="2"><input type="password" id="memPassword2" onkeyup="passwordCheck()" name="memPassword2" class="form-control" maxlength="20" placeholder="비밀번호를 확인하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:150px; vertical-align: middle">사용자 이름</td>
	    			<td colspan="2"><input type="text"  id="memName" name="memName" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:150px; vertical-align: middle">나이</td>
	    			<td colspan="2"><input type="number" id=memAge name="memAge" class="form-control" maxlength="20" placeholder="나이를 입력하세요"></td>  
    			</tr>
    			<tr>
	    			<td style="width:150px; vertical-align: middle">성별</td>
	    			<td colspan="2">
	    				<div class="form-group" style="text-align: center; margin: 0 auto;">
	    					<div class="btn-group" data-toggle="buttons">
	    						<label class="btn btn-primary active">
	    							<input type="radio" id=memGender name="memGender" autocomplete="off" value="남자" checked>남자
	    						</label>
	    						<label class="btn btn-primary">
	    							<input type="radio" id=memGender name="memGender" autocomplete="off" value="여자" checked>여자
	    						</label>
	    					</div>
	    				</div>
	    			</td>  
    			</tr>
    			<tr>
	    			<td style="width:110px; vertical-align: middle">이메일</td>
	    			<td colspan="2"><input type="text" id=memEmail name="memEmail" class="form-control" maxlength="20" placeholder="이메일을 입력하세요"></td>  
    			</tr>
    			<!-- 권한체크박스추가 -->
				<tr><!-- authList 변수의 0번째 인덱스에 해당하는 AuthVO 객체의 auth 변수에 값을 저장하고 리스트에도 저장 됩니다 -->
	    			<td style="width:110px; vertical-align: middle">사용자 권한</td>
	    			<td colspan="2"> 
	    				<input type="checkbox" name="authList[0].auth" value="ROLE_USER"> ROLE_USER
	    				<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER"> ROLE_MANAGER
	    				<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN"> ROLE_ADMIN
	    			</td>
    			</tr>
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<sapn id="passMessage" style="color: red"></sapn><input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goInsert()">
    				</td>
    			</tr>
    		</table>
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><!-- 토큰 넘겨주기 -->
    	</form>
		  <!-- 회원가입 폼 끝 -->
	    <!-- 중복확인창(모달) -->
	    <div id="myModal" class="modal fade" role="dialog">
		  	<div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div id="checkType" class="modal-content panel-info">
		      <div class="modal-header panel-heading">
		        <h4 class="modal-title">메세지 확인</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
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
		<!-- 모달 끝 -->
		  </div><!-- content 끝 -->
		  <div class="col-lg-3">
		  	<jsp:include page="../common/right.jsp"/>
		  </div>
		</div>
    </div> 
    <div class="card-footer">Spring 프로젝트</div>
   </div>
</body>
</html>

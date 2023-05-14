<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	function logout(){
	  	$.ajax({
	  		url : "${contextPath}/logout",
	  		type: "post", // insert    	
	  		beforeSend: function(xhr){
	              xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	          },
	  		success : function(){
	  			location.href="${contextPath}/";
	  		},
	  		error : function(){ alert("error");}    		
	  	}); 
	}
</script>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath}/">인터넷 도서</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath}/">Home</a></li>
        <li><a href="boardMain.do">게시판</a></li> 

        <security:authorize access="hasRole('ROLE_ADMIN')"> 
        	<li><a href="bkJoinForm.do">상품등록</a></li>            
      	</security:authorize>  

        <li><a href="bkContent.do">상품목록</a></li>   
       	<li><a href="orContent.do">주문현황</a></li>            
      </ul>
      <security:authorize access="isAnonymous()">
	      <ul class="nav navbar-nav navbar-right">
	            <li><a href="${contextPath}/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
	            <li><a href="${contextPath}/memJoin.do"><span class="glyphicon glyphicon-user">회원가입</span></a></li>            
	      </ul>
      </security:authorize>
      <security:authorize access="isAuthenticated()">
	      <ul class="nav navbar-nav navbar-right">
<%-- 	      		<security:authorize access="hasRole('ROLE_ADMIN')">
	            	<li><a href="${contextPath}/memJoin.do"><span class="glyphicon glyphicon-user"></span>회원추가</a></li>            
	            </security:authorize> --%>
	            <li><a href="${contextPath}/memUpdateForm.do"><span class="glyphicon glyphicon glyphicon-wrench"></span> 회원정보수정</a></li>
	            <li><a href="${contextPath}/memImageForm.do"><span class="glyphicon glyphicon glyphicon-picture"></span> 사진등록</a></li>
	            <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>            
	            <c:if test="${empty mvo.member.memProfile}">
			      <li><img class="img-circle" src="${contextPath}/resources/Images/person.png" style="width: 50px; height: 50px"/>
			    </c:if>
			    <c:if test="${!empty mvo.member.memProfile}">
			      <li><img class="img-circle" src="${contextPath}/resources/upload/${mvo.member.memProfile}" style="width: 50px; height: 50px"/>
			    </c:if>
			     ${mvo.member.memName}님
			     (
			     <security:authorize access="hasRole('ROLE_USER')"> 
			       U,
			     </security:authorize> 
			     <security:authorize access="hasRole('ROLE_MANAGER')"> 
			       M,
			     </security:authorize>  
			     <security:authorize access="hasRole('ROLE_ADMIN')">
			       A
			     </security:authorize>
			      )
			    </li>
	      </ul>
      </security:authorize>
    </div>
  </div>
</nav>
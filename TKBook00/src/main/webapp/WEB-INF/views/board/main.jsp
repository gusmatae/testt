<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>   
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 
<DOCTYPE html>
<html lang="en">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <script type="text/javascript">
  
  var csrfHeaderName = "${_csrf.headerName}";
  var csrfTokenValue = "${_csrf.token}";
  	$(document).ready(function(){
  		loadList();
  	});
	function loadList(){
		// 서버와 통신 : 게시판 리스트 가져오기
		$.ajax({
			url : "board/all",
			type : "get",
			dataType : "json", //받는 타입
			success : makeView, //콜백함수
			error : function(){alert("error"); }
		});
	}													 //        0  1  2
	function makeView(data){ //data 의 인수는 list json 객체 // data=[{},{},{},,,]
		var listHtml="<table class='table table-bordered'>";
		listHtml+="<tr>";
		listHtml+="<td>번호</td>";
		listHtml+="<td>제목</td>";
		listHtml+="<td>작성자</td>";
		listHtml+="<td>작성일</td>";
		listHtml+="<td>조회수</td>";
		listHtml+="</tr>";
		$.each(data, function(index,obj){// obj={idx:5, title:"게시판" ~~}
			listHtml+="<tr>";
			listHtml+="<td>"+obj.idx+"</td>";
			listHtml+="<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
			listHtml+="<td>"+obj.writer+"</td>";
			listHtml+="<td>"+obj.indate.split(' ')[0]+"</td>";
			listHtml+="<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
			listHtml+="</tr>";
			
			listHtml+="<tr id='c"+obj.idx+"' style='display:none'>"; //행마다 나오는 것을 일단 다 막음
			listHtml+="<td>내용</td>";
			listHtml+="<td colspan='4'>";
			listHtml+="<textarea rows='7' id='ta"+obj.idx+"' class='form-control' readonly></textarea>";
			if("${mvo.member.memID}" == obj.memID){//자신의 게시글이면
				listHtml+="<br/>";
				listHtml+="<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
				listHtml+="<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
			}else{//자신의 게시글이 아니면
				listHtml+="<br/>";
				listHtml+="<span id='ub"+obj.idx+"'><button disabled class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
				listHtml+="<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
			}
				listHtml+="</td>"; 
				listHtml+="</tr>";
		});
		//로그인을 해야 보이는 부분
		if(${!empty mvo.member}){
			listHtml+="<tr>";	
			listHtml+="<td colspan='5'>";	
			listHtml+="<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
			listHtml+="</td>";	
			listHtml+="</tr>";
		}
		listHtml+="</table>"
		$("#view").html(listHtml);
		//아래 2줄은 등록 버튼 눌렀을 때 화면
		$("#view").css("display", "block"); //보이고
		$("#wform").css("display", "none"); //감추고
	}
	
	function goForm(){ //글쓰기 버튼
		$("#view").css("display", "none"); //감추고
		$("#wform").css("display", "block"); //보이고
	}
	function goList(){ //리스트 버튼
		$("#view").css("display", "block"); //보이고
		$("#wform").css("display", "none"); //감추고
	}
	function goInsert(){
		//var title = $("#title").val();
		//var content = $("#content").val();
		//var writer = $("#writer").val();
		
		var fData=$("#frm").serialize(); //폼 안의 모든 파라메터를 직렬화(한줄로)
		//alert(fData);
		$.ajax({
			url : "board/new",
			type : "post",
			data : fData, //보내는 데이터
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			success : loadList, //로드리스트 함수 호출
			error : function() { alert("error"); }
		});
		
		//폼 초기화 : 화면만 감추고 보이고 한 것이라서 당연히 글 쓴 것이 그대로 남아있음
		//$("#title").val("");
		//$("#content").val("");
		//$("#writer").val("");
		$("#fclear").trigger("click");
	}
	function goContent(idx){ //idx =11, 9, ? //상세보기
		if($("#c"+idx).css("display") == "none"){
			
			$.ajax({
				url : "board/"+idx,
				type : "get",
				dataType : "json",
				success : function(data){ // data={    }
					$("#ta"+idx).val(data.content);
				},
				error : function() { alert("error"); }
			});
			
			$("#c"+idx).css("display", "table-row"); // 제목 데이터를 눌렀을 때의 idx 값이 함수에 전달되고 함수의 알고리즘이 해당 행의 tr을 보이게 한다  // 반복문 돌아갈 때 마다 id 값의 idx가 달라지므로 찾는 것이 달라지는 것
			$("#ta"+idx).attr("readonly", true);
		}else{ //닫을 때
			$("#c"+idx).css("display", "none");
			$.ajax({
				url : "board/count/"+idx,
				type : "put",
				dataType : "json",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
				success : function(data){
					$("#cnt"+idx).html(data.count); //html 또는 text
				},
				error : function(){ alert("error");}
				
			});
		}
	}	
	function goDelete(idx){ //삭제 함수
		$.ajax({
			url : "board/"+idx,
			type : "delete",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			success : loadList,
			error : function(){alert("error"); }
		});
	}
 	function goUpdateForm(idx){
		$("#ta"+idx).attr("readonly", false); //readonly는 스타일이 아닌 속성이므로 어트리뷰트 사용
	
		var title = $("#t"+idx).text(); //기존의 title 내용 가져오기
		var newInput="<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"'>";
		$("#t"+idx).html(newInput); //기존에꺼를 치우고 바꾸는 느낌임.
		
		var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</butoon>"
		$("#ub"+idx).html(newButton);
	} 
 	function goUpdate(idx){
		var title = $("#nt"+idx).val();
		var content = $("#ta"+idx).val();
		
		$.ajax({
			url : "board/update",
			type : "put",
			contentType:'application/json;charset=utf8',
			data : JSON.stringify({"idx":idx, "title":title, "content":content}),
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
			success : loadList,
			error : function(){ alert("error"); }
		});
		
 	}
  </script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/> 
  <h3>회원게시판</h3>
  <div class="panel panel-default">
    <div class="panel-heading">게시판</div>
    <div class="panel-body" id="view">Content</div>
    <div class="panel-body" id="wform" style="display: none">
   	 <form id="frm">
   	 		<input type="hidden" name="memID" id="memID"value="${mvo.member.memID }"/>
	    	<table class="table">
	    		<tr>
	    			<td>제목</td>
	    			<td><input type="text" id="title" name="title" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td>내용</td>
	    			<td><textarea rows="7" class="form-control" id="content" name="content"></textarea></td>
	    		</tr>
	    		<tr>
	    			<td>작성자</td>
	    			<td><input type="text" id="writer" name="writer" class="form-control" value="${mvo.member.memName }" readonly="readonly"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
	    				<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
	    				<button type="button" class="btn btn-warning btn-sm" onclick="goList()">리스트</button>
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    </div>
    <div class="panel-footer">김태경 프로젝트</div>
  </div>
</div>

</body>
</html>
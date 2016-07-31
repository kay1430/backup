<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">




<title>Insert title here</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">

</head>
<body>


<div id="container">

	<div id="action">
		<c:if test="${ login!=null}">
			<a href="MyPage/Index.jsp">마이페이지</a>&nbsp;&nbsp;
			<a href="#">로그아웃</a>&nbsp;&nbsp;
		</c:if>
		
		<c:if test="${ login==null}">
			<a href="index01.jsp?mode=Member/hong_Login">로그인</a>&nbsp;&nbsp;
			<a href="#">회원가입</a>&nbsp;&nbsp;
			<a href="#">ID찾기</a>&nbsp;&nbsp;
			<a href="#">PW찾기</a>
		</c:if>
	</div>
	
	<div id="nav">
		<nav class="navbar navbar-inverse">
  
  
    	<ul class="nav nav-tabs">
	  		<li role="presentation" class="active"><a href="index01.jsp?mode=body">Home</a></li>
	  		<li role="presentation"><a href="#">영화</a></li>
	  		<li role="presentation"><a href="#">예매</a></li>
	  		<li role="presentation"><a href="index01.jsp?mode=SNS/ReviewList">리뷰</a></li>
	  		<li role="presentation"><a href="SNS/Index.jsp">공지사항</a></li>
		</ul>
</nav>
	</div>
	
	<div id="contents">
	
		<%-- <c:if test="${param.mode == null || param.mode==body}">
			<jsp:include page="index01.jsp"  flush="false"/>
		</c:if> --%>
	
	
		<c:if test="${param.mode != null }">
			<jsp:include page="${param.mode}.jsp" flush="false"/>	
		</c:if>
		
	</div>
	
</div>

</body>
</html>
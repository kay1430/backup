<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="javascript/member.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">

</head>
<body>


<div id="container">
	
	<div id="action">
		
		<c:if test="${ login!=null}">
			
			[${login.m_id }] 님 안녕하세요 
			<a href="index01.jsp?mode=Member/logout" onclick="checkLogout()">로그아웃</a>&nbsp;&nbsp;
		</c:if>

	</div>
	
	<div id="nav">
		<nav class="navbar navbar-inverse">

    	<ul class="nav nav-tabs">
	  		<li role="presentation" class="active"><a href="#">Admin</a></li>
	  		<li role="presentation"><a href="#">영화</a></li>
	  		<li role="presentation"><a href="#">상영정보설정</a></li>
	  		<li role="presentation"><a href="#">회원정보</a></li>
	  		<li role="presentation"><a href="#">공지사항</a></li>
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
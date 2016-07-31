<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sist.co.Member.MemberDTO" %>
     <%@ page import="sist.co.Review.ReviewDAO" %>
     <%@ page import="sist.co.Review.ReviewDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>

<body>

<%
MemberDTO memberdto = (MemberDTO)session.getAttribute("login");
%>
<h3><%=memberdto.getM_id() %>님 하이요</h3>
<hr>

<div id="middle_wrap">
	<form action="SNS/ReviewWriteAF.jsp" method="post">
	<table class="table table-bordered" border="1">
		<tr>
			<td>작성자</td>
			<td><input type="text" name="m_id" readonly value="<%=memberdto.getM_id() %>"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="r_title"></td>
		</tr>
		<tr>
			<td>별점</td>
			<td><input type="hidden" name="r_star">아직 개발중...</td>
		</tr>
		
		<tr>
			<td>내용</td>
			<td><textarea rows="20" cols="50" name="r_content"></textarea></td>
		</tr>
	</table>
	
	<input type="submit" value="저장">
	<input type="button" value="취소" onclick="location.href='index01.jsp?mode=SNS/ReviewList'">
	
	</form>
	
</div>
<hr>




</body>
</html>
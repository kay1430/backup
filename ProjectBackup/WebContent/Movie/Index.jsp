
<%@page import="sist.co.Member.MemberDTO"%>


<%@page import="java.util.List"%>
<%@page import="sist.co.Movie.MovieManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* MovieManager mm = new MovieManager();
List<MovieDTO> list = mm.getCGVData();

//json 생성
String jsonresult = "[";
for(MovieDTO m: list){
	jsonresult += "{name:'" + m.getMv_title() + "',y:" + m.getMv_img() + "}, ";
}
jsonresult = jsonresult.substring(0, jsonresult.lastIndexOf(","));	// 맨 끝의 ',' 삭제
jsonresult += "]";

System.out.println(jsonresult);
request.setAttribute("jsonresult", jsonresult); */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>movie_index</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<title>movie_main</title>

</head>
<body>

<%	// main에서 빼도됌. nav 영역에서 session을 set해줌
/* MemberDTO mem = new MemberDTO("qwer", "qwer", "qwer", "asdf@asdf"); */
MemberDTO mem = new MemberDTO();
mem.setM_id("qwer");

session.setAttribute("login", mem); 
%>

<%-- nav 에 전체 예매 tab 존재. 따라서, 각 영화의 예매버튼이 존재 --%>
<%-- (수정할거1)예매할 때, 로그인했는지 안했는지 판단해야함. 따라서, session 변수저장되어있는지로 확인하기 --%>
<form action="Reserve.jsp">
	<input type="hidden" name="seq" value="<%=0 %>">
	<input type="submit" value="예매" style="width: 100px">	
</form>

<%-- (수정할거2)예매순, 좋아요순 --%>
<form>
</form>

<%-- 상영중인 영화들  : 순위 이미지, 포스터(이미지클릭), 제목, 좋아요갯수  --%>
<form action="moviedetail.jsp">
<table width="80%">
	<tr>
		<%--for문 --%>
		<td><a href="Moviedetail.jsp?seq=<%=2 %>"><img src="../img/arrow.png"></a></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	
	
</table>
</form>

<%-- admin --%>
<a href="AddTheater.jsp">AddTheater</a>

</body>
</html>
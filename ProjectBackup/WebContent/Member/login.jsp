<%@page import="sist.co.Member.MemberDTO"%>
<%@page import="sist.co.Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

Login.jsp
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pw");

System.out.println("id=" + id + "pw =" + pwd);
MemberDAO dao = MemberDAO.getInstance();
MemberDTO mem = new MemberDTO();

mem.setM_id(id);
mem.setM_name(null);
mem.setM_pw(pwd);
mem.setM_email(null);
mem.setM_auth(0);

mem = dao.login(mem);

/* boolean isS = dao.AddMember(mem); */

if(mem!= null && !mem.getM_id().equals("")){
	session.setAttribute("login", mem);
	session.setMaxInactiveInterval(30*60);				// 로그인 유지 시간
%>
	<script	type="text/javascript">
		alert("안녕하세요<%=mem.getM_id()%>님!");
		location.href="../MyPage/Index.jsp";
	</script>
<%}
else{%>
	<script	type="text/javascript">
		alert("아이디나 패스워드를 확인하십시오");
		location.href="Index.jsp";
	</script>
<%} %>

</body>
</html>
<%@page import="sist.co.Member.MemberDAO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String email = request.getParameter("email");
MemberDAO dao = MemberDAO.getInstance();
boolean emaildupchk = dao.EmailDuple(email);

if(!emaildupchk){
	%>
	<script type="text/javascript">
		alert("가입 가능한 이메일입니다");
		location("regi.jsp");
	</script>
<%}
else{ %>
	<script type="text/javascript">
		alert("이미 존재하는 이메일 입니다");
		location("regi.jsp");
	</script>
<%}%>
</body>
</html>
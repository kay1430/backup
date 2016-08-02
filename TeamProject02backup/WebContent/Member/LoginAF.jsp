<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sist.co.Member.MemberDTO" %>
    <%@ page import="sist.co.Member.MemberDAO" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

request.setCharacterEncoding("utf-8");

String m_id = request.getParameter("m_id");
String m_pw = request.getParameter("m_pw");

MemberDAO memdao = MemberDAO.getInstance();

int result = memdao.login(m_id, m_pw);
MemberDTO memberdto = null;
if(result  == 1){
	//로그인 성공
	
	memberdto = memdao.selectMemberDTO(m_id);
	session.setAttribute("login",memberdto);
	%>
		<script type="text/javascript">
			alert("로그인 성공!");
			location.href="../index01.jsp?mode=body";
		</script>
	<%
	
	
	
}else if (result < 1){
	//로그인 실패
	%>
		<script type="text/javascript">
			alert("로그인 실패");
			location.href="../index01.jsp?mode=Member/Login";
		</script>
	<%
}else if(result == 2){
	memberdto = memdao.selectMemberDTO(m_id);
	session.setAttribute("login",memberdto);
	%>
		<script type="text/javascript">
			alert("관리자님 환영합니다.");
			location.href="../admin.jsp"
		</script>
	<%
}
 
%>

</body>
</html>
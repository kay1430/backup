<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ page import = "sist.co.Member.MemberDTO"%>
<%@ page import = "sist.co.Member.MemberDAO" %>

<%
String m_id = request.getParameter("m_id");
request.setAttribute("m_id",m_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>Insert title here</title>

<script type="text/javascript">

function idok(){
	
   opener.frm.m_id.value="${m_id}";
   opener.frm.reid.value="${m_id}";
   self.close();
}
</script>

</head>
<body>
<%


	MemberDAO dao = MemberDAO.getInstance();
	boolean iddupchk = dao.IdDuple(m_id);
	
	session.setAttribute("result",iddupchk);
	 %>
<h2>중복확인</h2>

<form action="idCheck.jsp" method="get" name="frm">
아이디 <input type="text" name="m_id">
<input type="submit" value="중복 체크">
<br>

<c:if test="${result==false }">
   <script type="text/javascript">opener.document.frm.m_id.value=="";</script>
   <%=m_id %>는 이미 사용 중인 아이디 입니다.
</c:if>
<c:if test="${result==true }">
 	 <%=m_id %>는 사용 가능한 아이디입니다.
   <input type="button" value="사용" class="cancel" onclick="idok()">
</c:if>


</form>




</body>
</html>
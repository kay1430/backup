<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ page import = "sist.co.Member.MemberDTO"%>
<%@ page import = "sist.co.Member.MemberDAO" %>
<%
String id = request.getParameter("id");
request.setAttribute("m_id",id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function idok(){
	
   opener.joinmem.id.value=${m_id};
   alert("여기안되냐?");
   opener.joinmem.reid.value=${m_id};
   
   self.close();
}
</script>

</head>
<body>
<%


	MemberDAO dao = MemberDAO.getInstance();
	boolean iddupchk = dao.IdDuple(id);
	
	session.setAttribute("result",iddupchk);
	 %>
<h2>중복확인</h2>

<form action="idCheck.jsp" method="get" name="frm">
아이디 <input type="text" name="id">
<input type="submit" value="중복 체크">
<br>

<c:if test="${result==false }">
   <script type="text/javascript">opener.document.joinmem.id.value=="";</script>
   <%=id %>는 이미 사용 중인 아이디 입니다.
</c:if>
<c:if test="${result==true }">
 	 <%=id %>는 사용 가능한 아이디입니다.
   <input type="button" value="사용" class="cancel" onclick="idok()">
</c:if>


</form>




</body>
</html>
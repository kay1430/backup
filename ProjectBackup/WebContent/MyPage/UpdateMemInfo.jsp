 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.co.Member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../css/testmypage.css"/>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">


</head>
<body>
<%

Object objlogin = session.getAttribute("login");//로그인으로 mem 정보 가져옴

 
if(objlogin==null){
	%>
	<script type="text/javascript">
	alert("다시 로그인 하세요.");
	location.href="index.jsp";
	</script>
	<%
	return; //빠져나감
}

MemberDTO mem = (MemberDTO)objlogin;
%>

<header>
<h5><%=mem.getM_name() %>님 반갑습니다!</h5>
</header>

<nav>
<a href ="Index.jsp"><h4><b>마이시네마</b></h4></a>

  &nbsp;&nbsp;<a href = "LoginUpdate.jsp">회원정보</a><br>
  

  &nbsp;&nbsp;<a href = "Ticket.jsp">내 티켓</a><br>
  

  &nbsp;&nbsp;<a href = "MovieHistory.jsp">나의 관람 영화</a><br>
</nav>

<section>


<form action="UpdateMemInfoAF.jsp" method= "post">
<table>
<tr>
<td>아이디</td>
<td><input type = "text" name = "id" size="20" value = "<%=mem.getM_id() %>" readonly="readonly"/></td>
</tr>
<tr>
<td>비밀번호</td>
<td><input type = "password" name = "pw" size="20" value = "<%=mem.getM_pw() %>" /></td>
</tr>
<tr>
<td>이름</td>
<td><input type = "text" name = "name" size="20" readonly="readonly" value = "<%=mem.getM_name()%>"/></td>
</tr>
<tr>
<td>이메일</td>
<td><input type = "email" name = "email" size="20" value = "<%=mem.getM_email() %>"/></td>
</tr>

<tr>
<td colspan="2">
<input type = "submit" name = "Btn_Update" value = "수정" />
</td>
</tr>
</table>
</form>



<form action="OutMem.jsp" method= "post">
<input type = "submit" name = "Btn_Out" value = "탈퇴" />
</form><form action="Index.jsp" method= "post">
<input type = "submit" name = "Btn_Cancel" value = "취소" />
</form>

</section>

<footer>
Copyright@우리조
</footer>


</body>
</html>
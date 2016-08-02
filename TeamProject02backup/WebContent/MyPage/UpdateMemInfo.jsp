  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.co.Member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/mypage.css"/>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript" src="javascript/member.js"></script>

</head>
<body>
<%

Object objlogin = session.getAttribute("login");//로그인으로 mem 정보 가져옴

 
if(objlogin==null){
	%>
	<script type="text/javascript">
	alert("다시 로그인 하세요.");
	location.href="index01.jsp?mode=MyPage/Index";
	</script>
	<%
	return; //빠져나감
}

MemberDTO mem = (MemberDTO)objlogin;
%>

<header1>

</header1>

<nav1>
<a href ="index01.jsp?mode=MyPage/Index"><h4><b>마이시네마</b></h4></a>

   &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/LoginUpdate">회원정보</a><br>
  

  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/Ticket">내 티켓</a><br>
  
 
  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/MovieHistory">나의 관람 영화</a><br>
</nav1>

<section1>


<form action="index01.jsp?mode=MyPage/UpdateMemInfoAF" method= "post">
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



<form action="index01.jsp?mode=MyPage/OutMem" method= "post">
<input type = "submit" name = "Btn_Out" value = "탈퇴" />
</form><form action="Index.jsp" method= "post">
<input type = "submit" name = "Btn_Cancel" value = "취소" />
</form>

</section1>

<footer1>
<!-- Copyright@우리조 -->
</footer1>

</body>
</html>
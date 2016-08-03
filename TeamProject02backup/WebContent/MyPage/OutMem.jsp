 <%@page import="sist.co.Member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/mypage.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<script type="text/javascript" src="javascript/member.js"></script>

</head>
<body>
 
<%
MemberDTO memberdto = new MemberDTO();
memberdto.setM_id("bombom");
memberdto.setM_pw("1234");
memberdto.setM_name("Bom");
memberdto.setM_email("ddd");

session.setAttribute("login",memberdto);
 
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

<form action = "OutMemAF.jsp" method = "post">
●사용하고 계신 아이디(<%=memberdto.getM_id()%>)는 탈퇴할 경우 재사용 및 복구가 불가능합니다.<br>
●탈퇴 후 회원정보 및 서비스 이용기록은 모두 삭제됩니다.<br>
●탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.<br><br>
<b>탈퇴 후에는 아이디 <%=memberdto.getM_id() %> 로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다. 
게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.</b><br><br>

<input type = "submit" value = "확인"/>
</form>
 
</section1>

<footer1>
<!-- Copyright@우리조 -->
</footer1>

</body>
</html>
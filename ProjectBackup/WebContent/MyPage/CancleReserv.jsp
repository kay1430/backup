<%@page import="test.Reservation.ReservationDAO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/testmypage.css"/>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

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
<header>
<h5><%=memberdto.getM_name()%>님 반갑습니다!</h5>
</header>

<nav>
<a href ="Index.jsp"><h4><b>마이시네마</b></h4></a>

   &nbsp;&nbsp;<a href = "LoginUpdate.jsp">회원정보</a><br>  
 
  &nbsp;&nbsp;<a href = "Ticket.jsp">내 티켓</a><br>
  
  &nbsp;&nbsp;<a href = "MovieHistory.jsp">나의 관람 영화</a><br>
</nav>

<section>

<%
ReservationDAO rdao = ReservationDAO.getInstance();
boolean isS = rdao.cancleReserv(6);

if(isS){
	%>
	예매 취소가 정상적으로 처리 되었습니다.
	<%
}else{
	%>
	취소되었습니다.
	<%
}
%>

</section>

<footer>
Copyright@우리조
</footer>

  

</body>
</html>
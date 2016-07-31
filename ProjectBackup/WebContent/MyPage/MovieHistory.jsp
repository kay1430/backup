<%@page import="test.Movie.MovieDTO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@page import="test.Reservation.ReservationDTO"%>
<%@page import="test.Reservation.ReservationDAO"%>
<%@page import="test.Theater.TheaterDTO"%>
<%@page import="test.Theater.TheaterDAO"%>
<%@page import="test.Movie.MovieDAO"%>
<%@page import="test.Movie.MovieDTO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 관람영화</title>

<link rel="stylesheet" type="text/css" href="../css/testmypage.css"/>
<link rel="stylesheet" type="text/css" href="../css/style.css"/>
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
<h5><%=memberdto.getM_name() %>님 반갑습니다!</h5>
</header>

<nav>
<a href ="Index.jsp"><h4><b>마이시네마</b></h4></a>
  &nbsp;&nbsp;<a href = "LoginUpdate.jsp">회원정보</a><br>
 
  &nbsp;&nbsp;<a href = "Ticket.jsp">내 티켓</a><br>
  
  &nbsp;&nbsp;<a href = "MovieHistory.jsp">나의 관람 영화</a><br>
</nav>

<section>

<%
ReservationDAO dao = ReservationDAO.getInstance();
List<ReservationDTO> rLists = dao.getHistoryList(memberdto.getM_id());

TheaterDAO tdao = TheaterDAO.getInstance();
MovieDAO mdao = MovieDAO.getInstance();
%>
<table align = "center">
<col width="150"/><col width="150"/><col width="150"/><col width="150"/><col width="150"/>
<tr align = "center">  
  <td>관람일</td>
  <td>예매번호</td>
  <td>영화</td>
  <td>극장</td>
  <td>상영관</td>
</tr>

<%
for(int i=0; i<rLists.size();i++){ 
	ReservationDTO rdto = rLists.get(i);
	TheaterDTO tdto = tdao.getTheater(rdto.getTh_seq());
	MovieDTO mdto = mdao.getMovie(tdto.getMv_seq());
	
	if(rLists.size() == 0){ //내역이 없을때
		%>
		
		<tr>
		  <td colspan="5">지난 예매내역이 없습니다.</td>
		</tr>
		
		<%
	}else{ //내역이 있을 때
		%>

		<tr align = "center">
		   <td><%=tdto.getTh_time() %></td>
		   <td><a href = "#"><%=rdto.getR_seq() %></a></td> <%--예매detail로 이동 --%>
		   <td><a href = "#"><%=mdto.getMv_title() %></a></td> <%--영화detail로 이동 --%>
		   <td><%=tdto.getTh_name() %></td>
		   <td><%=tdto.getTh_cinema() %></td>
		</tr>


		<%
	}
}
%>

</table>

</section>

<footer>
Copyright@우리조
</footer>


</body>
</html>
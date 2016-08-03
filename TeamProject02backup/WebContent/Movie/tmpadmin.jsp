<%@page import="sist.co.Theater.TheaterDTO"%>
<%@page import="sist.co.Theater.TheaterDAO"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@page import="sist.co.Seat.SeatDAO"%>
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
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");

TheaterDAO thdao = TheaterDAO.getInstance();
TheaterDTO thdto = thdao.getTheaterinform(rdto.getTh_seq());

SeatDAO sdao = SeatDAO.getInstance();

for(int i = 0; i < thdto.getTh_totalseat(); i++){	
	
	char alpha = 'A';
	for(int j = 0; j < 10; j++){
		if(i/10==j)	alpha+=j;
	}
	
	String str = ""+ alpha + ((i%10)+1);
	//System.out.print(str);
	boolean isS = sdao.adminSeatSetting(thdto.getTh_seq(), str);
	if(!isS)	break;
	
}
%>

tmpadmin
setting seat
about <%=rdto.getTh_seq() %>

<a href="Seat.jsp">Back</a>


</body>
</html>
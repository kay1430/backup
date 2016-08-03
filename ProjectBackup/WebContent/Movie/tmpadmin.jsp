<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
	Date mydate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// boolean isS = sdao.adminSeatSetting(thdto.getTh_seq(), str, sdf.format(mydate)); 
	boolean isS = sdao.adminSeatSetting(thdto.getTh_seq(), str, "2016-08-04");//test용. 나중에 이거 지우기 
	if(!isS)	break;
	
}  

/* for(int i = 63; i < thdto.getTh_totalseat(); i++){	
	
	char alpha = 'A';
	for(int j = 0; j < 10; j++){
		if(i/10==j)	alpha+=j;
	}
	
	String str = ""+ alpha + ((i%10)+1);
	//System.out.print(str);
	Date mydate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//boolean isS = sdao.adminSeatSetting(thdto.getTh_seq(), str, sdf.format(mydate));
	boolean isS = sdao.adminSeatSetting(thdto.getTh_seq(), str, "2016-08-04");//test용. 나중에 이거 지우기
	if(!isS)	break;
	
}   */
%>

tmpadmin
setting seat
about <%=rdto.getTh_seq() %>

<a href="Seat.jsp">Seat.jsp</a>
<a href="Reserve.jsp">Reserve.jsp</a>

</body>
</html>
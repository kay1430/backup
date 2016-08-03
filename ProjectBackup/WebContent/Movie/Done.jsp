<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sist.co.Seat.SeatDTO"%>
<%@page import="sist.co.Reservation.ReservationDAO"%>
<%@page import="sist.co.Theater.TheaterDAO"%>
<%@page import="sist.co.Seat.SeatDAO"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Done</title>
<style type="text/css">
table {
	border-collapse: collapse;
	border: 1px solid black;	
}
th,td{
	border-collapse: collapse;
	border: 1px solid black;
	text-align: center;
}
</style>
</head>
<body>

<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq());

String mypay = request.getParameter("mypay");
System.out.println("mypay:" + mypay);

int isI = 1;	// 1:모든 절차 success, 0: 최소 하나의 절차 fail 

//seat : s_check = 0 => 1 로 변경 
SeatDAO sdao = SeatDAO.getInstance();
String[] s_name = rdto.getR_seat().split(",");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
for(int i = 0; i < s_name.length; i++){
	SeatDTO sdto = sdao.confirmSeatCheck(rdto.getTh_seq(), s_name[i], sdf.format(rdto.getR_viewtime())); 
	if(!sdao.reserAfSeat(sdto.getS_seq())) isI *= 0;
}

// theater : th_leftseat -= -1 해주기
TheaterDAO thdao = TheaterDAO.getInstance();
if(isI==1){
	if(!thdao.reserAfTheater(rdto.getTh_seq(), sdf.format(rdto.getR_viewtime()))) isI *= 0;
}

// reservation : DB에 저장
ReservationDAO rdao = ReservationDAO.getInstance();
if(isI==1){
	if(!rdao.reserve(rdto)) isI *= 0;
}

if(isI==1){
%>

<form action="Ticket.jsp" method="get">
<table>
	<tr>
		<th colspan="2">예매가 완료되었습니다</th>
	</tr>
	<tr>
		<td>결제수단 :</td>
		<td><%=mypay %></td>
	</tr>
	<tr>
		<td>가격 :</td>
		<td><%=rdto.getR_totalprice() %>원</td>
	</tr>
	<tr>
		<td><input type="submit" value="티켓확인"></td>
	</tr>
</table>
</form>

<%
}else{%>
	<script type="text/javascript">
		alert("예매에 실패했습니다");
		location.href = "Reserve.jsp";
	</script>
<%
} %>

<a href="Index.jsp">HOME</a>
<a href="Reserve.jsp">다시예매하기</a>

</body>
</html>
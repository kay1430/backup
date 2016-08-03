<%@page import="sist.co.Seat.SeatDAO"%>
<%@page import="sist.co.Reservation.ReservationDAO"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PayAf</title>
</head>
<body>


<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq()+",rdto.getR_seat()"+rdto.getR_seat());

String mypay = request.getParameter("mypay");
System.out.println("mypay:" + mypay);

// 예매되기 직전에 해당날짜, 자리확인 다시한번 해야함. 
SeatDAO sdao = SeatDAO.getInstance();
/* List<SeatDTO> slist = sdao. */


// 예매
ReservationDAO rdao = ReservationDAO.getInstance();
boolean isS = rdao.reserve(rdto); 
if(isS){ %>
	<script type="text/javascript">
		alert("예매가 완료되었습니다");
		location.href = "Done.jsp";
	</script>
<%}else{ %>
	<script type="text/javascript">
		alert("예매에 실패했습니다");
		location.href = "Seat.jsp";
	</script>
<%} %>
















</body>
</html>
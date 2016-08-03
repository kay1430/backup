<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SeatAf</title>
</head>
<body>

<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq());
int people = rdto.getR_adult() + rdto.getR_student() + rdto.getR_elder();

String sarr = request.getParameter("arr");

String[] arr = sarr.split(",");
for(int i = 0; i < arr.length; i++){
	System.out.println("arr["+i+"]:"+arr[i]);
}

System.out.println("people:"+people+",arr.length:"+arr.length);
if(people > arr.length){%>
	<script type="text/javascript">
		alert("좌석을 다시 선택하세요");
		location.href = "Seat.jsp";
	</script>
<%}else{
	rdto.setR_seat(sarr); %>
	<script type="text/javascript">
		location.href = "Pay.jsp";
	</script>
<%} %>
</body>
</html>
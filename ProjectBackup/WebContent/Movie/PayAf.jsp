<%@page import="sist.co.Seat.SeatDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
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

String url = String.format("./%s?mypay=%s", "Done.jsp", mypay);

// 예매되기 직전에 해당날짜, 자리확인 다시한번 해야함. // rdto.getR_viewtime() : yyyy-mm-dd hh:mi:ss => 여기서 날짜만 필요함
SeatDAO sdao = SeatDAO.getInstance();

int seatcheck = 0;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String[] s_name = rdto.getR_seat().split(",");
for(int i = 0; i < s_name.length; i++){
	SeatDTO sdto = sdao.confirmSeatCheck(rdto.getTh_seq(), s_name[i], sdf.format(rdto.getR_viewtime())); 
	seatcheck += sdto.getS_check();	// 비어있는 좌석일 경우 0, 예약된 좌석일 경우 1 
	System.out.println("seatcheck:" + seatcheck + ",sdto.getS_check():" + sdto.getS_check());
}	
if(seatcheck==0){		// 선택한 좌석이 모두 비어있는 좌석일 경우 => 예매가능 %>
	<script type="text/javascript">
		location.href="<%=url%>";
	</script>
<% 	
}else{					// 선택한 좌석 중에 예약된 좌석이 있는 경우 => 예매 불가능 %>
	<script type="text/javascript">
		alert("선택한 좌석 중에 예매 불가능한 좌석이 있습니다");
		location.href = "Seat.jsp";
	</script>
<%
} %>
















</body>
</html>
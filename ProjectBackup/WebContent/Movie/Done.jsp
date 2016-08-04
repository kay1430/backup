
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
	width: 700px;	
}
th,td{
	border-collapse: collapse;
	border: 1px solid black;
	text-align: center;
	height: 40px;
}
input{
	width: 270px;
	height: 40px;
}
#textone{
	height: 200px;
	font-size: 40px;
	font-weight: bold;
}
#thanks{
	font-size: 16px;
	font-weight: lighter;
}
.my{
	background-color: #dcdcdc;
}
</style>
</head>
<body>

<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq());

String mypay = request.getParameter("mypay");
System.out.println("mypay:" + mypay);

ReservationDAO rdao = ReservationDAO.getInstance();
if(!rdao.confirmreserve(rdto)){

	int isI = 1;	// 1:모든 절차 success, 0: 최소 하나의 절차 fail 
	
	//seat : s_check = 0 => 1 로 변경 
	SeatDAO sdao = SeatDAO.getInstance();
	String[] s_name = rdto.getR_seat().split(",");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	for(int i = 0; i < s_name.length; i++){
		SeatDTO sdto = sdao.confirmSeatCheck(rdto.getTh_seq(), s_name[i], sdf.format(rdto.getR_viewtime())); 
		if(!sdao.reserAfSeat(sdto.getS_seq())) isI *= 0;
	}
	
	// reservation : DB에 저장
	
	if(isI==1){
		if(!rdao.reserve(rdto)) isI *= 0;
	}
	
	if(isI==1){ 
	%>
	
	<form action="Ticket.jsp" method="get">
	<table width="500px">
		<tr>
			<th colspan="2" id="textone">예매가 완료되었습니다<br><font id="thanks"><br>감사합니다</font></th>
		</tr>
		<tr class="my">
			<td width="350px">결제수단</td>
			<td width="350px">가격</td>
		</tr>
		<tr class="mine">
			<td><%=mypay %></td>
			<td><%=rdto.getR_totalprice() %>원</td>
		</tr>
		<tr>
			<td colspan="2" width="100%" height="100%"><input type="submit" value="티켓확인"></td>
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
	}
}else{%>
	<script type="text/javascript">
		alert("동일한 예매정보가 존재합니다. 마이페이지에서 티켓을 확인하세요");
		location.href = "Index.jsp";
	</script>
	<%
}%>

<a href="Index.jsp">HOME</a>
<a href="Reserve.jsp">다시예매하기</a>

</body>
</html>
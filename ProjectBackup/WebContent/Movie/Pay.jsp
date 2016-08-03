<%@page import="sist.co.Theater.TheaterDTO"%>
<%@page import="sist.co.Theater.TheaterDAO"%>
<%@page import="sist.co.Movie.MovieDTO"%>
<%@page import="sist.co.Movie.MovieDAO"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pay</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function paychoose(value){
	var selectValue = document.getElementById('selectone').value;
	document.myform.mypay.value=selectValue;
	//alert(selectValue);
}
function dosubmit(){
	document.myform.method="GET";
	document.myform.action="PayAf.jsp";
	document.submit();
}
function goSeat(){
	location.href="Seat.jsp";
}
</script>
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
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq()+",rdto.getR_seat()"+rdto.getR_seat());

MovieDAO mdao = MovieDAO.getInstance();
MovieDTO mdto = mdao.getmoviedetail(rdto.getMv_seq());
TheaterDAO thdao = TheaterDAO.getInstance();
TheaterDTO thdto = thdao.getTheaterinform(rdto.getTh_seq());




%>

<div>div</div>
<table>
	<tr>
		<th width="500px">총 결제 금액</th>
		<td rowspan="5">
			<table width="100%" height="100%">
				<tr> <!-- <td colspan="2"><img src="../img/arrow.png" alt="포스터"></td> -->
					<td colspan="2"><img src="<%=mdto.getMv_img()%>"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><%=mdto.getMv_title()%></td>
				</tr>
				<tr>
					<th>상영관</th>
					<td><%=thdto.getTh_name() %></td>	
				</tr>
				<tr>
					<th>날짜</th>
					<%-- <td><%=year %>-<%=month %>-<%=sdate %> <%=getChooseTime(thlist, th_seq) %></td> --%>
					<td>선택한날짜</td>
				</tr>
				<tr>
					<th>인원</th>
					<td>성인(<%=rdto.getR_adult() %>) 학생(<%=rdto.getR_student() %>) 우대(<%=rdto.getR_elder() %>)</td>
				</tr>
				<tr>
					<th>좌석</th>
					<td colspan="2"><%=rdto.getR_seat() %></td>
				</tr>
				<tr>
					<th>잔여석</th>
					<td colspan="2"><%=thdto.getTh_leftseat() %>석/<%=thdto.getTh_totalseat() %>석</td>
				</tr>
				<tr>
					<th>금액</th>
					<td><%=rdto.getR_totalprice() %>원</td>	<%--(0801수정할거)가격 comma표시 --%>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<form name="myform">
						<input type="button" value="이전단계" onclick="goSeat()">
					
						<input type="hidden" name="mypay">
						<input type="submit" value="다음단계" onclick="dosubmit()">
					</form>	
					</td>				
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><b><%=rdto.getR_totalprice() %>원</b></td>
	</tr>
	<tr>
		<th>결제 수단 선택</th>
	</tr>
	<tr>
		<td>
			<select id="selectone" size="3" style="width: 250px" onchange="paychoose()">
				<option>휴대폰결제</option>
				<option>무통장입금</option>
				<option selected="selected">신용/체크카드</option>
			</select>
		</td>
	</tr>	
</table>


<a href="Index.jsp">HOME</a>
<a href="Reserve.jsp">다시예매하기</a>

</body>
</html>

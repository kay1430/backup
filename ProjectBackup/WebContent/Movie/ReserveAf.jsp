<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ReserveAf</title>
</head>
<body>
<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");

if(rdto.getM_id()==null){ %>
	<script type="text/javascript">
		alert("로그인하십시오");
		location.href = "login.jsp";
	</script>
<%	
}else if(rdto.getTh_seq()==0){  %>
	<script type="text/javascript">
		alert("영화관을 선택하지 않았습니다");
		location.href = "Reserve.jsp";
	</script>
<%
}else if(rdto.getMv_seq()==0){  %>
	<script type="text/javascript">
		alert("영화를 선택하지 않았습니다");
		location.href = "Reserve.jsp";
	</script>
<%
}else if(rdto.getR_totalprice()==0){  %>
	<script type="text/javascript">
		alert("관람인원을 선택하지 않았습니다");
		location.href = "Reserve.jsp";
	</script>
<%	
}else{
	System.out.println(rdto.toString());
	
}
%>


ReserveAf




<a href="Index.jsp">HOME</a>



</body>
</html>
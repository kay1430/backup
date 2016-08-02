<%@page import="sist.co.Reservation.ReservationDAO"%>
<%@page import="sist.co.movie.MovieDAO"%>
<%@page import="sist.co.movie.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.co.Member.MemberDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
System.out.println("seq = " + seq);

String url = String.format("%s?seq=%s", "moviedetail.jsp", sseq);

Object ologin = session.getAttribute("login");
MemberDTO mem = null;
if(ologin==null){
	System.out.println("session empty");
}else{
	mem = (MemberDTO)ologin;
	System.out.println("mem.getM_id():" + mem.getM_id());
}

MovieDAO dao = MovieDAO.getInstance();
ReservationDAO rdao = ReservationDAO.getInstance();
boolean isS = false;
boolean confirmreserve = false;
boolean confirmpoll = false;

String poll = request.getParameter("poll");
int addlike = Integer.parseInt(poll);
if(mem!=null){
	confirmreserve = rdao.judgereserve(seq, mem.getM_id()); // true : 예매했음
	if(confirmreserve){		// 해당 예매 내역 존재
		if(addlike==1){	// 좋아요
			isS = dao.addlike(seq, addlike, mem.getM_id());
		}else{			// 싫어요
			isS = dao.addlike(seq, addlike, mem.getM_id());
		}
		
		if(isS){ 
			//투표했으니 reservation 의 R_POLL을 1혹은 2로 바꿔줘야함
			// 따라서, 좋아요, 싫어요를 구분해야함. 단순히 투표에 성공했다고 쓰면 x
		%>
			<script type="text/javascript">
				alert("투표에 성공했습니다");
				location.href="<%=url%>";
			</script>
		<%	
		}else{ %>
			<script type="text/javascript">
				alert("투표에 실패했습니다");
				location.href="<%=url%>";
			</script>
		<%	 
		}
	}else{ %>
		<script type="text/javascript">
			alert("해당 영화를 관람하지 않았습니다");
			location.href="<%=url%>";
		</script>
	<%
	}
}else{%>
	<script type="text/javascript">
		alert("로그인하세요");
		location.href="Login.jsp";
	</script>
<%
}%> 

</body>
</html>
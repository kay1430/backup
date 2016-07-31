<%@page import="sist.co.Review.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="sist.co.Review.ReviewDAO"%>
<%@page import="sist.movie.MovieDTO"%>
<%@page import="sist.movie.MovieDAO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@page import="sist.movie.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화상세정보</title>
<style type="text/css">
table{
	border-collapse: collapse;
	border:  1px solid black;
	text-align: center;
}
.leftfix{
	text-align: left;
}
</style>
</head>
<body>
<%!
public String dot3(String msg){	// 리뷰가 15자 이상이면
	String s="";
	if(msg.length() >= 15){
		s = msg.substring(0, 15);
		s += "...";
	}else{
		s = msg.trim();
	}
	return s;
}
%>
<%
Object ologin = session.getAttribute("login");
MemberDTO mem = null;
if(ologin==null){
	System.out.println("session empty");
}else{
	mem = (MemberDTO)ologin;
}

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
System.out.println("seq = " + seq);

MovieDAO dao = MovieDAO.getInstance();
MovieDTO mdto = dao.getmoviedetail(1); 

%>

<form action="Reserve.jsp">
<table border="1">
	<tr>
		<th>제목</th>
		<td><%=mdto.getMv_title() %></td>
		<td rowspan="7" height="300"><img src="<%=mdto.getMv_img() %>" alt="포스터"></td>
	</tr>
	<tr>
		<th>개봉일</th>
		<td><%=mdto.getMv_openday() %></td>
	</tr>
	<tr>
		<th>장르</th>
		<td><%=mdto.getMv_genre() %></td>
	</tr>
	<tr>
		<th>예매율</th>	<%-- 해당 영화예매 / 전체 예매  --%>
		<td></td>
	</tr>
	<tr>
		<th>좋아요</th>
		<td><%=mdto.getMv_like() %></td>
	</tr>
	<tr>		<%--좋아요 , 싫어요: count 표시하기--%>
		<%
		if(mem!=null){	// 로그인한상태
			ReservationDAO rdao = ReservationDAO.getInstance();
			int confirmpoll = rdao.judgepoll(seq, mem.getM_id());	// ture : 투표했음
			if(confirmpoll == 1){		// 투표 여부 판단 : 좋아요 로 투표했음 %>
				<td colspan="2"><img src="../img/like.jpg">좋아요</td>
		<%	}else if(confirmpoll == 2){ // 투표 여부 판단 : 싫요 로 투표했음 %>
				<td colspan="2"><img src="../img/like.jpg">싫어요</td>
		<%	}else{						// confirmpoll==0 : 해당영화 예매 했지만, 투표안함	%>
				<td><a href="Like.jsp?poll=<%=1%>&seq=<%=mdto.getMv_seq()%>"><img src="../img/like.jpg">좋아요</a></td>
				<td><a href="Like.jsp?poll=<%=2%>&seq=<%=mdto.getMv_seq()%>"><img src="../img/hate.jpg">싫어요</a></td>
		<%	}
		}else{			// 로그인 안한 상태%>		
			<td><a href="Like.jsp?poll=<%=1%>&seq=<%=mdto.getMv_seq()%>"><img src="../img/like.jpg">좋아요</a></td>
			<td><a href="Like.jsp?poll=<%=2%>&seq=<%=mdto.getMv_seq()%>"><img src="../img/hate.jpg">싫어요</a></td>
		<%
		} %>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="예매하기"><input type="hidden" name="seq" value="<%=mdto.getMv_seq()%>"></td>
	</tr>
	<tr>
		<th colspan="3" class="leftfix">줄거리</th>
	</tr>
	<tr>
		<td colspan="3" class="leftfix"><%=mdto.getMv_story() %></td>
	</tr>
	<tr>
		<th colspan="3" class="leftfix">리뷰</th>
	</tr>
	<% 
		ReviewDAO rdao = ReviewDAO.getInstance();
		List<ReviewDTO> rlist = rdao.seereview(seq);
		for(int i = 0; i < rlist.size(); i++){	%>
			<tr>
				<td><%=rlist.get(i).getM_id() %></td>
				<td colspan="2"><b><%=rlist.get(i).getR_title() %><b></td>
			</tr>	
			<tr>
				<td colspan="3"><%=dot3(rlist.get(i).getR_content()) %></td>
			</tr>
		<%	if(i > 0) break;
		} %>	
	<tr>
		<td colspan="3"><a href="Reviewmore?seq=<%=seq %>.jsp">리뷰더보기</a></td>
	</tr>
</table>
</form>


</body>
</html>

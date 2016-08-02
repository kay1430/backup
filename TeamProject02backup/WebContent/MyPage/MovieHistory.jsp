 <%@page import="test.Movie.MovieDTO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@page import="test.Reservation.ReservationDTO"%>
<%@page import="test.Reservation.ReservationDAO"%>
<%@page import="test.Theater.TheaterDTO"%>
<%@page import="test.Theater.TheaterDAO"%>
<%@page import="test.Movie.MovieDAO"%>
<%@page import="test.Movie.MovieDTO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 관람영화</title>

<!-- 
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css" href="css/mypage.css"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<script type="text/javascript" src="javascript/member.js"></script>

<script type="text/javascript">
function clickLikeOr(i){
	String res;
	//한번만 선택되도록
	if(i=0){//싫어요
		alert("싫어요를 선택했습니다.");
		return res="싫어요";
	}else id(i=1){//좋아요
		alert("좋아요를 선택했습니다.");
		return res="좋아요";
	}
}

</script>

</head>
<body>
<%
MemberDTO memberdto = new MemberDTO();
memberdto.setM_id("bombom");
memberdto.setM_pw("1234");
memberdto.setM_name("Bom");
memberdto.setM_email("ddd");

session.setAttribute("login",memberdto);
%>

	
<header1>

</header1>

<nav1>
<a href ="index01.jsp?mode=MyPage/Index"><h4><b>마이시네마</b></h4></a>

   &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/LoginUpdate">회원정보</a><br>
  

  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/Ticket">내 티켓</a><br>
  
 
  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/MovieHistory">나의 관람 영화</a><br>
</nav1>

<section1>

<%
ReservationDAO dao = ReservationDAO.getInstance();
List<ReservationDTO> rLists = dao.getHistoryList(memberdto.getM_id());

TheaterDAO tdao = TheaterDAO.getInstance();
MovieDAO mdao = MovieDAO.getInstance();
%>
<table align = "center">
<col width="150"/><col width="150"/><col width="150"/><col width="150"/><col width="150"/>
<tr align = "center">  
  <td>관람일</td>
  <td>예매번호</td>
  <td>영화</td>
  <td>상영관</td>
  <td>좋아요싫어요</td>
</tr>

<%///////////////////////////////////////////////
    if(rLists.size()==0){
    	%>
    	<tr>
    	  <td colspan="5">지난 예매내역이 없습니다.</td>
    	</tr>
    	<%
    }
%>

<%
for(int i=0; i<rLists.size();i++){ 
	ReservationDTO rdto = rLists.get(i);
	TheaterDTO tdto = tdao.getTheater(rdto.getTh_seq());
	MovieDTO mdto = mdao.getMovie(tdto.getMv_seq());
	
	if(rLists.size() == 0){ //내역이 없을때
		%>
		
		<tr>
		  <td colspan="5">지난 예매내역이 없습니다.</td>
		</tr>
		
		<%
	}else{ //내역이 있을 때
		%>

		<tr align = "center">
		   <td><%=rdto.getR_viewtime() %></td>
		   <td><%=rdto.getR_seq() %></td> <%--예매detail로 이동 --%>
		   <td><a href = "#"><%=mdto.getMv_title() %></a></td> <%--영화detail로 이동 --%>
		   <td><%=rdto.getR_thname()%> <%=rdto.getR_cinema() %></td>
		   <% 
		   if(rdto.getR_poll()==0){
			   //투표안한 상태
			   %>
			   <td><input type = "submit" onclick = "clickLikeOr(1)" name = "btnlike" value = "좋아요"/><input type = "submit" onclick = "clickLikeOr(0)" name = "btnhate" value = "싫어요"/></td>
			   <%
		   }else if(rdto.getR_poll()==1){
			   //좋아요 투표한 상태
			   %>
			   <td>좋아요</td>
			   <%
		   }else if(rdto.getR_poll()==2){
			   //싫어요 투표한 상태
			   %>
			   <td>싫어요</td>
			   <%
		   }
		   %>
		   
		</tr>


		<%
	}
}
%>

</table>

</section1>

<footer1>
<!-- Copyright@우리조 -->
</footer1>


</body>
</html>
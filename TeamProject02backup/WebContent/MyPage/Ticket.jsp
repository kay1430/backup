 <%@page import="sist.co.Member.MemberDTO"%>
<%@page import="test.Movie.MovieDTO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@page import="test.Reservation.ReservationDTO"%>
<%@page import="test.Reservation.ReservationDAO"%>
<%@page import="test.Theater.TheaterDTO"%>
<%@page import="test.Theater.TheaterDAO"%>
<%@page import="test.Movie.MovieDAO"%>
<%@page import="test.Movie.MovieDTO"%>
<%@page import="test.Seat.SeatDTO"%>
<%@page import="test.Seat.SeatDAO"%>
<%@page import="test.Price.PriceDTO"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" type="text/css" href="css/mypage.css"/>
<!-- 
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
 -->

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<script type="text/javascript" src="javascript/member.js"></script>
</head>
<body>
<%
MemberDTO memberdto = new MemberDTO();
memberdto.setM_id("bombom");
memberdto.setM_pw("1234");
memberdto.setM_name("Bom");
memberdto.setM_email("ddd");

session.setAttribute("login",memberdto);

//예매내역이 있으면 보여주기
%>

<%!
	public Integer toInt(String x){
		int a = 0;
		try{
			a = Integer.parseInt(x);
		}catch(Exception e){}
		return a;
	}
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
ReservationDAO  rdao = ReservationDAO.getInstance();

TheaterDAO tdao = TheaterDAO.getInstance();
MovieDAO mdao = MovieDAO.getInstance();
SeatDAO sdao = SeatDAO.getInstance();


		
%>

<form action = "index01.jsp?mode=MyPage/CancleReserv" method = "post">

<%
List<ReservationDTO> rLists = rdao.getTicketList(memberdto.getM_id());
//페이징기법/////////
request.setAttribute("reList",rLists);
int pageno = toInt(request.getParameter("pageno"));
		   if(pageno<1){//현재 페이지
		      pageno = 1;
		   }
		   int total_record = rLists.size();         //총 레코드 수
		   int page_per_record_cnt = 2;  //페이지 당 레코드 수
		   int group_per_page_cnt =10;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//		                                              [6],[7],[8],[9],[10]                                 

		   int record_end_no = pageno*page_per_record_cnt;            
		   int record_start_no = record_end_no-(page_per_record_cnt);
		   if(record_end_no>total_record){
		      record_end_no = total_record;
		   }
		                                 
		                                 
		   int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
		   if(pageno>total_page){
		      pageno = total_page;
		   }



		

//		    현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
		   int group_no = pageno/group_per_page_cnt+( pageno%group_per_page_cnt>0 ? 1:0);
//		      현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)   
		//   ex)    14      =   13(몫)      =    (66 / 5)      1   (1(나머지) =66 % 5)           
		   
		   int page_eno = group_no*group_per_page_cnt;      
//		      현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
		//   ex)    70      =   14   *   5
		   int page_sno = page_eno-(group_per_page_cnt-1);   
//		       현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
		//   ex)    66   =   70 -    4 (5 -1)
		   
		   if(page_eno>total_page){
//		      현재 그룹 끝 번호가 전체페이지 수 보다 클 경우      
		      page_eno=total_page;
//		      현재 그룹 끝 번호와 = 전체페이지 수를 같게
		   }
		   
		   int prev_pageno = page_sno-group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//		      이전 페이지 번호   = 현재 그룹 시작 번호 - 페이지당 보여줄 번호수   
		//   ex)      46      =   51 - 5            
		   int next_pageno = page_sno+group_per_page_cnt;   // <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//		      다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
		//   ex)      56      =   51 - 5
		   if(prev_pageno<1){
//		      이전 페이지 번호가 1보다 작을 경우      
		      prev_pageno=1;
//		      이전 페이지를 1로
		   }
		   if(next_pageno>total_page){
//		      다음 페이지보다 전체페이지 수보가 클경우      
		      next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
//		      next_pageno=total_page
//		      다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
		//   ex)            =    76 / 5 * 5 + 1   ????????       
		   }
		   
		   // [1][2][3].[10]
		   // [11][12]

%>
<%

//for(int i=0; i<rlist.size();i++){
	//
for(int j = record_start_no; j < record_start_no+page_per_record_cnt; j++){
            if(rLists.size() == j) break;
	//
	ReservationDTO rdto = rLists.get(j);
	TheaterDTO tdto = tdao.getTheater(rdto.getTh_seq());
	MovieDTO mdto = mdao.getMovie(tdto.getMv_seq());
	List<SeatDTO> slist = sdao.getSeatList(rdto.getTh_seq());
	
    
	if(rLists.size() == 0){ //내역이 없을때
		%>
		예매내역이 없습니다.
		
		<%
	}else{ //내역이 있을 때
		%>
<table>
  <tr>
    <col width="80"/><col width="80"/><col width="150"/><col width="20"/>
    <td rowspan="7" valign="top" style="padding:30px;"><img src = "<%=mdto.getMv_img() %>" name = "MvPoster"/></td>  
  
    <td>예매번호</td>
    <td><%=rdto.getR_seq() %><input type = "hidden" name="r_seq" value="<%=rdto.getR_seq()%>"/><input type = "hidden" name="r_seat" value="<%=rdto.getR_seat()%>"/><input type = "hidden" name="th_seq" value="<%=rdto.getTh_seq()%>"/></td> <%--예매번호 46328332--%>
    
    <td><input type = "submit" name="R_Cancle" value = "예매취소"/></td>
  </tr>
  
  <tr><td colspan = "3"><h4><b><%=mdto.getMv_title() %></b></h4></td></tr>  <%--영화제목: 15 부산행 (디지털)--%>

  <tr> 
    <td>관람일</td>
    <td colspan="2"><%=rdto.getR_viewtime() %></td>
  </tr>
  
  <tr>
    <td>상영관</td>
    <td  colspan="2"><%=rdto.getR_thname()%> <%=rdto.getR_cinema() %></td>
  </tr>

  <tr>
    <td>관람인원</td>
    <td  colspan="2" align = "center"><b>좌석정보</b></td>
  </tr>
  
  <tr>
    <td rowsapn="3">성인<%=rdto.getR_adult() %><br>학생<%=rdto.getR_student() %><br>노인<%=rdto.getR_elder() %></td>
    <td  colspan="2" align = "center"><h4><b>
    <%=rdto.getR_seat() %>
    <%-- <%
    for(int j=0; j<slist.size();j++){
    	SeatDTO sdto = slist.get(j);
    	System.out.println(sdto.toString());
    	%>
    	<%=sdto.getS_name() %> 
    	<%
    }
    %> --%>
    </b></h4></td>
  </tr>
  
  <tr>
    <td>결제금액</td>
    <td  colspan="2"><%=rdto.getR_totalprice() %></td>
  </tr>
  </td>
</tr> 

</table>
<hr>
<%
	}
	
  
}
%>


<!-- 페이징 하는 부분!!! -->
	<div style="text-align:center;">
		<nav>
		  <ul class="pagination">
		  <%
		  if(rLists.size()==0){
			  %>
			  <li>
		      <a href="index01.jsp?mode=MyPage/Ticket&pageno=<%=prev_pageno%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		  	<li>
		  		<a href="index01.jsp?mode=MyPage/Ticket&pageno=1">1</a>
		  	</li>
		  	
		  	<li>
		      <a href="index01.jsp?mode=MyPage/Ticket&pageno=<%=next_pageno%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		    </ul>
			</nav>
		</div>
			  <%
		  }
		  %>
		  <%-- <c:if test="${ rLists.size()==0}"> 
		  	
		  	
		  </c:if>--%>
		  
		  <%
		  if(rLists.size()>0){
		  %>
		  <li>
		      <a href="index01.jsp?mode=MyPage/Ticket&pageno=<%=prev_pageno%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <% for(int i =page_sno;i<=page_eno;i++){
		    %>
		    <li><a href="index01.jsp?mode=MyPage/Ticket&pageno=<%=i%>"><%=i%></a></li>
		    <%}%>
		    <li>
		      <a href="index01.jsp?mode=MyPage/Ticket&pageno=<%=next_pageno%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
	 </div>
	 <%
		  }
		   %>
		  <%-- <c:if test="${ rLists.size()>0}">
		    
	      </c:if> --%>
	<!-- 페이징 하는 부분!!! -->
</form>


	
</section1>

<footer1>
<!-- Copyright@우리조 -->
</footer1>


</body>
</html>
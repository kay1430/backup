<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="sist.co.Member.MemberDTO" %>
     <%@ page import="sist.co.Review.ReviewDAO" %>
     <%@ page import="sist.co.Review.ReviewDTO" %>
     <%@ page import="java.util.*" %>
     <%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
         
<!DOCTYPE html>
<html>

<head>

 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>리뷰 리스트</title>

<link rel="stylesheet" type="text/css" href="../css/style.css">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">

</head>
<body>


<%! 
	public Integer toInt(String x){
		int a = 0;
		try{
			a = Integer.parseInt(x);
		}catch(Exception e){}
		return a;
	}
%>

<div id="middle_wrap">
<table class="table table-bordered">
	<col width="50"/><col width="70"/><col width="200"/><col width="100"/>
	<col width="50"/><col width="50"/>
	<tr>
		<th>번호</th><th>작성자</th><th>제목</th>
		<th>작성일</th><th>조회수</th><th>좋아요</th>
	</tr>
	
	<!-- 잠깐 스탑 여기서 review dto,dao 만들어서 불러야될듯 -->
	<%
		ReviewDAO redao = ReviewDAO.getInstance();
		List<ReviewDTO> reList = redao.selectAllReview();
		request.setAttribute("reList",reList);
		
		 int pageno = toInt(request.getParameter("pageno"));
		 
		   if(pageno<1){//현재 페이지
		      pageno = 1;
		   }
		   int total_record = reList.size();         //총 레코드 수
		   int page_per_record_cnt = 5;  //페이지 당 레코드 수
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
				if(reList.size()==0){
					%>
						
						<tr>
							<td colspan="6">등록된 게시글이 없습니다.</td>
						</tr>
					
					
					<%
				}
		%>
		
		
		<%
		for(int i = record_start_no; i < record_start_no+page_per_record_cnt; i++){
            if(reList.size() == i) break;
            ReviewDTO redto = reList.get(i);
			/* for(int i =0;i<reList.size();i++){
			ReviewDTO redto = reList.get(i); */%>
			<%
				//new 사진 이용하기 위해 시간작업
				Date date = new Date();
				SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); 
				String year = (String)simpleDate.format(date);
				String yea = redto.getR_writedate().toString().substring(0,10);
				
				int count = redao.countComment(redto.getR_seq());
			%>	
			<tr>
				<td><%=reList.size()-i %></td>
				<td><%=redto.getM_id() %></td>
				<td>
					<a href="index01.jsp?mode=SNS/ReviewDetail&r_seq=<%=redto.getR_seq() %>">
						<%=redto.getR_title()%>&nbsp;
						<%if(count !=0){%><p style="color:red;display:inline;">[<%=count %>]</p><%} %>
						<%if(year.equals(yea)){ %><img src="img/new.jpg"> <%} %>
					</a>
				</td>
				<td><%=redto.getR_writedate().toString().substring(0,10) %></td>
				<td><%=redto.getR_readcount() %></td>
				<td><%=redto.getR_like() %></td>
			</tr>
			
			<% 
		}%>
	
	
</table>
<!-- 글쓰기 버튼!!!! -->
<div style="text-align:right;">
<c:if test="${login != null }">
<input type="button" value="글쓰기" onclick="location.href='index01.jsp?mode=SNS/ReviewWrite'">
</c:if>
</div>

	<!-- 페이징 하는 부분!!! -->
	<div style="text-align:center;">
		<nav>
		  <ul class="pagination">
		  <c:if test="${ reList.size()==0}">
		  	<li>
		      <a href="index01.jsp?mode=SNS/ReviewList&pageno=<%=prev_pageno%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		  	<li>
		  		<a href="index01.jsp?mode=SNS/ReviewList&pageno=1">1</a>
		  	</li>
		  	
		  	<li>
		      <a href="index01.jsp?mode=SNS/ReviewList&pageno=<%=next_pageno%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		    </ul>
			</nav>
		</div>
		  	
		  </c:if>
		  
		  <c:if test="${ reList.size()>0}">
		  	
		  
		    <li>
		      <a href="index01.jsp?mode=SNS/ReviewList&pageno=<%=prev_pageno%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <% for(int i =page_sno;i<=page_eno;i++){
		    %>
		    <li><a href="index01.jsp?mode=SNS/ReviewList&pageno=<%=i%>"><%=i%></a></li>
		    <%}%>
		    <li>
		      <a href="index01.jsp?mode=SNS/ReviewList&pageno=<%=next_pageno%>" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
	</div>
	</c:if>
	<!-- 페이징 하는 부분!!! -->
	
	<!-- 검색 기능 부분!!!!! -->
	<form name="frm1" action="SNS/ReviewSelect.jsp">
	<div style="text-align:center; ">
		 <select name="check">
			<option value="1">제목</option>
			<option value="2">본문</option>
		</select>
		
    	<input type="text" placeholder="검색내용" name="selecting">
  		
		<input type="submit" name="findBtn" value="검색" >
	</div>
	</form>
</div>



<hr>

</body>
</html>
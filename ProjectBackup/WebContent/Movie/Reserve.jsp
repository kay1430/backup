<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="sist.movie.TheaterDTO"%>
<%@page import="sist.movie.TheaterDAO"%>
<%@page import="sist.movie.MovieDAO"%>
<%@page import="sist.movie.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.co.Member.MemberDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reserve</title>
<style type="text/css">
table {
	border-collapse: collapse;
	border: 1px solid black;	
}
th,td{
	border: 1px solid black;
}
</style>
</head>
<body>
<%!
public boolean nvl(String msg){
	return msg==null || msg.trim().equals("")?true:false; 	
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
System.out.println("seq = " + seq);		// 여기서 받은 seq는 selected가됨

String th_name = request.getParameter("th_name");	// (0729수정할거)MOVIEDETAIL이나 INDEX에서 넘어올때, NULL값으로 문제될수있음
System.out.println("th_name = " + th_name);		

// calendar
Calendar cal = Calendar.getInstance();	// 오늘날짜
cal.set(Calendar.DATE, 1);

String syear = request.getParameter("year");
String smonth = request.getParameter("month");
String sdate = request.getParameter("date");	// ay
System.out.println("sdate = " + sdate);	

int year = cal.get(Calendar.YEAR);
if(!nvl(syear)){
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH)+1;
if(!nvl(smonth)){
	month = Integer.parseInt(smonth);
}

if(month < 1){	month=12;	year--; }
if(month > 12){ month=1;	year++; }

cal.set(year, month-1, 1);

// 요일(1 ~ 7) 1:일요일
int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);	// 6

String pp=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/left.gif'/></a>", 
			"Reserve.jsp", seq, year-1, month);

String p=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/prec.gif'/></a>", 
		"Reserve.jsp", seq, year, month-1);

String nn=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/last.gif'/></a>", 
		"Reserve.jsp", seq, year+1, month);

String n=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/next.gif'/></a>", 
		"Reserve.jsp", seq, year, month+1);


%>

<table>
	<tr>
		<th>영화제목</th>
		<th>상영관</th>
		<th>달력</th>
		<th>포스터</th>
	</tr>
	<tr>
		<td width="100px">
			<!-- <select size="10" name="mv_title_selec" >	 -->
				<%
				MovieDAO mdao = MovieDAO.getInstance();
				List<MovieDTO> mlist = new ArrayList<MovieDTO>();
				mlist = mdao.getOnMovieList();
				
				for(int i = 0; i < mlist.size(); i++){ %>
					<%-- <option <%
						if(seq==mlist.get(i).getMv_seq()){	%>
							selected="selected"
					<%	} %> value="<%=mlist.get(i).getMv_seq()%>"><%=mlist.get(i).getMv_title() %></option> --%>
					<a href="Reserve.jsp?seq=<%=mlist.get(i).getMv_seq()%>"><%=mlist.get(i).getMv_title() %></a><br>
			<%	} %>
			<!-- </select> -->
		</td>
		<td>
			<!-- <select size="10" name="th_name_selec"> -->
			<%	TheaterDAO thdao = new TheaterDAO();
				List<TheaterDTO> thlist = new ArrayList<TheaterDTO>();
				thlist = thdao.getTheaterList(seq);
				String th_name_duple[] = new String[thlist.size()];	// 해당영화 상영을 명동 1관, 2관 혹은 1관 1회 2회일 경우, 명동이 두번 나오기떄문에, 한번만 나오도록함
				for(int i = 0; i < th_name_duple.length; i++){		// 초기화. 초기화안시키면 null이라 다음 for문에서 오류남
					th_name_duple[i] = "";
				}
				
				for(int i = 0; i < thlist.size(); i++){ 
					if(i==0) {%> 
						<a href="Reserve.jsp?seq=<%=thlist.get(0).getMv_seq()%>&th_name=<%=thlist.get(0).getTh_name() %>"><%=thlist.get(0).getTh_name() %></a><br>
			<%			th_name_duple[0] = thlist.get(0).getTh_name();
					}
					for(int j = 0; j < i; j++){
						if(!th_name_duple[j].equals(thlist.get(i).getTh_name())){ %>
							<a href="Reserve.jsp?seq=<%=thlist.get(i).getMv_seq()%>&th_name=<%=thlist.get(i).getTh_name() %>"><%=thlist.get(i).getTh_name() %></a><br>
					<%		th_name_duple[i] = thlist.get(i).getTh_name();
							break;
						}
					}
				} %>
			<!-- </select> -->
		</td>
		<td> <%-- 달력 --%>
			<table border="1">
				<col width="10"/><col width="10"/><col width="10"/>
				<col width="10"/><col width="10"/><col width="10"/>
				<col width="10"/>
					
				<tr height="10">
					<td colspan="7" align="center">
						<%=pp %><%=p %>	
						<font style="font-size:50">
							<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
						</font>
						<%=n %><%=nn %>
					</td>
				</tr>
				
				<tr height="10" align="center">
					<td valign="middle">일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
				
				<tr height="10" align="left" valign="top">
				
				<%
				for(int i = 1;i < dayOfWeek; i++){
					%>
					<td>&nbsp;</td>
					<%	
				}
				int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				for(int i = 1;i <= lastDay; i++){
					Calendar mysysdate = Calendar.getInstance();	// 오늘날짜 //(0729 수정할거) 만약 오늘날짜가 30일이면 다음달 1일2일까지 예매가능해야함. but, 아직 구현X
					if(mysysdate.get(Calendar.DATE) == i || (mysysdate.get(Calendar.DATE)+1) == i || (mysysdate.get(Calendar.DATE)+2) == i){	// 오늘날짜~+2까지 예매가능 
						if(mysysdate.get(Calendar.YEAR) == year && (mysysdate.get(Calendar.MONTH)+1) == month){ %>	
							<td align="center"><a href="Reserve.jsp?seq=<%=thlist.get(i).getMv_seq()%>&th_name=<%=th_name%>&date=<%=i%>"><%=i %></a></td>
					<%	}
					}else{ %>
						<td align="center"><%=i %></td>
				<%	}
					
					if((i+dayOfWeek-1)%7==0){	// 개행 %>
						</tr><tr height="10" align="center" >
				<%	}
				}
				
				for(int i = 0;i < (7-(dayOfWeek+lastDay-1)%7)%7; i++){
					%>
					<td>&nbsp;</td>	
					<%
				}
				%>
				
				</tr>
			</table>
					
		</td>
		<td rowspan="2">
			<table>
				<tr> <!-- <td colspan="2"><img src="../img/arrow.png" alt="포스터"></td> -->
					<%	for(int i = 0; i < mlist.size(); i++){
							if(seq == mlist.get(i).getMv_seq()){ %>
								<td colspan="2"><img src="<%=mlist.get(i).getMv_img() %>"></td>
					<%		}
						}%>
				</tr>
				<tr>
					<th colspan="2">제목</th>
					<%	for(int i = 0; i < mlist.size(); i++){
							if(seq == mlist.get(i).getMv_seq()){ %>
								<td><%=mlist.get(i).getMv_title() %></td>
					<%		}
						}%>
				</tr>
				<tr>
					<th>극장</th>
					<td>롯데</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td><%=year %>-<%=month %>-<%=sdate %></td>
				</tr>
				<tr>
					<th>인원</th>
					<td>23</td>
				</tr>
				<tr>
					<th>금액</th>
					<td>10000</td>
				</tr>
				<tr>
					<th colspan="2"><input type="submit" value="예매하기"></th>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">시간표</td>
		<td>인원수</td>
	</tr>
	<tr>
		<td>
			<table>
				<tr>	<%-- x관 --%>
					<% if(th_name!=null){	
							
							String th_cinema_duple[] = new String[thlist.size()];	// 해당영화 상영을 명동 1관 1회 2회일 경우, 1관이 두번 나오기떄문에, 한번만 나오도록함
							for(int i = 0; i < th_cinema_duple.length; i++){		// 초기화. 초기화안시키면 null이라 다음 for문에서 오류남
								th_cinema_duple[i] = "";
							}
							
							for(int i = 0; i < thlist.size(); i++){ 
								if(th_name.equals(thlist.get(i).getTh_name())){ 
									if(i==0) {%> 
										<td><%=thlist.get(i).getTh_cinema() %></td>
								<% 		th_cinema_duple[i] = thlist.get(i).getTh_cinema();
										List<TheaterDTO> th_numlist = new ArrayList<TheaterDTO>();
										th_numlist = thdao.getTh_num(seq, th_name, thlist.get(i).getTh_cinema());
										for(int k = 0; k < th_numlist.size(); k++){	%>
											<td><%=th_numlist.get(i).getTh_time()%></td>
						<%				}
									}
									for(int j = 0; j < i; j++){
										if(!th_cinema_duple[j].equals(thlist.get(i).getTh_cinema())){	%>
											<td colspan="2"><%=thlist.get(i).getTh_cinema() %></td>
						<%					th_cinema_duple[i] = thlist.get(i).getTh_cinema();	%>
											<td><%=thlist.get(i).getTh_num() %></td>
						<%					break;
										}
									}
								}
							}
						}%>
				</tr>

			
			</table>
		
			
		</td>
		<td>
			<table>
				<tr>
					<th>성인</th>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<th>학생</th>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<th>65세이상</th>
				</tr>
				<tr>
					<td></td>
				</tr>
				
			</table>
		</td>
	</tr>





</table>





















</body>
</html>
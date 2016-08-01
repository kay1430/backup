<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="sist.co.Price.PriceDTO"%>
<%@page import="sist.co.Price.PriceDAO"%>
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
	border-collapse: collapse;
	border: 1px solid black;
}
.headleft{
	text-align: left;
	border-right: 0px;
}
td.eachone{
	color: gray;
	font-size: 11px;
	text-align: right;
	vertical-align: center;
	border-left: 0px;
}
</style>
</head>
<body>
<%!
public boolean nvl(String msg){
	return msg==null || msg.trim().equals("")?true:false; 	
}
public String two(String msg){	// 날짜가 한자리 수일때 두자리로 표현하기 위한 함수 (ex. 1월 => 01월 )
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
public String timestamp2string(Timestamp t){ 	// timestamp를 String으로 변환
	return (""+t+"").substring(11, 16);
}
public List<TheaterDTO> getTheaterMatch(List<TheaterDTO> thelist, int seq, String th_name, String th_cinema){ // 시간표 출력시 해당 영화의 상영관 출력에 이용
	List<TheaterDTO> result = new ArrayList<TheaterDTO>();
	for(int i = 0; i < thelist.size(); i++){
		if(thelist.get(i).getMv_seq() == seq && th_name.equals(thelist.get(i).getTh_name()) && th_cinema.equals(thelist.get(i).getTh_cinema())){
			result.add(thelist.get(i));
		}
	}
	return result;
}
public int getleftseat(List<TheaterDTO> thelist, int th_seq){	// 잔여석
	for(int i = 0; i < thelist.size(); i++){
		if(th_seq == thelist.get(i).getTh_seq()){
			return thelist.get(i).getTh_leftseat();
		}
	}
	return -1;
}
public int getPrice(List<PriceDTO> plist, String man){		// 가격표 
	for(int i = 0; i < plist.size(); i++){
		if(plist.get(i).getP_grade().equals(man)) 
			return plist.get(i).getP_price();
	}
	return -1;
}
public int getTotalPrice(List<PriceDTO> plist, int adult, int student, int elder){	// 총 가격
	int price = 0;
	for(int i = 0; i < plist.size(); i++){
		if(plist.get(i).getP_grade().equals("adult"))			price+=adult*plist.get(i).getP_price();
		else if(plist.get(i).getP_grade().equals("student"))	price+=student*plist.get(i).getP_price();
		else if(plist.get(i).getP_grade().equals("elder"))		price+=elder*plist.get(i).getP_price();
	}	
	return price;
}
public MovieDTO getMovieDTO(List<MovieDTO> mlist, int seq){
	MovieDTO mvdto = new MovieDTO();
	for(int i = 0; i < mlist.size(); i++){
		if(seq == mlist.get(i).getMv_seq()){
			mvdto = mlist.get(i);
		}
	}
	return mvdto;
}
public String getChooseTime(List<TheaterDTO> thelist, int th_seq){	// 고객이 선택한 시간 추출 => 선택한 걸 보여주는 table 및 예매 데이터(예매 상영시간) 저장시 사용
	for(int i = 0; i < thelist.size(); i++){
		if(th_seq == thelist.get(i).getTh_seq()){
			return timestamp2string(thelist.get(i).getTh_time());
		}
	}
	return null;	// return "";
}
public Timestamp getTimestamp(String str){	// date => timestamp
    return Timestamp.valueOf(str);
}
public boolean compareTime(String stractdate){ 
	
	Date thisdate = new Date();	//오늘 날짜
	Date actdate; //스트링을 date로 저장할 변수 
	try { 
		actdate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(stractdate); 
	}catch (Exception e) {
		actdate = null;
	} 
	if (actdate.getTime() > thisdate.getTime()) {	
		return true;
	}
	return false;
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

/*[1] String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
System.out.println("seq = " + seq);		// 여기서 받은 seq는 selected가됨
*/
//[2]
int seq;
if(request.getParameter("seq")==null) seq = 0;
else seq = Integer.parseInt(request.getParameter("seq"));
System.out.println("seq = " + seq);		// 여기서 받은 seq는 selected가됨

/* //[1]
String th_name = request.getParameter("th_name");	// (0729수정할거)MOVIEDETAIL이나 INDEX에서 넘어올때, NULL값으로 문제될수있음
System.out.println("th_name = " + th_name);		
 */
//[2] (0731 수정할거) (1) 영화 제목선택x. 상영관 선택x, 달력 선택o. (2)영화 제목선택o, 상영관 선택x, 달력선택o : 이경우들에서, 상영관이 null이 넘어가는데 고쳐야함
String th_name;
if(request.getParameter("th_name")==null) th_name = "";
else th_name = request.getParameter("th_name");
System.out.println("th_name = " + th_name);	


	
int th_seq; 	// 시간 선택
if(request.getParameter("th_seq")==null) th_seq = 0;
else th_seq = Integer.parseInt(request.getParameter("th_seq"));
System.out.println("th_seq = " + th_seq);		

int adult, student, elder;
if(request.getParameter("adult")==null) adult = 0;
else adult = Integer.parseInt(request.getParameter("adult"));
if(request.getParameter("student")==null) student = 0;
else student = Integer.parseInt(request.getParameter("student"));
if(request.getParameter("elder")==null) elder = 0;
else elder = Integer.parseInt(request.getParameter("elder"));
System.out.println("(adult, student, elder) = (" + adult + ","+ student + ","+ elder + ")");

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
String pp=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/left.gif'/></a>", "Reserve.jsp", seq, year-1, month);
String p=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/prec.gif'/></a>", "Reserve.jsp", seq, year, month-1);
String nn=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/last.gif'/></a>", "Reserve.jsp", seq, year+1, month);
String n=String.format("<a href='./%s?seq=%d&year=%d&month=%d'><img src='../img/next.gif'/></a>", "Reserve.jsp", seq, year, month+1);

// 가격표 Data 취득
PriceDAO pdao = PriceDAO.getInstance();
List<PriceDTO> plist = pdao.getPriceList();

// Movie Data 취득
MovieDAO mdao = MovieDAO.getInstance();
List<MovieDTO> mlist = mdao.getOnMovieList();

// Theater Data 취득
TheaterDAO thdao = TheaterDAO.getInstance();
List<TheaterDTO> thlist = thdao.getTheaterList(seq);


// 예매관련 r_time 넣기 위한 작업 => timestamp에 값 못넣겟음. 그래서 그냥 DB에 String식으로 넣는 방식으로 바꿈 (0801 수정할거) => 좌석선택후 이런식으로 넣을꺼임
/* String s  = year+"-"+two(month+"")+"-"+two(sdate+"")+" "+getChooseTime(thlist, th_seq)+":00";
System.out.println("s:" + s); */

// 예매관련
ReservationDTO rdto = new ReservationDTO();
rdto.setM_id(mem.getM_id());
rdto.setTh_seq(th_seq);
rdto.setMv_seq(seq);
rdto.setR_totalprice(getTotalPrice(plist, adult, student, elder));
rdto.setR_adult(adult);
rdto.setR_student(student);
rdto.setR_elder(elder);
/*  if(syear != null && smonth != null && sdate != null && getChooseTime(thlist, th_seq)!= null){
	rdto.setR_viewtime(getTimestamp(s)); //yyyy-mm-dd hh:mm:ss형식
	System.out.println("rdto.setR_viewtime((Timestamp)t):" + rdto.getR_viewtime()); 
} */ 
 /* rdto.setR_viewtime(getTimestamp("2016-08-02 11:00:00")); //yyyy-mm-dd hh:mm:ss형식 */
 /* s = "2016-08-02 11:00:00"; */
/*  rdto.setR_viewtime(getTimestamp(s));  *///yyyy-mm-dd hh:mm:ss형식


session.setAttribute("rdto", rdto);

%>

<form action="ReserveAf.jsp">
<table>
	<tr>
		<th>영화제목</th>
		<th>상영관</th>
		<th>달력</th>
		<th>포스터</th>
	</tr>
	<tr>
		<td width="250px">
			<!-- <select size="10" name="mv_title_selec" >	 -->
			<%	for(int i = 0; i < mlist.size(); i++){ %>
					<%-- <option <%
						if(seq==mlist.get(i).getMv_seq()){	%>
							selected="selected"
					<%	} %> value="<%=mlist.get(i).getMv_seq()%>"><%=mlist.get(i).getMv_title() %></option> --%>
					<a href="Reserve.jsp?seq=<%=mlist.get(i).getMv_seq()%>"><%=mlist.get(i).getMv_title() %></a><br>
			<%	} %>
			<!-- </select> -->
		</td>
		<td width="100px">
			<!-- <select size="10" name="th_name_selec"> -->
			<%	
				
				String th_name_duple[] = new String[thlist.size()];	// 해당영화 상영을 명동 1관, 2관 혹은 1관 1회 2회일 경우, 명동이 두번 나오기떄문에, 한번만 나오도록함
				for(int i = 0; i < th_name_duple.length; i++){		// 초기화. 초기화안시키면 null이라 다음 for문에서 오류남
					th_name_duple[i] = "";
				}
				
				for(int i = 0, k = 0; i < thlist.size(); i++){ 
					
					boolean flag=false;		// 배열 비교 관련 변수 (true:이미 th_name_duple에 해당 영화관 존재) (false:th_name_duple에 해당 영화관 존재 x)  
					
					for(int j = 0; j < i; j++){	
						if(th_name_duple[j].equals(thlist.get(i).getTh_name()))		// th_name_duple배열에 이미 해당 영화관존재
							flag = true;
					}
					// 출력 
					if(!flag){	// 배열에 해당 영화관 X. 따라서, table에 출력과 동시에 th_name_duple에 저장 %>
						<a href="Reserve.jsp?seq=<%=thlist.get(i).getMv_seq()%>&th_name=<%=thlist.get(i).getTh_name() %>"><%=thlist.get(i).getTh_name() %></a><br>
					<%	th_name_duple[k] = thlist.get(i).getTh_name();
						k++;
					}
				} %> 
			<!-- </select> -->
		</td>
		<td width="300px"> <%-- 달력 --%>
			<table border="1" width="100%">
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
							<td align="center"><a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=i%>"><%=i %></a></td>
					<%	}else{	%>
							<td align="center"><%=i %></td>
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
		<td rowspan="3" width="225px" align="center">
			<table width="100%" height="100%">
				<tr> <!-- <td colspan="2"><img src="../img/arrow.png" alt="포스터"></td> -->
					<%	if(seq == 0){ %>
							<td colspan="2"><img src="../img/emptyposter.jpg"></td>
					<%	}else{	%>
							<td colspan="2"><img src="<%=getMovieDTO(mlist, seq).getMv_img()%>"></td>
					<%	}%>
				</tr>
				<tr>
					<th>제목</th>
					<%	if(seq == 0){ %>
							<td>영화를 선택하세요</td>
					<%	}else{ %>
							<td><%=getMovieDTO(mlist, seq).getMv_title()%></td>
					<%	} %>
				</tr>
				<tr>
					<th>상영관</th>
					<%	if(th_name == null){ %>
							<td>상영관을 선택하세요</td>
					<%	}else{ %>
							<td><%=th_name %></td>
					<%	} %>	
				</tr>
				<tr>
					<th>날짜</th>
					<%	if(sdate == null){ %>
							<td>관람일을 선택하세요</td>
					<%	}else{ %>
							<td><%=year %>-<%=month %>-<%=sdate %> <%=getChooseTime(thlist, th_seq) %></td>
					<%	}	%>
				</tr>
				<tr>
					<th>인원</th>
					<td>성인(<%=adult %>) 학생(<%=student %>) 우대(<%=elder %>)</td>
				</tr>
				<tr>
					<th>금액</th>
					<%	if((adult + student + elder) == 0){ %>
							<td>인원을 선택하세요</td>
					<%	}else{ %>
							<td><%=getTotalPrice(plist, adult, student, elder) %>원</td>	<%--(0801수정할거)가격 comma표시 --%>
					<%	} %>
				</tr>
				<tr>
					<th>잔여석</th>
					<td colspan="2">
					<% if(th_seq == 0){ %>
							관람시간을 선택하세요
					<%	}else{ %>
							<%=getleftseat(thlist, th_seq) %>석
					<%	}	%>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="예매하기"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<th colspan="2">시간표</th>
		<th>인원수</th>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%">
				<tr>	<%-- x관 --%>
					<% if(sdate != null && th_name!=null){	
							
							String th_cinema_duple[] = new String[thlist.size()];	// 해당영화 상영을 명동 1관 1회 2회일 경우, 1관이 두번 나오기떄문에, 한번만 나오도록함
							for(int i = 0; i < th_cinema_duple.length; i++){		// 초기화. 초기화안시키면 null이라 다음 for문에서 오류남
								th_cinema_duple[i] = "";
							}
							
							for(int i = 0, k = 0; i < thlist.size(); i++){ 
								if(th_name.equals(thlist.get(i).getTh_name())){ 
									
									boolean flag=false;	
									
									List<TheaterDTO> th_numlist = new ArrayList<TheaterDTO>();  
									// (1) sql  th_numlist = thdao.getTh_num(seq, th_name, thlist.get(i).getTh_cinema()); 
									// (2) 메소드
									th_numlist = getTheaterMatch(thlist, seq, th_name, thlist.get(i).getTh_cinema());
									
									for(int j = 0; j < i; j++){	
										if(th_cinema_duple[j].equals(thlist.get(i).getTh_cinema()))		// th_name_duple배열에 이미 해당 영화관존재
											flag = true;
									}
								
									// 출력 
								 	if(!flag){ %>
										<%-- <td colspan="2"><%=thlist.get(i).getTh_cinema() %>(총 <%=thlist.get(i).getTh_totalseat() %>석)</td></tr><tr> --%>
										<td class="headleft"><%=thlist.get(i).getTh_cinema() %></td><td class="eachone">(총 <%=thlist.get(i).getTh_totalseat() %>석)</td></tr><tr>
									<% 	for(int j = 0; j < th_numlist.size(); j++){%>
											<%-- <td><%=timestamp2string(th_numlist.get(j).getTh_time()) %></td> --%>
											<%-- <td align="center">
												<a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=sdate%>&th_seq=<%=th_numlist.get(j).getTh_seq()%>"><%=timestamp2string(th_numlist.get(j).getTh_time()) %></a>
											</td> --%>
											
											<%	// 현재날짜 및 시간보다 이전일 경우, 선택못하게 anchor를 뺀다
											String tt = getChooseTime(thlist, th_numlist.get(j).getTh_seq());
											System.out.println("tt:"+tt);
											/* if(syear != null && smonth != null && sdate != null && tt != null){ */
											if(sdate != null){
											
												String s  = year+"-"+two(month+"")+"-"+two(sdate+"")+" "+tt;
												if(compareTime(s)){ 
													System.out.println("(t)s:" + s );
													%>
													<td align="center">
														<a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=sdate%>&th_seq=<%=th_numlist.get(j).getTh_seq()%>"><%=timestamp2string(th_numlist.get(j).getTh_time()) %></a>
													</td>
											<%	}else{ System.out.println("(f)s:" + s ); %>
													<td align="center"><%=timestamp2string(th_numlist.get(j).getTh_time()) %></td>
											<%	}
											}
										}%>
										</tr><tr>
									<%	th_cinema_duple[k] = thlist.get(i).getTh_cinema();
										k++;
									}
								}
							}
						}%>
				</tr>
			</table>
		
			
		</td>
		<td>
			<table width="100%">
				<tr>
					<th colspan="5" class="headleft">성인</th>
					<td class="eachone" colspan="3">1매/<%=getPrice(plist, "adult")%>원</td>
				</tr>
				<tr>
				<%	for(int i = 1; i < 9; i++){ %>
						<td align="center">
						<%	if(i > getleftseat(thlist, th_seq)){ // 잔여석보다 큰 수는 선택할 수 없다%>
								<%=i %>
						<%	}else{ %>
								<a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=sdate%>&th_seq=<%=th_seq%>&adult=<%=i%>&student=<%=student%>&elder=<%=elder%>"><%=i %></a>
						<%	} %>
						</td>
				<%	} %>
				</tr>
				<tr>
					<th colspan="5" class="headleft">학생</th>
					<td class="eachone" colspan="3">1매/<%=getPrice(plist, "student")%>원</td>
				</tr>
				<tr>
				<%	for(int i = 1; i < 9; i++){ %>
						<td align="center">
						<%	if(i > getleftseat(thlist, th_seq)){ // 잔여석보다 큰 수는 선택할 수 없다%>
								<%=i %>
						<%	}else{ %>
							<a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=sdate%>&th_seq=<%=th_seq%>&adult=<%=adult%>&student=<%=i%>&elder=<%=elder%>"><%=i %></a>
						<%	} %>
						</td>
				<%	} %>
				</tr>
				<tr>
					<th colspan="5" class="headleft">우대(65세이상)</th>
					<td class="eachone" colspan="3">1매/<%=getPrice(plist, "elder")%>원</td>
				</tr>
				<tr>
				<%	for(int i = 1; i < 9; i++){ %>
						<td align="center">
						<%	if(i > getleftseat(thlist, th_seq)){ // 잔여석보다 큰 수는 선택할 수 없다%>
								<%=i %>
						<%	}else{ %>
							<a href="Reserve.jsp?seq=<%=seq%>&th_name=<%=th_name%>&date=<%=sdate%>&th_seq=<%=th_seq%>&adult=<%=adult%>&student=<%=student%>&elder=<%=i%>"><%=i %></a>
						<%	} %>
						</td>
				<%	} %>
				</tr>
				
			</table>
		</td>
	</tr>

</table>

</form>




<a href="Index.jsp">HOME</a>
<a href="Reserve.jsp">예매다시하기</a>


</body>
</html>
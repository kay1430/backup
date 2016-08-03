<%@page import="sist.co.Theater.TheaterDTO"%>
<%@page import="sist.co.Theater.TheaterDAO"%>
<%@page import="sist.co.Movie.MovieDTO"%>
<%@page import="sist.co.Movie.MovieDAO"%>
<%@page import="java.util.List"%>
<%@page import="sist.co.Seat.SeatDTO"%>
<%@page import="sist.co.Seat.SeatDAO"%>
<%@page import="sist.co.Reservation.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Seat</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
nu = 0;	/* 전역변수 */
function setDisable(elementid) {
	var el = document.getElementById(elementid);
	changeValue(elementid);
	el.style.backgroundColor='#ff8c00';
	el.style.color='#ffffff';
	el.disabled = 'true';
}
function changeValue(elementid){
	var str = "p" + nu;
	var divTest = document.getElementById(str);
	divTest.innerHTML=elementid;
	nu++;
}
function doSubmit() {
   	var arr = [nu];

	for(var i = 0; i < nu; i++){
		arr[i] = $("p:eq("+i+")").text();
	}
 
     document.myform.arr.value = arr.join(","); 
     document.myform.method = "POST";
     document.myform.action = "SeatAf.jsp";
     document.myform.submit();
}
function goReserve(){
	location.href="Reserve.jsp";
}
function ini(){
	var iniarr = [nu];
	for(var i = 0; i < nu; i++){
		// 선택한 좌석 버튼 초기화
		iniarr[i] = $("p:eq("+i+")").text();
		document.getElementById(iniarr[i]).disabled='false';
		document.getElementById(iniarr[i]).style.backgroundColor='#4169e1';
		// 선택한 좌석번호 초기화
		var str = "p" + i;
		document.getElementById(str).innerHTML="좌석"+(i+1);
	}
	
	// 전역변수 초기화
	nu=0;
	
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
#screen{
	width: 500px;
	height: 30px;
	background-color: lightgray;
}
.rowname{
	width: 30px;
	color : gray;
	border: 0px;
}
.topbottom{
	width: 500px;
	height: 20px;
	border: 0px;
}
.btsable{
	background-color: #4169e1;
	color: white;
	width: 100%;
	height: 100%;
}
.btsdisable{
	background-color: gray;
	width: 100%;
	height: 100%;
}
.btschoose{
	background-color: #ff8c00;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
<%!
public String[] getRow(List<SeatDTO> slist){	// rowname 추출
	String rowname_duple[] = new String[slist.size()];	// rowname 중복검사 배열
	int k = 0;
	for(int i = 0; i < rowname_duple.length; i++){		// 초기화. 초기화안시키면 null이라 다음 for문에서 오류남
		rowname_duple[i] = "";
	}
	
	for(int i = 0; i < slist.size(); i++){ 
		boolean flag=false;		// 배열 비교 관련 변수 (true:이미 rowname_duple 해당 rowname 존재) (false:rowname_duple 해당 rowname 존재 x)  
		for(int j = 0; j < i; j++){	
			if(rowname_duple[j].equals(slist.get(i).getS_name().substring(0, 1)))		// rowname_duple 이미 해당 rowname존재
				flag = true;
		}
		// 출력 
		if(!flag){	// 배열에 해당 영화관 X. 따라서, table에 출력과 동시에 rowname_duple 저장 	
			rowname_duple[k] = slist.get(i).getS_name().substring(0, 1);
			k++;
		}
	} 
	
	//""가 아닌 배열까지만 return하기 위한 작업
	String[] result = new String[k];
	for(int i = 0; i < k; i++){
		result[i] = rowname_duple[i];
	}
	
	return result;
}

%>
<%
ReservationDTO rdto = (ReservationDTO)session.getAttribute("rdto");
System.out.println("rdto.getTh_seq():"+rdto.getTh_seq());
int people = rdto.getR_adult() + rdto.getR_student() + rdto.getR_elder();
SeatDAO sdao = SeatDAO.getInstance();
List<SeatDTO> slist = sdao.getSeatList(rdto.getTh_seq());
String[] rowname = getRow(slist);
String[] chooseseat = new String[people];	// 선택한 인원수 == 배열 크기  

MovieDAO mdao = MovieDAO.getInstance();
MovieDTO mdto = mdao.getmoviedetail(rdto.getMv_seq());
TheaterDAO thdao = TheaterDAO.getInstance();
TheaterDTO thdto = thdao.getTheaterinform(rdto.getTh_seq());

%>

<a href="tmpadmin.jsp">tmpadmin</a>	<%-- 임시 좌석 DB insert에 해당. 원래 admin이 하는일 --%>


<table>
	<tr>
		<td colspan="3">
			<table>
				<tr>
					<th colspan="14" id="screen">Screen</th>
				</tr>
				<tr>
					<th colspan="14" class="topbottom"></th>
				</tr>		
				<%	for(int i = 0; i < rowname.length; i++){ %>
						<tr>
							<th class="rowname"><%=rowname[i]  %></th>
							<td class="rowname"></td>	<%--왼쪽통로 --%>
							<%
								for(int j = 0; j < slist.size(); j++){
									if(rowname[i].equals(slist.get(j).getS_name().substring(0, 1))){
										if(slist.get(i).getS_check()==0){	// 빈자리 : anchor%>			
										 	<%-- <td><a href="Seat.jsp"><%=Integer.parseInt(slist.get(j).getS_name().substring(1,slist.get(j).getS_name().length()))+1 %></a></td> --%>
											<td><input class="btsable" type='button' id='<%=slist.get(j).getS_name() %>' value='<%=Integer.parseInt(slist.get(j).getS_name().substring(1,slist.get(j).getS_name().length())) %>' onclick="setDisable('<%=slist.get(j).getS_name() %>')" /></td>
							<%			}else{ %> 									
											<%-- <td><%=slist.get(j).getS_name().substring(1,2) %></td> --%> 
											<td><input class="btsdisable" type='button' id='<%=slist.get(j).getS_name() %>' value='<%=Integer.parseInt(slist.get(j).getS_name().substring(1,slist.get(j).getS_name().length())) %>' disabled="disabled" /></td>
							<%			}
									}
								} %>
							<td class="rowname"></td>	<%--오른쪽통로 --%>
						</tr>
				<%	}%>
				<tr>
					<th colspan="14" class="topbottom"></th>
				</tr>	
				
			
			</table>
 		</td>
 		<td>
 			<table height="200px">
 				<tr><th>선택한 좌석번호</th></tr>
 			<%	for(int i = 0; i < people; i++){ %>
 					<tr><td><p id="p<%=i%>">좌석<%=i+1%></p></td></tr>
 			<%	} %>
 				<!-- <tr><td><button>다시선택</button></td></tr> -->
 			</table>
 		</td>
 		<td rowspan="2">
 			<td rowspan="3" width="225px" align="center">
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
					<th>금액</th>
					<td><%=rdto.getR_totalprice() %>원</td>	<%--(0801수정할거)가격 comma표시 --%>
				</tr>
				<tr>
					<th>잔여석</th>
					<td colspan="2"><%=thdto.getTh_leftseat() %>석</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<form name="myform">
						<input type="button" value="이전단계" onclick="goReserve()">
					
						<input type="hidden" name="arr">
						<input type="submit" value="다음단계" onclick="doSubmit()">
					</form>	
					</td>				
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><button class="btsable" disabled="disabled" style="width: 20px; height: 20px;"></button> : 선택가능좌석</td>
		<td><button class="btschoose" disabled="disabled" style="width: 20px; height: 20px;"></button> : 선택한좌석</td>
		<td><button class="btsdisable" disabled="disabled" style="width: 20px; height: 20px;"></button> : 선택불가좌석</td>
		<td><button style="width:100%; height:100%;" onclick="ini()">다시선택</button></td>
	</tr>
</table>




<a href="Index.jsp">HOME</a>


  


</body>
</html>
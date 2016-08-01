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
SeatDAO sdao = SeatDAO.getInstance();
List<SeatDTO> slist = sdao.getSeatList(rdto.getTh_seq());
String[] rowname = getRow(slist);

%>

<a href="tmpadmin.jsp">tmpadmin</a>	<%-- 임시 좌석 DB insert에 해당. 원래 admin이 하는일 --%>



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
								<td><a href="Seat.jsp"><%=Integer.parseInt(slist.get(j).getS_name().substring(1,2))+1 %></a></td>
				<%			}else{ %> 									
								<td><%=slist.get(j).getS_name().substring(1,2) %></td> 
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
 



















<a href="Index.jsp">HOME</a>
<a href="Reserve.jsp">예매다시하기</a>


</body>
</html>
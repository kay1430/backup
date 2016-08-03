<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AddTheater:admin</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function callme(value){
	var selectValue = document.getElementById('sel').value;
	var textValue = document.getElementById('th_name').value;
	document.myvalue.data1.value=selectValue;
	document.myvalue.data2.value=textValue;
	/* document.myvalue.method="GET";
	document.myvalue.action="AddTheater.jsp";
	document.submit();
	 */
	
}
</script>
</head>
<body>

<%
String th_name;
if(request.getParameter("th_name")==null) th_name="";
else th_name = request.getParameter("th_name");
System.out.println("th_name:" + th_name);

String data;
if(request.getParameter("data")==null) data="0";
else data = request.getParameter("data");
System.out.println("data:" + data);



%>


<form name="myvalue">
	<table>
		<tr>
			<th>지점</th>
			<td><input type="text" id="th_name" name="th_name" value="<%=th_name %>"></td>
		</tr>
		<tr>
			<th>상영관</th>
			<td>총 
				<select id="sel" style="width: 100px" onchange="callme(value)">
					<%for(int i = 1; i < 11; i++){ %>
						<option value="<%=i %>"	
							<%if(data!=null){
								if(i == Integer.parseInt(data)){ %> 
								selected="selected" <%}} 
							%>><%=i %>
						</option>
					<%} %>
				</select>
				관
			</td>
		</tr>
<!-- </table>
 </form>

<form action="AddTheaterAf.jsp">
<table> -->
		<tr>
			<th>회차</th>
			<td>
				<table>
					<%for(int i = 0; i < Integer.parseInt(data); i++){ %>
						<tr>
							<th><%=i+1 %>관</th> <%-- x관 --%>
							<td>
								<select id="<%=i+1 %>" style="width: 100px">
									<%for(int j = 1; j < 11; i++){ %>
										<option value="<%=j %>"><%=j %></option>
									<%} %>
								</select>
								차
							</td>
						</tr>	
					<%} %>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="text" name="data1">
				<input type="text" name="data2">
				<input type="submit" value="추가">
			</td>
		</tr>
	</table>
</form>



</body>
</html>
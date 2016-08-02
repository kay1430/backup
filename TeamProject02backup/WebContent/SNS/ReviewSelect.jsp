<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sist.co.Review.ReviewDAO" %>
    <%@ page import="java.util.*" %>
    <%@ page import="sist.co.Review.ReviewDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<%
	request.setCharacterEncoding("utf-8");
	
	String check = request.getParameter("check");
	String selecting = request.getParameter("selecting");
	
	ReviewDAO redao = ReviewDAO.getInstance();
	List<ReviewDTO> reList = redao.selectContent(check, selecting);
	
	request.setAttribute("selList",reList);
%>

<script type="text/javascript">
	location.href="../index01.jsp?mode=SNS/ReviewSelectList";
</script>

</body>
</html>
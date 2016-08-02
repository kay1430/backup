<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sist.co.Review.ReviewDTO" %>
    <%@ page import="sist.co.Review.ReviewDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<!-- 받는 값  r_title,r_content,r_seq,mv_seq -->

<%
	request.setCharacterEncoding("utf-8");

	int r_seq = Integer.parseInt(request.getParameter("r_seq"));
	int mv_seq = Integer.parseInt(request.getParameter("mv_seq"));
	String r_title = request.getParameter("r_title");
	String r_content = request.getParameter("r_content");
	
	ReviewDTO redto = new ReviewDTO();
	ReviewDAO redao = ReviewDAO.getInstance();
	
	redto.setR_seq(r_seq);
	redto.setMv_seq(mv_seq);
	redto.setR_title(r_title);
	redto.setR_content(r_content);
	
	redao.updateReview(redto);
	
	
%>

<script type="text/javascript">
	alert("작업완료");
	location.href="../index01.jsp?mode=SNS/ReviewList";
</script>
</body>
</html>
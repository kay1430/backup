<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
    <%@ page import="sist.co.Review.ReviewDAO" %>
         <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body> 

<%
	int r_seq = Integer.parseInt(request.getParameter("r_seq"));

	ReviewDAO redao = ReviewDAO.getInstance();
	int result = redao.deleteReview(r_seq);
	
	session.setAttribute("result",result);
%>

<c:choose>
	<c:when test="${result>=0 }">
		<script type="text/javascript">
			alert("삭제 완료");
			location.href="../index01.jsp?mode=SNS/ReviewList";
		</script>
	</c:when> 
	
	<c:when test="${result < 0 }">
		<script type="text/javascript">
			alert("삭제실패");
			location.href="../index.01.jsp?mode=SNS/ReviewList";
		</script>
	</c:when>
</c:choose>


</body>
</html>
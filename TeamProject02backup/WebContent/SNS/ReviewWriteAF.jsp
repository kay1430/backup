<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sist.co.Review.ReviewDTO" %>
<%@ page import="sist.co.Review.ReviewDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
 
<%request.setCharacterEncoding("utf-8");  %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
 
 

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	String m_id = request.getParameter("m_id");
	String r_title = request.getParameter("r_title");
	String r_content = request.getParameter("r_content");
	int r_star = Integer.parseInt(request.getParameter("r_star"));
	
	String mv_seqs = request.getParameter("mv_seq");
	int mv_seq = Integer.parseInt(mv_seqs);
	
	ReviewDAO redao = ReviewDAO.getInstance();
	ReviewDTO redto = new ReviewDTO();

	redto.setM_id(m_id);
	redto.setMv_seq(mv_seq);
	redto.setR_title(r_title);
	redto.setR_content(r_content);
	redto.setR_star(r_star);
	
	int result = redao.addReview(redto);
	session.setAttribute("result", result);
%>

<c:if test="${result==1 }">
	<script type="text/javascript">
		alert("리뷰등록 완료");
		location.href="../index01.jsp?mode=SNS/ReviewList";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script type="text/javascript">
		alert("리뷰등록 실패");
		location.href="../index01.jsp?mode=SNS/ReviewList";
	</script>
</c:if>




</body>
</html>
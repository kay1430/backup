<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     
    <%@ page import ="sist.co.Comment.CommentDTO" %>
    <%@ page import ="sist.co.Comment.CommentDAO" %>
    <%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String r_seqs = request.getParameter("r_seq");
	int r_seq = Integer.parseInt(r_seqs);
	
	String com_content = request.getParameter("com_content");
	
	String m_id = request.getParameter("m_id"); 
	
	CommentDTO comdto = new CommentDTO();
	
	comdto.setR_seq(r_seq);
	comdto.setM_id(m_id);
	comdto.setCom_content(com_content);
	
	CommentDAO comdao = CommentDAO.getInstance();
	comdao.insertComment(comdto);
	
%>
<script type="text/javascript">
	location.href="../index01.jsp?mode=SNS/ReviewDetail&r_seq=<%=r_seq%>";
</script>

</body>
</html>
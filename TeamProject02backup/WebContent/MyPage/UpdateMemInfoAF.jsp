   <%@page import="test.Member.testMemberDAO"%>
<%@page import="sist.co.Member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/mypage.css"/>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript" src="javascript/member.js"></script>

</head>
<body>
 
<%
testMemberDAO dao = new testMemberDAO();

MemberDTO memberdto = new MemberDTO();
memberdto.setM_id("bombom");
memberdto.setM_pw("1234");
memberdto.setM_name("Bom");
memberdto.setM_email("ddd");

session.setAttribute("login",memberdto);

String mid = memberdto.getM_id();
String mpw = memberdto.getM_pw();
System.out.println("mpw: " +mpw);
String memail = memberdto.getM_email();
System.out.println("memail: " +memail);

//회원수정 페이지값
String u_pw = request.getParameter("pw");
System.out.println("u_pw: " +u_pw);
String u_email = request.getParameter("email");
System.out.println("u_email: " +u_email);
System.out.println("mid: " +mid);

boolean isS = dao.updateMember(u_pw, u_email, mid);
//boolean isS = dao.updateMember("2222", "2222", "BOMBOM");
System.out.println("isS: " + isS);
%>

<header1>

</header1>

<nav1>
<a href ="index01.jsp?mode=MyPage/Index"><h4><b>마이시네마</b></h4></a>

   &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/LoginUpdate">회원정보</a><br>
  

  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/Ticket">내 티켓</a><br>
  
 
  &nbsp;&nbsp;<a href = "index01.jsp?mode=MyPage/MovieHistory">나의 관람 영화</a><br>
</nav1>

<section1> <%
//이전값과 현재 입력값이 다르면 수정 가능
//if(!u_pw.equals(mpw)||!u_email.equals(memail)){
   if(isS){ //수정값이 DAO에 잘 들어 가면
	%> 
	<script type="text/javascript">
	    alert("회원정보 수정을 성공했습니다.");
		location.href = "index01.jsp?mode=MyPage/Index";
	</script> <%
   }else{
	%> <script type="text/javascript">
		alert("회원정보 수정을 실패했습니다.");
		location.href = "index01.jsp?mode=MyPage/UpdateMemInfo";
	</script> <%
   }
//}
%>

</section1>

<footer1>
<!-- Copyright@우리조 -->
</footer1>


</body>
</html>
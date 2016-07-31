<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/style.css" type ="text/css">
<title>Member Login</title>
<script type="text/javascript" src="../javascript/member.js"></script>
</head>
<body>
<h1>Junghyun Login</h1>
<form action="login.jsp" method="post">
<table>
	<tr>
	
		<td>아이디</td>
		<td><input type="text" name="id" size="20"/></td>
	</tr>
	<tr>
		<td>PW</td>
		<td><input type="text" name="pw" size="20"/></td>
	</tr>
	<tr>
		<td></td>
		<td>
			<input type="button" name="join" value="회원가입" onclick="goPage(1)"/>
			<input type="submit" name="login" value="로그인" onclick="goPage(3)"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>
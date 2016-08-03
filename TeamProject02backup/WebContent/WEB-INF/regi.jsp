<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../css/style.css" type ="text/css">
<script type="text/javascript" src="../javascript/memeber.js"></script>
</head>
<body>

<h1>회원 등록</h1>

<div>
<form name="joinmem" action="RegiAf.jsp" method="post">
<table style = "border: 1px solid black">
<tr>
	<td>ID</td>
	<td><input type="text" name="id" size="20"/></td>
	<td><input type="submit" value="중복확인" size="100" onclick="iddupchk()"></td>
</tr>
<tr>
	<td>PW</td>
	<td><input type="password" name="pwd" size="20"/></td>
</tr>
<tr>
	<td>PW확인</td>
	<td><input type="password" name="pwd_chc" size ="20"/></td>
</tr>
<tr>
	<td>이름</td>
	<td><input type="text" name ="name" size= "20"/></td>
</tr>
<tr>
	<td>E-mail</td>
	<td><input type="text" name="email" size="20"/></td>
	<td><input type="submit" value="중복확인" size="100"></td>
</tr>
<tr>
	
</tr>
</table>
</form>
</div>
<input type="button" value ="가입완료" onclick = "goPage(2)">
<input type="button" value="메인으로" onclick="goPage(2)">
</body>
</html>
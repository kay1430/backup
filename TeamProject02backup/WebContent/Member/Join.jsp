<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sist.co.Member.MemberDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<link href="../css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="javascript/member.js"></script>
</head>
<body>
<h1 align="center">회원가입</h1>
<hr>


	<form name="frm" action="Member/JoinAF.jsp" method="post" enctype="multipart/form-data">
		<div class="form-group" >
			<label for="exampleInputName2">아이디</label>&nbsp;&nbsp;&nbsp;&nbsp;
   			 <input type="text" class="form-control" id="exampleInputName2" placeholder="lovely4750" name="m_id" style="width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   			 <input type="hidden" name="reid">
    		<input type="button" value="중복검사" onclick="idCheck()" >
    		<br><br>
    		
    		
    		<label for="exampleInputName2">비밀번호</label>&nbsp;&nbsp;&nbsp;&nbsp;
   			 <input type="password" class="form-control" id="exampleInputPassword3" placeholder="Password" style="width:40%;" name="m_pw">
    		<br><br>
    		
    		<label for="exampleInputName2">비밀번호확인</label>&nbsp;&nbsp;
   			 <input type="password" class="form-control" id="exampleInputPassword3" placeholder="Password" style="width:40%;" name="m_pwch">
    		<br><br>
 
    		<label for="exampleInputName2">이름</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   			 <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe" style="width:40%;"name="m_name">
    		<br><br>
    		
    		
    		<label for="exampleInputEmail1">이메일 주소</label>&nbsp;&nbsp;
    		<input type="email" class="form-control" id="exampleInputEmail1" placeholder="이메일을 입력하세요" style="width:40%;"name="m_email">
    		<br><br>
    	
    		<img src="img/no_image.gif" alt="이미지 못찾음" class="img-thumbnail" style="width:140px;height:140px;" id="imgimg"><br><br>
    		<input type="file" id="exampleInputFile" name="m_photo" onchange="readURL(this)">
    		<input type="button" value="삭제" onclick="deleteURL()">

    		<br><br><br>
    		<hr>
    		<input type="submit" value="저장" onclick="return joinCheck()">
    		<input type="reset" value="리셋">
    		<input type="button" value="취소" onclick="location.href='index01.jsp?mode=body'">
    	
    	</div>
    		  		
    		  		
    		  		
	</form>
	
<script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgimg').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function deleteURL(){
        	$('#imgimg').attr('src','img/no_image.gif');
        	$('#exampleInputFile').val("");
        }
</script>


</body>
</html>
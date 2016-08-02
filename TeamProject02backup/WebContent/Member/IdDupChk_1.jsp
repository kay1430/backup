<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript">
var USERID_CHECK_FLAG = false; //사용자아이디 중복체크했는지 여부
var USERID_CHECK_SUCCESS_FLAG = false; //사용자아이디 중복체크 한 후 결과값

$(document).ready(function() {
 $("#memberJoinForm").submit(function() {
  if ($("input[name=USERID]").val().length < 4) {
   alert("아이디는 최소 4자리 이상 입력해주십시오.");
   $("input[name=USERID]").focus();
   return false;
  }
  if (!USERID_CHECK_FLAG) {
   alert("아이디 중복체크를 안하셨기때문에 자동으로 중복체크를 실행하겠습니다.");
   $("#BTN_USERID_CHECK").click(); //버튼클릭 강제
   return false;
   
    
  }
  if (!USERID_CHECK_SUCCESS_FLAG) {
   alert("이미 사용중인 아이디입니다.\n다른 아이디를 사용해주십시오.");
            $("input[name=USERID]").val(""); //입력했던 아이디 초기화
            $("input[name=USERID]").focus();//아이디 필드로 자동이동   
   return false;
  }
  if ($("input[name=PASSWORD]").val().length < 4) {
   alert("비밀번호는 최소 4자리 이상 입력해주십시오.");
   $("input[name=PASSWORD]").focus();
   return false;
  }
 });
 $("input[name=USERID]").keyup(function() {  //아이디 입력필드에 키보드가 눌러졌을때 이벤트
  USERID_CHECK_FLAG = true; //아이디중복체크를 실행하였으므로 true
  $.ajax({
    url: "memberUserIdCheck.jsp",//아이디중복체크할페이지 지정
   data : ({
     USERID : $("input[name=USERID]").val() //파라메터로 USERID 이름으로 값은 사용자가 입력한 사용자아이디를 지정
   }),
   success: function(data){ //중복확인후의 값은 data로 들어온다.
    var isFlag = eval(trim(data)); //trim함수로  값에 공백을 제거한후 자바스크립트 값으로 인식하게
          if (isFlag) { 
     $("#USERID_MESSAGE").html("<font color=blue>현재 입력하시는 아이디는 사용이 가능합니다.</font>");
     $("#USERID_MESSAGE").show();
     $("input[name=PASSWORD]").focus();//패스워드로 자동이동
     USERID_CHECK_SUCCESS_FLAG = true;
     
             } else {
     $("#USERID_MESSAGE").html("<font color=red>이미 사용중인 아이디입니다. 다른 아이디를 사용해주십시오.</font>");
     $("#USERID_MESSAGE").show();                
              //    $("input[name=USERID]").val(""); //입력했던 아이디 초기화
                 $("input[name=USERID]").focus();//아이디 필드로 자동이동
                 USERID_CHECK_SUCCESS_FLAG = false;
             }
       }});
  
 });
 $("#BTN_USERID_CHECK").click(function() { //중복체크아이디 클릭이벤트
  USERID_CHECK_FLAG = true; //아이디중복체크를 실행하였으므로 true
  $.ajax({
    url: "memberUserIdCheck.jsp",//아이디중복체크할페이지 지정
   data : ({
     USERID : $("input[name=USERID]").val() //파라메터로 USERID 이름으로 값은 사용자가 입력한 사용자아이디를 지정
   }),
   success: function(data){ //중복확인후의 값은 data로 들어온다.
    var isFlag = eval(trim(data)); //trim함수로  값에 공백을 제거한후 자바스크립트 값으로 인식하게
          if (isFlag) { 
     alert("현재 입력하시는 아이디는 사용이 가능합니다.");
     $("input[name=PASSWORD]").focus();//패스워드로 자동이동
     USERID_CHECK_SUCCESS_FLAG = true;
     
             } else {

                 alert("이미 사용중인 아이디입니다.\n다른 아이디를 사용해주십시오.");
                 $("input[name=USERID]").val(""); //입력했던 아이디 초기화
                 $("input[name=USERID]").focus();//아이디 필드로 자동이동
                 USERID_CHECK_SUCCESS_FLAG = false;
             }
       }});
 });
 $("input[name=PASSWORD]").keyup(function() { //패스워드 필드로 이동하면 사용자아이디 메세지 보이기 않게하기
  if (USERID_CHECK_SUCCESS_FLAG) { //단 사용자아이디중복여부 체크한 후 성공일때만
   $("#USERID_MESSAGE").hide();
  }
 });
});

function trim(str) {
 return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

</script>
<form name="memberJoinForm" id="memberJoinForm" method="post" action="memberJoinProc.jsp">
<!-- <table>
<tbody>
<tr>
 <td>
  아이디
 </td>
 <td>
  <input type="text" name="USERID"></input>
  <div id="USERID_MESSAGE" style="display:none;"></div>
  
  <button type="button" id="BTN_USERID_CHECK">중복확인</button>
 </td>
</tr>
<tr>
 <td>
  패스워드
 </td>
 <td>
  <input type="password" name="PASSWORD"></input>
 </td>
</tr>
<tr>
 <td colspan="2">
  <input type="submit" value="전송"></input>
 </td>
</tr>
</tbody>
</table>
 -->
</form>

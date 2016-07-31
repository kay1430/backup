

function goPage(a){
	
	if(a==1){
		alert("회원가입클릭");
		location.href="regi.jsp";
	}else if(a==2){
		alert("가입완료클릭");
		location.href="regiAf.jsp";
	}else if(a==3){
		alert("로그인클릭");
		location.href="login.jsp";
	}else if(a==4){
		
		alert("메인으로 가기 클릭");
		location.href="Index.jsp";
	}else if(a==5){
		location.href="Calendar.jsp";
	}else if(a==6){
		location.href="logout.jsp";
	}else if(a==7){
		location.href="pds/pdslist.jsp";
	}else if(a==8){
		location.href="poll/pollmake.jsp";
	}else if(a==9){
		location.href="poll/polllist.jsp";
	}
}

function idDupchk(){
	if(document.joinmem.id.value.length<4){
		alert("ID를 최소 4자리 이상 입력하세요");
		document.joinmem.id.focus();
	}
	else if(document.joinmem.id.value){
		alert("ID 중복검사를 합니다");
		location.href="idDupChk.jsp";		//id 중복검사
	}
}


/*function checkpw() {
	pw = document.getElementsByName('passwd')[0].value;
	filter = /^[a-z0-9]*$/;

	if (pw.length > 5 && pw.length < 16) {
		if (!pw.match(filter)) {
			alert("비밀번호를 확인해주세요");
			document.edit_form.passwd.onfocus = "true";
			global_ck1 = false;
		} else
			global_ck1 = true;
	} else {
		alert("비밀번호의 길이를 확인해 주세요");
		global_ck1 = false;
	}
	if(pw.length == 0)
		global_ck1= true;
}
*/


function emailDupchk(){
	alert("emailDupchk");
	if(document.joinmem.email.value.length){
		alert("email를 최소 4자리 이상 입력하세요");
		document.joinmem.email.focus();
		return false;
		location.href = "emailDupChk.jsp";
	}
}

/*function regifinish(){
	if
}*/


function idCheck(){
		
	   if(document.joinmem.id.value==""){
	      alert("아이디를 입력해 주세요");
	      joinmem.id.focus();
	      return;
	   }
	   
	   var url="idCheck.jsp?id="+document.joinmem.id.value;
	   window.open(url,"_black_1", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=200");
	}
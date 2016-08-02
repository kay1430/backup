/**
 * 
 */



function goPage(a){
	if(a==1){
		location.href="bbswrite.jsp";
	}else if(a==2){
		location.href="bbslist.jsp";
	}else if(a==3){
		location.href="../main.jsp";
	}else if(a==4){
		location.href="answer.jsp?seq="+document.frm.seq.value;
	}else if(a==6){
		location.href="../logout.jsp";
	}
}

function bbsdelete(a){
	
	location.href="bbsdelete.jsp?seq="+a;
	
}

function bbsupdate(a){
	location.href="bbsupdate.jsp?seq="+a;
}
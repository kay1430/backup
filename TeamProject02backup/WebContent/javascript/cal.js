/**
 * 
 */


function goPage(a){
	
	if(a==1){
		location.href="../main.jsp";
	}else if(a==2){
		location.href="Calendar.jsp";
	}else if(a==3){
		location.href="calupdateAF.jsp";
	}else if(a==6){
		location.href="../logout.jsp";
	}
}



function deleteCal(a){
	location.href="caldelete.jsp?seq="+a;
}
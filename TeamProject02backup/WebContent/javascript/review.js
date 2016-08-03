/**
 * 
 */

function reviewCheck(){
	 
	 
		if(document.frm.mv_seq.value==0){
			alert("영화를 선택해 주세요");
			frm.mv_seq.focus();
			return false;
		}else if(document.frm.r_title.value.length==0){
			alert("제목을 입력해 주세요");
			frm.r_title.focus();
			return false;
		}
	return true;
}

function deleteCheck(){
	if(confirm("정말 삭제 하시겠습니까~?") == true){
		location.href="SNS/ReviewDelete.jsp?r_seq="+$('.r_seq_re').val();
		return true;
	}else{
		return false;
	}
}
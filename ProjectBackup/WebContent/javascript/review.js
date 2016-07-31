/**
 * 
 */


 

$(document).ready(function() {
	
	alert("오나요?");
	$('.comments').click(function(e) {
		alert("수정누름");
	    	
	        var $form = $(e.target).parent().parent().find('.modify-comment');
	        var $p = $(e.target).parent().parent().find('.view-comment');
	        if ($form.is(':hidden') == true) {
	            $form.show();
	            $p.hide();
	        } else {
	            $form.hide();
	            $p.show();
	        }
	        return false;
	    
	});
	//form 안의 수정하기 링크
	$('.modify-comment a:contains("수정")').click(function(e) {
	    $(e.target).parent().parent().submit();
	    return false;
	});
	//form 안의 취소 링크
	$('.modify-comment a:contains("취소")').click(function(e) {
	    var $form = $(e.target).parent().parent();
	    var $p = $(e.target).parent().parent().parent().find('.view-comment');
	    if ($form.is(':hidden') == true) {
	        $form.show();
	        $p.hide();
	    } else {
	        $form.hide();
	        $p.show();
	    }
	    return false;
	});

});
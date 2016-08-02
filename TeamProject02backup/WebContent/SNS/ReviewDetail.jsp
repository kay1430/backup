<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sist.co.Member.MemberDTO" %>
     <%@ page import="sist.co.Review.ReviewDAO" %>
     <%@ page import="sist.co.Review.ReviewDTO" %>
     <%@ page import="sist.co.Comment.CommentDTO" %>
     <%@ page import="sist.co.Comment.CommentDAO" %>
     <%@ page import="sist.co.Movie.MovieDAO" %>
      
     <%@ page import="java.util.*" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
<head>
  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>리뷰 디테일</title>

<script src="javascript/review.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="star/jquery.raty.js"></script>
<link rel="stylesheet" href="star/jquery.raty.css"/>
<script type="text/javascript" src="javascript/review.js"></script>
<script type="text/javascript">
$(function(){
    //전역변수선언
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "r_content",
        sSkinURI: "smarteditor/SmartEditor2Skin.html", 
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }
    });

    //전송버튼 클릭이벤트
    $("#savebutton").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        
        editor_object.getById["r_content"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증
         
        //폼 submit
        $("#frm").submit();
    })
})
</script>

<script type="text/javascript">
$(document).ready(function() {
	 
	$('.comment-toggle').click(function(e) {
		
	        var $form = $(e.target).parent().parent().find('.modify-comment');

	        var $p = $(e.target).parent().parent().find('.comment-toggle');
	        var $o = $(e.target).parent().parent().find('.comment-delete');
	        var $c = $(e.target).parent().parent().parent().find('.comment-content');
      
	        if ($form.is(':hidden') == true) {
	            $form.show();
	            $p.hide();
	        	$o.hide();
	        	$c.hide();
	        } else {
	            $form.hide();
	            $p.show();
	            $o.show();
	            $c.show();
	        }
	        return false;
	});
	
	$('.comment-delete').click(function(e) {
		var chk = confirm("정말로 삭제하시겠습니까?");
        if (chk == true) {
            return true;
        }
        return false;
});
	
	/* SNS/CommentUpdate.jsp?com_seq=${comment.com_seq }$r_seq=${comment.r_seq }&com_content= */
	//form 안의 수정하기 링크
	$('.modifying').click(function(e) {
		
	   var url="SNS/CommentUpdate.jsp?com_seq="+$('.com_seq_re').val()+"&r_seq="+$('.r_seq_re').val()+"&com_content="+$('.modify-comment-ta').val();
	    $(location).attr('href',url);
	     
	    //alert(url);
	    //location.href="index01.jsp?mode=SNS/ReviewDetail"

	});
	
	//form 안의 취소 링크
	$('.cancel').click(function(e) {
	    var $form = $(e.target).parents().find('.modify-comment');
	    
	    var $p = $(e.target).parents().find('.comment-toggle');
        var $o = $(e.target).parents().find('.comment-delete');
        var $c = $(e.target).parents().find('.comment-content');
        
        
        /* alert("1 : "+$('#com_seq_check').attr('value'));
        alert("2 : "+$(e.target).parents().find('.cancel').attr('id')); */
        
	    if ($form.is(':hidden') == true) {
	    	$form.show();
	        $p.hide();
        	$o.hide();
        	$c.hide();
	    } else {
	    	
	    	$form.hide();
	        $p.show();
            $o.show();
            $c.show();
	    }
	    return false;
	});

});
</script>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">

</head>
<body>

<%

String r_seqs = request.getParameter("r_seq");
int r_seq = Integer.parseInt(r_seqs);
ReviewDAO redao = ReviewDAO.getInstance();

redao.addReadCount(r_seq);
ReviewDTO redto = redao.getReviewDTO(r_seq);
session.setAttribute("redto",redto);

CommentDAO comdao = CommentDAO.getInstance();
List<CommentDTO> comList = comdao.selectComment(r_seq);
request.setAttribute("comList", comList);

%>
<div id="middle_wrap">
	<form name="frm" action="SNS/CommentWrite.jsp">
	<table class="table table-bordered">
		
		<tr>
			<td>제목</td>
			<td><%=redto.getR_title() %><input type="hidden" value="<%=redto.getR_seq() %>" name="r_seq"></td>
			<td rowspan="4">
				<div>
					<%
						MovieDAO moviedao = MovieDAO.getInstance();
						String mv_img = moviedao.getMvIMG(redto.getMv_seq());
						
						session.setAttribute("re_mv_img",mv_img);
					%>
					<img src="${re_mv_img }" alt="영화이미지" id="movieImg">
				</div>
			</td>
		</tr>
		
		<tr>
			<td>작성자</td>
			<td>
				[<%=redto.getM_id() %>] 님 작성글
			</td>
			
		</tr>
		
		<tr>
			<td>작성일</td>
			<td><%=redto.getR_writedate().toString().substring(0,10) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				좋아요: <input type="text" id ="like" value="<%=redto.getR_like() %>" size="2" readonly> 
				<input type="button" value="좋아용" id="addlike"></td>
		</tr>
		
		<tr>
			<td>별점</td>
			<td>
				<div id="default" style="cursor:pointer;" ></div>
						
						<div id=target>
				        	<input type="text" id="re_star" name="r_star">
       					</div>
				
			</td>
		</tr>
		
			
		<tr>
			
			<td colspan="3"  style="background:white"><textarea rows="20" cols="110" readonly id="r_content"><%=redto.getR_content()%></textarea></td>
		</tr>
		
		<c:if test="${comList.size() == 0 }">
			<tr >
				<td colspan="3" style="background-color:#C9AA56">등록된 댓글이 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${comList.size() > 0}">
			<c:forEach var="comment" items="${comList }">
				<tr style="background-color:#C9AA56">
					<td colspan="3">
					
						<div class="comments">

						<h4 class="view-commnet"> 
							[${comment.m_id}] 
							<small>${comment.com_writedate }</small>
							<c:if test="${login.m_id == comment.m_id }">		
									<a href="#" ><small class="comment-toggle">수정</small></a>
									<a href="SNS/CommentDelete.jsp?com_seq=${comment.com_seq }&r_seq=${comment.r_seq}"><small class="comment-delete">삭제</small></a>
	
	
								<!--  댓글 수정!!!!!!!!!!!!!!!!!!!!!!!!!!!!jquery -->	
											
								<div class="modify-comment" style="display: none">
							    	
							    <div style="text-align: right;">
							      <a href="#"><small class="modifying">수정</small></a> |
							      <a href="#"><small class="cancel">취소</small></a>
							    </div>
							    
							    <div>
							    	<input type="hidden" value="${comment.com_seq }" class="com_seq_re" id="com_seq_check">
							    	<input type="hidden" value="${comment.r_seq }" class="r_seq_re" >
							      <textarea class="modify-comment-ta" name="com_content_re" rows="4" cols="50">${comment.com_content }</textarea>
							    </div>
							    
							  </div>
									
							</c:if>
						</h4>
						<h3 class="comment-content">
						${comment.com_content } 
						</h3>
						</div>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
			<tr >
			
				<td colspan="3" >
						<c:choose>
							<c:when test="${login.m_id != null }">
								<textarea rows="4" cols="80" name ="com_content"></textarea>
									&nbsp;&nbsp;
								<input type="submit" value="등록" 
								<%-- onclick="location.href='SNS/CommentWrite.jsp?r_seq=<%=r_seq %>&com_content=&m_id=${login.m_id }'" --%>
								class="btn btn-danger">
								<input type="hidden" value="${login.m_id }" name="m_id">
								<input type="hidden" value=<%=r_seq %> name="r_seq">
							</c:when>
							
							<c:when test="${login.m_id ==null }">
								
								<textarea rows="4" cols="80" name ="com_content"></textarea>
									&nbsp;&nbsp;
								<input type="submit" value="등록" 
								<%-- onclick="location.href='SNS/CommentWrite.jsp?r_seq=<%=r_seq %>&com_content=&m_id=${login.m_id }'" --%>
								class="btn btn-danger">
								<input type="hidden" name="m_id" value="비로그인회원">
								<input type="hidden" value=<%=r_seq %> name="r_seq">
							</c:when>
						</c:choose>
						
					
				</td>
			</tr>
		
		
	</table>
	</form>
	
	
	<div style="text-align:right;">
		<c:if test="${login.m_id eq redto.m_id }">
			<input type="button" value="수정" onclick="location.href='index01.jsp?mode=SNS/ReviewUpdate&r_seq=<%=r_seq%>'">
			<input type="button" value="삭제" onclick="deleteCheck()">
		</c:if> 
		<input type="button" value="돌아가기" onclick="location.href='index01.jsp?mode=SNS/ReviewList'">
	
	
	
	
</div>
<hr>





<script>
	var like = <%=redto.getR_like()%>;
	var doLike = 0;
	
	
	    $('#addlike').click(function(){
	    	if(doLike==0){
	    	$.ajax({
	            url:'SNS/addLike.jsp?r_seq=<%=redto.getR_seq()%>' ,
	            success:function(data){
	            },complete : function(data) {
	            	like +=1;
	            	doLike +=1;
	            	$('#like').val(like);
	          }
	            
	        });
	    	
	    	}else{
	    		alert("그만눌러이씨");
	    	}
	    	
	    });
	
</script>

<script type="text/javascript">
	$('div#default').raty({
		score:<%=redto.getR_star()%>,
		path:'star/images',
		targetScore:'#re_star',
		readOnly:true
	});
</script>
</body>
</html>
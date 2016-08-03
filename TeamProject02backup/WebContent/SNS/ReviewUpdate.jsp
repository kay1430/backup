<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sist.co.Member.MemberDTO"%>
<%@ page import="sist.co.Review.ReviewDAO"%>
<%@ page import="sist.co.Review.ReviewDTO"%>
<%@ page import="sist.co.Movie.MovieDTO" %>
<%@ page import="sist.co.Movie.MovieDAO" %>
<%@ page import="java.util.*" %>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
 
<!DOCTYPE html>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../css/style.css">
<!-- jquery 링크 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- jquery 링크 -->

<!-- 별 링크 -->
<script type="text/javascript" src="star/jquery.raty.js"></script>
<link rel="stylesheet" href="star/jquery.raty.css"/>
<!-- 별 링크 -->

<!-- 스마트 에디터 링크 -->
<script type="text/javascript" src="smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<!-- 스마트 에디터 링크 -->
<script type="text/javascript" src="javascript/review.js"></script>

<script type="text/javascript">
	$(
			function() {
				//전역변수선언
				var editor_object = [];

				nhn.husky.EZCreator.createInIFrame({
					oAppRef : editor_object,
					elPlaceHolder : "r_content",
					sSkinURI : "smarteditor/SmartEditor2Skin.html",
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
				$("#savebutton").click(
						function() {
							//id가 smarteditor인 textarea에 에디터에서 대입
							if(document.frm.mv_seq.value==0){
								alert("영화를 선택해 주세요");
								frm.mv_seq.focus();
								return false;
							}else if(document.frm.r_title.value.length==0){
								alert("제목을 입력해 주세요");
								frm.r_title.focus();
								return false;
							}
							
							editor_object.getById["r_content"].exec(
									"UPDATE_CONTENTS_FIELD", []);

							// 이부분에 에디터 validation 검증

							//폼 submit
							$("#frm").submit();
						})
			})
			
			
</script>
<body>


	<%
		MemberDTO memberdto = (MemberDTO) session.getAttribute("login");
	%>
	<h3><%=memberdto.getM_id()%>님 하이요
	</h3>
	<hr>

	<%
		
		
		int r_seq = Integer.parseInt(request.getParameter("r_seq"));
		ReviewDAO redao = ReviewDAO.getInstance();
		ReviewDTO redto = redao.getReviewDTO(r_seq);
		
		MovieDAO modao = MovieDAO.getInstance();
		List<MovieDTO> moList = modao.getMovie();
		String mv_img = modao.getMvIMG(redto.getMv_seq());
		
		session.setAttribute("redto",redto);
		session.setAttribute("re_movie",moList);
		
		
		
	%>
	
	
	<div id="middle_wrap">
		<form action="SNS/ReviewUpdateAF.jsp" method="post" name="frm" id="frm">
			<table class="table table-bordered" border="1">
				<tr>
					<td>작성자</td>
					<td><input type="text" name="m_id" readonly value="<%=memberdto.getM_id()%>">
						<input type="hidden" name="r_seq" value="<%=redto.getR_seq() %>">
					</td>

					<td rowspan="3">
						<div>
							<img src="<%=mv_img %>" alt="영화이미지" id="movieImg" width="90px"height="140px;">
							<select name="mv_seq" id="mv" onchange="changeImg()">
								<option value="0">영화제목들</option>
								
								<c:forEach var="movie" items="${re_movie }">
									<c:if test="${redto.mv_seq == movie.mv_seq }">
										<option value="${movie.mv_seq }" id="${movie.mv_img }" selected>${movie.mv_title }</option>
									</c:if>
									
									<c:if test="${redto.mv_seq != movie.mv_seq }">
										<option value="${movie.mv_seq }" id="${movie.mv_img }">${movie.mv_title }</option>
									</c:if>
									
								</c:forEach>
								
							</select>
						</div>


					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="r_title" value="<%=redto.getR_title() %>"></td>
				</tr>
				<tr>
					<td>별점</td>
					<td>
						<div id="default" style="cursor:pointer;" ></div>
						
						<div id=target>
				        	<input type="text" id="re_star" name="r_star" readonly>
       					 </div>
        			</td>
				</tr>

				<tr>
					<td>내용</td>
					<td style="background: white" colspan="2">
						<textarea rows="20" cols="50" name="r_content" id="r_content"style="background: #8C8C8C">
							<%=redto.getR_content() %>
						</textarea>
					</td>



				</tr>
			</table>

			<input type="button" value="저장" id="savebutton" > 
			<input
				type="button" value="취소"
				onclick="location.href='index01.jsp?mode=SNS/ReviewList'">

		</form>

	</div>
	<hr>



<script type="text/javascript">
	$('div#default').raty({
		score:<%=redto.getR_star()%>,
		path:'star/images',
		targetScore:'#re_star'
	});
	
</script>

<script type="text/javascript">

	function changeImg(){
		$('#movieImg').attr('src',$('#mv option:selected').attr('id'));
	}

</script>
</body>
</html>
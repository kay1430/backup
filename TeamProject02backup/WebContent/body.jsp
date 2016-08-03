<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="sist.co.ShowMovie.MovieManage" %>
    <%@ page import="sist.co.ShowMovie.MovieVO" %>
    <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="css/style.css"> -->
<!-- <link rel="stylesheet" href="css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://googledrive.com/host/0B-QKv6rUoIcGeHd6VV9JczlHUjg"></script><!-- holder.js link -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<script>
    $(document).ready(function() {
        $('#myCarousel2').carousel('cycle');
    });
</script>

</head>

<body>

<%
MovieManage mm = new MovieManage();
List<MovieVO> list = mm.getMovieVO();

session.setAttribute("showMovie",list);
%>

<div id="myCarousel2" class="carousel slide vertical">
	  
	  <!-- div 갯수만큼 생성해야함 -->
	  <ol class="carousel-indicators">
	    <li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
	    <li data-target="#myCarousel2" data-slide-to="1" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="2" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="3" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="4" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="5" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="6" class=""></li>
	   <!-- <li data-target="#myCarousel2" data-slide-to="7" class=""></li> -->
	  </ol>

		<div class="carousel-inner" role="listbox">
			  
	  	<c:forEach var="vo" items="${showMovie }">
	      	<c:choose>
	      		<c:when test="${vo.num == 0 }">
	      			<div class="item active">
				      	<img src=${vo.movie_img } width="400px" height="600px">
				      	
				      	<div class="carousel-caption">
						<h1>${vo.title }</h1>
						<h4>개봉일 : ${vo.date }</h4><h4>예매율 : ${vo.reser }  </h4><h4>좋아요 : ${vo.like }</h4>
			     		 </div>
		    		</div> 
	      		</c:when>
	      		
	      		<c:when test="${vo.num != 0}">
	      			<div class="item">
			      		<img src=${vo.movie_img } width="400px" height="600px">
			      		
			      		<div class="carousel-caption">
							<h1>${vo.title }</h1>
						<h4>개봉일 : ${vo.date }</h4><h4>예매율 : ${vo.reser }  </h4><h4>좋아요 : ${vo.like }</h4>
			      		</div>    
		      	</div>
	      		</c:when>
	      	</c:choose>
	
	  	</c:forEach>
		</div>
		
		 
	  <a class="left carousel-control" href="#myCarousel2" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#myCarousel2" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>
	

</body>
</html>
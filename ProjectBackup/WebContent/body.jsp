<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://googledrive.com/host/0B-QKv6rUoIcGeHd6VV9JczlHUjg"></script><!-- holder.js link -->

<script>
    $(document).ready(function() {
        $('#myCarousel').carousel('cycle');
        $('#myCarousel2').carousel('cycle');
    });
</script>

</head>

<body>

<div id="myCarousel2" class="carousel slide vertical">
	  <ol class="carousel-indicators">
	    <li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
	    <li data-target="#myCarousel2" data-slide-to="1" class=""></li>
	    <li data-target="#myCarousel2" data-slide-to="2" class=""></li>
	  </ol>
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img data-src="holder.js/1200x500/text:First slide">
	      <div class="carousel-caption">
		<h3>First slide label</h3>
		<p style="color:black">Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
	      </div>      
	    </div>
	    <div class="item">
	      <img data-src="holder.js/1200x500/text:Second slide">
	      <div class="carousel-caption">
		<h3>Second slide label</h3>
		<p style="color:black">Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
	      </div>      
	    </div>
	    <div class="item">
	      <img data-src="holder.js/1200x500/text:Third slide">
	      <div class="carousel-caption">
		<h3>Third slide label</h3>
		<p style="color:black">Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
	      </div>      
	    </div>
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
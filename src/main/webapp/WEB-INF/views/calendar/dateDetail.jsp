<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	.imagebox {
		height: 150px;
		overflow: hidden;
	}
	 
	.imagebox > img {
		position: absolute;
		height: 100%;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
</style>

<html>
	<head>
		<title>Untitled</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />

	</head>

	<body class="is-preload">

		<!-- Header -->
			<header id="header" class="alt">
				<!-- Nav -->
					<nav id="nav">
						<ul>
							<li><a href="index.html">Home</a></li>
							<li>
								<a href="#" class="dropdown">Dropdown</a>
								<ul>
									<li><a href="#">Option One</a></li>
									<li><a href="#">Option Two</a></li>
									<li><a href="#">Option Three</a></li>
									<li>
										<a href="#">Submenu</a>
										<ul>
											<li><a href="#">Option One</a></li>
											<li><a href="#">Option Two</a></li>
											<li><a href="#">Option Three</a></li>
											<li><a href="#">Option Four</a></li>
										</ul>
									</li>
								</ul>
							</li>
							<li><a href="generic.html">Generic</a></li>
							<li class="current"><a href="elements.html">Elements</a></li>
						</ul>
					</nav>

				<!-- Logo -->
					<a class="logo" href="index.html">Momentum <span>by Pixelarity</span></a>
					<h1>Elements</h1>
			</header>

		<!-- Main -->
			<div id="main">
				<div class="wrapper">
					<div class="inner">
						<div class="row gtr-200">
							<div class="col-6 col-12-medium">
								<h3>${year}년 ${month+1}월 ${date}일</h3>
								<form method="post" action="/calendar/regist" enctype="multipart/form-data">
									<input type="hidden" value="${year}-${month+1}-${date}" name="caldate">
									<div class="row gtr-uniform">
										<div class="col-12">
											<input type="text" name="title" id="title" value="" placeholder="Title" />
										</div>
										<div class="col-12">
											<textarea name="contents" id="contents" placeholder="Detail" rows="6"></textarea>
										</div>
										<div id="imgdiv">
										</div>
										<div class="col-12">
											<input type="submit" value="Submit Form" class="primary" />
										</div>
									</div>
								</form>					
							</div>
							<div class="col-6 col-12-medium">
								<div class="col-6 col-12-medium">
									<div class="box alt">
										<div class="row gtr-50 gtr-uniform" id="imageSumb">
											<div class="col-12" >
												<a href="javascript:addImage()" class="button fit">add</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		<!--  -->
		</body>
	
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/browser.min.js"></script>
	<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
	<script src="/resources/assets/js/breakpoints.min.js"></script>
	<script src="/resources/assets/js/util.js"></script>
	<script src="/resources/assets/js/main.js"></script>

	<script>
		let cnt = 0;
		
		function addImage(){
			cnt++;
			cur = 'file' + cnt;
			$("#imgdiv").append("<input class='imgfile' type='file' id='file" + cnt + "' name='file" + cnt + "' style='display:none;' />");
			curfile = $('#'+cur);
			$('#' + cur).click();
		}
		
		$(document).on("change", ".imgfile", function(){
			setImageFromFile(this, '#imageSumb');			
		})	
		
		function setImageFromFile(input, expression) {
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		        	$(expression).append("<div id='sumb"+ cnt +"' class='col-4' onclick='javascript:cancel(" + cnt + ")'><span class='image fit imagebox'> <img src='" + e.target.result + "'/> </span></div>");
		        }
		        reader.readAsDataURL(input.files[0]);
		    }
		}
		
		function cancel(count){
			$('#'+ 'file' + count).remove();
			$('#'+ 'sumb' + count).remove();
		}
	</script>
</html>
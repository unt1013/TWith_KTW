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
								<div class="row gtr-uniform">
									<div class="col-12">
										<input type="text" name="title" id="title" value="${data.title}" placeholder="Name"  readonly="readonly"/>
									</div>
									<!-- Break -->
									<div class="col-12">
										<div class ="box">
											<p>${data.contents}</p>
										</div>
									</div>
									<!-- Break -->
									<div class="col-12">
										<a class="button fit" href="/calendar/updateDate?year=${year}&month=${month}&date=${date}&isUpdate=1">Update</a>
									</div>
								</div>
							</div>
							<div class="col-6 col-12-medium">
								<span class="image fit"><img id="sumb" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACoCAMAAABt9SM9AAAAA1BMVEX///+nxBvIAAAAR0lEQVR4nO3BAQEAAACCIP+vbkhAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO8GxYgAAb0jQ/cAAAAASUVORK5CYII=" alt="" /></span>
								<div class="box alt">
									<div class="row gtr-50 gtr-uniform">
										<c:choose>
											<c:when test='${isImg == "0"}'/>
											<c:otherwise>
												<c:forEach var="item" items="${Img}">
													<div class="col-4 ">
														<span class="image fit imagebox ">
															<img class="sumbcontent" src="<c:url value='/resources/images/${item.imgsavename}'/>"/>
														</span>
													</div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		<!-- <c:url value='/app/file/${fundImgList[i].img1}' /> -->
		</body>
	
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/browser.min.js"></script>
	<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
	<script src="/resources/assets/js/breakpoints.min.js"></script>
	<script src="/resources/assets/js/util.js"></script>
	<script src="/resources/assets/js/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> 
	<script>
		$(document).on("click", ".sumbcontent", function(){
			$("#sumb").attr("src", $(this).attr("src"));
		})
	</script>
</html>
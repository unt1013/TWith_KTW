<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html lang="kor">
<head>
	<title>TWith</title>
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
						<li><a href="elements.html">Elements</a></li>
						<li class="current"><a href="/user/login">LOGIN</a></li>
					</ul>
				</nav>

			<!-- Logo -->
				<a class="logo" href="index.html">Trip <span>by TWith</span></a>
				<h1>SIGN IN</h1>
		</header>

	<!-- Main -->
		<div id="main">
			<div class="wrapper">
				<div class="inner">
					<form name="loginform" action="/user/login" method="post" style="text-align: center;">
					<table>
						<tr>
							<td>아이디</td>
							<td><input class="put" type="text" name="userId"
								placeholder="아이디를 입력하세요"></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input class="put" type="password" name="userPw"
								placeholder="비밀번호를 입력하세요"></td>
						</tr>
						<tr>
							<td colspan=2>
								<h4 style="color: red;">회원이 아니라면 회원가입 버튼을 눌러주세요</h4>
							</td>
						</tr>
						<tr>
							<td>
								<input class="btn" type="button" value="LOGIN" onclick="sendit()">
							</td>
							<td><input class="btn" type="button" value="SIGN UP"
								onclick="location.href='/user/join'">
							</td>
						</tr>
					</table>
				</form>
				</div>
			</div>
		</div>

	<!-- Three -->
		<section id="newsletter">
			<div class="wrapper style2 special">
				<div class="inner">
					<header>
						<h2>Sapien mauris blandit?</h2>
						<p>Lorem ipsum dolor mauris, consectetur id ipsum sit amet lorem sed amet consequat.</p>
					</header>
					<form method="post" action="#" class="combined">
						<input type="email" name="email" id="email" placeholder="Your email address" class="invert" />
						<input type="submit" class="special" value="Subscribe" />
					</form>
				</div>
			</div>
		</section>

	<!-- Footer -->
		<section id="footer">
			<div class="wrapper style3">
				<div class="inner">
					<div>
						<header>
							<h3>Ipsum sed tristique</h3>
						</header>
						<p>Nunc et lorem mauris, fringilla in aliquam at, euismod in habitant morbi tristique senectus amet malesuada commodo lorem ipsum dolor amet. Pellentesque leo mauris, consectetur id ipsum sit amet, fergiat. Pellentesque in mi massa.</p>
						<ul class="actions">
							<li><a href="#" class="button">Learn More</a></li>
						</ul>
					</div>
					<div>
						<header>
							<h3>Get in touch</h3>
						</header>
						<div class="contact-icons">
							<ul>
								<li><a href="#" class="icon solid fa-envelope"><span>information@untitled.tld</span></a></li>
								<li><a href="#" class="icon brands fa-twitter"><span>@untitled-tld</span></a></li>
								<li><a href="#" class="icon brands fa-facebook-f"><span>facebook.com/untitled-tld</span></a></li>
								<li><a href="#" class="icon brands fa-linkedin-in"><span>linkedin.com/untitled-tld</span></a></li>
							</ul>
							<ul>
								<li><a href="#" class="icon solid fa-phone"><span>(000) 000-0000</span></a></li>
								<li>
									<div class="icon solid fa-map-marker-alt">
										<address>
											Untitled Incorporated<br />
											1234 Fictional Avenue Suite 5432<br />
											Nashville, TN 00000-0000<br />
											United States
										</address>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="copyright">
					&copy; Untitled Incorporated, All rights reserved. Lorem ipsum dolor sit amet nullam.
				</div>
			</div>
		</section>

</body>
<!-- Scripts -->
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/assets/js/browser.min.js"></script>
<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
<script src="/resources/assets/js/breakpoints.min.js"></script>
<script src="/resources/assets/js/util.js"></script>
<script src="/resources/assets/js/main.js"></script>

<script>
	let frm = document.loginform;
	let idTag = frm.userId;
	let pwTag = frm.userPw;

	function sendit() {
		if (idTag.value == "" || idTag.value == null) {
			alert("아이디를 입력하세요!");
			idTag.focus();
			return false;
		}
		if (pwTag.value == "" || pwTag.value == null) {
			alert("비밀번호를 입력하세요!");
			pwTag.focus();
			return false;
		}
		frm.submit();
	}
</script>
</html>
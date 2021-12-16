<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<title>JBeans</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet"
	href="../resources/assets/css/main.css" />
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
					<a href="/user/login" class="logo"><strong>LOGIN</strong> by
						JBeans</a>
					<ul class="icons">
						<li><a href="#" class="icon brands fa-twitter"><span
								class="label">Twitter</span></a></li>
						<li><a href="#" class="icon brands fa-facebook-f"><span
								class="label">Facebook</span></a></li>
						<li><a href="#" class="icon brands fa-snapchat-ghost"><span
								class="label">Snapchat</span></a></li>
						<li><a href="#" class="icon brands fa-instagram"><span
								class="label">Instagram</span></a></li>
						<li><a href="#" class="icon brands fa-medium-m"><span
								class="label">Medium</span></a></li>
					</ul>
				</header>

				<!-- Banner -->
				<section id="banner">
					<div class="content">
					</div>
				</section>

				<!-- Section -->
				<section>
					<header class="main">
					</header>

					<span class="image main"><img src="../resources/images/pic11.jpg" alt="" /></span>

					<form name="loginform"
						action="${pageContext.request.contextPath}/user/UserLoginOk.us"
						method="post" style="text-align: center;">
						<table>
							<tr>
								<td>아이디</td>
								<td><input class="put" type="text" name="memberId"
									placeholder="아이디를 입력하세요"></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input class="put" type="password" name="memberPw"
									placeholder="비밀번호를 입력하세요"></td>
							</tr>
							<tr>
								<td colspan=2><h4 style="color: red;">회원이 아니라면 회원가입
										버튼을 눌러주세요</h4></td>
							</tr>
							<tr>
								<td><input class="btn" type="button" value="LOGIN"
									onclick="sendit();"></td>
								<td><input class="btn" type="button" value="SIGN UP"
									onclick="location.href='${pageContext.request.contextPath}/src/main/webapp/resources/views/joinview.jsp'">
								</td>
							</tr>
						</table>
					</form>

				</section>

			</div>
		</div>

		<!-- Sidebar -->
		<div id="sidebar">
			<div class="inner">

				<!-- Search -->
				<section id="search" class="alt">
					<form method="post" action="#">
						<input type="text" name="query" id="query" placeholder="Search" />
					</form>
				</section>

				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2>Menu</h2>
					</header>
					<ul>
						<li><a href="${pageContext.request.contextPath}/index.jsp">MAIN</a></li>
						<li><a href="generic.jsp">RECIPE</a></li>
						<li><a href="elements.html">Elements</a></li>
						<li><span class="opener">COMMUNITY</span>
							<ul>
								<li><a
									href="${pageContext.request.contextPath}/board/BoardList.bo">SHARE</a></li>
								<li><a
									href="${pageContext.request.contextPath}/app/board/recipeBoard.jsp">RECIPE</a></li>
							</ul></li>
						<li><a href="#">A</a></li>
						<li><a href="#">B</a></li>
						<li><span class="opener">C</span>
							<ul>
								<li><a href="#">D</a></li>
								<li><a href="#">E</a></li>
								<li><a href="#">F</a></li>
								<li><a href="#">G</a></li>
							</ul></li>
						<li><a href="#">H</a></li>
						<li><a href="#">I</a></li>
						<li><a href="#">J</a></li>
					</ul>
				</nav>

				<!-- Section -->
				<section>
					<header class="major">
						<h2>오늘의 레시피</h2>
					</header>
					<div class="mini-posts">
						<article>
							<a href="#" class="image"><img src="../resources/images/pic07.jpg" alt="" /></a>
							<p>아침</p>
						</article>
						<article>
							<a href="#" class="image"><img src="../resources/images/pic08.jpg" alt="" /></a>
							<p>점심</p>
						</article>
						<article>
							<a href="#" class="image"><img src="../resources/images/pic09.jpg" alt="" /></a>
							<p>저녁</p>
						</article>
					</div>
					<ul class="actions">
						<li><a href="#" class="button">More</a></li>
					</ul>
				</section>

				<!-- Section -->
				<section>
					<header class="major">
						<h2>유저 랭킹</h2>
					</header>
					<p>이재원 | 김채린 | 류원희 | 손승한 | 안소은 | 이승환</p>
					<ul class="contact">
						<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
						<li class="icon solid fa-phone">(000) 000-0000</li>
						<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
							Nashville, TN 00000-0000
						</li>
					</ul>
				</section>

				<!-- Footer -->
				<footer id="footer">
					<p class="copyright">&copy; JBeans. All rights reserved.</p>
				</footer>

			</div>
		</div>

	</div>

	<!-- Scripts -->
	<script src="../resources/assets/js/jquery.min.js"></script>
	<script src="../resources/assets/js/browser.min.js"></script>
	<script src="../resources/assets/js/breakpoints.min.js"></script>
	<script src="../resources/assets/js/util.js"></script>
	<script src="../resources/assets/js/main.js"></script>
</body>
	<script>
		let frm = document.loginform;
		let idTag = frm.memberId;
		let pwTag = frm.memberPw;

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
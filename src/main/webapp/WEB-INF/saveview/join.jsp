<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page import="com.jovait.app.user.dao.UserDTO"%>
<%@ page import="com.jova.app.user.dao.UserDAO"%> --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>JBeans</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../resources/assets/css/main.css" />
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
					<a href="${pageContext.request.contextPath}/index.jsp" class="logo"><strong>SIGN UP</strong> by
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

				<!-- Content -->
				<section>
					<header class="main">
						<h1>SIGN UP</h1>
					</header>

					<form name="joinform"
						action="${pageContext.request.contextPath}/user/UserJoinOk.us"
						method="post">
						<div id="container">
							<!-- <h1 style="text-align: center;">넣을 문구</h1> -->
							<hr>
							<table>
								<tr>
									<td colspan=3><span id="text"
										style="color: red; font-weight: bold;"></span></td>
								</tr>
								<tr>
									<td>아이디</td>
									<td><input type="text" name="memberId"></td>
									<td><input type="button" value="중복체크" onclick="checkId();"></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" name="memberPw"></td>
								</tr>
								<tr>
									<td>비밀번호확인</td>
									<td><input type="password" name="memberPw_re"></td>
								</tr>
								<tr>
									<td>이름</td>
									<td><input type="text" name="memberName"></td>
								</tr>
								<tr>
									<td>휴대폰번호</td>
									<td><input type="text" name="memberPhone"></td>
								</tr>
								<tr>
									<td>E-Mail</td>
									<td><input type="text" name="memberEmail"></td>
								</tr>
								<tr>
									<td>우편번호</td>
									<td><input type="text" name="memberPostCode" id="sample6_postcode" size="7" placeholder="우편번호" onclick="sample6_execDaumPostcode()" readonly></td>
									<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
								</tr>
								<tr>
									<td colspan="2"><input type="text" name="memberAddr" id="sample6_address" placeholder="주소" size="25" readonly></td>
								</tr>
									<tr>
									<td colspan="2"><input type="text" name="memberAddrDetail" id="sample6_detailAddress" size="17" placeholder="상세주소"></td>
									<td><input type="text" name="memberAddrEtc" id="sample6_extraAddress" size="8" placeholder="참고항목" readonly></td>
								</tr>
								<tr>
									<td colspan=3 class="put"><input type="button" value="SIGN UP" onclick="sendit()"></td>
								</tr>
							</table>
						</div>
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
	<script>let contextPath = "${pageContext.request.contextPath}";</script>
</body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="user.js"></script>

</html>
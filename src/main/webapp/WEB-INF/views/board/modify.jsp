<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="/resources/assets/css/main.css" />
</head>
<body class="is-preload">
	<div id="main">
		<div class="wrapper">
			<div class="inner">
				<header class="major">
					<h1 class="home">Board</h1>
					<p>게시글 수정</p>
				</header>
				<a href="/board/list${cri.getListLink()}" class="button primary small">목록 보기</a>
				<br>
				<br>
				<div class="col-12">
					<form method="post" action="/board/modify">
						<input type="hidden" value="${cri.pageNum}" name="pageNum">
						<input type="hidden" value="${cri.amount }" name="amount">
						<div class="col-12">
							<h4>번호</h4>
							<input name="boardnum" type="text" value="${board.boardnum}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<h4>*제목</h4>
							<input name="boardtitle" type="text" value="${board.boardtitle}">
						</div>
						<hr>
						<div class="col-12">
							<h4>*내용</h4>
							<textarea name="boardcontents" rows="10" style="resize:none;">${board.boardcontents}</textarea>
						</div>
						<hr>
						<div class="col-12">
							<h4>작성자</h4>
							<input name="boardwriter" type="text" value="${board.boardwriter}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<input type="submit" value="수정완료" class="primary">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- Scripts -->
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
<script src="/resources/assets/js/browser.min.js"></script>
<script src="/resources/assets/js/breakpoints.min.js"></script>
<script src="/resources/assets/js/util.js"></script>
<script src="/resources/assets/js/main.js"></script>
</html>















<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<title>BOARD</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<style>
	td, th{
		text-align: center !important;
	}
	.small-width{
		display:none;
	}
	.big-width{
	
	}
	select{
		width:15%;
		display:inline;
	}
	#keyword{
		display:inline;
		width:55%;
	}
	@media(max-width : 918px){
		select[name='type']{
			width:80%;
		}
		#keyword{
			width:80%;
		}
		.fa-search{
			width:80%;		
		}
		.big-width{
			display:none;
		}
		.small-width{
			display:block;
		}
	}
</style>
</head>
<body class="is-preload">
	<div id="main">
		<div class="wrapper">
			<div class="inner">
				<header class="major">
					<h1 class="home">Board</h1>
					<p>게시판 목록</p>
				</header>
				<a href="/board/regist${pageMaker.cri.getListLink()}" class="button primary small">글 등록</a>
				<br>
				<br>
				<!-- 게시글 띄우는 테이블 -->
				<div class="table-wrapper">
					<table>
						<thead>
							<tr>
								<th style="width:8%">번호</th>
								<th style="width:40%">제목</th>
								<th style="width:16%">작성자</th>
								<th style="width:18%" class="big-width">작성일</th>
								<th style="width:18%" class="big-width">수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${list != null and list.size()>0}">
									<c:forEach items="${list}" var="board">
									<tr style="text-align:center;">
										<td>${board.boardnum}</td>
										<td><a class="get" href="${board.boardnum}">${board.boardtitle}</a></td>
										<td>${board.boardwriter}</td>
										<td class="big-width">${board.regDate}</td>
										<td class="big-width">${board.updateDate}</td>
									</tr>								
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">
											작성된 게시글이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>							
						</tbody>
					</table>
				</div>
				
				<form action="/board/list" id="searchForm" method="get">
					<div class="col-12" style="text-align:center;">
						<select name="type">
							<option value="">검색</option>
							<option value="T">제목</option>
							<option value="C">내용</option>
							<option value="W">작성자</option>
							<option value="TC">제목 또는 내용</option>
							<option value="TW">제목 또는 작성자</option>
							<option value="TCW">제목 또는 내용 또는 작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword">
						<a href="#" class="button primary icon solid fa-search">검색</a>						
					</div>
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				</form>
				<!-- 페이징 처리 -->
				<div class="big-width" style="text-align: center;">
					<c:if test="${pageMaker.prev}">
						<a class="changePage" href="${pageMaker.startPage - 1}"><code>&lt;</code></a>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="i">
						<c:choose>
							<c:when test="${pageMaker.cri.pageNum == i}">
								<code>${i}</code>
							</c:when>
							<c:otherwise>
								<!-- localhost:9090/board/list?pageNum=${i}&amount=${pageMaker.cri.amount} -->
								<a class="changePage" href="${i}"><code>${i}</code></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<a class="changePage" href="${pageMaker.endPage + 1}"><code>&gt;</code></a>				
					</c:if>
				</div>
				<div class="small-width" style="text-align: center;">
					<c:if test="${pageMaker.cri.pageNum > 1}">
						<a class="changePage" href="${pageMaker.cri.pageNum - 1}"><code>&lt;</code></a>
					</c:if>
					<code>${pageMaker.cri.pageNum}</code>
					<c:if test="${pageMaker.cri.pageNum != pageMaker.realEnd }">
						<a class="changePage" href="${pageMaker.cri.pageNum + 1}"><code>&gt;</code></a>				
					</c:if>
				</div>
				<form id="pageForm" name="pageForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type="hidden" name="type" value="${pageMaker.cri.type }">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
				</form>
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
<script>
	let frm = $("#pageForm")
	let searchForm = $("#searchForm");
	$(".changePage").on("click",function(e){
		//a태그의 동작을 막기
		e.preventDefault();
		//해당 form 안에서 name이 pageNum인 태그 찾고 그 value를 바꿔준다.
		//$(this) : 현재 눌린 a태그
		//.attr("href") : 그 태그의 href속성에 써져있는것
		frm.find("input[name='pageNum']").val($(this).attr("href"));
		frm.submit();
	})
	$(".get").on("click",function(e){
		e.preventDefault();
		//123번 게시글을 누른 경우
		//<input type='hidden' name='boardnum' value='123'>
		frm.append("<input type='hidden' name='boardnum' value='"+$(this).attr("href")+"'>")
		frm.attr("action","/board/get")
		frm.submit();
	})
	$("#searchForm a").on("click",function(e){
		e.preventDefault();
		
		if(!searchForm.find("option:selected").val()){
			alert("검색 기준을 선택하세요.");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();
		
	})
	
	
	
	
	
	result = "${result}";
	$(document).ready(
		function(){
			if(result == '' || history.state){
				return;
			}
			if(parseInt(result) > 0){
				alert("게시글 "+parseInt(result)+"번이 등록되었습니다.");
			}
			history.replaceState({},null,null);
		}		
	
	)
	
</script>
</html>




















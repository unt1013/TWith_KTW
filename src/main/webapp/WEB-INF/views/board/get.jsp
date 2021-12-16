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
					<p>게시글 상세보기</p>
				</header>
				<a href="/board/list${cri.getListLink()}" class="button primary small">목록 보기</a>
				<br>
				<br>
				<div class="col-12">
					<form method="post" action="/board/remove">
						<input type="hidden" value="${cri.pageNum}" name="pageNum">
						<input type="hidden" value="${cri.amount }" name="amount">
						<div class="col-12">
							<h4>번호</h4>
							<input name="boardnum" type="text" value="${board.boardnum}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<h4>제목</h4>
							<input name="boardtitle" type="text" value="${board.boardtitle}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<h4>내용</h4>
							<textarea name="boardcontents" rows="10" style="resize:none;" readonly>${board.boardcontents}</textarea>
						</div>
						<hr>
						<div class="col-12">
							<h4>작성자</h4>
							<input name="boardwriter" type="text" value="${board.boardwriter}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<input type="button" value="수정" class="primary" onclick="location.href='/board/modify${cri.getListLink()}&boardnum=${board.boardnum}'">
							<input type="submit" value="삭제" class="primary">
						</div>
					</form>
					<hr>
					<h3 style="text-align:center;">댓 글</h3>
					<a href="#" class="button primary regist">댓글 등록</a>
					<br>
					<br>
					<!-- style="display:none" -->
					<div class="replyForm row" style="display:none; justify-content: center; ">
						<div style="width:15%;">
							<h4>작성자</h4>
							<input name="replywriter" placeholder="Writer" type="text">						
						</div>
						<div style="width:65%; ">
							<h4>내용</h4>
							<textarea name="replycontents" rows="2" style="resize:none;" placeholder="Contents"></textarea>
						</div>
						<div style="width:10%; margin-left:1%" class="row">
							<h4 style="margin-bottom:1.3rem !important;">&nbsp;</h4>
							<a href="#" style="margin-bottom:0.7rem;" class="button primary small finish">등록</a>
							<a href="#" class="button primary small cancel">취소</a>
						</div>
					</div>
					<!-- 댓글 띄우는 ul -->
					<ul class="alt replies"></ul>
					<!-- 댓글 페이징 처리할 div -->
					<div class="page" style="text-align:center">
					</div>
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
<script src="/resources/assets/js/reply.js"></script>
<script>
	/* 댓글 쓰는 폼 띄우는 코드 */
	$(".regist").on("click",function(e){
		e.preventDefault();
		$(".replyForm").show();
		$(this).hide();
	})
	
	/* 댓글 작성중 취소버튼 눌렀을 때의 코드 */
	$(".cancel").on("click",function(e){
		e.preventDefault();
		$(".replyForm").hide();
		$(".regist").show();
	})
	
	/* 댓글 등록하기 버튼 눌렀을 때의 코드 */
	//$("선택자").on("click",함수) : 앞에있는 선택자의 요소가 "click"되었을 때 두번째 매개변수로 넘겨주는 함수를 호출한다.  
	$(".finish").on("click",function(e){
		//어떤 게시글의 댓글인지
		let boardnum = "${board.boardnum}";
		//누가 썼는지
		let replywriter = $("input[name='replywriter']").val();
		//어떤 내용인지
		let replycontents = $("textarea[name='replycontents']").val();
		//Ajax 코드는 reply.js에 모듈화 시켜놓았다. 그 모듈화된 파일에 있는 replyService 객체 이용
		//replyService.add(데이터객체,성공시 호출할 함수,실패시 호출할 함수)
		//흐름이 reply.js에 있는 add로 흐름 이동
		replyService.add(
			//{boardnum:위의boardnum변수의값, replywriter:위의replywriter변수의값, replycontents:위의replycontents변수의값}
			{boardnum:boardnum,replywriter:replywriter,replycontents:replycontents},
			//성공시 호출할 함수
			function(result){
				alert("등록 완료");
			},
			//실패시 호출할 함수
			function(result){
				alert("등록 실패");
			}
		);
		//DOM으로 뷰단 수정하는 코드로 바꾸기
		location.reload();
	})
	
	/* 댓글 목록과 페이징처리 띄워주는 코드 */
	//$(document).ready(함수) : 문서가 준비 완료 되었다면 넘겨주는 함수 호출
	$(document).ready(
		function(){
			//어떤 게시글의 댓글들을 불러와야 하는지
			let boardnum = "${board.boardnum}";
			//댓글 목록 띄워줄 ul태그
			let replies = $(".replies");
			//현재 이 게시글에서 보여주고 있는 댓글의 페이지
			let pageNum = 1;
			//댓글 페이징 처리를 위한 div태그
			let pagediv = $(".page");
	
			//1페이지의 댓글 불러오는 함수
			showList(1);
			
			function showList(page){
				//매개변수 page : 현재 띄워주어야 할 댓글의 페이지를 받아온다.
				//replyService.getList(객체, 성공시 호출할 함수, 실패시 호출할 함수) 사용
				//흐름이 reply.js에 있는 getList로 이동
				replyService.getList(
					//게시글번호, 띄워야할페이지 정보를 가지고 있는 객체
					{ boardnum : boardnum, page : page || 1 },
					
					function(replyCnt,list){
						if(list == null || list.length == 0){
							//DB에서 검색해온 댓글목록이 없을 경우에는
							//댓글 목록을 띄울 ul태그 안에 "댓글이 없습니다." 문자열 넣기
							replies.html("<li>댓글이 없습니다.</li>");
							return;
						}
						//댓글 목록 DOM으로 띄우기
						let str = "";
						/* 
							<li style='clear: both;'>
							<div style="display:inline;float:left;">
								<strong>durian</strong>
								<p>댓글 테스트4</p>
							</div>
							<div style='text-align:right'>
								<strong>2021-09-14 20:33:42</strong><br>
								<a href='#'>수정</a>
								<a href='#'>삭제</a>
							</div>
						</li>
						
						*/
						//for문을 댓글목록의 길이만큼 반복하면서
						for(let i=0, len = list.length; i<len; i++){
							//댓글 목록 띄울 ul태그 안에 들어갈 html 요소 등을 댓글 한개마다 달아준다.
							//비어있는 str문자열에 연결로 이어준다.
							//li,div 여는태그
							str += "<li style='clear:both'><div style='display:inline;float:left;'>";
							//<strong>작성자</strong>
							str += "<strong>" + list[i].replywriter+"</strong>"
							//<p class='reply댓글번호'>댓글내용</p></div>
							str += "<p class='reply" + list[i].replynum + "'>"+list[i].replycontents+"</p></div>"
							//<div><strong>
							str += "<div style='text-align:right;'><strong>"
							//시간 포매팅 데이터 </strong>
							//시간 포매팅 때 displayTime(댓글의 등록시간) 호출 : 흐름 이동
							str += replyService.displayTime(list[i].regdate) + "</strong>";
							//<br><a>수정</a>  <a>삭제</a>
							str += "<br><a href='#'>수정</a>&nbsp;&nbsp;"
							str += "<a href='#'>삭제</a></div></li>"
						}
						//ul태그 안에 위의 for문에서 연결누적된 str 써주기
						replies.html(str);
						//페이징 처리하는 함수 호출하기(전체 개수 넘기면서)
						showReplyPage(replyCnt);
					}
				);
			}
			//1 2 3 4 5 6 7 8 9 10 >
			function showReplyPage(replyCnt){
				let endPage = Math.ceil(pageNum/10.0)*10;
				let startPage = endPage-9;
				
				let prev = startPage != 1;
				let next = false;
				
				if(endPage*5>=replyCnt){
					endPage = Math.ceil(replyCnt/5.0);
				}
				if(endPage*5 < replyCnt){
					next = true;
				}
				//핸드폰 환경 : < 5 >
				//컴퓨터 환경 : 1 2 3 4 5 6 7 8 9 10 >
				let str = "";
				if(matchMedia("screen and (max-width:918px)").matches){
					//핸드폰 환경
					if(pageNum > 1){
						str += "<a class='changePage' href='"+(pageNum-1)+"'><code>&lt;</code></a>";
					}
					str += "<code>" + pageNum + "</code>"
					if(pageNum != endPage){
						str += "<a class='changePage' href='"+(pageNum+1)+"'><code>&gt;</code></a>";
					}
				}else{
					//컴퓨터 환경
					if(prev){
						str += "<a class='changePage' href='"+(startPage-1)+"'><code>&lt;</code></a>";
					}
					for(let i=startPage; i<=endPage; i++){
						if(i == pageNum){
							str += "<code>"+i+"</code>"
						}else{
							str += "<a class='changePage' href='"+ i +"'><code>"+i+"</code></a>"
						}
					}
					if(next){
						str += "<a class='changePage' href='"+ (endPage+1) +"'><code>&gt;</code></a>"
					}
				}
				pagediv.html(str);
				
				$(".changePage").on("click",function(e){
					e.preventDefault();
					let target = $(this).attr("href");//"4"
					pageNum = parseInt(target); // 4
					showList(pageNum);
				})
			}
		}		
	)
</script>
</html>















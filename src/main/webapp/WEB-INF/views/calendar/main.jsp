<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title>Untitled</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
	</head>

	<style>
	th, td {
 		text-align: center !important;
	}
	
	</style>
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

				<!-- Elements -->
						<div class="row gtr-200">
							<div class="col-6 col-12-medium">
								<!-- Table -->
								
								<div class="col-12-medium" style="text-align: center;">
									<h3 id="dateText">
										<a href="javascript:changeMonth(-1)"><code>&lt;</code></a> 
										${data.getYear()}년 ${data.getMonth() + 1}월 
										<a href="javascript:changeMonth(1)"><code>&gt;</code></a>
										<input type="hidden" value = "${data.getYear()}" name="year">
										<input type="hidden" value = "${data.getMonth()}" name="month">
									</h3>
								</div>
									<div class="table-wrapper">
										<table class="alt">
											<thead>
												<tr>
													<th>일</th>
													<th>월</th>
													<th>화</th>
													<th>수</th>
													<th>목</th>
													<th>금</th>
													<th>토</th>
												</tr>
											</thead>
											<tbody id="calbody">
												<c:set var="row" value="${(data.total + data.startday)/7 + 1}"/>
												<c:if test="${(data.total+data.startday)%7 < 2}">
													<c:set var="row" value="${row - 1}" />
												</c:if>
												<c:set var="days" value="1"/>
												<c:forEach begin="1" end="${row}">
													<tr>
														<c:forEach begin="1" end="7">
															<c:choose>
																<c:when test="${days < data.startday}">
																	<td></td>
																	<c:set var="days" value="${days+1}" />
																</c:when>
																<c:when test="${days >= data.total + data.startday}">
																	<td></td>
																	<c:set var="days" value="${days+1}" />
																</c:when>
																<c:otherwise>
																	<td><a href="/calendar/date?year=${data.getYear()}&month=${data.getMonth()}&date=${days-data.startday + 1}">${days-data.startday + 1}</a></td>		
																	<c:set var="days" value="${days+1}" />											
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								
							</div>
							<div class="col-6 col-12-medium" style="text-align: center; ">
								<h3 id="schedule">
									<a href="javascript:changeMonth(-1)"><code>&lt;</code></a> 
									일정 
									<a href="javascript:changeMonth(1)"><code>&gt;</code></a>
									<input type="hidden" value = "${data.getYear()}" name="year">
									<input type="hidden" value = "${data.getMonth()}" name="month">
								</h3>
								<ul class="alt">
									<li>Dolor pulvinar amet etiam.</li>
									<li>Sagittis adipiscing lorem eleifend.</li>
									<li>Felis enim feugiat viverra.</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- Scripts -->
			<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>

			<script>
				function changeMonth(num){
					var month = $("input[name='month']");
					var year = $("input[name='year']");
					
					month.val(parseInt(month.val())+parseInt(num));
					if(parseInt(month.val()) < 0) {
						month.val(11);
						year.val(parseInt(year.val())-1);
					}
					else if(month.val()>11){
						month.val(0);
						year.val(parseInt(year.val())+1);
					}
					var ajax_url = "/calendar/pageMove?year="+ year.val() +"&month=" + month.val();
					$.ajax({
						url : ajax_url,
						type : 'GET',
						dataType : 'text',
						success : function(a){
							var arr_datas = a.split('%');
							var total = arr_datas[0];
							var startday = arr_datas[1];
							var newyear = arr_datas[2];
							var newmonth = arr_datas[3];
							updateList(total, startday, newyear, newmonth);
						},
						error : function() {
							console.log("ajax실패");
						}
					})
				}
				
				function updateList(total, startday, year, month){
					var result = "";
					
					var numtotal = parseInt(total);
					var numstart = parseInt(startday);
					var numyear = parseInt(year);
					var month = parseInt(month);
					
					
					var row = (numtotal + numstart)/7 + 1;
					if((numtotal + numstart)%7<2) { row -= 1; }
					var days = 1;
					for(var i = 1; i <= row; i++){
						result+="<tr>";
						for(var j = 0; j < 7; j++){
							if(days < numstart || days >= numtotal + numstart){
								result += "<td></td>";
								days+=1;
							}else{
								result += '<td><a href="'+ 
									'/calendar/date?year='+ year + '&month=' + month + '&date=' + (days - numstart + 1) +'">'+ 
									(days - numstart + 1) +'</a></td>';
								days+=1;
							}
						}
						result+="</tr>";
					}
					$("#calbody").html(result);
					
					result = '<a href="javascript:changeMonth(-1)"><code>&lt;</code></a>' +
					year + "년 " + (month + 1) + "월" + 
					'<a href="javascript:changeMonth(1)"><code>&gt;</code></a>'+
					'<input type="hidden" value = "' + year + '" name="year">' +
					'<input type="hidden" value = "' + month +'" name="month">';
					$("#dateText").html(result);
				}
			</script>
			<script>
			
			</script>
	</body>
</html>
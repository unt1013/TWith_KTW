/**
	reply 관리할 module
*/

/*
function create(){
	return {};
}
let replyService = create();
*/
/*
function a(){
	alert("하이!");
} 
function b(f){
	f(); //a();
}
b(a)
 */


//		replyService  mapper
//javascript ---> JAVA ---> DB
let replyService = (function(){
	//댓글 등록
	//reply --> {boardnum:"3",replywriter:"apple",..}
	//callback --> alert("등록 성공") 하는 함수
	//error --> alert("등록 실패") 하는 함수
	function add(reply,callback,error){
		console.log("add reply......");
		//callback,error는 외부에서 전달받을 함수이다.
		//함수의 파라미터 개수를 일치시킬 필요가 없기 때문에
		//사용시 callback이나 error와 같은 것은 상황에 따라 작성한다.
		$.ajax(
			{
				//전송방식
				type:"POST",
				//전송할 목적지
				url:"/reply/regist",
				//데이터
				data:JSON.stringify(reply),
				//데이터의 타입
				contentType:"application/json; charset=utf-8",
				//ajax 성공시 호출할 함수
				success:function(result,status,xhr){
					//매개변수로 넘겨받은 성공했을 때의 함수가 있다면
					if(callback){
						console.log("regist result :",result);
						//그 함수 호출해줘
						callback(result);
					}
				},
				//ajax 실패시 호출할 함수
				error:function(xhr,status,e){
					//매개변수로 넘겨받은 실패했을 때의 함수가 있다면
					if(error){
						//그 함수 호출해줘
						error(e);
					}
				}
			}
		);
		//add() 호출 끝
	}
	//댓글 목록
	//data --> {boardnum:2323, page:2}
	function getList(data,callback,error){
		//2323
		let boardnum = data.boardnum;
		//2
		let page = data.page;
		// /reply/pages/2323/2.json
		$.getJSON(
			"/reply/pages/"+boardnum+"/"+page+".json", //ReplyController로 이동
			//두번쨰로 넘겨주는 함수의 매개변수는 getJSON으로 받아온 JSON을 담는다.
			function(data){
				//data : ReplyPageDTO를 JSON으로 바꾼것 
				if(callback){
					//성공시 호출할 함수를 넘겨 받았다면 그거 호출!
					//Ajax 요청으로 받아온 데이터의 replyCnt와 list를 넘겨주면서 호출한다.
					//흐름이 get.jsp의 160번째줄로 다시 이동
					callback(data.replyCnt,data.list);
				}
			}
		).fail(
			function(xhr,status,e){
				if(error){
					error(e);
				}
			}
		)
	}
	//댓글 삭제
	function remove(){
		
	}
	//댓글 수정
	function update(){
		
	}
	//댓글 조회
	function get(){
		
	}
	//시간 처리(당일은 시:분:초 / 지난날은 년/월/일)
	function displayTime(time){
		//time : 댓글마다 등록된 시간데이터
		//현재시간 정보를 담은 객체
		let now = new Date();
		//넘겨준 시간데이터의 정보를 담은 객체
		let dateObj = new Date(time);
		//데이트객체.getTime() : 현재 시간 정보를 밀리초로 변환
		
		let gap = now.getTime() - dateObj.getTime();
		
		//밀리초단위로 변환해서 뽑아냈고 그 차이를 구했기 때문에 1000을 곱해주어야 초단위로 변경
		if(gap < 1000*24*60*60){
			//gap이 하루보다 작다면
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			
			//시분초가 한자리수일 경우에는 앞에 0을 붙여주어야 하므로
			return (hh>9?'':'0')+hh+":" + (mi>9?'':'0')+mi+":"+(ss>9?'':'0')+ss;
		}else{
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth()+1;
			let dd = dateObj.getDate();
			
			//월일이 한자리수일 경우에는 앞에 0을 붙여주어야 하므로
			return yy+"-"+(mm>9?'':'0')+mm+"-"+(dd>9?'':'0')+dd;
		}
	}
	
	//콜백함수
	//외부에서는 replyService.키값(); 형식으로 사용하며
	//Ajax 호출이 감추어져 있기 때문에 코드가 더 깔끔해진다.
	return {add:add, getList:getList, remove:remove, update:update, get:get, displayTime:displayTime};
})();











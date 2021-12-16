package com.twith.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}
)
@Log4j
@WebAppConfiguration	//Servlet의 ServletContext를 이용하기 위해서
public class BoardControllerTests {
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext wac;
	
	//가짜 MVC
	//마치 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다.
	private MockMvc mockMvc;
	
	@Before//org.junit
	//@Before : 적용된 메소드를 모든 테스트 전에 매번 한번씩 실행한다.
	public void setup() {
		//			건축가		받아온 wac로 헬멧,로프,... 세팅	건축
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
//	@Test
//	public void listTest() throws Exception{
////		log.info(
////							//MockMvc에 보낼 요청 제작자	get방식으로	요청명
////			mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))//mockMvc.perform(요청)
////			.andReturn()	//반환된 결과 : 응답(뷰, 모델, ..)
////			.getModelAndView() //응답에서 모델과 뷰를 받아오기
////			.getModelMap()	//모델에 어떤 데이터가 있는지 Map형식으로 확인
////		);
//		log.info(
//			mockMvc.perform(
//				MockMvcRequestBuilders.get("/board/list")
//				.param("pageNum", "2")	
//				.param("amount","15")
//			)
//			.andReturn()
//			.getModelAndView()
//			.getModelMap()
//		);
//	}
	
//	@Test
//	public void getTest() throws Exception{
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
//				.param("pageNum", "3")	
//				.param("amount", "10")
//				.param("boardnum", "1000")
//			)
//			.andReturn()
//			.getModelAndView()
////			.getModelMap()
//			.getViewName() //응답으로 보여줄 페이지 이름
//		);
//		
////		ModelAndView mav = mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
////				.param("pageNum", "3")	
////				.param("amount", "10")
////				.param("boardnum", "1000")
////			)
////			.andReturn()
////			.getModelAndView();
////		log.info(mav.getViewName() + " : "+mav.getModelMap());
//	}
	
//	@Test
//	public void removeTest() throws Exception{
//		MvcResult result = mockMvc.perform(
//				MockMvcRequestBuilders.post("/board/remove")
//				.param("pageNum", "3")
//				.param("amount", "10")
//				.param("boardnum", "2305")
//			)
//			.andReturn();
//		
//		log.info(
//			result
//			.getModelAndView()
//			.getViewName()
//		);
//		//getFlashMap() : FlashAttribute로 세팅한 데이터 확인
//		log.info(result.getFlashMap());
//	}
	@Test
	public void modifyTest() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
			.param("boardnum", "1")
			.param("boardtitle", "수정 테스트3")
			.param("boardcontents", "수정 테스트3")
			.param("boardwriter", "admin3")
			.param("pageNum", "3")
			.param("amount", "10")
		)
		.andReturn();
		
		log.info(result.getModelAndView().getViewName());
		log.info(result.getFlashMap());
	}
}
























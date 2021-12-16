package com.twith.controller;

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

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}
)
@Log4j
@WebAppConfiguration	//Servlet의 ServletContext를 이용하기 위해서
public class UserControllerTests {
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	public void setup() {
		//			건축가		받아온 wac로 헬멧,로프,... 세팅	건축
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Test
	public void checkIdTest() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/user/checkId")
			.param("userId", "apple")
		)
		.andReturn();
		
		log.info(result.getModelAndView().getViewName());
		log.info(result.getFlashMap());
	}
}

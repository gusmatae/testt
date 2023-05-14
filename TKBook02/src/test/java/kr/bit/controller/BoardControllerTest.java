package kr.bit.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.bit.mapper.DataSourceTest;
import lombok.extern.log4j.Log4j;

@Log4j // lombok에 있는 api
@RunWith(SpringJUnit4ClassRunner.class)//spring test에서는 우리 프로젝트를 spring 컨테이너에서 동작시키게 하는 방법
@WebAppConfiguration //서블릿 컨테이너가 메모리에 만들어진다 스프링 컨테이너를 쓰기위한 어노테이션
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class BoardControllerTest {

	@Autowired
	private WebApplicationContext ctx; //Spring Container
	
	private MockMvc mockMvc;//스프링 컨테이너에 Mock(가상)의 mvc프레임워크처럼 동작시켜 줄 수 있는 클래스
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView());
		//퍼폼에 의해서 보드 리스트를 요청하게되면 그쪽 컨트롤러가 리턴을 해주게 되는데
		//모델과 뷰를 리턴해서 info
	}
}

package kr.bit.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.CriteriaVO;
import kr.bit.mapper.BoardMapperTest;
import lombok.extern.log4j.Log4j;

@Log4j // lombok에 있는 api
@RunWith(SpringJUnit4ClassRunner.class)//spring test에서는 우리 프로젝트를 spring 컨테이너에서 동작시키게 하는 방법
									   //러너가 아래를 참조해서 root-context가 컨테이너에 올라갔기 때문에 오토와이어드 가능한 것 같다.
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {
	
	@Autowired
	BoardService boardService;
	
	@Test
	public void testGetList() {
		// List<Board>
		CriteriaVO cri = new CriteriaVO();
		cri.setPage(1); //<< 숫자 변경해가면서 테스트 해볼 수 있겠음.
		cri.setPerPageNum(10);
		boardService.getList(cri).forEach(vo->log.info(vo));
	}
}

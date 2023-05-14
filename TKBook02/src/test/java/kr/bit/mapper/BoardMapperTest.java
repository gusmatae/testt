package kr.bit.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.BoardVO;
import lombok.extern.log4j.Log4j;

@Log4j // lombok에 있는 api
@RunWith(SpringJUnit4ClassRunner.class)//spring test에서는 우리 프로젝트를 spring 컨테이너에서 동작시키게 하는 방법
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTest {

		@Autowired
		BoardMapper boardMapper;
		
		@Test
		/*
		public void testGetList() {
			List<BoardVO> list = boardMapper.getList();
			for(BoardVO vo : list) {
				//System.out.println(vo);
				log.info(vo); //로그.info로 찍으면 디테일하게 나옴
			}
			
		}
		*/
		public void testInsert() {
			BoardVO vo = new BoardVO();
			vo.setMemID("bit02");
			vo.setTitle("B");
			vo.setContent("새로작성한 글");
			vo.setWriter("김태경");
			
			boardMapper.insertSelectKey(vo);
			log.info(vo);
		}
		
}

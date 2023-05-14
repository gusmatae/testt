package kr.bit.mapper;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j // lombok에 있는 api
@RunWith(SpringJUnit4ClassRunner.class)//spring test에서는 우리 프로젝트를 spring 컨테이너에서 동작시키게 하는 방법
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DataSourceTest {
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try(Connection conn = dataSource.getConnection()) {
			log.info(conn); //Log는 log4j에 있는 객체
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.AuthVO;
import kr.board.entity.Board;
import kr.board.entity.Book;
import kr.board.entity.Member;
import kr.board.entity.Order;

//-MyBatis API DAO라고 볼 수 있음
@Mapper
public interface BookMapper {

	public List<Book> getBookLists();
	public void bookProfileInsert(Book mvo);
	public void bookDelete(String bkImage);
	public void orderRegister(Order order);
	public List<Order> orderContent();
}
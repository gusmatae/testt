package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;

//-MyBatis API DAO라고 볼 수 있음
@Mapper
public interface BoardMapper {
	public List<Board> getLists(); //전체리스트(추상메서드)
	public void boardInsert(Board vo);
	public Board boardContent(int idx);
	public void boardDelete(int idx);
	public void boardUpdate(Board vo);
	
	@Update("update myboard set count=count+1 where idx=#{idx}")
	public void boardCount(int idx);
}
 
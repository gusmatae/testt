package kr.bit.mapper;

import java.util.List;

import kr.bit.entity.BoardVO;
import kr.bit.entity.CriteriaVO;
import kr.bit.entity.MemberVO;

//@mapper 생략 가능
public interface BoardMapper { // @ or XML
	public List<BoardVO> getList(CriteriaVO cri);
	public void insert(BoardVO vo);
	public void insertSelectKey(BoardVO vo);
	public MemberVO login(MemberVO vo);
	public BoardVO read(int idx);
	public void update(BoardVO vo);
	public void delete(int idx);
	public void replySeqUpdate(BoardVO parent);//부모글의 정보라서 parent라고 보기 좋게 적음
	public void replyInsert(BoardVO vo);
	public int totalCount(CriteriaVO cri);
	public void countUpdate(int idx);
	public void join(MemberVO vo);
}

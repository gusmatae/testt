package kr.bit.service;

import java.util.List;

import kr.bit.entity.BoardVO;
import kr.bit.entity.CriteriaVO;
import kr.bit.entity.MemberVO;

public interface BoardService {

	public List<BoardVO> getList(CriteriaVO cri);
	public MemberVO login(MemberVO vo);
	public void register(BoardVO vo);
	public BoardVO get(int idx);
	public void modify(BoardVO vo);
	public void remove(int idx);
	public void replyProcess(BoardVO vo);
	public int totalCount(CriteriaVO cri);
	public void join(MemberVO vo);
}

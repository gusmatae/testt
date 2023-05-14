package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.BoardVO;
import kr.bit.entity.CriteriaVO;
import kr.bit.entity.MemberVO;
import kr.bit.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> getList(CriteriaVO cri) {
		List<BoardVO> list = boardMapper.getList(cri);
		return list;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		MemberVO mvo= boardMapper.login(vo);
		return mvo;
	}

	@Override
	public void register(BoardVO vo) {
		boardMapper.insertSelectKey(vo);
	}

	@Override
	public BoardVO get(int idx) {
		BoardVO vo = boardMapper.read(idx);
		boardMapper.countUpdate(idx);
		return vo;
	}

	@Override
	public void modify(BoardVO vo) {
		boardMapper.update(vo);
	}

	@Override
	public void remove(int idx) {
		boardMapper.delete(idx);
	}

	@Override
	public void replyProcess(BoardVO vo) {
		// 답글만들기
		// 1. 부모글(원글)의 정보를 가져오기(vo->idx)
		BoardVO parent = boardMapper.read(vo.getIdx());
		//2. 부모글의 boardGroup의 값을->답글(vo)정보에 저장하기
		vo.setBoardGroup(parent.getBoardGroup());
		//3. 부모글의 boardSequence의 값을 1을 더해서 -> 답글(vo)정보에 저장하기
		vo.setBoardSequence(parent.getBoardSequence()+1);
		//4. 부모글의 boardLevel의 값을 1 더해서 -> 답글(vo)정보에 저장하기
		vo.setBoardLevel(parent.getBoardLevel()+1);
		//5. 같은 boardGroup에 있는 글 중에서 부모글의 boardSequence보다 큰 값들을 모두 1씩 업데이트하기
		boardMapper.replySeqUpdate(parent);
		//6. 답글(vo)을 저장하기
		boardMapper.replyInsert(vo);
	}

	@Override
	public int totalCount(CriteriaVO cri) {
		return boardMapper.totalCount(cri);
	}

	@Override
	public void join(MemberVO vo) {
		boardMapper.join(vo);
	}

}

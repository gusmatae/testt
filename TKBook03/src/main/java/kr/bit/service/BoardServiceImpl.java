package kr.bit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardRepository boardRepository;
	
	@Override
	public List<Board> getList() {
		List<Board> list = boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(Long idx) {
		Optional<Board> vo = boardRepository.findById(idx);//JPA 같은 경우에 읽어온 데이터가 있는지 유무를 검증하기 위해 Optional
		return vo.get();
	}

	@Override
	public void delete(Long idx) {
		boardRepository.deleteById(idx);
	}

	@Override
	public void update(Board vo) {
		boardRepository.save(vo); //insert //save()는 vo에 idx가 담아있지 않으면 insert 담아져 있으면 update가 된다
	}

}

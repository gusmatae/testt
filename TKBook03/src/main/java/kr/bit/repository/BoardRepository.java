package kr.bit.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Board;

@Repository //생략 가능 //메모리에 올라와야해서 스캔대상 repository 안에 있는 인터페이스들만 자동으로 올리기 때문에 생략 가능한 것임
public interface BoardRepository extends JpaRepository<Board, Long>{//PK의 {Board, 타입정보}

	
	
	//public List<Board> findAll();
	// -> select * from Board
	//public Board findById(long idx);
	// -> select * from Board where idx=#{  }
	//프라이머리 키 이외의 조건절을 걸고싶을 때
	public Board findBoardByWriter(String writer); // find + 엔티티 이름 + By + 변수 이름
	// -> select * from Board where writer = #{writer}
	
	
}

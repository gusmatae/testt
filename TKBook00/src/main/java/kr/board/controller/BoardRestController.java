package kr.board.controller;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

//Ajax통신을 사용할 때 쓰는 컨트롤러 responsebody(joson 응답하겠다라는 신호) 묵시적으로 들어가있으므로 생략 //레스트인 /board를 타고오고
@RequestMapping("/board") //컨트롤러 자체에 requestMapping을 걸수가 있음 // board라는 것으로 오면 아래 BoardRestController가 다 처리하겠다
@RestController
public class BoardRestController {

	@Autowired
	BoardMapper boardmapper;

	@GetMapping("/all") //리스트
	public  List<Board> boardList(){ //"@ResponseBody 객체를 json 데이터 포맷으로 변환(API)해서 응답하겠다" 정의
		List<Board> list = boardmapper.getLists();
		return list; // JSON 데이터 형식으로 변환(API)해서 리턴하겠다.
	}
	@PostMapping("/new") //전송
	public  void boardInsert(Board vo) {
		boardmapper.boardInsert(vo); //등록 성공
	}
	@DeleteMapping("/{idx}") //삭제
	public  void boardDelete(@PathVariable("idx") int idx) {
		boardmapper.boardDelete(idx);
	}
	@PutMapping("/update") //수정
	public  void boardUpdate(@RequestBody Board vo) { //json으로 넘어온 데이터를 받으려면 @requestBody
		boardmapper.boardUpdate(vo);
	}
	@GetMapping("/{idx}") //상세보기
	public  Board boardContent(@PathVariable("idx") int idx) {
		Board vo = boardmapper.boardContent(idx); // vo->Json으로 변환되서 내려가겠죠
		return vo;
	}
	@PutMapping("/count/{idx}") //조회수
	public  Board boardCount(@PathVariable("idx") int idx) {
		boardmapper.boardCount(idx);
		Board vo = boardContent(idx); //수정된 조회 수가 들어있음. 번호는 이미 jsp에 상위 인수로 있음
		return vo;
	}
}
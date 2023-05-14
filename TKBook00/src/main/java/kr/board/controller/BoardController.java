package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller //알바생(Controller, Component)이라는 표식 scan
public class BoardController {
		
		/*
		@Autowired
		BoardMapper boardmapper;
		*/
		
		@RequestMapping("/boardMain.do")
		public String main() {
			return "board/main";
		}
		
	/*	@RequestMapping("/boardList.do")
		public @ResponseBody List<Board> boardList(){ //"@ResponseBody 객체를 json 데이터 포맷으로 변환(API)해서 응답하겠다" 정의
			List<Board> list = boardmapper.getLists();
			return list; // JSON 데이터 형식으로 변환(API)해서 리턴하겠다.
		}
		@RequestMapping("/boardInsert.do")
		public @ResponseBody void boardInsert(Board vo) {
			boardmapper.boardInsert(vo); //등록 성공
		}
		
		@RequestMapping("/boardDelete.do")
		public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {
			boardmapper.boardDelete(idx);
		}
		@RequestMapping("/boardUpdate.do")
		public @ResponseBody void boardUpdate(Board vo) {
			boardmapper.boardUpdate(vo);
		}
		@RequestMapping("/boardContent.do")
		public @ResponseBody Board boardContent(@RequestParam("idx") int idx) {
			Board vo = boardmapper.boardContent(idx); // vo->Json으로 변환되서 내려가겠죠
			return vo;
		}
		@RequestMapping("/boardCount.do")
		public @ResponseBody Board boardCount(@RequestParam("idx") int idx) {
			boardmapper.boardCount(idx);
			Board vo = boardContent(idx); //수정된 조회 수가 들어있음. 번호는 이미 jsp에 상위 인수로 있음
			return vo;
		}*/
}

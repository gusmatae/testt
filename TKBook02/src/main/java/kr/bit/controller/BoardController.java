package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.BoardVO;
import kr.bit.entity.CriteriaVO;
import kr.bit.entity.MemberVO;
import kr.bit.entity.PageMakerVO;
import kr.bit.service.BoardService;

@Controller
@RequestMapping("/board/*") //보드 아래 경로 전체
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/index")
	public String index() {
		return "board/index"; //WEB-INF/views/index.jsp
	}
	
	@RequestMapping("/list")//get,post 둘다 받기위해서 requestMapping(search를 post로 보내려고 바꿈)
	public String getlist(CriteriaVO cri, Model model) {
		List<BoardVO> list = boardService.getList(cri);
		// 객체바인딩
		model.addAttribute("list", list);
		// 페이징 처리에 필요한 부분
		PageMakerVO pageMaker = new PageMakerVO();
		pageMaker.setCri(cri); //현재 선택된 페이지를 넣어주는 것
		pageMaker.setTotalCount(boardService.totalCount(cri)); //totalCount()가 구해진 상태에서 VO의 메서드가 쭉 실행이 될 것
		model.addAttribute("pageMaker", pageMaker);
		return "board/list";
	}
	
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {//파라메터수집(vo) 하기전에 한글 인코딩을 해줘야 함 rttr쓰는이유: 리다이렉트시 정보끊김
		boardService.register(vo);
		System.out.println(vo); //selectKey에서 리절트타입에 묶을때 vo에 저장되게 됨
		rttr.addFlashAttribute("result", vo.getIdx());//일회성 세션같은 느낌 el표현식으로 꺼내면 됨
		return "redirect:/board/list";
	}
	
	@RequestMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	@PostMapping("/join")
	public String mregister(MemberVO vo) {//파라메터수집(vo) 하기전에 한글 인코딩을 해줘야 함 rttr쓰는이유: 리다이렉트시 정보끊김
		boardService.join(vo);
		return "redirect:/board/list";
	}

	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") CriteriaVO cri) {
		BoardVO vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/get"; // /WEB-INF/views/board/get.jsp 서블릿.xml에 관련된 설정
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") CriteriaVO cri) {
		BoardVO vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, CriteriaVO cri, RedirectAttributes rttr) {
		boardService.modify(vo); //수정
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx ,CriteriaVO cri, RedirectAttributes rttr) {
		boardService.remove(idx);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") CriteriaVO cri) {
		BoardVO vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/reply";
	}
	
	@PostMapping("/reply")
	public String reply(BoardVO vo, CriteriaVO cri, RedirectAttributes rttr) {
		// 답글에 필요한 처리...
		boardService.replyProcess(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
		
	}
	

	
}

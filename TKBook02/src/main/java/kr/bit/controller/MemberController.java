package kr.bit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.AuthVO;
import kr.bit.entity.MemberVO;
import kr.bit.service.BoardService;
import kr.bit.service.MemberService;



@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/memJoin")
	public String memJoin() {
		return "member/joinForm";
	}
	
	//중복확인
	@RequestMapping("/memRegisterCheck")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		System.out.println(memID);
		MemberVO m = memberService.registerCheck(memID);
		if(m!=null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 입력불가
		}
		return 1; //사용가능한 아이디
	}
	
	//회원가입 처리
		@RequestMapping("/memRegister")
		public String memberRegister(MemberVO m, String memPassword1, String memPassword2, RedirectAttributes rttr, HttpSession session) {
			if(m.getMemID()==null || m.getMemID().equals("") ||
					   memPassword1==null || memPassword1.equals("") ||
					   memPassword2==null || memPassword2.equals("") ||
					   m.getMemName()==null || m.getMemName().equals("") ||	
					   m.getMemAge()==0 || m.getAuthList() == null ||
					   m.getMemGender()==null || m.getMemGender().equals("") ||
					   m.getMemEmail()==null || m.getMemEmail().equals("")) {
					   // 누락메세지를 가지고 가기? =>객체바인딩(Model, HttpServletRequest, HttpSession)
					   rttr.addFlashAttribute("msgType", "실패 메세지");
					   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
					   return "redirect:/memJoin";  // ${msgType} , ${msg}
			}
			if(!memPassword1.equals(memPassword2)) {
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
				return "redirect:/memJoin";
			}
			
			m.setMemProfile(""); //사진 이미지는 없다는 의미 ""
			m.setMemPassword(memPassword2);
			// 회원을 테이블에 저장하기
			// 추가 : 비밀번호를 암호화 하기(API)
				//String encyptPw = pwEncoder.encode(m.getMemPassword());
				//m.setMemPassword(encyptPw);
			//register() 수정
			int result = memberService.register(m); /**mem_stbl 테이블에 삽입**/
			if(result==1) { // 회원가입 성공 메세지
				//추가 : 권한 테이블에 회원의 권한을 저장하기
					
				List<AuthVO> list = m.getAuthList();
				for(AuthVO authVO : list) {
					if(authVO.getAuth()!=null) {//널체크를 위해서 했찌만 그냥 한번 더해봄
						AuthVO saveVO = new AuthVO();
						saveVO.setMemID(m.getMemID()); //회원 아이디
						saveVO.setAuth(authVO.getAuth()); //회원의 권한
						memberService.authInsert(saveVO); /**mem_auth 테이블에 삽입**/
				
					}
				}
				
				rttr.addFlashAttribute("msgType", "성공 메세지");
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
				//회원가입이 성공하면 => 로그인처리하기

				return "redirect:/memJoin";
			}else {
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다");
				return "redirect:/memJoin";
			}
		}	

}//끝



















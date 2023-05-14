package kr.board.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.AuthVO;
import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;
import kr.board.security.MemberUserDetailsService;



@Controller
public class MemberController {

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	MemberUserDetailsService memberUserDetailsService;

	@Autowired
	PasswordEncoder pwEncoder;

	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "member/join";
	}
	//중복확인
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		Member m = memberMapper.registerCheck(memID);
		if(m!=null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 입력불가
		}
		return 1; //사용가능한 아이디
	}
	//회원가입 처리
	@RequestMapping("/memRegister.do")
	public String memberRegister(Member m, String memPassword1, String memPassword2, RedirectAttributes rttr, HttpSession session) {
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
				   return "redirect:/memJoin.do";  // ${msgType} , ${msg}
		}
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memJoin.do";
		}

		m.setMemProfile(""); //사진 이미지는 없다는 의미 ""
		// 회원을 테이블에 저장하기
		// 추가 : 비밀번호를 암호화 하기(API)
		String encyptPw = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encyptPw);
		//register() 수정
		int result = memberMapper.register(m); /**mem_stbl 테이블에 삽입**/
		if(result==1) { // 회원가입 성공 메세지
			//추가 : 권한 테이블에 회원의 권한을 저장하기
			List<AuthVO> list = m.getAuthList();
			for(AuthVO authVO : list) {
				if(authVO.getAuth()!=null) {//널체크를 위해서 함
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(m.getMemID()); //회원 아이디
					saveVO.setAuth(authVO.getAuth()); //회원의 권한
					memberMapper.authInsert(saveVO); /**mem_auth 테이블에 삽입**/
				}
			}

			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
			//회원가입이 성공하면 => 로그인처리하기

			return "member/memLoginForm";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다");
			return "redirect:/memJoin.do";
		}
	}	
	/*
	//로그아웃 처리
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	*/
	//로그인 화면으로 이동
	@RequestMapping("memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm";
	}
	/*
	// 로그인 기능 구현
	@RequestMapping("memLogin.do")
	public String memLogin(Member m, RedirectAttributes rttr, HttpSession session) {
		if(m.getMemID()==null || m.getMemID().equals("") ||
		   m.getMemPassword()==null ||m.getMemPassword().equals("")) {
			rttr.addFlashAttribute("msgType", "누락 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요");
		}
		Member mvo= memberMapper.memLogin(m);
		// 추가 : 비밀번호 일치여부 체크
		if(mvo!=null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {//로그인에 성공(input된 값 && 가져온 값 매칭 원래는 쿼리에서 일치시켜줬었음)
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인에 성공하였습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}else {//로그인에 실패
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "로그인에 실패하였습니다.");
			return "redirect:/memLoginForm.do";
		}
	}
	*/
	//회원정보수정화면
	@RequestMapping("memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	//회원정보수정
	@RequestMapping("memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes rttr, String memPassword1, String memPassword2, HttpSession session) {
		if(m.getMemID()==null || m.getMemID().equals("") ||
				memPassword1==null || memPassword1.equals("") ||
				memPassword2==null || memPassword2.equals("") ||
		   m.getMemName()==null || m.getMemName().equals("") ||	
		   m.getMemAge()==0 || m.getAuthList().size()==0 ||
		   m.getMemGender()==null || m.getMemGender().equals("") ||	
		   m.getMemEmail()==null || m.getMemEmail().equals("")) {
		   // 누락메세지를 가지고 가기? => 객체바인딩(Model, HttpServletRequest, HttpSession)
			rttr.addFlashAttribute("msgType", "누락 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
		   return "redirect:/memUpdateForm.do";
		}
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			return "redirect:/memUpdateForm.do";
		}
		// 회원을 수정하기
		// 추가 : 비밀번호 암호화
		String encyptPw = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encyptPw);
		int result = memberMapper.memUpdate(m);
		if(result==1) { // 수정 성공 메세지
			// 기존권한을 삭제하고
			memberMapper.authDelete(m.getMemID());

			// 새로운 권한을 추가하기
			List<AuthVO> list = m.getAuthList();
			for(AuthVO authVO : list) {
				if(authVO.getAuth()!=null) { //널체크를 위해서 했찌만 그냥 한번 더해봄
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(m.getMemID()); //회원 아이디
					saveVO.setAuth(authVO.getAuth()); //회원의 권한
					memberMapper.authInsert(saveVO); /**mem_auth 테이블에 삽입**/
				}
			}

			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원정보수정에 성공했습니다.");
			//회원수정이 성공하면 => 로그인처리하기
			  Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			  MemberUser userAccount = (MemberUser) authentication.getPrincipal();
			  SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getMember().getMemID()));
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다");
			return "redirect:/memUpdateForm.do";
		}
	}
	// 회원의 사진등록 화면
	@RequestMapping("/memImageForm.do")
	public String memImageForm() {
			return "member/memImageForm";
	}
	//회원사진 이미지 업로드(upload, DB저장)
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
		// 파일업로드 API(고전(초창기) cos.jar, 3가지)
		MultipartRequest multi = null;
		int fileMaxSize=10*1024*1024; //10MB
		/*
		실제 이클립스에서 만들어진 경로
		C:/eGovFrame-4.0.0/workspace.edu/SpringMVC03/src/main/webapp/resources/upload
		실제 이클립스가 우리 프로젝트를 만들어서 최종 관리하는 디렉토리
		C:/eGovFrame-4.0.0/workspace.edu/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/SpringMVC03/resources/upload
		*/
		String savePath=request.getRealPath("resources/upload");// 1.png
		try {                                                                     // 파일 이름 중복시 리네임 해주는 클래스 ex) 1_1.png
			//MultipartRequest() 생성자가 이 정보를 가지고 이미지 업로드
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy()); //폴더에 저장되는 시점
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			return "redirect:/memImageForm.do";
		}
		// 데이터베이스 테이블에 회원이미지를 업데이트
		String memID=multi.getParameter("memID");
		String newProfile="";
		File file=multi.getFile("memProfile"); //파일 객체에 대한 정보들
		if(file != null) { //파일이 존재한다면(png,jpg,gif)
			String ext=file.getName().substring(file.getName().lastIndexOf(".")+1); //파일의 이름을 리턴
			ext=ext.toUpperCase();//대문자로 통일
			if(ext.equals("PNG") ||ext.equals("GIF") || ext.equals("JPG")) {
				//새로 업로드된 이미지(NEW 1.png), 현재DB에 있는 이미지(OLD 4.png)
				String oldProfile = memberMapper.getMember(memID).getMemProfile();
				File oldFile = new File(savePath+"/"+oldProfile); //파일포인터 만들기(파일을 참조하는 변수)
				if(oldFile.exists()) {
					oldFile.delete(); //다른 이름이여도 삭제되더라 
				}
				newProfile=file.getName();
			}else { //이미지 파일 확장자가 아니고
				if(file.exists()) {//파일이 존재하면
					file.delete(); //이미지 삭제
				}
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.");
				return "redirect:/memImageForm.do";
			}
		}
		//새로운 이미지를 테이블에 업데이트
		Member mvo=new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		memberMapper.memProfileUpdate(mvo); //이미지 업데이트 성공
		//세션을 새롭게 생성한다.
		// 스프링보안(새로운 인증 세션을 생성->객체바인딩)
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberUser userAccount = (MemberUser) authentication.getPrincipal();
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getMember().getMemID()));

		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "이미지 변경이 성공하였습니다");

		return "redirect:/";
	}

	// 스프링 보안(새로운 세션 생성 메서드)
		 // UsernamePasswordAuthenticationToken -> 회원정보+권한정보
		 protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
			    UserDetails newPrincipal = memberUserDetailsService.loadUserByUsername(username);
			    UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
			    newAuth.setDetails(currentAuth.getDetails());	    
			    return newAuth;
		 }

	@GetMapping("/access-denied")
	public String showAccessDenied() {
		return "access-denied";
	}

}//끝
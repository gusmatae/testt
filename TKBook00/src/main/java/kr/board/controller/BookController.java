package kr.board.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.reflect.MethodDelegate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.AuthVO;
import kr.board.entity.Board;
import kr.board.entity.Book;
import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.entity.Order;
import kr.board.mapper.BookMapper;
import kr.board.mapper.MemberMapper;
import kr.board.security.MemberUserDetailsService;



@Controller
public class BookController {

	@Autowired
	BookMapper bookMapper;

		// 회원의 상품 등록 폼화면
		@RequestMapping("bkJoinForm.do")//memImageForm.do
		public String bkJoinForm() {
				return "/book/bookJoinForm";//member/memImageForm
		}
		// 상품 목록 jsp
		@RequestMapping("bkContent.do")//memImageForm.do
		public String bkContent(Model model) {
			List<Book> blist = bookMapper.getBookLists();
			model.addAttribute("blist", blist);
			return "/book/bookContent";//member/memImageForm
		}
		// 상품 주문
		@RequestMapping("odJoinForm.do")//memImageForm.do bkImage
		public String orRegister(Model model, @RequestParam("memID") String memID , @RequestParam("bkCd") String bkCd, @RequestParam("bkNm") String bkNm, @RequestParam("bkImage") String bkImage) {
			Order od = new Order();
			od.setMemID(memID);
			od.setBkNm(bkNm);
			od.setBkCd(bkCd);
			model.addAttribute("od", od);
			model.addAttribute("bkImage", bkImage);
			return "/order/orderJoinForm";
		}
		//주문 현황(목록)
		@RequestMapping("orContent.do")//memImageForm.do
		public String orContent(Model model) {
			List<Order> odlist = bookMapper.orderContent();
			model.addAttribute("odlist", odlist);
			return "/order/orderContent";//member/memImageForm
		}
		//주문 insert
		@RequestMapping("orRegister.do")//memImageForm.do
		public String orRegister(Model model, Order order) {
			bookMapper.orderRegister(order);
			return "redirect:/bkContent.do";//상품 목록
		}

		//상품 삭제
		@RequestMapping("bkDelete.do")//memImageForm.do
		public String bkdelete(Model model, @RequestParam("bkImage") String bkImage, HttpServletRequest request) {
			MultipartRequest multi = null;
			String savePath=request.getRealPath("resources/book");
			File file = new File(savePath + File.separator + bkImage);
			if(file.exists()) {
			    file.delete(); 
			}

			bookMapper.bookDelete(bkImage);

			return "redirect:/bkContent.do";
		}

		//상품등록 이미지 업로드(upload, DB저장)
		@RequestMapping("bkRegister.do")///memImageUpdate.do
		public String bkRegister(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
			// 파일업로드 API(고전(초창기) cos.jar, 3가지)
			MultipartRequest multi = null;
			int fileMaxSize=10*1024*1024; //10MB
			/*
			실제 이클립스에서 만들어진 경로
			C:/eGovFrame-4.0.0/workspace.edu/SpringMVC03/src/main/webapp/resources/upload
			실제 이클립스가 우리 프로젝트를 만들어서 최종 관리하는 디렉토리
			C:\eGovFrame-4.0.0\workspace.edu\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SpringMVC77\resources\book
			*/
			String savePath=request.getRealPath("resources/book");// 1.png
			try {                                                                     // 파일 이름 중복시 리네임 해주는 클래스 ex) 1_1.png
				//MultipartRequest() 생성자가 이 정보를 가지고 이미지 업로드
				multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy()); //폴더에 저장되는 시점
			}catch(Exception e){
				e.printStackTrace();
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
				return "redirect:/memImageForm.do";
			}
			/*
			// 데이터베이스 테이블에 상품이미지를 업데이트
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
					return "redirect:/bkJoinForm.do";
				}
			}
			*/
			//새로운 이미지를 테이블에 업데이트
			String bkNm = multi.getParameter("bkNm");
			String bkPrice = multi.getParameter("bkPrice");
			String bkContent = multi.getParameter("bkContent");
			File file=multi.getFile("memProfile");
			String filename=file.getName();

			Book mvo=new Book();

			mvo.setBkNm(bkNm);
			mvo.setBkPrice(bkPrice);
			mvo.setBkContent(bkContent);
			mvo.setBkImage(filename);
			bookMapper.bookProfileInsert(mvo); //이미지 업데이트 성공
			//세션을 새롭게 생성한다.

			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "상품 등록이 성공하였습니다");

			return "redirect:/";
		}
}//끝
package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.bit.controller.MemberRepository;
import kr.bit.entity.CustomUser;
import kr.bit.entity.Member;

//DB와 연동하여 인증 체크하는 클래스
@Service
public class UserDetailsServiceImpl implements UserDetailsService{ //이 클래스를 Spring Security에서 인식하기 위해서는 등록을 해줘야한다. 그래서 환경설정 파일을 만든다.
	
	@Autowired
	private MemberRepository memberRepository ; //new 해준 것과 같음
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		Member member = memberRepository.findById(username).get(); //memberRepository는 JPA CRUD 관련 인터페이스를 상속받은 interface
		if(member==null) {
			throw new UsernameNotFoundException(username+"없음");
			
		}
		
		
		return new CustomUser(member); //User(3가지 권한정보)+Member(다른 회원 정보)
	}

}

package kr.bit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.bit.controller.MemberRepository;
import kr.bit.entity.Member;
import kr.bit.entity.Role;

@SpringBootTest
class SpringMvc11ApplicationTests {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void createMember() {
		Member m=new Member();
		m.setUsername("Admin");
		m.setPassword(encoder.encode("Admin"));  // 암호화
		m.setName("관리자");
		m.setRole(Role.MANAGER);
		m.setEnabled(true);
		memberRepository.save(m); // 회원가입
	}

}
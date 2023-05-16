package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {
 
	@Autowired
	private UserDetailsServiceImpl userDetailsService;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		http.csrf().disable(); //CSRF 공격을 비활성화
		http.authorizeHttpRequests() //HTTP 요청에 대한 인가 규칙 설정
			.antMatchers("/", "/member/**").permitAll() // 이 요청에 대한 접근 허용
			.antMatchers("/board/**").authenticated() //이 요청에 대한 접근 비허용
			
			.and()
			.formLogin() //폼 기반 인증 사용
			.loginPage("/member/login") //로그인 하지 않은 상태에서 해당 경로로 이동
			.defaultSuccessUrl("/board/list") // 로그인 후 기본적으로 이동할 페이지
			
			.and()
			.logout() //로그아웃 설정
			.logoutUrl("/member/logout")// 로그아웃을 수행할 URL
			.logoutSuccessUrl("/"); //로그아웃 이후 루트
		
		 http.userDetailsService(userDetailsService); //사용자의 상세 정보를 로드하는 서비스 설정
		
		return http.build();
	}
}
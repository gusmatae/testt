package kr.board.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.board.security.MemberUserDetailsService;

@Configuration
@EnableWebSecurity
			//스프링환경설정 클래스파일
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberUserDetailsService()).passwordEncoder(passwordEncoder());
	}
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//요청에 대한 보안 설정~~
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);
		//요청에 따른 권한을 확인하여 서비스하는 부분-1
		http.authorizeRequests()//요청에 따른 권한에 따라서 설정해주겠다,
			.antMatchers("/")//어떤 경로로 왔을때 어떤 권한을 가진 사람에게 서비스 해 줄 것인지,
			.permitAll()//특별한 권한이 없어도 괜찮다.
			.and()//다음 권한을 또 걸고 싶을 때
		.formLogin()//어떤 url이 왔을 때 로그인 페이지로 갈 건지 //설정을 하지 않으면 기본 ui //나의 FORM으로 할 것▼
			.loginPage("/memLoginForm.do")
			.loginProcessingUrl("/memLogin.do") //이 url이 왔을 때 스프링 내부 인증 api를 거치겠다 //타고가다가 UserDetailsService 클래스의 메서드가 실행됨
			.permitAll()//이런 url들은 특별한 제약이 있어서 쓰는게 아니라 모든 사람들이 사용 할 수 있어야 하기 때문에
			.and()
		.logout() 
			.invalidateHttpSession(true) //세션을 끊어준다
			.logoutSuccessUrl("/")
			.and()
		.exceptionHandling().accessDeniedPage("/access-denied"); //오류처리 //클라이언트가 특정한 권한 없이 들어오려고 할 때 가게되는 페이지
			
	}
	//패스워드 인코딩 객체 설정
	@Bean
	public PasswordEncoder passwordEncoder() { //클래스?
		return new BCryptPasswordEncoder();
	}
	
}

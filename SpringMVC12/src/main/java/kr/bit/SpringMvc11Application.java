package kr.bit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication // 이 어노테이션 하나면 spring컨테이너에 있는 것들이 api받아서 다 되므로, spring 처럼 내부가 복잡하지 않다.
public class SpringMvc11Application {

	public static void main(String[] args) {
		SpringApplication.run(SpringMvc11Application.class, args);
	}
}




/*
부트는 일반적으로 템플릿을 타임리프를 사용한다.
부트는 서버에 내장된 톰캣서버가 있다 별도의 서버를 구축할 필요가 없다.
main클래스를 동작시키면 내부에서 톰캣 서버가 구동된다.
프토퍼티스 파일 야물로 바꿔서 할 예정
톰캣서버의 포트는 기본 8080인데 appliproperties 에서 수정하면 된다.
appli.properties이 자동으로 만들어 진 것인데 지웠다가 다시 만듦? 그러면 이클립스가 잘 인식함 - utf-8로 변경하여 한글 인식 가능하도록.

jpa 나 mysql 을 쓰겠다고 했기 때문에 설정안하면 런 안됨
 */
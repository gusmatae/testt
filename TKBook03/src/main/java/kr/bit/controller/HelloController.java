package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller //제이슨 스트링으로 넘겨주는 것
public class HelloController {
	@RequestMapping("/")
	public String hellow() {
		return "index";
	}
}

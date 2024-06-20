package com.warriors.wod;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginRegisterController {
	
	@RequestMapping(value = {"/", "/login.do"})
	public String showLoginForm() {
		return "/WEB-INF/views/login_register/login.jsp";
	}
	
	@RequestMapping("/register.do")
	public String showRegisterForm() {
		return "/WEB-INF/views/login_register/register.jsp";
	}
}

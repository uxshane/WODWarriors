package com.warriors.wod;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping("/main.do")
	public String showMainPage() {
		return "/WEB-INF/views/mainpage.jsp";
	}
	
}

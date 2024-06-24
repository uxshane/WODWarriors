package com.warriors.wod;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.NoticeService;
import vo.NoticeVO;

@Controller
public class MainController {
	
	@Autowired
    private NoticeService noticeService;

	@RequestMapping("/main.do")
	public String showMainPage(Model model, HttpServletRequest request) {
		
        List<NoticeVO> notices = noticeService.getAllNotices();
        model.addAttribute("notices", notices);

        boolean isAdmin = false;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userRole") && cookie.getValue().equals("admin")) {
                    isAdmin = true;
                    break;
                }
            }
        }
        model.addAttribute("isAdmin", isAdmin);

        return "/WEB-INF/views/mainpage.jsp";
		
	}
	
}

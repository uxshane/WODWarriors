package com.warriors.wod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import service.NoticeService;
import vo.NoticeVO;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;
    
    @RequestMapping("/writeNotice.do")
    public String showWriteNoticeForm() {
        return "/WEB-INF/views/writeNotice.jsp";
    }

    @RequestMapping(value = "/saveNotice.do", method = RequestMethod.POST)
    public String saveNotice(NoticeVO notice, HttpServletRequest request) {
        String userEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userEmail")) {
                    userEmail = cookie.getValue();
                    break;
                }
            }
        }
        
        if (userEmail != null) {
            int userId = noticeService.getUserIdByEmail(userEmail);
            notice.setUserId(userId);
            noticeService.saveNotice(notice);
        }
        
        return "redirect:/main.do";
    }
	
}

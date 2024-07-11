package com.warriors.wod;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import service.PostService;
import service.UserService;
import util.PropertiesUtil;
import vo.PostVO;
import vo.UserVO;

@Controller
public class MainController {


	@Autowired
	private PostService postService;

	@Autowired
	private UserService userService;

	//	@RequestMapping("/main.do")
	//	public String showMainPage() {
	//		return "/WEB-INF/views/mainpage.jsp";
	//	}


	@RequestMapping("main.do")
	public String showMainPage(Model model, HttpServletRequest request) {

		//		Cookie[] cookies = request.getCookies();
		//		if (cookies != null) {
		//			for (Cookie cookie : cookies) {
		//				if (cookie.getName().equals("userRole") && cookie.getValue().equals("admin")) {
		//					isAdmin = true;
		//					break;
		//				}
		//			}
		//		}

		HttpSession session = request.getSession();
		Integer userIdx = (Integer) session.getAttribute("userIdx");
		if (userIdx == null) {
			userIdx = -1; // userIdx가 없을 경우 -1로 설정
		}
		model.addAttribute("userIdx", userIdx);


		boolean isAdmin;
		if(userIdx != -1) {
			UserVO curUser = userService.selectOneUser(userIdx);
			if(curUser.getIsAdmin() == 1) {
				isAdmin = true;
			} else {
				isAdmin = false;
			}
		} else {
			isAdmin = false;
		}
		model.addAttribute("isAdmin", isAdmin);

		List<PostVO> post_list = postService.getAllPosts();
		model.addAttribute("posts", post_list);

		return "/WEB-INF/views/mainpage.jsp";

	}

	@RequestMapping("register_lightning.do")
	public String showRegister_LightningPage() {
		return "/WEB-INF/views/register_lightning.jsp";
	}

	@RequestMapping("testmap.do")
	public String showTestMapPage(Model model, HttpServletRequest request) throws JsonProcessingException {

		//API정보 유출방지용 메서드
		PropertiesUtil propertiesUtil = new PropertiesUtil("secret_key.properties");
		String appKey = propertiesUtil.getProperty("kakao.app.key");
		model.addAttribute("appKey", appKey);

		//로그인 상태로 들어왔는지 확인.
		HttpSession session = request.getSession();
		if(session.getAttribute("userIdx") != null) {
			model.addAttribute("userIdx", (int) session.getAttribute("userIdx"));
		} else {
			model.addAttribute("userIdx", -1);
		}

		//모든 post들을 List형태로 보냄.
		List<PostVO> posts = postService.getAllPosts();
		ObjectMapper objectMapper = new ObjectMapper();
		String postsJson = objectMapper.writeValueAsString(posts);
		model.addAttribute("posts", postsJson);

		return "/WEB-INF/views/testmap.jsp";
	}

	@RequestMapping("settings.do")
	public String showSettingsPage(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer session_userIdx = (Integer) session.getAttribute("userIdx");
		if(session_userIdx == null || session_userIdx == -1) {
			return "redirect:login.do";
		} else {
			UserVO curUser = userService.selectOneUser(session_userIdx);
			model.addAttribute("user", curUser);
			return "/WEB-INF/views/mypage.jsp";
		}
	}

}












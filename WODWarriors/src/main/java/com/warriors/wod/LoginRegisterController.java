package com.warriors.wod;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.EmailService;
import service.UserService;
import vo.UserVO;

@Controller
public class LoginRegisterController {

	@Autowired
	private UserService userService;

	@Autowired
	private EmailService emailService;

	/*------------------------------------------------------------*/
	//기본 로그인 화면 출력용
	@RequestMapping(value = {"/", "/login.do"})
	public String showLoginForm(Model model, @RequestParam(value = "email", required = false) String email) {
		if (email != null && !email.isEmpty()) {
			model.addAttribute("email", email);
		}
		return "/WEB-INF/views/login_register/login.jsp";
	}

	//기본 회원가입 화면 출력용
	@RequestMapping("/register.do")
	public String showRegisterForm() {
		return "/WEB-INF/views/login_register/register.jsp";
	}

	//기본 잃어버린 비밀번호 찾는 화면 출력용
	@RequestMapping("/find_password.do")
	public String showFindPasswordForm() {
		return "/WEB-INF/views/login_register/find_password.jsp";
	}
	/*------------------------------------------------------------*/

	/*------------------------------------------------------------*/
	 // 로그인 "진행시켜!!"
    @RequestMapping(value = "/verify_login.do", method = RequestMethod.POST)
    public String verify_user_login(String email, String password, Model model, HttpServletRequest request, HttpServletResponse response) {
        UserVO user = userService.getUserByEmail(email);
        boolean loggedInUser = false;
        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("error", "이메일 또는 비밀번호가 잘못되었습니다.");
            model.addAttribute("email", email);
            return "/WEB-INF/views/login_register/login.jsp";
        }
        
        loggedInUser = true;
        HttpSession session = request.getSession();
        session.setAttribute("loggedInUser", loggedInUser);
        session.setAttribute("userIdx", user.getIdx());

        Cookie idxCookie = new Cookie("userIdx", String.valueOf(user.getIdx()));
        idxCookie.setPath("/");
        idxCookie.setMaxAge(60 * 60 * 24); // 1일 동안 유효

        Cookie roleCookie = new Cookie("userRole", user.getIsAdmin() == 1 ? "admin" : "user");
        roleCookie.setPath("/");
        roleCookie.setMaxAge(60 * 60 * 24); // 1일 동안 유효

        response.addCookie(idxCookie);
        response.addCookie(roleCookie);

        return "redirect:/main.do";
    }
    
    // 로그아웃 처리
    @RequestMapping("/logout.do")
    public String logoutUser(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.invalidate();

        Cookie idxCookie = new Cookie("userIdx", null);
        idxCookie.setPath("/");
        idxCookie.setMaxAge(0); // 쿠키 삭제
        response.addCookie(idxCookie);

        Cookie roleCookie = new Cookie("userRole", null);
        roleCookie.setPath("/");
        roleCookie.setMaxAge(0); // 쿠키 삭제
        response.addCookie(roleCookie);
        
        return "redirect:/login.do";
    }
	
	//회원가입 "진행시켜!!"
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public String registerUser(UserVO user, String verificationCode, Model model, String signMeAdmin) {
		// 이메일 존재 여부 확인
		boolean emailExists = emailService.emailExists(user.getEmail());
		if (emailExists) {
			model.addAttribute("error", "이메일이 존재합니다.");
			return "/WEB-INF/views/login_register/register.jsp";
		} else {
			
			//일단 isAdmin=0으로 등록시키고 서버관리자 이메일로 신청인의 이메일, 이름과 함께 보냄
			//추후에 서버 관리자가 확인하고 수동으로 DB에 isAdmin을 1로 변경시켜줘야함.
			user.setIsAdmin(0);
			if(signMeAdmin != null && signMeAdmin.equals("on")) {
				emailService.sendAdminRegiForm(user.getEmail(), user.getName());
			}
			
			// DB에 사용자 정보 저장
			int res = userService.registerUser(user);

			if(res > 0) {
				model.addAttribute("message", "회원가입 성공! 로그인 페이지로 이동합니다.");
				model.addAttribute("email", user.getEmail());
			} else {
				model.addAttribute("error", "서버 쪽 문제로 " + user.getName() + "이 등록되지 못했습니다.");
			}
			return "/WEB-INF/views/login_register/register.jsp";
		}
	}
	/*------------------------------------------------------------*/

	/*------------------------------------------------------------*/
	//인증코드를 보내주는 작업을 하는 용도
	@RequestMapping(value = "/sendVerificationCode.do", method = RequestMethod.POST)
	@ResponseBody
    public String sendVerificationCode(@RequestParam("email") String email) {
        try {
			String code = emailService.generateAndSendVerificationCode(email);
			return code;
		} catch (MessagingException e) {
			return "error";
		}
    }
	
	//이메일을 이용해서 비밀번호를 찾아주는 용도
	@RequestMapping("/send_email_password.do")
	public String findPassword(Model model, String email) {

		// 이메일 존재 여부 확인 및 비밀번호 전송
		boolean emailExists = emailService.emailExists(email);
		if (emailExists) {
			emailService.sendPasswordByEmail(email);
			model.addAttribute("message", "비밀번호가 이메일로 전송되었습니다.");
		} else {
			model.addAttribute("error", "이메일이 존재하지 않습니다.");
		}

		return "/WEB-INF/views/login_register/find_password.jsp";
	}
	/*------------------------------------------------------------*/
}











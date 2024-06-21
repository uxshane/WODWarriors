package com.warriors.wod;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	//회원가입 "진행시켜!!"
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public String registerUser(UserVO user, String verificationCode, Model model) {
		//인증코드 
		if (!emailService.verifyCode(user.getEmail(), verificationCode)) { // 추가된 부분
            model.addAttribute("error", "인증코드가 올바르지 않습니다.");
            return "/WEB-INF/views/login_register/register.jsp";
        }
		
		// 이메일 존재 여부 확인
		boolean emailExists = emailService.emailExists(user.getEmail());
		if (emailExists) {
			model.addAttribute("error", "이메일이 존재합니다.");
			return "/WEB-INF/views/login_register/register.jsp";
		} else {
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
    public void sendVerificationCode(@RequestParam("email") String email) {
        try {
			emailService.generateAndSendVerificationCode(email);
		} catch (MessagingException e) {
			e.printStackTrace();
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











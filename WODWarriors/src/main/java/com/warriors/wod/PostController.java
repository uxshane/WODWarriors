package com.warriors.wod;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.PostService;
import service.RecruitmentService;
import service.UserService;
import vo.PostUserVO;
import vo.PostVO;
import vo.RecruitmentPostUserVO;
import vo.RecruitmentVO;
import vo.UserVO;

@Controller
public class PostController {

	@Autowired
	private PostService postService;

	@Autowired
	private UserService userService;

	@Autowired
	private RecruitmentService recruitmentService;

	@RequestMapping("createPost.do")
	@ResponseBody
	public Map<String, String> createPost(@ModelAttribute PostVO post,
			String exercise,
			String exerciseOption,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		int userIdx = (int) session.getAttribute("userIdx");

		post.setIsPast(post.isStartDateTimeInThePast());

		boolean isCreated = postService.createPost(post, userIdx, exercise, exerciseOption);

		Map<String, String> result = new HashMap<String, String>();

		if (isCreated) {
			result.put("status", "success");
			result.put("message", "운동번개가 성공적으로 등록되었습니다.");
		} else {
			result.put("status", "error");
			result.put("error", "운동번개 등록에 실패했습니다. 다시 시도해주세요.");
		}
		return result;
	}

	@RequestMapping("post_detail.do")
	public String showPostDetailPage(int postIdx, Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		Integer session_userIdx = (Integer) session.getAttribute("userIdx");
		if(session_userIdx == null || session_userIdx == -1) {
			return "redirect:login.do";
		}

		PostUserVO postUser = postService.selectOnePostWithUserInfo(postIdx);
		model.addAttribute("postUser", postUser);

		if(recruitmentService.getApplicantCount(postIdx) > 0) {
			List<RecruitmentPostUserVO> join_users = recruitmentService.getRecruitmentPostUserJoinTable(postIdx);
			model.addAttribute("join_users", join_users);
		}
		
		boolean isApplicant = recruitmentService.isApplicant(postIdx, session_userIdx);
        model.addAttribute("isApplicant", isApplicant);

		if(postUser.getUserIdx() == session_userIdx) {
			return "/WEB-INF/views/post/my_post_detail.jsp";
		} else {
			return "/WEB-INF/views/post/your_post_detail.jsp";
		}

	}

	@RequestMapping("join_activity.do")
	public String joinActivity(int postIdx, HttpSession session, Model model) {
		
		PostUserVO postUserVO = postService.selectOnePostWithUserInfo(postIdx);
		int max_recruitment = recruitmentService.getApplicantCount(postIdx);
		
		if(postUserVO.getRecruitment() == max_recruitment) {
			model.addAttribute("max_rec", postUserVO)
		}
		
		int post_user_idx = postUserVO.getUserIdx();
		int join_user_idx = (int) session.getAttribute("userIdx");
		

		boolean success = recruitmentService.insertApplicant(postIdx, post_user_idx, join_user_idx);

		if (success) {
			return "redirect:post_detail.do?postIdx=" + postIdx;
		} else {
			return "/WEB-INF/views/post/post_fail.jsp";
		}
	}
	
	@RequestMapping("/leave_activity.do")
    public String leaveActivity(int postIdx, HttpSession session) {
		int join_user_idx = (int) session.getAttribute("userIdx");
        
        boolean success = recruitmentService.deleteApplicant(postIdx, join_user_idx);
        
        return "redirect:post_detail.do?postIdx=" + postIdx;
    }

}




















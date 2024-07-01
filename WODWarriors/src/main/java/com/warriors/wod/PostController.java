package com.warriors.wod;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.PostService;
import vo.PostVO;

@Controller
public class PostController {

    @Autowired
    private PostService postService;
    
    @RequestMapping("createPost.do")
    @ResponseBody
    public Map<String, String> createPost(@ModelAttribute PostVO post, HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	int userIdx = (int) session.getAttribute("userIdx");
    	
    	post.setIsPast(post.isStartDateTimeInThePast());
    	
        boolean isCreated = postService.createPost(post, userIdx);
        
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
	
}

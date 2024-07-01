package com.warriors.wod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import service.PostService;

@Configuration
@EnableScheduling
public class SchedulerConfig {

	@Autowired
	private PostService postService;
	
	@Scheduled(cron = "0 * * * * *") // 매 1분마다 실행
    public void updatePostStatus() {
    	System.out.println("포스트 시간 업데이트 함!");
        postService.updatePastStatus();
    }
	
}

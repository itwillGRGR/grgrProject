package com.grgr.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.grgr.dto.NoticeBoard;
import com.grgr.service.MainPageService;
import com.grgr.service.NoticeBoardService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MainController {
	private final MainPageService mainPageService;
	private final NoticeBoardService noticeBoardService;

	@RequestMapping("/main")
	public String mainPage(Model model, HttpSession session) {
		Map<String, Object> newPostWithFile = mainPageService.selectNewPost();
		model.addAllAttributes(newPostWithFile);
		NoticeBoard latestNotice = noticeBoardService.getLatestNotice();
		session.setAttribute("latestNoticeBno",latestNotice.getNoticeBno());
		session.setAttribute("latestNoticeTitle",latestNotice.getNoticeTitle());
		return "/tiles/main";
	}
}

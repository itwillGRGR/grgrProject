package com.grgr.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grgr.dto.NoticeBoard;
import com.grgr.exception.WriteNullException;
import com.grgr.service.NoticeBoardService;
import com.grgr.util.SearchCondition;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/noticeboard")
@RequiredArgsConstructor
public class NoticeBoardController {
	private final NoticeBoardService noticeBoardService;

	// 글목록 (전체 & 검색 조건)
	@RequestMapping("/list")
	public String list(SearchCondition searchCondition, Model model) {
		Map<String, Object> result = noticeBoardService.getNoticeBoardList(searchCondition);
		model.addAttribute("noticeBoardList", result.get("noticeBoardList"));
		model.addAttribute("pager", result.get("pager"));
		return "board/notice_boardlist";
	}
	

	// 선택 게시글 조회
	@GetMapping("/read")
	public String noticeBoardRead(@RequestParam int noticeBno, SearchCondition searchCondition, HttpSession httpSession, Model model) {
		try {
			noticeBoardService.increaseNoticeViewCnt(noticeBno);//조회수 증가 처리
			Map<String, Object> noticeBoard = noticeBoardService.getNoticeBoard(noticeBno);
			Integer prevNoticeBno = noticeBoardService.prevNoticeBno(searchCondition, noticeBno);
			Integer nextNoticeBno = noticeBoardService.nextNoticeBno(searchCondition, noticeBno);
					
			model.addAllAttributes(noticeBoard); 
			model.addAttribute("nextNoticeBno", nextNoticeBno);
			model.addAttribute("prevNoticeBno", prevNoticeBno);
			model.addAttribute("isLastPost", nextNoticeBno == null);
			model.addAttribute("isFirstPost", prevNoticeBno == null);
			model.addAttribute("searchCondition", searchCondition); // 검색 조건 추가
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/notice_board";
	}
	
//	@GetMapping("/latestNotice")
//	public String latestNotice(@RequestParam int noticeBno, Model model) {
//		NoticeBoard latestNotice = noticeBoardService.getLatestNotice();
//		model.addAttribute("latestNoticeNo",latestNotice.getNoticeBno());
//		
//		return "board/notice_board";	
//	}

	// 글쓰기 페이지 요청
	@GetMapping(value = "/write")
	public String noticeBoardWrite(SearchCondition searchCondition, Model model) {
		model.addAttribute("searchCondition", searchCondition);
		return "board/notice_write";
	}

	// 글 작성 및 제출
	@PostMapping(value = "/write")
	public String noticeBoardWrite(NoticeBoard noticeBoard)
		throws WriteNullException, IOException {
		int newBno = noticeBoardService.addNoticeBoard(noticeBoard);

		return "redirect:/noticeboard/read?noticeBno=" + newBno;
	}

	// 글 수정페이지 요청
	@GetMapping("/modify")
	public String noticeBoardModify(int noticeBno, SearchCondition searchCondition, Model model) {
		Map<String, Object> noticeBoard = noticeBoardService.getNoticeBoard(noticeBno);
		
		model.addAllAttributes(noticeBoard);
		model.addAttribute("searchCondition", searchCondition);
		return "board/notice_modify";
	}

	// 글 수정 제출
	@PostMapping(value="/modify")
	public String noticeBoardModify(NoticeBoard noticeBoard, RedirectAttributes rattr) throws WriteNullException {
		if (noticeBoard.getNoticeTitle() == null || noticeBoard.getNoticeContent() == null) {
				throw new WriteNullException("제목 또는 내용이 비어있습니다.");
		}

		noticeBoardService.modifyNoticeBoard(noticeBoard); 
		return "redirect:/noticeboard/read?noticeBno="+noticeBoard.getNoticeBno();
	}

	// 글 제거
	@RequestMapping("/remove")
	public String noticeBoardRemove(@RequestParam Integer noticeBno, SearchCondition searchCondition, HttpSession session,
			RedirectAttributes rattr) {
		Integer loginUno =(Integer) session.getAttribute("loginUno");
		Integer loginUserStatus =(Integer) session.getAttribute("loginUserStatus");
		noticeBoardService.removeNoticeBoard(noticeBno, loginUno, loginUserStatus);
		String redirectUri = "redirect:/noticeboard/list"+searchCondition.getQueryString();
		return redirectUri;
	}
}

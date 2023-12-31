package com.grgr.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grgr.dto.QnaBoard;
import com.grgr.exception.FileUploadFailException;
import com.grgr.exception.PostUpdateException;
import com.grgr.exception.WriteNullException;
import com.grgr.service.QnaBoardService;
import com.grgr.util.SearchCondition;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//0914 - 안소연_사진 업로드 추가/세션추가
//				비밀글 추가
//0920 - 안소연_관리자가 비밀글 조회 가능하도록 수정

@Controller
@RequestMapping("/qnaboard")
@RequiredArgsConstructor
@Slf4j
public class QnaBoardController {
	private final QnaBoardService qnaBoardService;

	// 글목록 (전체 & 검색 조건)
	@RequestMapping("/list")
	public String qnaBoardList(SearchCondition searchCondition, HttpSession session, Model model) {
		log.info("@@@@@QnaBoardController() 클래스의 qnaBoardList() 메소드 호출");

		Integer loginUserStatus = (Integer) session.getAttribute("loginUserStatus");
		Integer uno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> result = qnaBoardService.getQnaBoardList(searchCondition, session, loginUserStatus);

		model.addAttribute("qnaBoardList", result.get("qnaBoardList"));
		model.addAttribute("pager", result.get("pager"));
		model.addAttribute("fileList", result.get("fileList"));

		return "board/qna_boardlist";
	}

	// 선택 게시글 조회
	@GetMapping("/read")
	public String qnaBoardRead(@RequestParam int qnaBno, SearchCondition searchCondition, HttpSession session, Model model) {
		log.info("QnaBoardController() 클래스의 qnaBoardRead() 메소드 호출");

		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> readMap = qnaBoardService.getQnaBoard(loginUno, qnaBno);
		Integer prevQnaBno = qnaBoardService.prevQnaBno(searchCondition, qnaBno);
		Integer nextQnaBno = qnaBoardService.nextQnaBno(searchCondition, qnaBno);
		// int loginUno = (int)session.getAttribute("loginUno");
		// model.addAttribute("loginUno", loginUno);
		model.addAllAttributes(readMap);
		model.addAttribute("nextQnaBno", nextQnaBno);
		model.addAttribute("prevQnaBno", prevQnaBno);
		model.addAttribute("isLastPost", nextQnaBno == null);
		model.addAttribute("isFirstPost", prevQnaBno == null);
		model.addAttribute("searchCondition", searchCondition); // 검색 조건 추가

		return "board/qna_board";
	}

	// 글쓰기 페이지 요청
	@GetMapping(value = "/write")
	public String qnaBoardWrite(SearchCondition searchCondition, HttpSession session, Model model) {
		log.info("@@@@@QnaBoardController() 클래스의 Get qnaBoardWrite() 메소드 호출");
		model.addAttribute("searchCondition", searchCondition);
		return "board/qna_write";
	}

	// 글 작성 및 제출(공개상태 추가)
	@PostMapping(value = "/write")
	public String qnaBoardWrite(@RequestParam(value = "qnaBlindstate", required = false) Integer qnaBlindstate,
			QnaBoard qnaBoard, List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {
		log.info("@@@@@QnaBoardController() 클래스의 Post qnaBoardWrite() 메소드 호출");

		int newBno = qnaBoardService.addQnaBoard(qnaBoard, qnaBlindstate, files);

		return "redirect:/qnaboard/read?qnaBno=" + newBno;
	}

	// 글 수정페이지 요청
	@GetMapping("/modify")
	public String qnaBoardModify(int qnaBno, SearchCondition searchCondition, HttpSession session, Model model) {
		log.info("@@@@@QnaBoardController() 클래스의 get qnaBoardModify() 메소드 호출");

		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> qnaBoardWithFiles = qnaBoardService.getQnaBoard(loginUno, qnaBno);
		QnaBoard qnaBoard = (QnaBoard) qnaBoardWithFiles.get("qnaBoard");

		if (loginUno != qnaBoard.getUno()) {
			return "/404";
		}
		model.addAllAttributes(qnaBoardWithFiles);
		model.addAttribute("searchCondition", searchCondition);
		return "board/qna_modify";
	}

	// 글 수정 제출
	@PostMapping(value = "/modify")
	public String qnaBoardModify(@RequestParam(value = "qnaBlindstate", required = false) Integer qnaBlindstate,
			QnaBoard qnaBoard, @RequestParam(value = "files", required = false) List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {
		log.info("@@@@@QnaBoardController() 클래스의 post qnaBoardModify() 메소드 호출");

		if (qnaBoard.getQnaTitle() == null || qnaBoard.getQnaContent() == null) {
			throw new WriteNullException("제목 또는 내용이 비어있습니다.");
		}

		qnaBoardService.modifyQnaBoard(qnaBoard, qnaBlindstate, files);
		return "redirect:/qnaboard/read?qnaBno=" + qnaBoard.getQnaBno();
	}

	// 글 제거
	@RequestMapping("/remove")
	public String qnaBoardRemove(@RequestParam Integer qnaBno, SearchCondition searchCondition, HttpSession session,
			RedirectAttributes rattr) throws PostUpdateException {
		log.info("QnaBoardController() 클래스의 qnaBoardRemove() 메소드 호출");

		Integer loginUno = (Integer) session.getAttribute("loginUno");
		qnaBoardService.removeQnaBoard(qnaBno, loginUno);
		String redirectUri = "redirect:/qnaboard/list" + searchCondition.getQueryString();
		return redirectUri;
	}

	// 글 숨김
	@GetMapping("/hide")
	public String qnaBoardBlind(@RequestParam Integer qnaBno, SearchCondition searchCondition, HttpSession session) {
		int loginUser = (int) session.getAttribute("loginUser");
		int loginUserStatus = (int) session.getAttribute("loginUserStatus");
		qnaBoardService.hideQnaBoard(qnaBno, loginUser, loginUserStatus);

		String redirectUri = "redirect:/qnaboard/list" + searchCondition.getQueryString();
		return redirectUri;
	}

}

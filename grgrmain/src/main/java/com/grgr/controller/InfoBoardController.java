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
import org.springframework.web.util.HtmlUtils;

import com.grgr.dto.InfoBoard;
import com.grgr.exception.FileUploadFailException;
import com.grgr.exception.PostUpdateException;
import com.grgr.exception.WriteNullException;
import com.grgr.service.InfoBoardService;
import com.grgr.util.SearchCondition;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//작성자 : 김정현 
// 수정일 - 수정내용
// 0908 - 위치정보를 searchCondition 객체에 주가하였음 
//	+ 세션 정보의 값 중 ㅇㅇ구에 대한 내용만 추출하여 searchCondition의 loginLocation에 저장하는 메서드 생성   
//0909 - 글 수정시, 사진의 추가업로드 및 삭제기능 추가 예정
@Controller
@RequestMapping("/infoboard")
@RequiredArgsConstructor
@Slf4j
public class InfoBoardController {
	private final InfoBoardService infoBoardService;

	// 글목록 (전체 & 검색 조건)
	@RequestMapping("/list")
	public String list(SearchCondition searchCondition, HttpSession session, Model model) {
		searchCondition.setLoginLocation(extractLoginLocation(session));
		Integer loginUserStatus = (Integer) session.getAttribute("loginUserStatus");
		log.info("loginUserStatus : " + loginUserStatus);
		Map<String, Object> result = infoBoardService.getInfoBoardList(searchCondition,loginUserStatus);
		log.info("GET INFOBOARDLIST 메서드 수행 완료");
		
		model.addAttribute("infoBoardList", result.get("infoBoardList"));
		model.addAttribute("pager", result.get("pager"));
		model.addAttribute("fileList", result.get("fileList"));
		return "board/info_boardlist";
	}

	// 선택 게시글 조회 -> 읽어올때, 글번호로 사진정보를 select해서 출력할것 -> 글 수정, 삭제, 숨김권한 필요 ,
	@GetMapping("/read")
	public String infoBoardRead(@RequestParam int infoBno, SearchCondition searchCondition, HttpSession session,
			Model model) {

		searchCondition.setLoginLocation(extractLoginLocation(session));
		Integer loginUno = (Integer)session.getAttribute("loginUno");
		Integer loginUserStatus = (Integer) session.getAttribute("loginUserStatus");
		Map<String, Object> infoBoardWithFiles = infoBoardService.getInfoBoard(loginUno, infoBno);
		Integer prevInfoBno = infoBoardService.prevInfoBno(searchCondition, infoBno, loginUserStatus);
		Integer nextInfoBno = infoBoardService.nextInfoBno(searchCondition, infoBno, loginUserStatus);
		model.addAllAttributes(infoBoardWithFiles);
		model.addAttribute("nextInfoBno", nextInfoBno);
		model.addAttribute("prevInfoBno", prevInfoBno);
		model.addAttribute("isLastPost", nextInfoBno == null);
		model.addAttribute("isFirstPost", prevInfoBno == null);
		model.addAttribute("searchCondition", searchCondition); // 검색 조건 추가

		return "board/info_board";
	}

	// 글쓰기 페이지 요청
	@GetMapping(value = "/write")
	public String infoBoardWrite(SearchCondition searchCondition, HttpSession session, Model model) {
		searchCondition.setLoginLocation(extractLoginLocation(session));
		model.addAttribute("searchCondition", searchCondition);
		return "board/info_write";
	}

	// 글 작성 및 제출
	@PostMapping(value = "/write")
	public String infoBoardWrite(InfoBoard infoBoard,
			@RequestParam(value = "files", required = false) List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {
		infoBoard.setInfoTitle(HtmlUtils.htmlEscape(infoBoard.getInfoTitle()));
		infoBoard.setInfoContent(HtmlUtils.htmlEscape(infoBoard.getInfoContent()));
		int newBno = infoBoardService.addInfoBoard(infoBoard, files);

		return "redirect:/infoboard/read?infoBno=" + newBno;
	}

	// 글 수정페이지 요청
	@GetMapping("/modify")
	public String infoBoardModify(int infoBno, SearchCondition searchCondition, HttpSession session, Model model) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		searchCondition.setLoginLocation(extractLoginLocation(session));
		Map<String, Object> infoBoardWithFiles = infoBoardService.getInfoBoard(loginUno, infoBno);
		InfoBoard infoBoard = (InfoBoard) infoBoardWithFiles.get("infoBoard");

		if (loginUno != infoBoard.getUno()) {
			return "/404";
		}
		model.addAllAttributes(infoBoardWithFiles);
		model.addAttribute("searchCondition", searchCondition);
		return "board/info_modify";
	}

	// 글 수정 제출
	@PostMapping(value = "/modify")
	public String infoBoardModify(InfoBoard infoBoard,
			@RequestParam(value = "files", required = false) List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {
		if (infoBoard.getInfoTitle() == null || infoBoard.getInfoContent() == null) {
			throw new WriteNullException("제목 또는 내용이 비어있습니다.");
		}
		infoBoard.setInfoTitle(HtmlUtils.htmlEscape(infoBoard.getInfoTitle()));
		infoBoard.setInfoContent(HtmlUtils.htmlEscape(infoBoard.getInfoContent()));
		infoBoardService.modifyInfoBoard(infoBoard, files);
		return "redirect:/infoboard/read?infoBno=" + infoBoard.getInfoBno();

	}

	// 글 제거
	@RequestMapping("/remove")
	public String infoBoardRemove(@RequestParam Integer infoBno, SearchCondition searchCondition, HttpSession session,
			RedirectAttributes rattr) throws PostUpdateException {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		infoBoardService.removeInfoBoard(infoBno, loginUno);
		String redirectUri = "redirect:/infoboard/list" + searchCondition.getQueryString();
		return redirectUri;
	}

	// 글 숨김
	@GetMapping("/hide")
	public String infoBoardBlind(@RequestParam Integer infoBno, SearchCondition searchCondition, HttpSession session) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Integer loginUserStatus = (Integer) session.getAttribute("loginUserStatus");
		infoBoardService.hideInfoBoard(infoBno, loginUno, loginUserStatus);

		String redirectUri = "redirect:/infoboard/list" + searchCondition.getQueryString();
		return redirectUri;

	}
	// 세션의 위치정보에서 <구>에 대한 정보만 추출하는 메서드
	private String extractLoginLocation(HttpSession session) {
		String loginLocation = (String) session.getAttribute("loginLocation");
		if (loginLocation != null && !loginLocation.trim().isEmpty()) {
			return loginLocation.split(",")[1].trim();

		}
		return null;
	}

}
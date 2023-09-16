package com.grgr.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

import com.grgr.dto.InfoComment;
import com.grgr.exception.CommentBlindException;
import com.grgr.exception.CommentInsertException;
import com.grgr.exception.CommentModifyException;
import com.grgr.exception.CommentRemoveException;
import com.grgr.service.InfoCommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/infocomment")
@RequiredArgsConstructor
@Slf4j
public class InfoCommentController {
	private final InfoCommentService infoCommentService;

	// 댓글 조회 (GET 사용)
	@GetMapping("/list/{infoBno}")
	public Map<String, Object> commentList(@PathVariable int infoBno, @RequestParam(defaultValue = "1") int pageNum,
			HttpSession session) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> resultMap = infoCommentService.getInfoCommentList(infoBno, pageNum);

		return resultMap;
	}

	// 댓글 삽입(POST 사용)
	@PostMapping("/write/{infoBno}")
	public ResponseEntity<String> infoCommentAdd(@RequestBody InfoComment infoComment, @PathVariable int infoBno,
			HttpSession session) throws CommentInsertException {
		int loginUno = (int) session.getAttribute("loginUno");
		infoComment.setUno(loginUno);
		infoComment.setInfoBno(infoBno);
		infoCommentService.addInfoComment(infoComment);

		return new ResponseEntity<String>("WRT_OK", HttpStatus.OK);
	}

	// 댓글 수정(PUT 사용)
	@PatchMapping("/modify/{infoCommentNo}")
	public ResponseEntity<String> infoCommentModify(@PathVariable int infoCommentNo,
			@RequestBody InfoComment infoComment, HttpSession session) throws CommentModifyException {
		int loginUno = (int) session.getAttribute("loginUno");
		infoComment.setUno(loginUno);
		infoComment.setInfoCommentContent(HtmlUtils.htmlEscape(infoComment.getInfoCommentContent()));
		infoCommentService.modifyInfoComment(infoComment);
		return new ResponseEntity<String>("MOD_OK", HttpStatus.OK);
	}
 
	// 댓글 삭제(본인)
	@PutMapping("/remove/{infoCommentNo}")
	public ResponseEntity<String> infoCommentRemove(@PathVariable int infoCommentNo, HttpSession session)
			throws CommentRemoveException {
		int loginUno = (int) session.getAttribute("loginUno");
		infoCommentService.removeInfoComment(infoCommentNo, loginUno);

		return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);

	}

	// 댓글 숨김
	@PutMapping("/hide/{infoCommentNo}")
	public ResponseEntity<String> infoCommentBlind(@PathVariable int infoCommentNo, HttpSession session)
			throws CommentBlindException {
		int loginUno = (int) session.getAttribute("loginUno");
		int loginUserStatus = (int) session.getAttribute("loginUserStatus");
		log.info("hide메서드");
		infoCommentService.hideInfoComment(loginUno, infoCommentNo, loginUserStatus);

		return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
	}

}

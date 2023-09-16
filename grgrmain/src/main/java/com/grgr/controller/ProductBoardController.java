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

import com.grgr.dto.ProductBoardVO;
import com.grgr.exception.FileUploadFailException;
import com.grgr.exception.WriteNullException;
import com.grgr.service.ProductBoardService;
import com.grgr.util.SearchCondition;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/productboard") // 메인페이지 확인 필요
public class ProductBoardController {

	private final ProductBoardService productBoardService;

	/* 상품 목록 페이지 */
	@RequestMapping("/list")
	public String productBoardListGet(SearchCondition searchCondition, Model model) {
		System.out.println("목록 진입");
		Map<String, Object> result = productBoardService.getProductBoardList(searchCondition);
		model.addAttribute("productBoardList", result.get("productBoardList"));		
		model.addAttribute("pager", result.get("pager"));
		model.addAttribute("fileList", result.get("fileList"));
		return "board/product_boardlist";
	}

	/* 상품 조회 */
	@GetMapping("/get")
	public String productBoardPageGet(@RequestParam int productId, SearchCondition searchCondition, Model model) {
		try {
			Map<String, Object> productBoardWithFiles = productBoardService.getProductBoard(productId);
			Integer preProductId = productBoardService.prevProductId(searchCondition, productId);
			Integer nextProductId = productBoardService.nextProductId(searchCondition, productId);
			model.addAllAttributes(productBoardWithFiles);
			model.addAttribute("nextProductId", nextProductId);
			model.addAttribute("preProductId", preProductId);
			model.addAttribute("isLastPost", nextProductId == null);
			model.addAttribute("isFirstPost", preProductId == null);
			model.addAttribute("searchCondition", searchCondition);
			model.addAttribute("userInfo", productBoardService.getBoardUserInfo(productId));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/product_board";

	}

	/* 상품 등록 페이지 접속 */
	@GetMapping(value = "/insert")
	public String ProductBoardInsertGet(SearchCondition searchCondition, HttpSession session, Model model) {
		model.addAttribute("searchCondition", searchCondition);
		return "board/product_insert";
	}

	/* 상품 등록 */
	@PostMapping("/insert")
	public String ProductBoardInsertPost(ProductBoardVO productBoard,
			@RequestParam(value = "files", required = false) List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {

		productBoardService.addProduct(productBoard, files);

		return "redirect:/productboard/list";
	}

	/* 수정 페이지 이동 */
	@GetMapping("/modify")
	public String ProductBoardModifyGet(int productId, SearchCondition searchCondition, HttpSession session,
			Model model) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");

		Map<String, Object> productBoardWithFiles = productBoardService.getProductBoard(productId);
		ProductBoardVO productBoard = (ProductBoardVO) productBoardWithFiles.get("productBoard");

		if (loginUno != productBoard.getUno()) {
			return "/404";
		}

		model.addAllAttributes(productBoardWithFiles);
		model.addAttribute("searchCondition", searchCondition);

		return "board/product_modify";
	}

	/* 페이지 수정 */
	@PostMapping(value = "/modify")
	public String ProductBoardModifyPost(ProductBoardVO productBoard, RedirectAttributes rttr) {
		if (productBoard.getProductTitle() == null || productBoard.getProductContent() == null) {
			throw new WriteNullException("제목 또는 내용이 비어있습니다.");
		}

		productBoardService.modifyProduct(productBoard);
		return "redirect:/productboard/get?productId=" + productBoard.getProductId();
	}

	/* 페이지 삭제 */
	@RequestMapping("/remove")
	public String ProductBoardDeletePost(@RequestParam Integer productId, SearchCondition searchCondition,
			HttpSession session, RedirectAttributes rattr) {

		Integer loginUno = (Integer) session.getAttribute("loginUno");
		productBoardService.removeProduct(productId, loginUno);

		String redirectUri = "redirect:/productboard/list" + searchCondition.getQueryString();
		return redirectUri;

	}

	// 글 숨김
	@GetMapping("/hide")
	public String infoBoardBlind(@RequestParam Integer productId, SearchCondition searchCondition,
			HttpSession session) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Integer loginUserStatus = (Integer) session.getAttribute("loginUserStatus");
		productBoardService.hideProductBoard(productId, loginUno, loginUserStatus);

		String redirectUri = "redirect:/productboard/list" + searchCondition.getQueryString();
		return redirectUri;

	}

}

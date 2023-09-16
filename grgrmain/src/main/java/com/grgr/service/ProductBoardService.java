package com.grgr.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.grgr.dto.ProductBoardVO;
import com.grgr.dto.ProductUserDTO;
import com.grgr.exception.FileUploadFailException;
import com.grgr.exception.WriteNullException;
import com.grgr.util.SearchCondition;

public interface ProductBoardService {

	/* 게시판 목록 */
	Map<String, Object> getProductBoardList(SearchCondition searchCondition);

	/* 게시판 조회 */
	Map<String, Object> getProductBoard(int productId);

	Integer prevProductId(SearchCondition searchCondition, int productId);

	Integer nextProductId(SearchCondition searchCondition, int productId);

	/* 게시판 등록 */
	int addProduct(ProductBoardVO productBoard, List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException;

	/* 게시판 수정 */
	void modifyProduct(ProductBoardVO productBoard);

	/* 게시판 삭제 */
	void removeProduct(int productId, int uno);

	/* 조회수 증가 */
	// int increaseProductViewCnt(int productId);

	/* 신고수 증가 */
	// int increaseProductReportNo(int productId);

	/* 게시판 총 갯수 */
	int productBoardCount(SearchCondition searchCondition);

	/* 게시판 상품 정보와 회원 정보 함께 조회 */
	ProductUserDTO getBoardUserInfo(int productId);

	void hideProductBoard(int productId, int loginUser, int loginUserStatus);

}

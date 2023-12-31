package com.grgr.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.grgr.dao.ProductBoardDAO;
import com.grgr.dto.InfoBoard;
import com.grgr.dto.InfoFile;
import com.grgr.dto.ProductBoardVO;
import com.grgr.dto.ProductFile;
import com.grgr.dto.ProductUserDTO;
import com.grgr.exception.FileDeleteException;
import com.grgr.exception.FileUploadFailException;
import com.grgr.exception.PostUpdateException;
import com.grgr.exception.WriteNullException;
import com.grgr.util.Pager;
import com.grgr.util.SearchCondition;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductBoardServiceImpl implements ProductBoardService {

	private final ProductBoardDAO productBoardDAO;
	private final WebApplicationContext context;

	/* 상품목록 조회 */
	@Override
	public Map<String, Object> getProductBoardList(SearchCondition searchCondition) {

		Map<String, Object> searchMap = createSearchMap(searchCondition);
		int totalBoard = productBoardCount(searchCondition);

		Pager pager = new Pager(totalBoard, searchCondition);
		// 페이징 계산
		searchMap.put("startRow", pager.getStartRow());
		searchMap.put("endRow", pager.getEndRow());

		List<ProductBoardVO> productBoardList = productBoardDAO.selectProductBoardList(searchMap);

		List<String> fileList = new ArrayList<String>();
		for (ProductBoardVO productBoard : productBoardList) {
			List<ProductFile> productFiles = productBoardDAO.selectProductFile(productBoard.getProductId());
			if (!productFiles.isEmpty()) {
				fileList.add(productFiles.get(0).getProductFileUpload());
			} else {
				fileList.add("placeholder-square.jpg");
			}
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("productBoardList", productBoardList);
		resultMap.put("pager", pager); // pager 객체를 반환
		// resultMap.put("searchMap", searchMap);
		resultMap.put("fileList", fileList);

		return resultMap;
	}

	/* 특정 상품 조회 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> getProductBoard(int productId) {

		Map<String, Object> readMap = new HashMap<String, Object>();

		ProductBoardVO productBoard = productBoardDAO.selectProductBoard(productId);
		String productConentIncludeEnter = productBoard.getProductContent().replace("\r\n", "<br>"); // 개행문자를 포함하여
																										// 출력하기위함
		productBoard.setProductContent(productConentIncludeEnter);
		readMap.put("productBoard", productBoard);
		readMap.put("productFiles", productBoardDAO.selectProductFile(productId));

		return readMap;
	}

	/* 페이징 */
	@Override
	public Integer prevProductId(SearchCondition searchCondition, int productId) {
		Map<String, Object> searchMap = createSearchMap(searchCondition);
		searchMap.put("productId", productId);

		return productBoardDAO.selectPrevProductId(searchMap);
	}

	/* 페이징 */
	@Override
	public Integer nextProductId(SearchCondition searchCondition, int productId) {
		Map<String, Object> searchMap = createSearchMap(searchCondition);
		searchMap.put("productId", productId);

		return productBoardDAO.selectNextProductId(searchMap);
	}

	/* 상품 등록 */
	@Override
	@Transactional(rollbackFor = Exception.class)	
	public int addProduct(ProductBoardVO productBoard, List<MultipartFile> files)
			throws WriteNullException, FileUploadFailException, IOException {

		if (productBoard.getProductTitle() == null || productBoard.getProductContent() == null) {
			throw new WriteNullException("상품의 제목과 내용을 입력해주세요.");
		}

		productBoardDAO.insertProduct(productBoard);

		imgUpload(productBoard, files);

		return productBoard.getProductId();
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void modifyProduct(ProductBoardVO productBoard, List<MultipartFile> files)
			throws FileUploadFailException, IOException {
		// TODO Auto-generated method stub
		productBoardDAO.updateProduct(productBoard);

		imgUpload(productBoard, files);
	}

	@Override
	public void removeProduct(int productId, int uno) throws PostUpdateException {
		// TODO Auto-generated method stub
		int result = productBoardDAO.deleteProduct(productId, uno);

		if (result < 1) {
			throw new PostUpdateException("상품 삭제에 실패하였습니다");
		}
	}

	@Override
	public int productBoardCount(SearchCondition searchCondition) {
		Map<String, Object> searchMap = createSearchMap(searchCondition);

		return productBoardDAO.productBoardCount(searchMap);
	}

	@Override
	public ProductUserDTO getBoardUserInfo(int productId) {
		// TODO Auto-generated method stub
		return productBoardDAO.getBoardUserInfo(productId);
	}

	@Override
	public void hideProductBoard(int productId, int loginUno, int loginUserStatus) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productId", productId);
		map.put("uno", loginUno);
		map.put("userStatus", loginUserStatus);

		productBoardDAO.blindProductBoard(map);
	}

	// 검색관련 맵객체 생성 메서드
	private Map<String, Object> createSearchMap(SearchCondition searchCondition) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		if (searchCondition != null) {
			if (searchCondition.getSearchType() != null && !searchCondition.getSearchType().isEmpty()) {
				searchMap.put("searchType", searchCondition.getSearchType());
			}
			if (searchCondition.getSearchKeyword() != null && !searchCondition.getSearchKeyword().isEmpty()) {
				searchMap.put("searchKeyword", searchCondition.getSearchKeyword());
			}
			if (searchCondition.getKeyword() != null && !searchCondition.getKeyword().trim().isEmpty()) {
				searchMap.put("infoKeyword", searchCondition.getKeyword().trim());
			}
//				if (searchCondition.getLocation() != null && !searchCondition.getLocation().trim().isEmpty()) {
//					searchMap.put("infoLoc", searchCondition.getLocation().trim());
//				}
		}

		return searchMap;
	}

	// 이미지 파일 삭제
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void removeProductFiles(List<Integer> deleteFileList) throws FileDeleteException {
		// TODO Auto-generated method stub
		for (Integer fileNo : deleteFileList) {
			productBoardDAO.deleteProductFile(fileNo);
		}
	}

	// 파일 업로드 처리 메서드
	private void imgUpload(ProductBoardVO productBoard, List<MultipartFile> files)
			throws FileUploadFailException, IOException {

		String uploadDirectory = context.getServletContext().getRealPath("/resources/upload");

		// 파일을 하나도 업로드하지 않아도 되므로 null이 아닐시에만 업로드 작업
		if (files != null && !files.isEmpty()) {
			for (MultipartFile multipartfile : files) {
				if (multipartfile.isEmpty()) {
					continue; // 파일이 비어 있으면 다음 파일로 넘어감
				}

				if (!multipartfile.getContentType().startsWith("image/")) {
					throw new FileUploadFailException("사진이 아닌 파일입니다.");
				}

				String uploadFileName = UUID.randomUUID().toString() + "_" + multipartfile.getOriginalFilename();
				System.out.println(uploadFileName);
				File file = new File(uploadDirectory, uploadFileName);
				System.out.println(file);

				multipartfile.transferTo(file);

				// 파일 정보 객체 생성
				ProductFile productFile = new ProductFile();
				productFile.setProductId(productBoard.getProductId());
				productFile.setProductFileOrigin(multipartfile.getOriginalFilename());
				productFile.setProductFileUpload(uploadFileName);

				productBoardDAO.insertProductFile(productFile);

			}
		}
	}
}

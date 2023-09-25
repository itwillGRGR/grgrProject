package com.grgr.service;

import java.io.ObjectOutputStream.PutField;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.FetchProfile.Item;
import javax.servlet.http.HttpSession;

import org.junit.internal.runners.statements.Fail;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.grgr.dao.OrderPageDAO;
import com.grgr.dao.ProductCartDAO;
import com.grgr.dto.OrderListDTO;
import com.grgr.dto.OrderPage;
import com.grgr.dto.ProductBoardVO;
import com.grgr.dto.ProductCartDTO;
import com.grgr.dto.Userinfo;
import com.grgr.exception.CartDeleteFailException;
import com.grgr.exception.CartNullException;
import com.grgr.exception.OrderInsertFailException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderPageServiceImpl implements OrderPageService {
	private final OrderPageDAO orderPageDAO;
	private final ProductCartDAO productCartDAO;

	// 장바구니 목록을 주문테이블에 저장 - 주문테이블에 저장한 장바구니 목록은 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void addOrderedItems(List<Integer> selectedItemList, int loginUno, HttpSession session)
			throws CartNullException, CartDeleteFailException, OrderInsertFailException {
		int orderGroup = orderPageDAO.selectLastOrderGroup() + 1;

		if (selectedItemList == null) {
			throw new CartNullException("장바구니에 상품이 존재하지 않습니다.");
		}

		for (int cartNo : selectedItemList) {
			Map<String, Object> map = new HashMap<>();
			map.put("productCartNo", cartNo);
			map.put("uno", loginUno);
			ProductCartDTO cartDTO = orderPageDAO.selectCartByCartNo(map);
			if (cartDTO == null) {
				throw new CartNullException("회원님의 장바구니에 존재하지 않는 상품입니다.");
			}
			OrderPage orderPage = new OrderPage();
			orderPage.setOrderGroup(orderGroup);
			orderPage.setProductId(cartDTO.getProductId());
			orderPage.setUno(cartDTO.getUno());
			orderPage.setOrderQuantity(cartDTO.getProductCount());

			int result = orderPageDAO.insertOrderPage(orderPage);
			if (result < 1) {
				throw new OrderInsertFailException("주문목록에 담는 과정에 오류가 발생하였습니다.");
			}

			result = productCartDAO.deleteCart(cartNo);

			if (result < 1) {
				throw new CartDeleteFailException("장바구니 삭제시에 예상치못한 오류가 발생하였습니다.");
			}
		}
		session.setAttribute("orderGroup", orderGroup);
	}
	// 바로구매시 주문테이블에 저장하는 과정을 위한 서비스 클래스
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void addDirectPurchase(OrderPage orderPage, HttpSession session) throws OrderInsertFailException {
		int orderGroup = orderPageDAO.selectLastOrderGroup() + 1;
		orderPage.setOrderGroup(orderGroup);
		int result = orderPageDAO.insertOrderPage(orderPage);
		if(result<1) {
			throw new OrderInsertFailException("주문목록에 담는 과정에 오류가 발생하였습니다.");
		}
		
		session.setAttribute("orderGroup", orderGroup);
		
	}
	
	
	
/***************************************************************************************************************************/	
	@Override
	public Map<String, Object> getOrderInfo(int loginUno) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Userinfo userinfo = orderPageDAO.selectOrderUserinfo(loginUno);
		List<OrderListDTO> orderList = orderPageDAO.selectRecentOrderListByUno(loginUno);
		map.put("userinfo", userinfo);
		map.put("orderList", orderList);

		return map;
	}
	
	@Override
	public OrderPage getOrderInfo(String orderGroup) {
        return orderPageDAO.getOrderInfo(orderGroup);
	}
}
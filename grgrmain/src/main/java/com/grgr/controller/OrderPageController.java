package com.grgr.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.grgr.dto.OrderPage;
import com.grgr.dto.ProductCartDTO;
import com.grgr.exception.CartDeleteFailException;
import com.grgr.exception.CartNullException;
import com.grgr.exception.OrderInsertFailException;
import com.grgr.service.OrderPageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/order")
@RequiredArgsConstructor
@Slf4j
public class OrderPageController {
	private final OrderPageService orderPageService;
	
	// 주문테이블에 저장
	@PostMapping("/add")
	public ResponseEntity<String> addOrderItems(@RequestParam("selectedItemList[]") List<Integer> selectedItemList, @RequestParam int totalPrice, HttpSession session ) throws CartNullException, CartDeleteFailException, OrderInsertFailException {
		
		session.setAttribute("totalPrice", totalPrice);
		
		
		Integer loginUno =(Integer)session.getAttribute("loginUno");
		
		//주문테이블에 저장 및 장바구니에서 삭제
		orderPageService.addOrderedItems(selectedItemList, loginUno,session);
		
		
		return new ResponseEntity<String> ("success", HttpStatus.OK);
	}

	
	
	// 바로구매
	@PostMapping("/product")
	public ResponseEntity<String> productOrderPage(@RequestBody OrderPage orderPage, HttpSession session) throws OrderInsertFailException {

		orderPageService.addDirectPurchase(orderPage, session);
		session.setAttribute("totalPrice", orderPage.getTotalPrice());
		return new ResponseEntity<String> ("success", HttpStatus.OK);
	}
}
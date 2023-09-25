package com.grgr.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MyOrderListDTO {
	/* 구매번호 */
	private int orderNo;
	private int orderGroup;

	/* 구매자 회원번호 */
	private int uno;

	/* 상품 번호 */
	private int product_id;

	/* 구매 수량 */
	private int orderQuantity;

	/* 구매일 */
	private Date orderDate;

	/* 상품 총합 */
	private int totalPrice;

	/* 상품 가격 */
	private int productPrice;

	/* 상품 이름 */
	private String productTitle;
}

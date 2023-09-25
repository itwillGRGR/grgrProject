package com.grgr.dto;

import java.sql.Date;

import lombok.Data;

/*
CREATE TABLE ORDERPAGE(
    ORDER_NO NUMBER PRIMARY KEY,
    ORDER_GROUP NUMBER,
    UNO NUMBER,
    CONSTRAINT ORDERPAGE_UNO_FK FOREIGN KEY(UNO) REFERENCES USERINFO(UNO),
    PRODUCT_ID NUMBER,
    CONSTRAINT ORDERPAGE_PRODUCT_ID_FK FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCT_BOARD(PRODUCT_ID),
    ORDER_QUANTITY NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE,
    ORDER_STATUS NUMBER DEFAULT 1,-- 1: 결제대기 2: 결제중, 3: 결제완료
    ORDER_UPDATE DATE DEFAULT SYSDATE);
    
CREATE SEQUENCE ORDERPAGE_SEQ;
 */

@Data
public class OrderPage {
	private int orderNo;//주문 테이블 번호(PK)
	private int orderGroup; //주문번호
	private int uno;//회원번호
	private int productId;//상품번호
	private Date orderDate;//주문 일자
	private int orderStatus;//주문 상태(1: 결제대기 2: 결제중, 3: 결제완료)
	private int orderQuantity;//주문 수량
	private Date orderUpdate;//주문상태변경일
	private Long totalPrice;
}
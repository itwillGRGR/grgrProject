package com.grgr.dto;

import java.sql.Date;

import lombok.Data;

/*
0920 - 안소연_결제 관련 정보를 저장하기 위한 클래스 생성

CREATE TABLE PAYMENT(IMP_UID VARCHAR2(100) PRIMARY KEY, 
    UNO NUMBER,
    CONSTRAINT PAYMENT_UNO_FK FOREIGN KEY(UNO) REFERENCES USERINFO(UNO),
    MERCHARNT_UID VARCHAR2(100),
    AMOUNT NUMBER, 
    PAY_DATE DATE DEFAULT SYSDATE, 
    PAY_STATUS VARCHAR2(50));

이름            널?       유형            
------------- -------- ------------- 
IMP_UID       NOT NULL VARCHAR2(100) - 결제 관련 Open API에서 제공되는 고유값
UNO                    NUMBER        - 유저번호
MERCHARNT_UID          VARCHAR2(100) - 주문번호
AMOUNT                 NUMBER        - 결제금액
STATUS                 VARCHAR2(20)  - 결제상태
*/



@Data
public class Payment {
    private String impUid;
    private String merchantUid;
    private Long amount;
    private String status;
}

package com.grgr.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;

import com.grgr.dto.Payment;
import com.grgr.service.PaymentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/order/payment")
@RequiredArgsConstructor
@Slf4j
public class PaymentsController {
    private final PaymentService paymentService;

    @RequestMapping(value = "/pay", method = RequestMethod.GET)
    public String pay() {
        return "pay";
    }

    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    @ResponseBody
    public String pay(@RequestBody Payment payment, HttpSession session) {
    	
    	
            return "ok";
       
    } 

  //결제 후 결제 금액을 검증하여 응답하는 요청 처리 메소드
  	@RequestMapping(value="/complate", method = RequestMethod.POST)
  	@ResponseBody
  	
  	public String complate(@RequestBody Payment payment, HttpSession session) {
  		//접근 토큰을 발급받아 저장
  		String accessToken=paymentService.getAccessToken(payment);
  		
  		//토큰과 결제고유값을 전달하여 API를 이용하여 결제정보를 반환받아 저장
  		Payment returnPayment=paymentService.getPayment(accessToken, payment.getImpUid());
  		

  		//세션에 저장된 결제 금액을 반환받아 저장
  		Long beforeAmount=Long.parseLong((Integer)session.getAttribute("totalPrice")+"");
  		log.info(beforeAmount+"");
  		//결제된 결제금액을 반환받아 저장
  		Long amount=returnPayment.getAmount();
  		log.info(amount+"");
  		if(beforeAmount.equals(amount)) {//검증 성공
  			paymentService.addPayment(returnPayment);//테이블에 결제정보 삽입 처리
  			return "success";
  		} else {//검증 실패(결제 금액 불일치) - 위변조된 결제
  			paymentService.cancelPayment(accessToken, returnPayment);
  			return "forgery";
  		}
  	}
}
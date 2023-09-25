<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPRING</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
	<h1>결제페이지</h1>
	<hr>
	<button type="button" id="html5_inicis" class="pay">일반결제(KG이니시스)</button>
	<button type="button" id="kakaopay" class="pay">간편결제(카카오페이)</button>

	<script type="text/javascript">

	$(".pay").click(function() {
		var pg=$(this).attr("id");
		//alert(pg);
		
		var IMP=window.IMP;
		//IMP 객체 초기화 - 가맹점 식별코드
		IMP.init("imp00885377");
		
		//주문번호 - 주문테이블에서 제공된 값 사용
		var merchantUid=${sessionScope.orderGroup};;
		//결제금액 - 주문테이블에서 제공된 값 사용
		var amount=${sessionScope.totalPrice};
				
		//결제 전 주문번호와 결제금액을 세션에 저장하기 위한 페이지 요청
		// => 결제 후 결제정보와 비교하여 검증하기 위해 세션에 저장 
		$.ajax({
			type: "post",
			url: "<c:url value="/order/payment/pay"/>",
			
			contentType: "application/json",
			data: JSON.stringify({"merchantUid":merchantUid, "amount":amount}),
			dataType: "text",
			success: function(result) {
				if(result=="ok") {
					//결제를 요청하는 메소드 호출
					IMP.request_pay({
						// 결제 대행사 : kakaopay, html5_inicis, nice, jtnet, uplus, danal, payco 등
						pg : pg,
						// 결제 방식 : card(카드), samsung(삼성페이), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
						pay_method : "card",
						//주문번호
						merchant_uid : merchantUid,
						//결제금액
						amount : amount,
						//결제창에 보여질 제품명
						name: "테스트상품",

					}, function(response) {//결제 관련 응답 결과를 제공받아 처리하는 함수
						//response : 응답결과를 저장한 Object 객체
						if (response.success) {//결제한 경우
							//결제금액을 검증하기 위한 페이지를 요청
							$.ajax({
								type: "post",
								url: "<c:url value="/order/payment/complate"/>",
								contentType: "application/json",
								data: JSON.stringify({"impUid": response.imp_uid, "merchantUid": response.merchant_uid}),
								dataType: "text",
								success: function(result) {
									if(result == "success") {
										//결제 성공 페이지로 이동
										alert("결제 성공");
										
									} else if(result == "forgery") {
										alert("결제 forgery");
									} else{
										alert("결제 실패")
									}
								}, 
								error: function(xhr) {
									alert("에러 = "+xhr.status);
								}
							});
						}
					});
				}
			}, 
			error: function(xhr) {
				alert("에러 = "+xhr.status);
			}
		});
		
	});
		
	
					
	</script>
</body>
</html>
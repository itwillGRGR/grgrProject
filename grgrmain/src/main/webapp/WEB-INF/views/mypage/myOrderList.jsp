<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>

<style>
.va-middle {
	font-size: 20px;
}

.page-link {
	font-size: 20px;
}

.mb-20 {
	font-size: 2rem;
	font-weight: 'bold';
}

.board-images {
	width: 100px;
}

#comment-reply {
	margin-bottom: 20px; /* 아래쪽 여백을 20px로 설정 */
	clear: both;
}

.comment-style {
	font-size: 15px;
	font-weight: normal;
}

.comment {
	border-top: 1px solid #97989d;
}

.table-container table {
	margin-bottom: 60px; /* 원하는 간격 크기(px)로 조절하세요 */
}
</style>
</head>

<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<!-- 배너 -->
	<c:set var="boardName" value="주문 목록" />
	<header class="xl bg-img bg-fixed"
		style="background-color: white; padding-bottom: 50px; padding-top: 80px;">
		<div class="container text-center" style="font-size: 100%;">
			<h1 class="page-title">주문 목록</h1>

		</div>
		<!-- / container -->
	</header>

	<div id="preloader">
		<div class="preloader">
			<span></span> <span></span>
		</div>
	</div>

	<div id="top"></div>
	<!-- / top -->
	<section class="lg" style="padding-top: 30px;">
		<div class="container">
			<div class="promo-box">

				<!-- / nav tabs -->
			</div>
			<!-- / tab-content -->
		</div>

		<br>

		<div class="container" style="text-align: center;">
			<div class="row">
				<div class="col-lg-12 tablet-lg-top-30 page-content">
					<div class="project-post">
						<div class="page-content">
							<!-- project: 장바구니 list 출력 -->
							<c:set var="i" value="0" />
							<c:set var="currentOrderGroup" value="" />
							<div class="table-container">
								<c:forEach items="${myOrderList}" var="myOrder">
									<c:choose>
										<c:when test="${myOrder.orderGroup != currentOrderGroup}">
											<!-- 새로운 주문 번호인 경우 새로운 테이블 시작 -->
											<c:set var="currentOrderGroup" value="${myOrder.orderGroup}" />
											<c:set var="totalPrice" value="0" />
											<!-- 새로운 주문 번호 테이블마다 totalPrice 초기화 -->
											<table class="table table-xl">
												<thead class="thead-light">
													<tr>
														<th colspan="4">주문번호: ${myOrder.orderGroup}</th>
													</tr>
													<tr>
														<th width="100">상품명</th>
														<th width="100">수량</th>
														<th width="100">상품금액</th>
														<th width="100">구매일자</th>
													</tr>
												</thead>
												</c:when>
												<c:otherwise>
													<!-- 주문 번호가 같은 경우 이전 테이블 닫지 않음 -->
												</c:otherwise>
												</c:choose>
												<tr>
													<td width="100">${myOrder.productTitle}</td>
													<td width="100">${myOrder.orderQuantity}</td>
													<td width="100">${myOrder.productPrice}</td>
													<td width="100">${myOrder.orderDate}</td>
												</tr>
												<c:set var="totalPrice"
													value="${totalPrice + (myOrder.orderQuantity * myOrder.productPrice)}" />
												<!-- 총 가격 누적 -->
												<c:if
													test="${i == myOrderList.size() - 1 || myOrder.orderGroup != myOrderList[i + 1].orderGroup}">
													<!-- 마지막 주문 번호 또는 다음 주문 번호가 다른 경우 테이블 닫기 -->
													<!-- 주문 번호가 같은 경우 총 가격 출력 -->
													<table class="table table-xl">
														<tr>
															<td colspan="2">총 가격</td>
															<td colspan="2" class="text-right">${totalPrice}</td>
														</tr>
													</table>
												</c:if>
												<c:set var="i" value="${i + 1}" />
								</c:forEach>
							</div>
							<!-- / owl-carousel -->
						</div>
						<!-- / page-content -->
					</div>
					<!-- / project-post -->
				</div>
				<!-- / column -->
			</div>
			<!-- / row -->
		</div>




	</section>


	<a href="#top" class="scroll-to-top is-hidden smooth-scroll"
		data-nav-status="toggle"><i class="fas fa-chevron-up"></i></a>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />

	<!-- core JavaScript -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<!-- / core JavaScript -->

	<!-- preloader -->
	<script src="${pageContext.request.contextPath}/assets/js/preloader.js"></script>
	<!-- / preloader -->

	<!-- hide nav -->
	<script src="${pageContext.request.contextPath}/assets/js/hide-nav.js"></script>
	<!-- / hide nav -->

	<!-- form validation -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.validate.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/form-validation.js"></script>
	<!-- end of form validation -->

	<!-- Owl Carousel -->
	<script
		src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
	<script>
		$('#product-carousel').owlCarousel({
			loop : true,
			margin : 0,
			nav : false,
			dots : true,
			items : 1,
			animateIn : 'fadeIn',
			animateOut : 'fadeOut'
		});
	</script>
	<!-- / Owl Carousel -->


	<script>
		$(document).ready(function() {
			if (Modernizr.touch) {
				// show the close overlay button
				$('.close-overlay').removeClass('hidden');
				// handle the adding of hover class when clicked
				$('.img').click(function(e) {
					if (!$(this).hasClass('hover')) {
						$(this).addClass('hover');
					}
				});
				// handle the closing of the overlay
				$('.close-overlay').click(function(e) {
					e.preventDefault();
					e.stopPropagation();
					if ($(this).closest('.img').hasClass('hover')) {
						$(this).closest('.img').removeClass('hover');
					}
				});
			} else {
				// handle the mouseenter functionality
				$('.img').mouseenter(function() {
					$(this).addClass('hover');
				})
				// handle the mouseleave functionality
				.mouseleave(function() { // 추가된 부분
					$(this).removeClass('hover');
				}); // 추가된 부분
			}
		});
	</script>
</body>
</html>
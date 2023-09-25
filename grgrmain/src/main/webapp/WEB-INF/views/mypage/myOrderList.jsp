<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath}/images/grgr_logo.png">
</head>
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

.btn-outline-primary {
	font-size: 18px; /* 원하는 크기로 설정 */
}

.selected {
	background-color: #007bff;
	//
	선택된
	배경색
	color
	:
	#ffffff;
	//
	선택된
	텍스트
	색상
}
</style>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<div id="preloader">
		<div class="preloader">
			<span></span> <span></span>
		</div>
	</div>
	<!-- 배너 -->
	<c:set var="boardName" value="주문 목록" />
	<header class="xl bg-img bg-fixed"
		style="height: 300px; padding-top: 200px;">
		<div class="container text-center">
			<h1 class="page-title">주문목록</h1>
		</div>
		<!-- / container -->
	</header>


	<div class="container">
		<div class="row">

			<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp" />

			<!-- Main Content -->
			<main class="main-content col-md-10">

				<p class="row portfolio project-grid lightbox list-unstyled mb-0"
					id="grid" style="clear: both">
					<!--====================================================================================================  -->
					<!-- project : 게시글 list 출력 -->
					<c:forEach items="${myOrderList}" var="myOrderList">
						<!-- &pageNum=${pageNum} -->
						<div class="promo-box">
							<div class="cta p-0">
								<div class="row v-center">
									<!-- / column -->
									<div class="col-lg-12 text-left tablet-lg-center">
										<p class="mb-20">상품명: ${myOrderList.productTitle}</p>
										<p class="lead mb-20">가격: ${myOrderList.productPrice} 원</p>
										<p class="lead mb-20">구매 수량: ${myOrderList.orderQuantity}
											개</p>
										<p class="fs-16 post-meta-small mt-15 mb-0"
											style="text-align: right">
											<i class="fas fa-user mr-5"></i>주문 상태: ${myOrderList.orderStatus} <span
												class="m-x-10 text-muted">|</span> <i
												class="far fa-calendar-alt mr-5"></i>주문 일자:
											<fmt:formatDate value="${myOrderList.orderDate }"
												pattern="yyyy-MM-dd HH:mm:ss" />

										</p>
									</div>
									<!-- / column -->
								</div>
								<!-- / row -->
							</div>
							<!-- / cta -->
						</div>
						<!-- / promo-box -->

					</c:forEach>
					<!--====================================================================================================  -->
				</p>

				<!-- / pagination-center -->
			</main>
		</div>
	</div>

	<a href="#top" class="scroll-to-top is-visible smooth-scroll"
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

	<!-- portfolio script -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.shuffle.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/portfolio.js"></script>
	<script>
		$(document).ready(
				function() {

					var keywordInput = $('input[name="searchKeyword"]');
					$('#search-button').click(
							function() {
								// 선택한 검색 유형과 키워드를 가져옵니다.
								var searchType = $('#select').val();
								var searchKeyword = keywordInput.val();
								var pageNum = $('input[name="pageNum"]').val();

								if (searchKeyword === '') {
									keywordInput.val('검색어를 입력하지 않으셨습니다.'); // 값을 직접 변경
									keywordInput.css('color', 'red'); // 텍스트 색상 변경
									return;
								} else {

									keywordInput.css('color', 'black'); // 일반 색상으로 되돌림
								}

								// url 생성
								var url = "list?pageNum=" + pageNum
										+ "&searchType=" + searchType
										+ "&searchKeyword=" + searchKeyword;

								//리다이렉트합니다.
								window.location.href = url;
							});

					keywordInput.focus(function() {
						if (keywordInput.val() === '검색어를 입력하지 않으셨습니다.') {
							keywordInput.val(''); // 오류 메시지를 지움
							keywordInput.css('color', 'black'); // 일반 텍스트 색상으로 되돌림
						}
					});

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
						.mouseleave(function() {
							$(this).removeClass('hover');
						});
					}
				});
	</script>
	<!-- / portfolio script -->
</body>
</html>
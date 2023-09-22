<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<!-- Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Soft UI - Neumorphism Style UI Kit">
<meta name="author" content="kingstudio.ro">
<!-- Favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath}/assets/images/favicon.png">
<!-- Site Title -->
<title>끼리끼리 상점</title>
<!-- Bootstrap 4 core CSS -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom Styles -->
<link
	href="${pageContext.request.contextPath}/assets/css/nouislider.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/animate.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet">
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;600;800&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;600;800&display=swap"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/css/fontawesome-all.min.css"
	rel="stylesheet" type="text/css">
<style type="text/css">
.card-body {
	text-align: center;
	padding: 20px; /* 상하좌우 패딩을 일정하게 조정 */
	height: 100%; /* 카드 내용을 상자 크기에 맞게 확장 */
}

/* 나머지 스타일은 이전과 동일하게 유지 */
#select {
	border-radius: 10px;
	font-size: 16px; /* 원하는 크기로 조정 */
}

.form-control.pill {
	border-radius: 10px;
	font-size: 16px; /* 원하는 크기로 조정 */
	width: 100%;
}

#search-button {
	border-radius: 10px;
	font-size: 16px; /* 원하는 크기로 조정 */
}

.card-container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	/* 최소 250px 크기의 그리드 셀로 설정 */
	gap: 20px; /* Card 요소 사이의 간격 조절 */
	margin-bottom: 20px; /* Card 컨테이너 아래 여백 추가 */
}

/* 제목 길이가 길 경우 말줄임 처리 */
.product-title {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 가격 영역의 스타일 조정 */
.price-block {
	font-weight: bold;
	color: #007bff; /* 가격 색상을 원하는 색상으로 설정 */
	margin-bottom: 10px; /* 아래 여백 추가 */
}

/* 상품 등록일 스타일 조정 */
.product-regdate {
	font-size: 14px; /* 원하는 크기로 조정 */
}

/* Buy Now 버튼 스타일 조정 */
.product-card-footer {
	margin-top: 10px; /* 위쪽 여백 추가 */
}

.card-body img {
	max-width: 100%; /* 이미지의 최대 너비를 부모 요소에 맞게 설정 */
	max-height: 100%; /* 이미지의 최대 높이를 부모 요소에 맞게 설정 */
	width: auto; /* 가로 너비 자동 조정 */
	height: auto; /* 세로 높이 자동 조정 */
	display: block; /* 이미지를 블록 요소로 설정하여 가운데 정렬 */
	margin: 0 auto; /* 이미지를 가로 중앙으로 정렬 */
}

.product-image {
	max-width: 250px; /* 이미지의 최대 너비를 설정 (원하는 크기로 조절) */
	max-height: 250px; /* 이미지의 최대 높이를 설정 (원하는 크기로 조절) */
	width: auto; /* 가로 너비 자동 조정 */
	height: auto; /* 세로 높이 자동 조정 */
}
</style>




</head>

<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<!-- 배너 -->
	<c:set var="boardName" value="판매게시판" />
	<header class="xl bg-img bg-fixed"
		style="background-image: url(${pageContext.request.contextPath}/images/market.jpg); background-size: cover; height: 300px;">
		<div class="container text-center">
			<h1 class="page-title">Market</h1>
			<p class="w-50 m-x-auto mb-30" style="color: white;">판매게시판</p>
			<a href="#start" class="btn btn-sm btn-primary smooth-scroll"> <i
				class="fas fa-shopping-cart mr-5"></i> <span>쇼핑하러 가기</span>
			</a>
		</div>
		<!-- / container -->
	</header>


	<div class="container">
		<div class="row">

			<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp" />

			<!-- Main Content -->
			<main class="main-content col-md-10">


				<section id="start" class="lg page-section">
					<!-- 검색 -->
					<!-- select -->
					<div class="card">
						<div class="card-body"
							style="padding-bottom: 20px; padding-top: 20px; padding-left: 50px; padding-right: 50px;">
							<form action="list" method="get"
								class="d-flex align-items-center justify-content-between">
								<input type="hidden" name="pageNum" value="1">
								<div class="col-md-3 tablet-top" style="padding-right: 10px">
									<select class="custom-select" id="select" name="searchType">
										<option value="TC"
											${pager.searchCondition.searchType == 'TC' ? 'selected' : ''}>제목+내용</option>
										<option value="T"
											${pager.searchCondition.searchType == 'T' ? 'selected' : ''}>제목</option>
										<option value="W"
											${pager.searchCondition.searchType == 'W' ? 'selected' : ''}>작성자</option>
										<!-- 나머지 옵션 -->
									</select>
									<!-- / custom-select -->
								</div>
								<!-- / column -->
								<div class="input-group input-w-overlap-btn mb-0">
									<input type="text" class="form-control pill"
										name="searchKeyword" placeholder="검색어를 입력하세요."
										value="${pager.searchCondition.searchKeyword }" /> <span
										class="input-group-btn">
										<button id="search-button"
											class="btn btn-sm btn-primary lh-0 overlapping-btn big-btn pill"
											type="button">
											<i class="fas fa-search mr-5"></i> 검색
										</button>
									</span>
									<!-- / input-group-btn -->
								</div>
								<!-- / input-group -->
							</form>
						</div>
					</div>
					<!-- 검색입력창 -->

					<!-- 글쓰기버튼 -->
					<c:if test="${loginUserStatus == '3'}">
						<a
							href="<c:url value='/productboard/insert${pager.searchCondition.getQueryString()}'/>"
							class="btn btn-primary-gradient m-y-10 mr-10"
							style="float: right; display: block"><span
							class="fas fa-edit mr-10"></span> <span style="font-size: 20px">제품
								등록</span></a>
					</c:if>

					<!-- project : 게시글 list 출력 -->
					<div class="container" style="clear: both">
						<div class="row justify-content-center">
							<div class="col-lg-8 col-xl-12 tablet-lg-top-30 page-content">
								<div class="row">
									<c:set var="i" value="0" />
									<c:forEach var="productBoardList" items="${productBoardList}">
										<div class="col-sm-6 col-xl-3">
											<div class="card ">
												<div class="full-height-cards card-body text-center p-y-30"
													style="">
													<img
														src="${pageContext.request.contextPath}/upload/${fileList[i]}"
														alt="Thumbnail" class="mb-30 rounded raised-sm "
														width="150" height="150">

													<c:set var="i" value="${i+1 }" />
													<p class="card-title product-title fs-20">
														<a
															href="<c:url value='/productboard/get${pager.searchCondition.getQueryString()}&productId=${productBoardList.productId}'/>"
															class="title-link primary-hover fs-20"> <c:out
																value="${productBoardList.productTitle}" />
														</a>
													</p>
													<p class="price-block text-primary">
														₩
														<c:out value="${productBoardList.productPrice}" />
													</p>
													<p class="product-regdate">
														<i class="far fa-calendar-alt mr-5"></i>
														<fmt:formatDate value="${productBoardList.productRegdate}"
															pattern="yyyy-MM-dd HH:mm:ss" />
													</p>

													<div class="product-card-footer">
														<a
															href="<c:url value='/productboard/get${pager.searchCondition.getQueryString()}&productId=${productBoardList.productId}'/>"
															class="btn btn-sm btn-outline-primary mt-15"> <i
															class="fas fa-shopping-cart mr-5"></i> <span>Buy
																Now</span>
														</a>
													</div>
													<!-- / product-card-footer -->
												</div>
												<!-- / card-body -->
											</div>
											<!-- / card -->
										</div>
										<!-- / column -->
									</c:forEach>
								</div>
								<!-- / row -->
							</div>
							<!-- / col-lg-8 col-xl-9 tablet-lg-top-30 page-content -->

						</div>
						<!-- / row -->
					</div>
					<!-- / container -->
				</section>

				<nav aria-label="pagination-center">
					<ul class="pagination justify-content-center">
						<!-- 이전 블록 이동 표시 -->
						<c:choose>
							<c:when test="${pager.startPage != 1 }">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/productboard/list${pager.searchCondition.getQueryString(pager.startPage-1)}'/>"><i
										class="fas fa-arrow-left mb-5"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="#x"><i class="fas fa-arrow-left mb-5"></i></a></li>
							</c:otherwise>
						</c:choose>
						<!-- 페이지 목록 출력 -->
						<c:forEach var="i" begin="${pager.startPage}"
							end="${pager.endPage }">
							<c:choose>
								<c:when test="${i == pager.searchCondition.pageNum}">
									<li class="page-item active"><a class="page-link"
										href="<c:url value='/productboard/list${pager.searchCondition.getQueryString(i)}'/>">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link"
										href="<c:url value='/productboard/list${pager.searchCondition.getQueryString(i)}'/>">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 다음 블록 이동 표시 -->
						<c:choose>
							<c:when test="${pager.endPage != pager.totalPage}">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/productboard/list${pager.searchCondition.getQueryString(pager.endPage+1)}'/>"><i
										class="fas fa-arrow-right mb-5"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="#x"><i class="fas fa-arrow-right mb-5"></i></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
				<!-- / pagination-center -->
			</main>
		</div>
	</div>


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

	<!-- noUI slider -->
	<script
		src="${pageContext.request.contextPath}/assets/js/nouislider.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/noui-init.js"></script>
	<!-- / noUI slider -->

	<script>
		$(document).ready(function() {
			const moveForm = $("#moveForm"); // moveForm 변수를 정의해야 함

			$("#searchButton").on("click", function(e) {
				e.preventDefault();
				let val = $("#searchKeyword").val();
				moveForm.find("input[name='keyword']").val(val);
				moveForm.find("input[name='pageNum']").val(1);
				moveForm.submit();
			});

			$("#searchKeyword").on("keypress", function(e) {
				if (e.which === 13) { // 엔터 키의 keyCode는 13입니다.
					e.preventDefault();
					let val = $("#searchKeyword").val();
					moveForm.find("input[name='keyword']").val(val);
					moveForm.find("input[name='pageNum']").val(1);
					moveForm.submit();
				}
			});
		});

		$(document).ready(function() {

			let result = '<c:out value="${result}"/>';

			checkAlert(result);

			function checkAlert(result) {

				if (result === '') {
					reutrn;
				}

				if (result === "insert success") {
					alert("등록이 완료되었습니다.");
				}

				if (result === "update success") {
					alert("수정이 완료되었습니다.");
				}

				if (result === "delete success") {
					alert("삭제가 완료되었습니다.");
				}

			}

		});
	</script>



</body>

</html>
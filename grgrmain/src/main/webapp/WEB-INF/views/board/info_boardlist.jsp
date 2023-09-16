<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="Soft UI - Neumorphism Style UI Kit" />
<meta name="author" content="kingstudio.ro" />
<!-- Favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath}/assets/images/favicon.png" />
<!-- Site Title -->
<title>Soft UI - Neumorphism Style UI Kit</title>
<!-- Bootstrap 4 core CSS -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Custom Styles -->
<link href="${pageContext.request.contextPath}/assets/css/animate.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;600;800&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;600;800&display=swap"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/fontawesome-all.min.css"
	rel="stylesheet" type="text/css" />
</head>
<style>
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
	color: #ffffff;
}

.viewCnt {
	text-align: right;
	margin-bottom: 0;
}
</style>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<!-- 배너 -->
	<c:set var="boardName" value="정보공유게시판" />
	<header class="xl bg-img bg-fixed"
		style="background-image: url(/grgrmain/images/information.jpg); background-size: cover;">
		<div class="container text-center">

			<h1 class="page-title">Information</h1>

			<p class="w-50 m-x-auto mb-30" style="color: white;">
				<c:out value="${boardName}" />
			</p>
		</div>
		<!-- / container -->
	</header>

	<div class="container">
		<div class="row">

			<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp" />

			<!-- Main Content -->
			<main class="main-content col-md-10">

				<ul class="list-inline text-center mb-30">

					<li><a href="<c:url value="/infoboard/list"/>"
						class="btn btn-outline-primary m-y-10 mr-10">${pager.searchCondition.loginLocation}</a></li>
					<!-- ${userInfo_Loc} -->
					<li id="keyword-button"><a
						href="<c:url value="/infoboard/list?keyword=food"/>"
						class="btn btn-outline-primary m-y-10 mr-10">맛집후기</a></li>
					<li id="keyword-button"><a
						href="<c:url value="/infoboard/list?keyword=market"/>"
						class="btn btn-outline-primary m-y-10 mr-10">동네후기</a></li>
					<li id="keyword-button"><a
						href="<c:url value="/infoboard/list?keyword=living"/>"
						class="btn btn-outline-primary m-y-10 mr-10">생활정보</a></li>
					<li id="keyword-button"><a
						href="<c:url value="/infoboard/list?keyword=crew"/>"
						class="btn btn-outline-primary m-y-10 mr-10">모임 / 구인</a></li>
					<li id="keyword-button"><a
						href="<c:url value="/infoboard/list?keyword=event"/>"
						class="btn btn-outline-primary m-y-10 mr-10">이벤트</a></li>
				</ul>


				<div>
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
					<a
						href="<c:url value='/infoboard/write${pager.searchCondition.getQueryString()}'/>"
						class="btn btn-primary-gradient m-y-10 mr-10"
						style="float: right; display: block"><span
						class="fas fa-edit mr-10"></span> <span style="font-size: 20px">글쓰기</span></a>
				</div>

<div>
    <ul class="row portfolio project-grid lightbox list-unstyled mb-0" id="grid" style="clear: both">
        <!-- project : 게시글 list 출력 -->
        <c:set var="i" value="0" />
        <c:forEach items="${infoBoardList}" var="infoBoard">
            <li class="col-md-12 col-lg-0 project">
                <a href="<c:url value='/infoboard/read${pager.searchCondition.getQueryString()}&infoBno=${infoBoard.infoBno}'/>">
                    <div class="promo-box">
                        <div class="cta p-0">
                            <div class="row v-center">
                                <div class="col-lg-2 tablet-lg-top-30 tablet-lg-center">
                                    <img src="${pageContext.request.contextPath}/upload/${fileList[i]}" alt="Thumbnail" class="rounded" />
                                    <c:set var="i" value="${i+1 }" />
                                </div>
                                <!-- / column -->
                                <div class="col-lg-10 text-left tablet-lg-center">
                                    <p class="mb-20">${infoBoard.infoTitle}</p>
                                    <p class="lead mb-20">${infoBoard.infoContent}&nbsp;&nbsp;...</p>

                                    <!-- 조회수 -->
                                    <div class="viewCnt">
                                    <p class="d-inline-block va-middle " style="margin-bottom:0">
                                        <span class="text-sm text-info">조회수 : </span>
                                        <span class="timer va-middle" id="count-inline-three" data-to="1155" data-speed="3000">${infoBoard.infoViewCnt }</span>
                                    </p></div>

                                    <!-- 닉네임, 등록일, 키워드 -->
                                    <p class="fs-16 post-meta-small mb-0" style="display: block; text-align: right;">
                                        <i class="fas fa-user mr-5"></i>${infoBoard.nickname} 
                                        <span class="m-x-10 text-muted">|</span> 
                                        <i class="far fa-calendar-alt mr-5"></i>${infoBoard.infoRegdate}
                                        <span class="m-x-10 text-muted">|</span> 
                                        <i class="fas fa-tag mr-10"></i>
                                        <c:choose>
                                            <c:when test="${infoBoard.infoKeyword=='food'}">맛집</c:when>
                                            <c:when test="${infoBoard.infoKeyword=='market'}">기타 후기</c:when>
                                            <c:when test="${infoBoard.infoKeyword=='living'}">생활정보</c:when>
                                            <c:when test="${infoBoard.infoKeyword=='crew'}">모임 / 구인</c:when>
                                            <c:otherwise>이벤트</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <!-- / column -->
                            </div>
                            <!-- / row -->
                        </div>
                        <!-- / cta -->
                    </div> <!-- / promo-box -->
                </a>
            </li>
        </c:forEach>
    </ul>
</div>

				<!-- / container -->



				<nav aria-label="pagination-center">
					<ul class="pagination justify-content-center">
						<!-- 이전 블록 이동 표시 -->
						<c:choose>
							<c:when test="${pager.startPage != 1 }">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/infoboard/list${pager.searchCondition.getQueryString(pager.startPage-1)}'/>"><i
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
										href="<c:url value='/infoboard/list${pager.searchCondition.getQueryString(i)}'/>">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link"
										href="<c:url value='/infoboard/list${pager.searchCondition.getQueryString(i)}'/>">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 다음 블록 이동 표시 -->
						<c:choose>
							<c:when test="${pager.endPage != pager.totalPage}">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/infoboard/list${pager.searchCondition.getQueryString(pager.endPage+1)}'/>"><i
										class="fas fa-arrow-right mb-5"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="#x"><i class="fas fa-arrow-right mb-5"></i></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</main>
		</div>
	</div>
	<!-- / pagination-center -->

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

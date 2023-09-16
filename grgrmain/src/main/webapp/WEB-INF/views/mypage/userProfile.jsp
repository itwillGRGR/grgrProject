<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<!-- 테스트 주석 -->
<!-- 테스트 주석1 -->
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
<title>마이 페이지</title>
<!-- Bootstrap 4 core CSS -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom Styles -->
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
</head>

<body>

	<div id="preloader">
		<div class="preloader">
			<span></span> <span></span>
		</div>
	</div>

	<div id="top"></div>
	<!-- / top -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<header class="xxl pb-30 bg-img bg-fixed">

		<!-- / navbar-toggler -->
		<!-- / dropdown -->

		<!-- / navbar -->
		<div class="container relative z-index-1">
			<h1 class="page-title text-left mb-15">
				<c:out value="${user.nickName}" />
				님의 페이지
			</h1>
			<nav class="breadcrumb relative z-index-1 pt-10 pl-5">
				<a class="breadcrumb-item"
					href="${pageContext.request.contextPath}/main">Home</a> <span
					class="breadcrumb-item active">마이 페이지</span>
			</nav>
		</div>
		<!-- / container -->
	</header>

	<section class="lg pb-60 page-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 tablet-lg-top-30 page-content">
					<div class="project-post">
						<div class="page-content">
							<div class="col-md-6 mx-auto">
								<div class="card mb-0">
									<div class="card-body">
										<div class="promo-big mb-15 left-0">
											<img
												src="${pageContext.request.contextPath}/assets/images/placeholder-mini.jpg"
												alt="" class="promo-box-image circle mb-25 raised-xs">
											<h2 class="page-title mb-10">
												<c:out value="${user.nickName}" />
											</h2>
										</div>

										<div class="widget text-left p-y-15">
											<h6 class="widget-title mb-25">나의 정보</h6>
											<ul class="pl-0 mb-0 feature-list">
												<li class="mb-15"><i class="fas fa-user va-middle mr-5"></i>
													<span class="va-middle">이름 : <c:out
															value="${user.userName}" /></span></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>아이디 : <c:out
														value="${user.userId}" /></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>연락처 : <c:out
														value="${user.phone}" /></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>이메일 : <c:out
														value="${user.email}" /></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>포인트 : <c:out
														value="${user.point}" /></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle">등급 :</span> <c:choose>
														<c:when test="${user.userStatus == 1}">관리자</c:when>
														<c:when test="${user.userStatus == 2}">일반회원</c:when>
														<c:when test="${user.userStatus == 3}">상권회원</c:when>
													</c:choose></li>

												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>사업자 등록 번호 : <c:out
														value="${user.businessNo}" /></li>
												<li class="mb-15"><i
													class="fas fa-map-marker-alt va-middle mr-5"></i> <span
													class="va-middle">지역 :</span><span class="va-middle">${user.userLoc }</span></li>
												<li class="mb-15"><i
													class="fas fa-calendar va-middle mr-5"></i> <span
													class="va-middle">가입일 : </span> <span class="va-middle"><fmt:formatDate
															value="${user.regDate}" pattern="yyyy년 MM월 dd일" /></span></li>
											</ul>
										</div>
									</div>
									<!-- / card-body -->
								</div>
								<!-- / card -->
							</div>
						</div>
						<!-- / page-content -->
					</div>
					<!-- / project-post -->
				</div>
				<!-- / column -->

				<div class="col-lg-4 sidebar">
					<div class="widget text-left pb-20 mt-0">
						<div
							class="promo-box p-x-0 p-y-15 mb-0 promo-left bg-transparent no-shadow">
							<div class="widget text-left p-y-15">
								<a
									href="<c:url value='/mypage/myBoardWriteList?uno=${user.uno}' />"
									class="btn btn-primary btn-block mb-15"><i
									class="fas fa-user mr-5"></i> <span>내가 쓴 글</span></a> <a
									href="<c:url value='/mypage/myCommentList?uno=${user.uno}' />"
									class="btn btn-primary btn-block"><i
									class="fas fa-user mr-5"></i> <span>내가 쓴 댓글</span></a>
							</div>
							<!-- / promo-container -->
						</div>
					</div>
					<!-- / widget -->

					<!-- / widget -->


					<!-- / widget -->

					<div class="widget text-left p-y-15">
						<a href="<c:url value='/mypage/updateUserProfile' />"
							class="btn btn-primary btn-block"><i class="fas fa-user mr-5"></i>
							<span>회원정보 수정</span></a>
					</div>
					<!-- / widget -->
				</div>
				<!-- / column -->
			</div>
			<!-- / row -->
		</div>
		<!-- / container -->
	</section>

	<a href="#top" class="scroll-to-top is-hidden smooth-scroll"
		data-nav-status="toggle"><i class="fas fa-chevron-up"></i></a>

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

	<!-- smooth scroll -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/smooth-scroll.js"></script>
	<!-- / smooth scroll -->

	<!-- hide nav -->
	<script src="${pageContext.request.contextPath}/assets/js/hide-nav.js"></script>
	<!-- / hide nav -->

</body>

</html>
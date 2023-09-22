<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<!-- Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Soft UI - Neumorphism Style UI Kit">
<meta name="author" content="kingstudio.ro">
<!-- 파비콘 변경 -->
<link rel="icon"
	href="${pageContext.request.contextPath}/images/grgr_logo.png">
<!-- Site Title -->
<title>끼리끼리</title>
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
<link
	href="${pageContext.request.contextPath}/assets/css/owl.carousel.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/css/magnific-popup.css"
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
.custom-text {
	font-size: 16px;
	color: #333333;
	margin-bottom: 15px;
}

.update-location-button {
	background-color: #ffffff;
	color: #0074cc;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.card.bg-img {
	background-color: rgba(0, 0, 0, 0.4); /* 이는 검은색 40% 투명도를 추가합니다 */
	background-blend-mode: overlay;
}

.card-body a, .card-text, .card-header p {
	text-shadow: -1px -1px 0 #ffffff, 1px -1px 0 #ffffff, -1px 1px 0 #ffffff,
		1px 1px 0 #ffffff;
}

.main-banner {
	weight: auto;
	height: 500px;
	overflow: hidden;
}

.loc {
	/* 	display: flex;
	text-align: center;
 */
	width: 60px;
	height: 60px;
}

.nav-item {
	display: flex;
	item-align: center;
}
</style>
</head>
<body style="background-color: white">
	<div style="background-color: #E2E6FC;">
		<nav
			class="navbar navbar-expand-lg navbar-light top-0 left-0 right-0 d-flex justify-content-between">
			<a href="<c:url value='/main' />" class="navbar"> <img
				class=" ml-10 mt-5 w-50"
				src="${pageContext.request.contextPath}/images/grgr_logo.png"
				alt="메인로고">
			</a>

			<div class="collapse navbar-collapse" id="navbar-toggle1">
				<ul class="nav-item d-flex justify-content-between">
					<li class="nav-item loc d-flex align-items-center "><a
						href="<c:url value="/info/matzib"/>"><img class="mb-10"
							alt="맛집정보" src="<c:url value="/images/restaurant.png"/>" />맛집</a></li>
					<li class="nav-item loc d-flex align-items-center"><a
						href="<c:url value="/info/medical"/>"><img class="mb-10"
							alt="병원정보" src="<c:url value="/images/hospital.png"/>" />병원</a></li>
				</ul>
				<!-- / navbar-nav -->
			</div>

			<!-- / input-group -->
			<c:if test="${loginUno==null}">
			<div>
					<h2>
						<a
							href="<c:url value='/noticeboard/read?noticeBno=${latestNoticeBno}'/>"
							style="text-decoration: underline;"> <i
							class="fas fa-bullhorn"></i> ${latestNoticeTitle}
						</a>
					</h2>
				</div>
				<ul class="navbar-button p-30 m-0 d-flex justify-content-between">
					<li class="nav-item"><a href="<c:url value="/user/login"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i> <span>로그인</span>
					</a></li>
					<li class="nav-item"><a href="<c:url value="/user/register"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i> <span>회원가입</span>
					</a></li>
				</ul>
			</c:if>
			<c:if test="${loginUno!=null && loginUserStatus!=1 }">

				<div
					class="collapse navbar-collapse m-0 d-flex justify-content-between"
					id="navbar-toggle1">
					<ul class="navbar-nav align-items-center">
						<li class="nav-item"
							style="font-family: 'Font Awesome 5 Free', sans-serif !important, font-weight : 20px bold;">"${loginNickname }"님의
							위치는<br> "${loginLocation}" 입니다.
						</li>
						<li class="nav-item ml-30"><a class="nav-link">
								<button class="update-location-button"
									onclick="updateLocation()">Update Location</button>
						</a></li>
					</ul>
					<!-- / navbar-nav -->

				</div>
				<div>
					<h2>
						<a
							href="<c:url value='/noticeboard/read?noticeBno=${latestNoticeBno}'/>"
							style="text-decoration: underline;"> <i
							class="fas fa-bullhorn"></i> ${latestNoticeTitle}
						</a>
					</h2>
				</div>
				<ul class="navbar-button p-0 m-0 m-0 d-flex justify-content-between">

					<li class="nav-item"><a
						href="<c:url value="/mypage/userProfile"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i><span>마이페이지</span>
					</a></li>
					<li class="nav-item"><a href="<c:url value="/cart/list"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i><span>장바구니</span>
					</a></li>
					<li class="nav-item"><a href="<c:url value="/user/logout"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i><span>로그아웃</span>
					</a></li>
				</ul>
			</c:if>
			<c:if test="${loginUno!=null && loginUserStatus==1 }">

				<span>관리자님, 환영합니다.</span>

				<ul class="navbar-button p-0 m-0 m-0 d-flex justify-content-between">
					<li class="nav-item"><a
						href="<c:url value="/admin/user-list"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i><span>관리자페이지</span></a></li>
					<li class="nav-item"><a href="<c:url value="/user/logout"/>"
						class="btn btn-sm btn-primary pill"> <i
							class="fas fa-rotate-90 fs-12 va-middle mr-5"></i><span>로그아웃</span>
					</a></li>
				</ul>
			</c:if>

			<!-- / navbar-collapse -->
		</nav>
	</div>
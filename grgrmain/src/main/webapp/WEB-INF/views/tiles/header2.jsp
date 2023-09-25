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
	background-color: rgba(0, 0, 0, 0.4);
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
	width: 30px;
	height: 30px;
}

.nav-itm {
	gap: 10px;
}
</style>
</head>
<body style="background-color: white">
	<div class="bg-light ">


		<div class="modal fade modal-left modal-left-example modal-register"
			tabindex="-1" style="display: none;" aria-modal="true" role="dialog">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="side-modal-wrapper">
						<div class="vertical-align">
							<div class="table-cell">
								<div class="modal-body">
									<ul>
										<hr>
										<p>▶내 정보</p>
										<hr>
										<li><a href="<c:url value="/mypage/userProfile"/>">-
												마이 페이지</a></li>
										<li><a href="<c:url value="/cart/list"/>">- 장바구니</a></li>
										<hr>
										<p>▶주변 정보</p>
										<hr>
										<li><a href="<c:url value="/info/matzib"/>">- 맛집 정보</a></li>
										<li><a href="<c:url value="/info/medical"/>">- 의료 정보</a></li>
										<hr width:20px>
										<p>▶게시판</p>
										<hr>
										<li><a href="<c:url value="/noticeboard/list"/>">-
												공지사항</a></li>
										<li><a href="<c:url value="/infoboard/list"/>">- 정보공유</a></li>
										<li><a href="<c:url value="/productboard/list"/>">-
												판매</a></li>
										<li><a href="<c:url value="/freeboard/list"/>">- 자유</a></li>
										<li><a href="<c:url value="/qnaboard/list"/>">- 문의</a></li>
									</ul>
								</div>
								<!-- / modal-body -->
							</div>
							<!-- / table-cell -->
						</div>
						<!-- / vertical-align -->
					</div>
					<!-- / side-modal-wrapper -->
					<div class="modal-footer text-left">
						<span class="fs-14">Already have an account? <a href="#x"
							class="fs-14">Login Now</a></span>
					</div>
					<!-- / modal-footer -->
				</div>
				<!-- / modal-content -->
			</div>
			<!-- / modal-dialog -->
		</div>

		<nav
			class="navbar navbar-expand-lg navbar-light custom-menu split-menu bg-light">

			<!-- 아이템 컨테이너 -->

			<!-- ---------------------------------------------------------------------------------------------------------- -->
			<div class="collapse navbar-collapse pt-30 pb-30 "
				id="navbar-toggle-split-left">

				<button id="showModalBtn" class="btn btn-icon btn-danger">
					<i class="fas fa-indent fs-14"></i>
				</button>
				<ul class="navbar-nav align-items-center" style="width: 300px;">

					<li class="nav-item w-50 mr-30"><a
						href="<c:url value="/info/matzib"/>"> <img class="w-40 mr-10"
							alt="맛집정보" src="<c:url value="/images/restaurant.png"/>" /><span>맛집</span>
					</a></li>
					<li class="nav-item w-50 mr-30"><a
						href="<c:url value="/info/medical"/>"> <img class="w-40 mr-10"
							alt="병원정보" src="<c:url value="/images/hospital.png"/>" /><span>병원</span></a></li>
				</ul>

			</div>

			<!-- / navbar-nav -->
			<!-- / navbar-collapse -->

			<div
				class="collapse navbar-collapse p-30 d-flex justify-content-center">
				<c:if test="${loginUno==null}">
					<a class="navbar-brand" href="<c:url value='/main' />"><img
						src="${pageContext.request.contextPath}/images/grgr_favicon.png"
						alt="메인로고"></a>
				</c:if>
				<c:if test="${loginUno!=null}">
					<ul
						class="navbar-nav align-items-center d-flex justify-content-xl-between"
						style="width: 600px;">
						<c:if test="${loginUno!=null && loginUserStatus!=1 }">
							<li class="nav-item w-120 mr-30"
								style="font-family: 'Font Awesome 5 Free', sans-serif !important, font-weight : 20px bold;"><button
									class="update-location-button btn btn-primary"
									style="padding: 10px;" onclick="updateLocation()">
									<i class="fas fa-map-marker-alt fs-30 va-middle mr-10"></i> <span
										id="login-location-text" class="va-middle"
										style="width: 100px !important;">${loginLocation != null ? loginLocation : '나의 위치 인증'}</span>
								</button></li>
							<li class="nav-item"><a class="navbar-brand "
								href="<c:url value='/main' />"><img
									src="${pageContext.request.contextPath}/images/grgr_favicon.png"
									alt="메인로고"></a></li>
							<li class="nav-item w-120"><h5>"${loginNickname }"님
									환영합니다</h5></li>
						</c:if>
						<!-- 관리자 페이지 -->
						<c:if test="${loginUno!=null && loginUserStatus==1 }">
							<li class="nav-item w-120 mr-30 invisible">
								<button style="padding: 10px;" onclick="updateLocation()">
									<i class="fas fa-map-marker-alt fs-30 va-middle mr-10"></i> <span
										class="va-middle" style="width: 100px !important;">나의
										위치 인증</span>
								</button>
							</li>
							<li class="nav-item"><a class="navbar-brand"
								href="<c:url value='/main' />"><img
									src="${pageContext.request.contextPath}/images/grgr_favicon.png"
									alt="메인로고"></a></li>
							<li class="nav-item w-120"><h5>"관리자"님 환영합니다.</h5></li>
						</c:if>
					</ul>

				</c:if>
			</div>


			<div class="collapse navbar-collapse pr-30"
				id="navbar-toggle-split-right">
				<!-- 비로그인 사용자 -->
				<c:if test="${loginUno==null}">
					<ul class="navbar-nav ml-auto d-flex align-items-center"
						style="width: 300px; justify-content: flex-end;">
						<li class="nav-item w-50 mr-30">
							<!-- href="<c:url value="/info/matzib"/>" --> <span></span>
						</li>
						<li class="nav-item w-50 mr-30"><a
							href="<c:url value="/user/login"/>"><span>로그인</span></a></li>
						<li class="nav-item w-50 "><a
							href="<c:url value="/user/register"/>"><span>회원가입</span></a></li>
					</ul>
				</c:if>
				<!-- 로그인 사용자 -->
				<c:if test="${loginUno!=null && loginUserStatus!=1 }">
					<ul class="navbar-nav ml-auto d-flex align-items-center"
						style="width: 300px; justify-content: flex-end;">

						<li class="nav-item w-100 mr-30"><a
							href="<c:url value="/mypage/userProfile"/>"><span>마이페이지</span></a></li>
						<li class="nav-item w-50 mr-30"><a
							href="<c:url value="/cart/list"/>"><span>장바구니</span></a></li>
						<li class="nav-item w-50 "><a
							href="<c:url value="/user/logout"/>"><span>로그아웃</span></i></a></li>
					</ul>
				</c:if>

				<!-- 관리자 사용자 -->
				<c:if test="${loginUno!=null && loginUserStatus==1 }">
					<ul class="navbar-nav d-flex align-items-center"
						style="width: 300px; justify-content: flex-end;">
						<li class="nav-item w-50 mr-30"><span></span></li>
						<li class="nav-item w-100 mr-30"><a
							href="<c:url value="/admin/user-list"/>"><span>관리자페이지</span></a></li>
						<li class="nav-item w-50 "><a
							href="<c:url value="/user/logout"/>"><span>로그아웃</span></a></li>
					</ul>
				</c:if>
				<!-- / navbar-nav -->
			</div>
			<!-- / navbar-collapse -->

		</nav>
		<!-- / split-navbar -->
	</div>



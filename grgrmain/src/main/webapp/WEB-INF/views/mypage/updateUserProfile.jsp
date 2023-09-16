<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

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
<title>정보 수정</title>
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
<link href="${pageContext.request.contextPath}/css/login-register.css"
	rel="stylesheet">
</head>

<body>
<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<div id="preloader">
		<div class="preloader">
			<span></span> <span></span>
		</div>
	</div>

	<div id="top"></div>
	<!-- / top -->
		<!-- / navbar -->
		<div class="container relative z-index-1">
			<h1 class="page-title text-left mb-15">회원 정보 수정</h1>
			<nav class="breadcrumb relative z-index-1 pt-10 pl-5">
				<a class="breadcrumb-item"
					href="${pageContext.request.contextPath}/main">Home</a> <a
					class="breadcrumb-item"
					href="/mypage/userProfile?uno=<c:out value="${user.uno}" />">마이
					페이지</a><a class="breadcrumb-item">정보 수정</a>
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
							<div class="col-md-6">
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

										<form id="updateForm" action="/mypage/updateUserProfile"
											method="post">
											<div class="widget text-left p-y-15">
												<h6 class="widget-title mb-25">나의 정보</h6>
												<ul class="pl-0 mb-0 feature-list">
													<li class="mb-15"><i
														class="fas fa-user va-middle mr-5"></i> <span
														class="va-middle">이름 : <c:out
																value="${user.userName}" /></span></li>
													<li class="mb-15"><i
														class="fas fa-star va-middle mr-5"></i> <span
														class="va-middle"></span>아이디 : <c:out
															value="${user.userId}" /></li>
												</ul>
											</div>
											<div class="form-group">
												<div class="mb-15">
													<i class="fas fa-star va-middle mr-5"></i> <span
														class="va-middle"></span>비밀번호 : <input type="text"
														class="form-control pw_input" name="userPw"
														placeholder="&#xf2bd; 변경할 비밀번호"
														style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400">
													<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
												</div>
											</div>

											<div class="form-group">
												<div class="mb-15">
													<i class="fas fa-star va-middle mr-5"></i> <span
														class="va-middle"></span>비밀번호 확인 : <input type="password"
														class="form-control pwck_input"
														name="passwordRegisterConfirm3" placeholder="변경할 비밀번호 확인"
														style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400">
													<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span> <span
														class="pwck_input_re_1">비밀번호가 일치합니다.</span> <span
														class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
												</div>
											</div>

											<ul class="pl-0 mb-0 feature-list">
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>연락처 : <input type="text"
													class="form-control phone_input" name="phone"
													placeholder="&#xf2bd; ${user.phone }"
													style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400"></li>
												<li class="mb-15"><i class="fas fa-star va-middle mr-5"></i>
													<span class="va-middle"></span>이메일 : <input type="text"
													class="form-control email_input" name="email"
													placeholder="&#xf2bd; ${user.email }"
													style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400"></li>
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
													<span class="va-middle"></span>사업자 등록 번호 : <input
													type="text" class="form-control businessNo_input"
													name="businessNo"
													placeholder="&#xf2bd; ${user.businessNo }"
													style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400"></li>
												<li class="mb-15"><i
													class="fas fa-map-marker-alt va-middle mr-5"></i> <span
													class="va-middle">지역 :</span><span class="va-middle">${user.userLoc }</span></li>
												<li class="mb-15"><i
													class="fas fa-calendar va-middle mr-5"></i> <span
													class="va-middle">가입일 : </span> <span class="va-middle"><fmt:formatDate
															value="${user.regDate}" pattern="yyyy년 MM월 dd일" /></span></li>
											</ul>

											<div class="button-container">
												<div class="widget text-left p-y-15">
													<input type="hidden" name="uno" value="${user.uno}" />
													<button type="submit" class="btn btn-primary"
														id="updateButton">변경하기</button>
										</form>
										<form id="deleteForm" action="/mypage/deleteUserProfile"
											method="post">
											<input type="hidden" name="uno" value="${user.uno}" />
											<button type="submit" class="btn btn-danger"
												id="deleteButton">탈퇴하기</button>
										</form>
									</div>
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


		<!-- / column -->
		</div>
		<!-- / row -->
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

	<script>
		// 페이지 이동 form(리스트 페이지 이동, 조회 페이지 이동)
		let mForm = $("#updateForm"); // 페이지 데이터 수정 from
		let dForm = $("#deleteForm");
		/* 수정 하기 버튼 */
		$("#updateButton").on("click", function(e) {
			// 비밀번호 입력 필드 값 가져오기
			let passwordInput = $(".pw_input").val();
			let passwordCkInput = $(".pwck_input").val();

			// 비밀번호가 비어있는 경우 알림 메시지 표시
			if (passwordInput === "") {
				e.preventDefault(); // 기본 동작 방지
				$(".final_pw_ck").css("display", "block"); // 알림 메시지 표시
			}
			if (passwordCkInput === "") {
				e.preventDefault();
				$(".final_pwck_ck").css("display", "block"); // 알림 메시지 표시
			} else {
				// 비밀번호가 입력된 경우 폼 제출
				mForm.submit();
			}
		});

		$(document).ready(function() {
			// 삭제 버튼 클릭 시
			$("#deleteButton").on("click", function(e) {
				e.preventDefault(); // 기본 동작 막기

				// 삭제 확인 다이얼로그 표시
				if (confirm("정말로 탈퇴 하시겠습니까?")) {
					// 삭제 폼을 서버로 전송
					$("#deleteForm").submit();
					confirm("탈퇴처리가 완료되었습니다.");
				}
			});
		});
	</script>


	<!-- input박스 디폴트값 선언 -->
	<script>
		// Replace with the actual user data
		const user = {
			phone : "<c:out value='${user.phone}' />",
			email : "<c:out value='${user.email}' />",
			businessNo : "<c:out value='${user.businessNo}' />"
		};

		// Set the default values for the input fields
		const phoneInput = document.querySelector(".phone_input");
		const emailInput = document.querySelector(".email_input");
		const businessNoInput = document.querySelector(".businessNo_input");

		phoneInput.value = user.phone;
		emailInput.value = user.email;
		businessNoInput.value = user.businessNo;
	</script>



	<script>
		var pwckCheck = false; // 비번 확인
		var pwckcorCheck = false; // 비번 확인 일치 확인
		$(document).ready(
				function() {

					$(".pw_input, .pwck_input").on(
							"propertychange change keyup paste input",
							function() {
								$(this).siblings(
										" .final_pw_ck, .final_pwck_ck").css(
										"display", "none");
							});

					$('.pwck_input').on(
							"propertychange change keyup paste input",
							function() {

								var pw = $('.pw_input').val();
								var pwck = $('.pwck_input').val();
								$('.final_pwck_ck').css('display', 'none');

								if (pw == pwck) {
									$('.pwck_input_re_1').css('display',
											'block');
									$('.pwck_input_re_2')
											.css('display', 'none');
									pwckcorCheck = true;
								} else {
									$('.pwck_input_re_1')
											.css('display', 'none');
									$('.pwck_input_re_2').css('display',
											'block');
									pwckcorCheck = false;
								}
							});
				});
	</script>

</body>

</html>
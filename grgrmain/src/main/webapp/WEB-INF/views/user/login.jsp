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
<title>Soft UI - Neumorphism Style UI Kit</title>
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

	<div id="preloader">
		<div class="preloader">
			<span></span> <span></span>
		</div>
	</div>

	<a href="${pageContext.request.contextPath}/index.html"
		class="top-logo"> <img
		src="${pageContext.request.contextPath}/assets/images/logo-main.png"
		alt=""></a>

	<div class="full-height relative p-y-30 v-center bg-img"
		style="background-image: url(/assets/images/placeholder.jpg)">
		<div class="container p-y-70">
			<div class="m-x-auto" style="max-width: 500px;">
				<div class="card mb-15">
					<div class="card-body p-x-25">
						<ul class="nav nav-tabs nav-pills text-center p-x-50"
							role="tablist">
							<li class="nav-item"><a
								class="nav-link active p-x-40"
								href="<c:url value="/user/login"/>" > <i
									class="fas fa-lock mr-5 va-middle"></i> <span class="va-middle">로그인</span>
							</a></li>
							<li class="nav-item"><a
								class="nav-link active p-x-40"
								href="<c:url value="/user/register"/>"> <i
									class="fas fa-user mr-5 va-middle"></i> <span class="va-middle">회원가입</span>
							</a></li>
						</ul>

						<!-- / nav tabs -->
						<div class="tab-content">
							<div class="tab-pane fade show active mt-20 p-15"
								id="tab-sign-in" role="tabpanel">
								<form class="validation-inner" id="login-form3"
									action="${pageContext.request.contextPath}/user/login"
									method="post">
									<div class="form-group">
										<input type="text" class="form-control" name="userId"
											placeholder="&#xf2bd; 아이디"
											style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400">
									</div>
									<!-- / form-group -->

									<div class="form-group">
										<input type="password" class="form-control" name="userPw"
											placeholder="&#xf11c; 비밀번호" required
											style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400">
									</div>
									<c:if test="${result == 0 }">
										<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
									</c:if>
									<!-- / form-group -->

									<!-- 아이디 찾기와 비밀번호 찾기 링크 -->
									<div class="forgot-links">
										<a href="${pageContext.request.contextPath}/user/find-id"
											class="forgot-link">아이디 찾기</a> <span class="divider">|</span>
										<a
											href="${pageContext.request.contextPath}/user/forgot-password"
											class="forgot-link">비밀번호 찾기</a>
									</div>

									<div class="row v-center mt-30">
										<div class="col-lg-5 tablet-lg-top-30">
											<!-- / checkbox -->
										</div>
										<!-- / column -->
										<div class="col-lg-7 text-right">
											<button type="submit"
												class="btn btn-sm btn-primary tablet-lg-fw">
												<i class="fas fa-sign-in-alt mr-5"></i> Sign In
											</button>
										</div>
										<!-- / column -->
									</div>
									<!-- / row -->
								</form>
								<!-- / login-form -->
								<div class="pt-60 text-center">
									<p style="margin-bottom: 4px;">간편 로그인</p>
									<a href="#x" class="btn btn-sm btn-outline-facebook mt-5">
										<span class="fab fa-facebook-f mr-5"></span> <span>Facebook</span>
									</a> <a href="#x" class="btn btn-sm btn-outline-twitter mt-5">
										<span class="fab fa-twitter mr-5"></span> <span>Twitter</span>
									</a> <a href="#x" class="btn btn-sm btn-outline-warning mt-5">
										<span class="fab fa-google mr-5"></span> <span>Google</span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<!-- / tab-content -->
				</div>
				<!-- / card-body -->
			</div>
			<!-- / card -->
		</div>
	</div>

	<p class="absolute bottom-15 x-0 text-center">
		<a href="${pageContext.request.contextPath}/index.html"
			class="text-link fs-16 m-x-15">Home</a> <a
			href="${pageContext.request.contextPath}/components.html"
			class="text-link fs-16 m-x-15">Components</a> <a
			href="${pageContext.request.contextPath}/sections.html"
			class="text-link fs-16 m-x-15">Sections</a> <a
			href="${pageContext.request.contextPath}/templates.html"
			class="text-link fs-16 m-x-15">Templates</a>
	</p>
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

	<!-- form validation -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.validate.min.js"></script>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.buttion-submit {
	display: inline-block;
}

.titleAndError {
	display: flex;
	align-items: center; /* 세로 중앙 정렬 */
	font-size: 20px height: 100px;
}
</style>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
<!-- 배너 -->
<c:set var="boardName" value="끼리끼리 상점" />
<header class="xl bg-img bg-fixed"
	style="background-image: url(${pageContext.request.contextPath}/images/market.jpg); background-size: cover;">
	<div class="container text-center">
		<h1 class="page-title">Product</h1>
		<p class="w-50 m-x-auto mb-30" style="color: white;">
			<c:out value="${boardName}" />
		</p>
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


<section class="lg bg-light-grey">
	<div class="container">
		<div class="w-90 m-x-auto mt-70" id="titleAndError">
			<div style="display: flex; align-items: left;">
				<h4 class="mb-30 text-left">상품 등록</h4>
				<span id="error-message" style="color: red;">${message}</span> <span
					id="content-error-message" style="color: red; padding-left: 20px"></span>
			</div>

			<!-- 폼 제출 영역 -->
			<form action="insert" method="post" enctype="multipart/form-data"
				class="validation-inner" id="form-validation"
				novalidate="novalidate">
				<!-- <input type="hidden" name="uno" value="loginUno" /><input type="hidden" name="infoUpdateUno" value="loginUno" /><input type="hidden"
						name="infoLoc" value="loginLoc" />  -->
				<input type="hidden" name="uno" value="${sessionScope.loginUno}" />
				<input type="hidden" name="productUpdateUno"
					value="${sessionScope.loginUno}" />
				<div class="row">

					<!-- / column -->

					<div class="col-md-9">
						<div class="form-group">
							<input type="text" class="form-control" id="productTitle"
								name="productTitle" placeholder="제목을 입력해주세요" required="true"
								style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400"
								aria-required="true"> <span id="error-message"
								style="color: red;">${message}</span> <span
								id="title-error-message" style="color: red; padding-left: 20px"></span>
						</div>
						<!-- / form-group -->
					</div>

					<div class="col-md-4">
						<div class="form-group">
							<input type="text" class="form-control" id="productPrice"
								name="productPrice" placeholder="가격을 입력해주세요" required="true"
								style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400"
								aria-required="true">
						</div>
						<!-- / form-group -->
					</div>
					<!-- / column -->

					<div class="form-group">
						<textarea id="contact-message" class="form-control"
							name="productContent" rows="8" placeholder="내용을 입력하세요"
							required="true"
							style="font-family: 'Font Awesome 5 Free', sans-serif !important; font-weight: 400; min-height: 500px; max-height: 500px;"
							aria-required="true"></textarea>
					</div>

					<div>
						<input type="file" name="files" multiple="multiple"
							accept="image/*" id="file-button" style="display: none;">
						<div class="btn btn-instagram m-y-10 mr-10"
							onclick="document.getElementById('file-button').click()">
							<span class="mr-5"><i class="fab fa-instagram"></i></span> <span>사진업로드</span>
						</div>
						<span id="img-error-message" style="color: red; font-size: 15px;"></span>
						<!-- 이미지 미리보기 영역 -->
						<div id="imagePreviewContainer" class="mb-10"></div>

					</div>


					<!-- / column -->

					<div style="text-align: right;">
						<a
							href="<c:url value='/productboard/list${searchCondition.getQueryString()}'/>"
							target="_blank">
							<button type="button" class="btn btn-primary-gradient">글목록</button>
						</a> <a
							href="<c:url value='/productboard/list${searchCondition.getQueryString()}'/>">
							<button type="button" class="btn btn-primary-gradient">작성
								취소</button>
						</a>
						<button type="button" class="btn btn-primary-gradient"
							id="insert-submit">등록</button>
					</div>
				</div>
			</form>
			<!-- / form-group 폼 제출 완료 -->
		</div>
	</div>
</section>
<!-- / pagination-center -->

<a href="#top" class="scroll-to-top is-hidden smooth-scroll"
	data-nav-status="toggle"><i class="fas fa-chevron-up"></i></a>
<!-- footer -->
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />

<!-- core JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
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
	var files;
	document.getElementById('file-button').addEventListener(
			'change',
			function(event) {
				files = event.target.files;
				var previewContainer = document
						.getElementById('imagePreviewContainer');
				previewContainer.innerHTML = '';

				for (var i = 0; i < files.length; i++) {
					var file = files[i];
					var reader = new FileReader();

					reader.onload = (function(file) {
						return function(e) {
							var div = document.createElement('div');
							div.style.display = 'inline-block';
							div.style.marginRight = '10px';

							var img = document.createElement('img');
							img.src = e.target.result;
							img.alt = "Image Preview";
							img.width = 30;
							div.appendChild(img);
							previewContainer.appendChild(div);
						};
					})(file);

					reader.readAsDataURL(file);
				}
			});
</script>

<script>
	$(document)
			.ready(
					function() {

						function isImageFile(file) {
							const validImageTypes = [ 'image/gif',
									'image/jpeg', 'image/png', 'image/jpg' ]; // 원하는 이미지 타입에 따라 확장 가능
							return file && validImageTypes.includes(file.type);
						}
						document
								.querySelector('#insert-submit')
								.addEventListener(
										'click',
										function() {
											var title = document
													.getElementsByName('productTitle')[0].value;
											var content = document
													.getElementsByName('productContent')[0].value;
											var price = document
													.getElementsByName('productPrice')[0].value;

											var contentErrorMessage = "";
											var imgErrorMessage = "";
											var titleErrorMessage = "";

											if (title.length > 25) {
												titleErrorMessage = '제목의 길이가 너무 깁니다.';
											}
											

											if (title.trim() === ''
													|| content.trim() === ''
													|| price.trim() === '') {
												console.log('trim 진입');
												contentErrorMessage = '입력값을 모두 입력해주세요.';
												console
														.log(contentErrorMessage);

											} else if (!isValidPrice(price)) {
												contentErrorMessage = '올바른 형식의 가격을 입력해주세요.';
											}

											if (files
													&& files.length > 0
													&& !Array.from(files)
															.every(isImageFile)) {
												console.log('img trim 진입');
												imgErrorMessage = '유효하지 않은 파일 형식입니다. 이미지 파일만 업로드 해주세요.';
												console.log('img error save');
											}

											if (contentErrorMessage !== "") {
												console
														.log('title error not null');

												document
														.getElementById('content-error-message').textContent = contentErrorMessage;

												$('#content-error-message')
														.show();
												console.log('title error show');

												setTimeout(function() {
													$('#content-error-message')
															.fadeOut('slow');
												}, 5000);
											}

											if (titleErrorMessage !== "") {
												console
														.log('title error not null');

												document
														.getElementById('title-error-message').textContent = titleErrorMessage;

												$('#title-error-message')
														.show();
												console.log('title error show');

												setTimeout(function() {
													$('#title-error-message')
															.fadeOut('slow');
												}, 5000);
											}

											if (imgErrorMessage !== '') {
												console
														.log('img error not null');
												document
														.getElementById('img-error-message').textContent = imgErrorMessage;
												$('#img-error-message').show();
												console.log('img error show');

												setTimeout(function() {
													$('#img-error-message')
															.fadeOut('slow');
												}, 5000);
											}

											if (contentErrorMessage === ""
													&& imgErrorMessage === ""
													&& titleErrorMessage === "") {
												document.getElementById(
														'form-validation')
														.submit(); // 폼을 제출
											}
										});

						setTimeout(function() {
							$('#error-message').fadeOut('slow');
						}, 5000);

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
							$('.close-overlay').click(
									function(e) {
										e.preventDefault();
										e.stopPropagation();
										if ($(this).closest('.img').hasClass(
												'hover')) {
											$(this).closest('.img')
													.removeClass('hover');
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

	function isValidPrice(price) {
		// 가격이 숫자이고 1 이상 50,000,000 이하인지 검사
		var numericPrice = parseFloat(price);
		return !isNaN(numericPrice) && numericPrice >= 1
				&& numericPrice <= 50000000;
	}
</script>
<!-- / portfolio script -->
</body>
</html>


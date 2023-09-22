<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Site Title -->
<title>끼리끼리 - 정보공유게시판</title>
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
	font-weight: "bold"
}
.uploaded-img{
	width: 300px;
	height:auto;
}
</style>
<body>
<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp" />
	<!-- 배너 -->
	<c:set var="boardName" value="판매게시판" />
	<header class="xl bg-img bg-fixed" style="background-image: url(${pageContext.request.contextPath}/images/productrmation.jpg); background-size: cover;">
		<div class="container text-center">
			<h1 class="page-title">Product</h1>
			<p class="w-50 m-x-auto mb-30" style="color: white;"><c:out value="${boardName}" /></p>
			<nav class="breadcrumb relative z-index-1 pt-10 pl-5">
				<a class="breadcrumb-item" href="/main">Home</a> <a
					class="breadcrumb-item" href="/productboard/list">Market</a> <span
					class="breadcrumb-item active">Product</span>
			</nav>
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
	
	<script type="text/javascript">
		
	</script>
	<!-- 큰 컨테이너  -->
	<section class="lg bg-light-grey">
		<div class="container">
			<div class="w-90 m-x-auto mt-70">
				<div>
					<h4 class="mb-30 text-left">상품 수정</h4>
					<span id="content-error-message" style="color: red; padding-left: 20px"></span>
					<c:if test="${not empty msg}">
						<div class="alert alert-danger">${msg}</div>
					</c:if>
				</div>
				<form action="modify" method="post" class="validation-inner" enctype="multipart/form-data"
					id="form-validation" novalidate="novalidate">
					<input type="hidden" name="uno" value="${productBoard.uno}" /> <input
						type="hidden" name="productId" value="${productBoard.productId}" /> <input
						type="hidden" name="productUpdateUno" value="${sessionScope.loginUno}" />
					<div class="row">
						<!-- / column -->

						<div class="col-md-12">
								<div class="form-group">
									상품명 : <input type="text" class="form-control border-faded"
										name="productTitle" value="${productBoard.productTitle}"
										placeholder="상품명" style="font-weight: bold;">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									가격 : <input type="text" class="form-control border-faded"
										name="productPrice" value="${productBoard.productPrice}"
										placeholder="가격" style="font-weight: bold;">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									상품 설명 :
									<textarea class="form-control border-faded"
										name="productContent" placeholder="상품 설명"
										style="height: 413px; font-weight: bold; resize: none;">${productBoard.productContent}</textarea>
								</div>

							</div>

						<!-- / form-group -->
					</div>
					<!-- / column -->
					<!-- 사진업로드 버튼 -->
					<div>
						<input type="file" name="files" multiple="multiple"
							accept="image/*" id="file-button" style="display: none;">
						<div class="btn btn-instagram m-y-10 mr-10"
							onclick="document.getElementById('file-button').click()">
							<span class="mr-5"><i class="fab fa-instagram"></i></span> <span>사진업로드</span>
							<span id="img-error-message" style="color: red; font-size: 15px;"></span>
							<!-- 이미지 미리보기 영역 -->
						</div>
						<div id="imagePreviewContainer" class="mb-10"></div>

					</div>
					<!-- 글 목록/ 수정 버튼 -->
					<div style="text-align: right;">
						<a
							href="<c:url value='/productboard/list${searchCondition.getQueryString()}'/>"
							target="_blank">
							<button type="button" class="btn btn-primary">상품 목록</button>
						</a> <a
									href="<c:url value='/productboard/get?productId=${productBoard.productId}'/>">
									<button type="button" class="btn btn-primary">수정취소</button>
								</a>
						<button type="button" id="modify-submit"
							class="btn btn-primary">수정</button>
					</div>
					<!-- 기존 업로드됐던 파일들 -->
					<c:forEach var="file" items="${productFiles}">
						<div data-hide="false">
						<img class="uploaded-img" src="<c:url value="/upload/${file.productFileUpload}"/>"
							alt="${file.productFileOrigin }">
							<!-- ${file.productFileNo}사용해야함 -->
							<a class="btn btn-xs btn-danger m-y-10 mr-10 delete-file" data-file-no="${file.productFileNo}">이미지 삭제</a>
						</div>
					</c:forEach>
				</form>
				<!-- / form-group -->
			</div>
		</div>
	</section>
	<!-- / pagination-center -->

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

	<!-- portfolio script -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery.shuffle.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/portfolio.js"></script>
		<script>
		//파일 업로드 input태그에서 선택한 파일을 저장하기위한 변수
		var files;
		//이미지가 선택되고나면 실행될 이벤트 리스너 
		document.getElementById('file-button').addEventListener('change',function(event) {
					//이벤트실행시 선택된 파일의정보를 파일에 저장함
					files = event.target.files;
					var previewContainer = document.getElementById('imagePreviewContainer');
					previewContainer.innerHTML = '';

					for (var i = 0; i < files.length; i++) {
						var file = files[i];
						//파일을 읽어오기위해 FileReader 객체 생성
						var reader = new FileReader();
						//
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
						
						//파일리더를 통해 읽어온 파일 데이터를 URL 형태로 가져옴
						reader.readAsDataURL(file);
					}
				});
	</script>
	
	<script>
		$(document).ready(function() {
			//파일 화면에서 hide()
			var deleteFileList = [];
			$('.delete-file').click(function(){
				var $selectedImg= $(this).closest('div');
				var fileNo = $(this).data('file-no');
				deleteFileList.push(fileNo)
				$(this).closest('div').attr("data-hide", "true").hide();
		
			});
			
			
			//파일 형식 검사
		    function isImageFile(file) {
		        const validImageTypes = ['image/gif', 'image/jpeg', 'image/png', 'image/jpg']; 
		        return file && validImageTypes.includes(file.type);
		    }
		    document.querySelector('#modify-submit').addEventListener('click', function() {
		        var productBoardUno = "${productBoard.uno}";
		        var loginUno = "${sessionScope.loginUno}";
	
		        // 권한이 없는 사용자가 get방식으로 페이지를 요청하여 수정하는 것 방지
		        if (productBoardUno !== loginUno) {
		            window.location.href = "<c:url value="/404"/>";
		            return;
		        }
	
		        var title = document.getElementsByName('productTitle')[0].value;
		        var content = document.getElementsByName('productContent')[0].value;
		        var productPrice = document.getElementsByName('productPrice')[0].value;
		        var priceErrorMessage = "";
		        var contentErrorMessage = "";
		        var imgErrorMessage = "";
		        var titleErrorMessage = "";
		        
		        if (isNaN(productPrice) || productPrice < 1 || productPrice > 500000000) {
		            priceErrorMessage = '잘못된 형식의 가격입니다. 올바르게 입력해주세요.';
		        }
		        
		        if (priceErrorMessage !== "") {
		            alert(priceErrorMessage);
		        }
	
		        if (title.trim() === '' || content.trim() === '') {		         
		            contentErrorMessage = '제목과 내용을 모두 입력해주세요.';		            
		        }
		        if (title.length > 25) {
	                titleErrorMessage = '제목의 길이가 너무 깁니다.';
	            }
		        if (titleErrorMessage !== "") {
		        	alert(titleErrorMessage);
		        }
		        
		        if (contentErrorMessage !== "") {
		            alert(contentErrorMessage);
		        }

		        if (files && files.length > 0 && !Array.from(files).every(isImageFile)) {		         
		            imgErrorMessage = '유효하지 않은 파일 형식입니다. 이미지 파일만 업로드 해주세요.';
		        }
		        
		        if (imgErrorMessage !== "") {
		            alert(imgErrorMessage);
		        }

		        if (contentErrorMessage === "" && imgErrorMessage === "" && priceErrorMessage === "" && titleErrorMessage === "") {
					
					 $.ajax({
						type:'DELETE',
						url:"<c:url value='/productfile/delete'/>",
						contentType: "application/json",
						data: JSON.stringify(deleteFileList),
						success: function(data){
							document.getElementById('form-validation').submit(); // 폼을 제출
						},
						error: function(err){
							console.error("파일 삭제에 실패하였습니다.", err.responseText );
						}
					}); 
		        }
		    });

		    setTimeout(function() {
		        $('#error-message').fadeOut('slow');
		    }, 5000);
	
		    if (Modernizr.touch) {
		        // 터치 이벤트를 지원하는 환경 처리
		        $('.close-overlay').removeClass('hidden');
		        $('.img').click(function(e) {
		            if (!$(this).hasClass('hover')) {
		                $(this).addClass('hover');
		            }
		        });
	
		        $('.close-overlay').click(function(e) {
		            e.preventDefault();
		            e.stopPropagation();
		            if ($(this).closest('.img').hasClass('hover')) {
		                $(this).closest('.img').removeClass('hover');
		            }
		        });
		    } else {
		        // 터치 이벤트를 지원하지 않는 환경 처리
		        $('.img').mouseenter(function() {
		            $(this).addClass('hover');
		        }).mouseleave(function() {
		            $(this).removeClass('hover');
		        });
		    }
		});
	</script>
	<!-- / portfolio script -->
</body>
</html>


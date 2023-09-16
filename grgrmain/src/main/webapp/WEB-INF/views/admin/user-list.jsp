<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Bootstrap 4, from LayoutIt!</title>

<meta name="description"
	content="Source code generated using layoutit.com">
<meta name="author" content="LayoutIt!">

<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.2/jquery.modal.min.js"></script>

<style>
th, td {
	text-align: center;
	padding: 8px; /* 셀 내부 패딩 값 조절 */
}
.custom-margin{
	margin-botom:100px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<h1>&emsp;&emsp;&emsp;&emsp;
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;header</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2">
				<ul>
					<li class="list-item">회원관리</li>
					<li class="list-item">주문 관리</li>
					<li class="list-item">공지글 관리</li>
					<li class="list-item">신고 글 관리</li>
					<li class="list-item">문의 게시판</li>
				</ul>
			</div>
			<div class="col-md-10">
				<div class="row">
					<div class="col-md-12">
						<h1>회원 목록</h1>
					</div>
				</div>

				<table class="table1">
					<tr>
						<th width="100">회원번호</th>
						<th width="100">이름</th>
						<th width="100">닉네임</th>
						<th width="100">아이디</th>
						<th width="100">휴대폰</th>
						<th width="100">이메일</th>
						<th width="100">회원 등급</th>
						<th width="100">활동 상태</th>
						<th width="100">포인트</th>
						<th width="100">사업자 등록번호</th>
						<th width="100">마지막 로그인</th>
						<th width="100">가입 날짜</th>
						<th width="100">수정 날짜</th>
						<th width="100">최근 수정 회원</th>
					</tr>
					<!-- 게시글 목록 출력 -->
					<c:forEach var="user" items="${userList}">
						<tr>
							<td align="center">${user.uno }</td>
							<td align="center" class="user-name-cell"
								data-user-id="${user.uno}">${user.userName}</td>
							<td align="center">${user.nickName }</td>
							<td align="center">${user.userId }</td>
							<td align="center">${user.phone }</td>
							<td align="center">${user.email }</td>
							<td align="center">${user.userStatus }</td>
							<td align="center">${user.active }</td>
							<td align="center">${user.point }</td>
							<td align="center">${user.businessNo }</td>
							<td align="center"><fmt:formatDate value="${user.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            				<td align="center"><fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            				<td align="center"><fmt:formatDate value="${user.userUpdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td align="center">${user.userName }</td>
						</tr>
					</c:forEach>
				</table>

				<!-- 페이지 번호 출력 - 링크 제공 -->
				<c:choose>
					<c:when test="${pager.startPage > pager.blockSize }">
						<a href="<c:url value="user-list"/>?pageNum=${pager.prevPage}">[이전]</a>
					</c:when>
					<c:otherwise>
                    [이전]
                </c:otherwise>
				</c:choose>

				<c:forEach var="i" begin="${pager.startPage }"
					end="${pager.endPage }" step="1">
					<c:choose>
						<c:when test="${pager.pageNum != i  }">
							<a href="<c:url value="user-list"/>?pageNum=${i}">[${i }]</a>
						</c:when>
						<c:otherwise>
                        [${i }]
                    </c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${pager.endPage != pager.totalPage }">
						<a href="<c:url value="user-list"/>?pageNum=${pager.nextPage}">[다음]</a>
					</c:when>
					<c:otherwise>
                    [다음]
                </c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h1>footer</h1>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="userModal" tabindex="-1" role="dialog"
		aria-labelledby="userModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="userModalLabel">사용자 정보</h4>
					<hr>
				</div>
				<div class="modal-body">
					<!-- 기존 사용자 정보 출력 -->

					<!-- 추가적인 사용자 정보도 여기에 표시 -->

					<!-- 추가: 수정 폼 -->
					<form id="userEditForm">
						
						<p><strong>회원 번호 :</strong> <span id="modal-uno"></span></p>
						<input type="hidden" id="modal-uno-input">

						<div class="custom-margin" >
							<label for="modal-username-input">이름 :</label> <input type="text"
								id="modal-username-input" name="userName">
						</div>

						<div class="custom-margin">
							<label for="modal-nickname-input">닉네임 :</label> <input type="text"
								id="modal-nickname-input" name="nickName">
						</div>

						<div class="custom-margin">
							<label for="modal-userid-input">아이디:</label> <input type="text"
								id="modal-userid-input" name="userId">
						</div>
						<div class="custom-margin">
							<label for="modal-phone-input">휴대폰 :</label> <input type="text"
								id="modal-phone-input" name="phone">
						</div>
						<div class="custom-margin">
							<label for="modal-email-input">이메일 :</label> <input type="text"
								id="modal-email-input" name="email">
						</div>
						<div class="custom-margin">
							<label for="modal-userStatus-input">회원 등급 :</label> <input type="text"
								id="modal-userStatus-input" name="userStatus">
						</div>
						<div class="custom-margin">
							<label for="modal-active-input">활동 상태 :</label> <input type="text"
								id="modal-active-input" name="active">
						</div>
						<div class="custom-margin">
							<label for="modal-point-input">포인트 :</label> <input type="text"
								id="modal-point-input" name="point">
						</div>
						<div class="custom-margin">
							<label for="modal-businessNo-input">사업자 등록 번호 :</label> <input type="text"
								id="modal-businessNo-input" name="businessNo">
						</div>
						<p><strong>마지막 로그인 :</strong> <span id="modal-lastLogin"></span></p>
						<p><strong>가입 날짜 :</strong> <span id="modal-regDate"></span></p>
						<p><strong>수정 날짜 :</strong> <span id="modal-userUpdate"></span></p>
						<p><strong>최근 수정 회원 :</strong> <span id="modal-userUpdateUno"></span></p>
					</form>
					
				</div>
				<div class="modal-footer">
					<!-- 수정 버튼 -->
					<button type="button" class="btn btn-primary" id="editUserButton">수정하기</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
    var userList = ${userListJson};

 	// 날짜 형식 변환 함수
    function formatDate(date) {
        var options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', timeZone: 'Asia/Seoul' };
        return new Date(date).toLocaleDateString('ko-KR', options);
    }
    
 	var clickedUserId; // 클릭한 사용자의 userId 저장용 변수

    jQuery(document).ready(function() {
        jQuery('.user-name-cell').click(function() {
            var userId = jQuery(this).data('user-id');
            var user = userList.find(u => u.uno === userId);

            if (user) {
                clickedUserId = userId; // 클릭한 사용자의 userId 저장
                var modalBody = jQuery('#userModal').find('.modal-body');

                jQuery('#modal-uno').text(user.uno);
	
             	//입력 필드에 기존 정보를 기본값으로 설정
                $('#modal-username-input').val(user.userName);
                $('#modal-nickname-input').val(user.nickName);
                $('#modal-userid-input').val(user.userId);
                $('#modal-phone-input').val(user.phone);
                $('#modal-email-input').val(user.email);
                $('#modal-userStatus-input').val(user.userStatus);
                $('#modal-active-input').val(user.active);
                $('#modal-point-input').val(user.point);
                $('#modal-businessNo-input').val(user.businessNo);
                
                jQuery('#modal-lastLogin').text(formatDate(user.lastLogin));
                jQuery('#modal-regDate').text(formatDate(user.regDate));
                jQuery('#modal-userUpdate').text(formatDate(user.userUpdate));
                jQuery('#modal-userUpdateUno').text(user.userName);
                
                // 모달을 표시합니다
                jQuery('#userModal').modal('show');

                $('#editUserButton').click(function() {
                    var userName = $('#modal-username-input').val();
                    var nickName = $('#modal-nickname-input').val();
                    var userId = $('#modal-userid-input').val();
                    var phone = $('#modal-phone-input').val();
                    var email = $('#modal-email-input').val();
                    var userStatus = $('#modal-userStatus-input').val();
                    var active = $('#modal-active-input').val();
                    var point = $('#modal-point-input').val();
                    var businessNo = $('#modal-businessNo-input').val();
                    
                    if (!userName || !nickName || !userId) {
                        // 필수 필드가 비어있을 경우 처리
                        alert('필수 정보를 입력해주세요.');
                        return;
                    }
                    
                    var editedUser = {
                        uno: clickedUserId, // 클릭한 사용자의 userId를 uno로 사용
                        userName: userName,
                        nickName: nickName,
                        userId: userId,
                        phone: phone,
                        email: email,
                        userStatus: userStatus,
                        active: active,
                        point: point,
                        businessNo: businessNo,
                        // 추가적인 수정 필드들
                    };
                    
                    $.ajax({
                        type: 'POST',
                        url: '/admin/user-update',
                        contentType: 'application/json',
                        data: JSON.stringify(editedUser),
                        success: function(response) {
                            if (response === 'success') {
                                // 성공 시 모달 닫기 및 새로고침
                                $('#userModal').modal('hide');
                                location.reload();
                            } else {
                                // 실패 시 처리
                            }
                        },
                        error: function() {
                            // 에러 처리
                        }
                    });
                });
            }
        });
    });
</script>
</body>
</html>

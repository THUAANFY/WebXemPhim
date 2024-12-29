<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="referrer" content="no-referrer">
    <!-- Nhúng CSS bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Nhúng styles.css -->
    <link rel="stylesheet" href="/ASSIGNMENT/views/css/styles.css">

    <!-- Nhúng CSS BoxIcons -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <!-- Nhúng CSS Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Online Entertainment</title>
    <style type="text/css">
    	.video-poster {
		    position: relative;
		    width: 100%; /* Đảm bảo poster chiếm toàn bộ chiều rộng của container */
		    height: 0;
		    padding-bottom: 56.25%; /* Tỉ lệ 16:9 (ví dụ tiêu chuẩn cho video) */
		    overflow: hidden;
		    border-top-left-radius: 5px;  /* Bo tròn góc trên bên trái */
    		border-top-right-radius: 5px;
		}
		
		.video-poster img {
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;  /* Chiều rộng của ảnh = chiều rộng container */
		    height: 100%; /* Chiều cao của ảnh = chiều cao container */
		    object-fit: cover; /* Đảm bảo hình ảnh được cắt tỉ lệ và phủ kín container */
		}
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-md bg-success-subtle border-1 border-success border-bottom sticky-top p-0">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="/ASSIGNMENT/index">
                <img src="/ASSIGNMENT/views/image/logo.png" alt="">
                <span class="m-auto">ONLINE ENTERTAINMENT</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
            	<ul class="navbar-nav ms-auto">
				    <c:choose>
				        <c:when test="${not empty sessionScope.userlogin}">
				            <!-- Show user's name on the right side -->
				            <li class="nav-item">
				                <p class="nav-link alert alert-warning mb-0 p-2">Xin chào, ${sessionScope.userlogin.fullname} !</p>
				            </li>
				        </c:when>
				    </c:choose>
				
				    <li class="nav-item dropdown me-2">
				        <a class="nav-link dropdown-toggle d-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				            <i class='bx bxs-user-account'></i>
				            Tài khoản của tôi
				        </a>
				        <ul class="dropdown-menu mt-3 mb-1 me-4 ms-n1">
				            <c:choose>
				                <c:when test="${not empty sessionScope.userlogin}">
				                    <!-- User-specific options when logged in -->
				                    <li class="mb-2">
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/dangxuat">
				                            <i class="fa-solid fa-right-from-bracket"></i>
				                            Đăng xuất
				                        </a>
				                    </li> 
				                    <li class="mb-2">
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/doimatkhau">
				                            <i class="fa-solid fa-rotate"></i>
				                            Thay đổi mật khẩu
				                        </a>
				                    </li>
				                    <li>
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="/ASSIGNMENT/chinhsua">
				                            <i class="fa-solid fa-pen-to-square"></i>
				                            Chỉnh sửa thông tin
				                        </a>
				                    </li>
				
				                    <!-- Chỉ hiển thị "Công cụ" cho người dùng là admin -->
									<c:if test="${not empty sessionScope.userlogin && sessionScope.userlogin.admin == true}">
									    <li class="mt-2">
									        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/admin-videos">
									            <i class="fa-solid fa-toolbox"></i>
									            Công cụ
									        </a>
									    </li>
									</c:if>
				
				                </c:when>
				                <c:otherwise>
				                    <!-- Options for users who are not logged in -->
				                    <li class="mb-2">
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/dangnhap">
				                            <i class="fa-solid fa-right-to-bracket"></i>
				                            Đăng nhập
				                        </a>
				                    </li>
				                    <li class="mb-2">
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/quenmatkhau">
				                            <i class="fa-solid fa-lock"></i>
				                            Quên mật khẩu
				                        </a>
				                    </li>
				                    <li class="mb-2">
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="${pageContext.request.contextPath}/dangky">
				                            <i class="fa-solid fa-user-pen"></i>
				                            Đăng ký
				                        </a>
				                    </li>
				                </c:otherwise>
				            </c:choose>
				        </ul>
				    </li>
				    <li class="nav-item me-2">
				        <a class="nav-link active d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/videodathich">
				            <i class='bx bx-like'></i>
				            Video Đã Thích
				        </a>
				    </li>
				</ul>
			</div>
        </div>
    </nav>
    
    <c:if test="${not empty sessionScope.error}">
    	<div class="alert alert-danger fade show p-2 mx-3 mt-1 mb-0 z-3" role="alert">
	        ${sessionScope.error}
	        <button type="button" class="btn-close position-absolute end-0 me-2" data-bs-dismiss="alert" aria-label="Close"></button>
	    </div>
	    <c:remove var="error" scope="session" />
	</c:if>
    

    <div class="container-sm mt-1 pt-3">
        <figure class="text-center">
            <blockquote class="blockquote">
                <p class="text-success display-5">Our Videos</p>
            </blockquote>
            <figcaption class="blockquote-footer">
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus in quia libero suscipit aliquam aspernatur.
            </figcaption>
        </figure>
    </div>

    <!-- CONTAINER -->
    <div class="container">
        <div class="row">
        	<c:forEach var="video" items="${videoList}">
			    <div class="col-12 col-sm-6 p-sm-2 col-lg-4 col-xl-3">
			        <div class="card mb-3 border-0">
				       	<div class="video-poster">
			                <a href="${pageContext.request.contextPath}/chitietvideo?id=${video.id}" class="video-link">
			                    <img src="${video.poster}" alt="Poster for ${video.title}" class="img-fluid" />
			                </a>
			            </div>
			            <div class="card-body p-3">
			                <a href="${pageContext.request.contextPath}/chitietvideo?id=${video.id}" class="text-reset text-decoration-none">
			                    <h6 class="card-title text-truncate">${video.title}</h6>
			                </a>
			                <div class="row align-items-center justify-content-end">
			                    <div class="row align-items-center justify-content-end">
			                        <div class="btn-group col-auto pe-2 ps-0" role="group" aria-label="Basic example">
			                            <button type="button" class="btn bg-success-subtle border-1 border-success p-1 d-flex align-items-center gap-2 successA likeButton" id="" data-video-id="${video.id}"> <!-- ?videoId=${video.id} -->
			                                <i class='bx bx-like'></i>
			                                Thích
			                            </button>
			                            <button type="button" class="btn bg-success-subtle border-1 border-success p-1 d-flex align-items-center gap-2">
			                                <i class='bx bx-dislike'></i>
			                            </button>
			                        </div>
			                        <div class="col-auto pe-2 ps-0">
			                            <button class="btn bg-success-subtle border-1 border-success p-1 d-flex align-items-center gap-2" onclick="window.location.href='${pageContext.request.contextPath}/chiase?videoId=${video.id}'">
			                                <i class='bx bx-share bx-flip-horizontal'></i>
			                                Chia sẻ
			                            </button>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</c:forEach>
        </div>
    </div>

    <!-- PAGINATION -->
    <div class="d-flex justify-content-center my-3">
        <div class="btn-group" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-outline-success">
                <i class="fa-solid fa-angles-left"></i>
            </button>
            <button type="button" class="btn btn-outline-success">
                <i class="fa-solid fa-angle-left"></i>
            </button>
            <button type="button" class="btn btn-outline-success">
                <i class="fa-solid fa-angle-right"></i>
            </button>
            <button type="button" class="btn btn-outline-success">
                <i class="fa-solid fa-angles-right"></i>
            </button>
        </div>
    </div>

    <hr>

    <!-- FOOTER -->
    <div class="container-fluid">
        <div class="row">
            <div class="col-6">
                <p class="text-start small">&copy; 2024 Online Entertainment OE</p>
            </div>
            <div class="col-6">
                <div class="row">
                    <div class="col-9 small text-end ms-auto">
                        <a href="#" class="mx-auto nav-link small">Privacy & Policy</a>
                    </div>
                    <div class="col-3 small text-end ms-auto">
                        <a href="#" class="mx-auto nav-link small">Terms & Condition</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function () {
		    // Attach the click event to all buttons with the likeButton class
		    $('.likeButton').click(function () {
		        var videoId = $(this).data('video-id'); // Lấy videoId từ thuộc tính data-video-id
		        var $button = $(this);  // Tham chiếu tới nút đã được nhấn
		    
		        $.ajax({
		            url: '${pageContext.request.contextPath}/thich',
		            method: 'GET',
		            data: { videoId: videoId },
		            success: function (response) {
		                console.log(response); // Log phản hồi từ server
	
		                if (response.status === "success") {
		                    alert(response.message);  // Thông báo thành công
		                    $button.text('Đã thích');  // Cập nhật lại chữ của nút
		                    $button.find('i').removeClass('bx-like').addClass('fa-solid fa-thumbs-up');  // Thay đổi biểu tượng
		                } else {
		                    alert(response.message);  // Thông báo lỗi nếu có
		                }
		            },
		            error: function () {
		                alert("Đã có lỗi xảy ra. Vui lòng thử lại.");
		            }
		        });
		    });
		});
	</script>

    <!-- Nhúng JS IonIcons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- Nhúng JS bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- <script src="/ASSIGNMENT/views/js/script.js"></script> -->
</body>
</html>
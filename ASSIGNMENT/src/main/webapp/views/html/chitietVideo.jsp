<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Nhúng CSS bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Nhúng styles.css -->
    <link rel="stylesheet" href="/ASSIGNMENT/views/css/styles.css">

    <!-- Nhúng CSS BoxIcons -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <!-- Nhúng CSS Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>${videoWatch.title}</title>
    <style type="text/css">
    	.video-poster {
		    position: relative;
		    width: 100%; /* Đảm bảo poster chiếm toàn bộ chiều rộng của container */
		    height: 0;
		    padding-bottom: 56.25%; /* Tỉ lệ 16:9 (ví dụ tiêu chuẩn cho video) */
		    overflow: hidden;
		    border-radius: 5px;  /* Bo tròn góc trên bên trái */
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
				                            Đổi mật khẩu
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
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="/ASSIGNMENT/views/html/quenmatkhau.jsp">
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

    <!-- CONTAINER -->
    <div class="container-fluid mt-1 pt-3">
        <div class="row">
        	<div id="notification" style="display: none; background: #d4edda; color: #155724; padding: 10px; margin-top: 10px; border-radius: 5px;">
			    <!-- Thông báo sẽ được hiển thị ở đây -->
			</div>
            <!-- Video Player Section -->
            <div class="col-12 col-md-8 col-lg-8 mb-3">
                <div class="ratio ratio-16x9 mb-2">
                    <iframe class="rounded-4" src="${videoWatch.id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                </div>


                <!-- Tiêu Đề Video -->
                <h5 class="fw-bold">${videoWatch.title}</h5>

                <div class="row">
                    <div class="col-6">
                        <div class="d-flex align-items-center p-2 rounded">
                            <!-- Profile Image -->
                            <img src="/ASSIGNMENT/views/image/channels4_profile.jpg" alt="Profile" class="rounded-circle me-3" style="width: 50px; height: 50px;">
                            
                            <!-- Channel Information -->
                            <div class="flex-grow-1">
                                <h6 class="mb-0 d-flex align-items-center">
                                    Lee Thuaan Fy
                                    <i class="bi bi-check-circle-fill ms-2 text-primary"></i>
                                </h6>
                                <small class="text-muted">Active User</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <!-- Nút like & share -->
                        <div class="row align-items-center justify-content-end">
                            <div class="row align-items-center justify-content-end">
                                <div class="btn-group col-auto pe-2 ps-0" role="group" aria-label="Basic example">
                                    <button type="button" class="btn bg-success-subtle border-1 rounded-start-pill border-success p-1 d-flex align-items-center gap-2 px-2" id="likeButton" data-video-id="${videoWatch.id}">
									    <i class='bx bx-like'></i>
									    Thích
									</button>
                                    <button type="button" class="btn bg-success-subtle rounded-end-pill border-1 border-success p-1 d-flex align-items-center gap-2 p-2 px-3">
                                        <i class='bx bx-dislike' ></i>
                                    </button>
                                </div>
                                <div class="col-auto pe-2 ps-0">
                                    <button class="btn bg-success-subtle border-1 border-success p-2 px-3 d-flex align-items-center gap-2 rounded-pill" onclick="window.location.href='${pageContext.request.contextPath}/chiase?videoId=${videoWatch.id}'">
                                        <i class='bx bx-share bx-flip-horizontal'></i>
                                        Chia sẻ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p class="text-end pe-4">Lượt xem: ${videoWatch.views}</p>
                </div>

                <hr>

                <!-- Mô tả -->
                <h6 class="fw-bold">DESCRIPTION</h6>
                <p class="ps-3">
                	${videoWatch.description}
                </p>
            </div>
            
    
            <!-- Sidebar Section -->
            <div class="col-12 col-md-4">
            	<c:forEach var="video" items="${videoList}">
            		<div class="row mb-2">
	                    <div class="col-5">
	                        <div class="video-poster">
				                <a href="${pageContext.request.contextPath}/chitietvideo?id=${video.id}" class="video-link">
				                    <img src="${video.poster}" alt="Poster for ${video.title}" class="img-fluid" />
				                </a>
				            </div>
	                    </div>
	                    <div class="col-7 p-0">
	                        <a href="${pageContext.request.contextPath}/chitietvideo?id=${video.id}" class="text-reset text-decoration-none">
	                            <h6 class="card-title text-truncate-2">${video.title}</h6>
	                        </a>
	                    </div>
	                </div>
            	</c:forEach>
            </div>
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
	        $('#likeButton').click(function () {
	            var videoId = $(this).data('video-id'); // Lấy videoId từ thuộc tính data-video-id
	
	            $.ajax({
	                url: '${pageContext.request.contextPath}/thich',  // URL đến Servlet xử lý thích video
	                method: 'GET',  // Sử dụng GET để lấy dữ liệu từ server
	                data: { videoId: videoId },  // Gửi videoId như một tham số
	                success: function (response) {
	                    console.log(response); // Log phản hồi từ server
	
	                    // Kiểm tra nếu response có status là "success"
	                    if (response.status === "success") {
	                        alert(response.message);  // Thông báo thành công
	                        $('#likeButton').text('Đã thích');
	                        $('#likeButton i').removeClass('bx-like').addClass('fa-thumbs-up');
	                    } else if (response.status === "error") {
	                        // Nếu có lỗi, hiển thị thông báo lỗi
	                        alert(response.message);  // Thông báo lỗi (ví dụ: yêu cầu đăng nhập)
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
	<script src="/ASSIGNMENT/views/js/script.js"></script>
</body>
</html>
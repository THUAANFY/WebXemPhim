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
    <title>Chia sẻ</title>
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
				                <p class="nav-link alert alert-warning mb-0 p-2">Hello, ${sessionScope.userlogin.fullname} !</p>
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
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="/ASSIGNMENT/views/html/doimatkhau.jsp">
				                            <i class="fa-solid fa-rotate"></i>
				                            Thay đổi mạt khẩu
				                        </a>
				                    </li>
				                    <li>
				                        <a class="dropdown-item d-flex align-items-center gap-3" href="/ASSIGNMENT/views/html/chinhsua.jsp">
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
				                            Forgot Password
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
	<div class="container mt-1 pt-3">
        <h2 class=" p-2">CHIA SẺ VIDEO ĐẾN BẠN BÈ</h2>
        <div>
            <form action="chiase" method="post">
			    <label for="">Email</label>
			    <div class="input-group flex-nowrap mb-3">
			        <span class="input-group-text" id="addon-wrapping">@</span>
			        <input type="text" name="email" class="form-control" placeholder="Nhập Email" aria-label="Username" aria-describedby="addon-wrapping">
			    </div>
			
			    <!-- Video ID -->
			    <input type="hidden" name="videoId" value="${videoId}"> <!-- Thêm videoId vào đây -->
			
			    <div class="d-flex justify-content-end">
			        <button class="btn btn-warning p-1" type="submit">Chia sẻ Video</button>
			    </div>
			</form>
        </div>
    </div>
    

    <!-- Nhúng JS IonIcons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- Nhúng JS bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/ASSIGNMENT/views/js/script.js"></script>
</body>
</html>
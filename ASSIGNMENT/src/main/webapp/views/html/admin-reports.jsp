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
    <title>Chỉnh sửa</title>
</head>
<body>
	<!-- NAVBAR -->
    <nav class="navbar navbar-expand-md bg-success-subtle border-1 border-success border-bottom fixed-top p-0">
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
                    <li class="nav-item me-2">
                        <a class="nav-link active d-flex align-items-center gap-1" aria-current="page" href="${pageContext.request.contextPath}/index">
                            <i class="fa-solid fa-house"></i>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item me-2">
                        <a class="nav-link active d-flex align-items-center gap-1" aria-current="page" href="${pageContext.request.contextPath}/admin-videos">
                            <i class="fa-solid fa-video"></i>
                            Videos
                        </a>
                    </li>
                    <li class="nav-item me-2">
                        <a class="nav-link active d-flex align-items-center gap-1" aria-current="page" href="${pageContext.request.contextPath}/admin-users">
                            <i class="fa-solid fa-user pe-1"></i>
                            Người dùng
                        </a>
                    </li>
                    <li class="nav-item me-2">
                        <a class="nav-link active d-flex align-items-center gap-1" aria-current="page" href="${pageContext.request.contextPath}/favorites-reports">
                            <i class="fa-solid fa-chart-pie"></i>
                            Báo cáo
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

	<!-- CONTAINER -->
	  <div class="container-xxl mt-5 pt-5">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" id="myTab" role="tablist">
        	<li class="nav-item" role="presentation">
                <button class="nav-link active" id="favorites" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Yêu thích</button>
            </li>
        	<li class="nav-item" role="presentation">
                <button class="nav-link" id="favorites-users" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Người dùng yêu thích</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="shared-friends" data-bs-toggle="tab" data-bs-target="#shared" type="button" role="tab" aria-controls="profile" aria-selected="false">Bạn bè chia sẻ</button>
            </li>
        </ul>
    
        <!-- Tab panes -->
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="favorites">
                <table class="table table-striped table-hover mt-3">
                    <thead class="table-info">
                    	<tr>
                            <th scope="col">Tiêu Đề Video</th>
                            <th scope="col">Số Lượt Thích</th>
                            <th scope="col">Cũ Nhất</th>
                            <th scope="col">Mới Nhất</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="video" items="${favoritesReports}">
			            <tr>
			                <td>${video[0]}</td>
			                <td>${video[1]}</td>
			                <td>${video[2]}</td>
			                <td>${video[3]}</td>
			            </tr>
			        </c:forEach>
                    </tbody>
                </table>
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
            </div>
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="favorites-users">
				    <div class="row mt-3">
				        <div class="col-md-2 d-flex align-items-center">
				        	<h6>Tiêu Đề Video</h6>
				        </div>
				        <div class="col-md-10">
				            <select class="form-select form-control" name="videoId" onchange="location.href='${pageContext.request.contextPath}/favorites-user&share-reports?videoId=' + this.value">
							    <option value="">...</option>
							    <c:forEach var="video" items="${videoList}">
							        <option value="${video.id}" ${video.id == sessionScope.selectedVideoId ? 'selected' : ''}>${video.title}</option>
							    </c:forEach>
							</select>
				        </div>
				    </div>
                <table class="table mt-3 table-striped table-hover">
                    <thead class="table-info">
                    <tr>
                            <th scope="col">Tên người dùng</th>
                            <th scope="col">Họ Tên</th>
                            <th scope="col">Email</th>
                            <th scope="col">Ngày Thích</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="user" items="${usersLikedVideo}">
			                <tr>
			                    <td>${user[0]}</td>
			                    <td>${user[1]}</td>
			                    <td>${user[2]}</td>
			                    <td>${user[3]}</td>
			                </tr>
			            </c:forEach>
                    </tbody>
                </table>


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
            </div>
            <div class="tab-pane fade" id="shared" role="tabpanel" aria-labelledby="favorites-users">
                <div class="row mt-3">
                    <div class="col-md-2 d-flex align-items-center">
                            <h6>Tiêu Đề Video</h6>
                    </div>
                    <div class="col-md-10">
                        <select class="form-select form-control" name="videoId" onchange="location.href='${pageContext.request.contextPath}/favorites-user&share-reports?videoId=' + this.value">
							<option value="">...</option>
							<c:forEach var="video" items="${videoList}">
							    <option value="${video.id}" ${video.id == sessionScope.selectedVideoId ? 'selected' : ''}>${video.title}</option>
							</c:forEach>
						</select>
                    </div>
                </div>
                <table class="table mt-3 table-striped table-hover">
                    <thead class="table-info">
                    <tr>
                            <th scope="col">Người Chia Sẻ</th>
                            <th scope="col">Email Người Gửi</th>
                            <th scope="col">Email Người Nhận</th>
                            <th scope="col">Ngày Chia Sẻ</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="share" items="${shareDetails}">
			                <tr>
			                    <td>${share[0]}</td> <!-- Người chia sẻ -->
			                    <td>${share[1]}</td> <!-- Email người gửi -->
			                    <td>${share[2]}</td> <!-- Email người nhận -->
			                    <td>${share[3]}</td> <!-- Ngày chia sẻ -->
			                </tr>
			            </c:forEach>
                    </tbody>
                </table>

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
            </div>
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
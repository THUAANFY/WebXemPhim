<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<!-- CONTAINER -->
    <div class="container p-3">
        <h2 class="text-center fw-bold">CHỈNH SỬA TÀI KHOẢN</h2>
        <a href="/ASSIGNMENT/index">
            <button class="btn btn-outline-warning text-dark mb-4 ms-3">Quay lại trang chủ</button>
        </a>
        
        <%-- Hiển thị thông báo thành công hoặc lỗi --%>
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success p-2">
                <%= request.getAttribute("message") %>
                <button type="button" class="btn-close position-absolute end-0 me-2" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <form action="chinhsua" method="POST">
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="mb-3">
                        <label for="" class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" placeholder="Nhập Username"/>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="mb-3">
                        <label for="" class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : "" %>" placeholder="Nhập Password" readonly/>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="mb-3">
                        <label for="" class="form-label">Fullname</label>
                        <input type="text" class="form-control" name="fullname" value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>" placeholder="Nhập Fullname"/>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="mb-3">
                        <label for="" class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" placeholder="Nhập Email"/>
                    </div>
                </div>
            </div>
            <button class="dangnhap" type="submit">Cập Nhập</button>
        </form>
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
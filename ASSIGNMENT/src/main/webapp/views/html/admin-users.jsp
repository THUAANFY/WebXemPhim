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
                <button class="nav-link active" id="user-edition" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Chỉnh sửa nười dùng</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="user-list" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Danh sách người dùng</button>
            </li>
        </ul>
        
        <!-- Display success message after deletion -->
		<c:if test="${not empty sessionScope.success}">
		    <div class="alert alert-success fade show p-2 mx-3 mt-1 mb-0 z-3" role="alert">
		        ${sessionScope.success}
		        <button type="button" class="btn-close position-absolute end-0 me-2" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		    <c:remove var="success" scope="session" />
		</c:if>
    
        <!-- Tab panes -->
		<div class="tab-content" id="myTabContent">
		    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="user-edition">
			    <form action="${pageContext.request.contextPath}/users-edit/${useredit.id}" method="post">
			        <div class="row mt-3">
			            <div class="col-12 col-md-6">
			                <div class="mb-3">
			                    <label for="" class="form-label">Tên người dùng</label>
			                    <input type="text" class="form-control" name="username" value="${useredit.id}" placeholder="Nhập Tên Người Dùng" required/>
			                </div>
			            </div>
			            <div class="col-12 col-md-6">
			                <div class="mb-3">
			                    <label for="" class="form-label">Mật khẩu</label>
			                    <input type="password" class="form-control" name="password" value="${useredit.password}" placeholder="Nhập Mật Khẩu" required/>
			                </div>
			            </div>
			            <div class="col-12 col-md-6">
			                <div class="mb-3">
			                    <label for="" class="form-label">Họ Tên</label>
			                    <input type="text" class="form-control" name="fullname" value="${useredit.fullname}" placeholder="Nhập Họ Tên" required/>
			                </div>
			            </div>
			            <div class="col-12 col-md-6">
			                <div class="mb-3">
			                    <label for="" class="form-label">Email</label>
			                    <input type="email" class="form-control" name="email" value="${useredit.email}" placeholder="Nhập Email" required/>
			                </div>
			            </div>
			        </div>
			        <div class="col-12 mt-2 d-flex justify-content-end gap-2">
			            <button type="submit" name="action" value="UPDATE" class="btn bg-primary-subtle rounded-1 border-primary">CẬP NHẬT</button>
			            <!-- <button type="submit" class="btn bg-danger-subtle rounded-1 border-danger">DELETE</button> -->
			            <!-- Delete Button -->
        				<button type="submit" name="action" value="DELETE" class="btn bg-danger-subtle rounded-1 border-danger">XỎA BỎ</button>
			        </div>
			    </form>
			</div>
		
		    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="user-list">
			    <table class="table table-striped table-hover mt-3">
			        <thead class="table-info">
			            <tr>
			                <th scope="col">Tên người dùng</th>
			                <th scope="col">Mật khẩu</th>
			                <th scope="col">Họ Tên</th>
			                <th scope="col">Email</th>
			                <th scope="col">Vai Trò</th>
			                <th scope="col"></th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach var="user" items="${usersList}">
			                <tr>
			                    <td>${user.id}</td>
			                    <td>${user.password}</td>
			                    <td>${user.fullname}</td>
			                    <td>${user.email}</td>
			                    <td>${user.admin ? 'Admin' : 'User'}</td>
			                    <td>
			                        <a href="${pageContext.request.contextPath}/users-edit/${user.id}">Chỉnh sửa</a>
			                    </td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
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
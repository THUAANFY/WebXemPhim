<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/index">
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
                <button class="nav-link active" id="video-edition" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Chỉnh sửa video</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="video-list" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Danh sách video</button>
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
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="video-edition">
                <form action="${pageContext.request.contextPath}/video-edit/create" method="post" enctype="multipart/form-data" class="row mt-3">
                    <div class="col-12 col-md-6 mb-2">
                        <!-- Khu vực chứa ảnh poster và input để tải ảnh -->
                        <div class="poster-container ratio ratio-16x9 rounded-3">
                            <%-- <img id="posterImage" src="${videoedit.poster}" alt="Poster" class="poster"> --%>
				                <img id="posterImage" src="${pageContext.request.contextPath}/${videoedit.poster != null && !videoedit.poster.isEmpty() ? videoedit.poster : 'uploads/default-poster.jpg'}"  class="poster">
            				<input type="file" class="poster-input" name="poster" accept="image/*" onchange="loadImage(event)">
                        </div>
                    </div>
                    
                    <div class="col-12 col-md-6">
                        <div class="mb-3">
                            <label for="youtubeId" class="form-label">ID</label>
                            <input type="text" class="form-control input-box" name="id" id="youtubeId" value="${videoedit.id}" placeholder="Nhập ID" required>
                        </div>
                        <div class="mb-3">
                            <label for="videoTitle" class="form-label">TIÊU ĐỀ VIDEO</label>
                            <input type="text" class="form-control input-box" name="title" id="videoTitle" value="${videoedit.title}" placeholder="Nhập Tiêu Đề Video" required>
                        </div>
                        <div class="mb-3">
                            <label for="viewCount" class="form-label">SỐ LƯỢT XEM</label>
                            <input type="text" class="form-control input-box" name="view" id="viewCount" value="${videoedit.views}" readonly>
                        </div>
                        <div class="mb-3 form-check-inline">
                            <input type="radio" class="btn-check" id="active" name="status" value="active" ${videoedit.active ? 'checked' : ''}>
                            <label class="btn btn-outline-danger" for="active">HOẠT ĐỘNG</label>
                
                            <input type="radio" class="btn-check" id="inactive" name="status" value="inactive" ${!videoedit.active ? 'checked' : ''}>
                            <label class="btn btn-outline-warning" for="inactive">KHÔNG HOẠT ĐỘNG</label>
                        </div>
                    </div>
                
                    <!-- Row mới cho phần mô tả để textarea chiếm toàn bộ chiều rộng dưới các input và poster -->
                    <div class="col-12 mt-3">
                        <div class="form-floating">
                            <textarea class="form-control" name="description" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px" required>${videoedit.description}</textarea>
                            <label for="floatingTextarea2">MÔ TẢ</label>
                        </div>
                    </div>
                
                    <!-- Các nút hành động nằm trong cùng form để căn phải và sắp xếp dễ hơn -->
                    <div class="col-12 mt-2 d-flex justify-content-end gap-2">
                        <button type="submit" name="action" value="CREATE" class="btn bg-success-subtle rounded-1 border-success">THÊM MỚI</button>
                        <!-- Button for UPDATE -->
						<button type="submit" name="action" value="UPDATE" class="btn bg-primary-subtle rounded-1 border-primary">CẬP NHẬT</button>
						
						<!-- Button for DELETE -->
						<button type="submit" name="action" value="DELETE" class="btn bg-danger-subtle rounded-1 border-danger">XÓA BỎ</button>
						
						<!-- Button for RESET -->
						<!-- <button type="reset" class="btn bg-info-subtle rounded-1 border-info">RESET</button> -->
                    </div>
                </form>
            </div>
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="video-list">
                <table class="table table-striped table-hover mt-3">
                    <thead class="table-info">
                        <tr>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 40%;">Tiêu Đề Video</th>
                            <th scope="col">Số Lượt Xem</th>
                            <th scope="col">Trạng Thái</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="video" items="${videoList}">
			                <tr>
			                    <td>${video.id}</td>
			                    <td>${video.title}</td>
			                    <td>${video.views}</td>
			                    <td>${video.active ? 'Active' : 'Inactive'}</td>
			                    <td>
			                        <a href="${pageContext.request.contextPath}/video-edit?id=${fn:escapeXml(video.id)}">Chỉnh sửa</a>
			                    </td>
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
    
    <script>
	    function loadImage(event) {
	        // Lấy file được chọn
	        const file = event.target.files[0];
	        if (file) {
	            // Tạo đối tượng FileReader
	            const reader = new FileReader();
	            
	            // Đọc ảnh và hiển thị trên hình ảnh trong form
	            reader.onload = function(e) {
	                document.getElementById('posterImage').src = e.target.result;
	            };
	
	            // Đọc ảnh dưới dạng Data URL (base64)
	            reader.readAsDataURL(file);
	        }
	    }
	</script> 
	

    <!-- Nhúng JS IonIcons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- Nhúng JS bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/ASSIGNMENT/views/js/script.js"></script>
</body>
</html>
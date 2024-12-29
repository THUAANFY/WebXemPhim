package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.poly.dao.VideoDAO;
import com.poly.dao.VideoDAOImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.poly.dao.FavoriteDAO;
import com.poly.dao.FavoriteDAOImpl;
import com.poly.dao.ShareDAO;
import com.poly.dao.ShareDAOImpl;
import com.poly.dao.UsersDAO;
import com.poly.dao.UsersDAOImpl;
import com.poly.entity.Users;
import com.poly.entity.Video;

/**
 * Servlet implementation class adminServlet
 */
@WebServlet({
	"/admin-videos",
	"/admin-users",
	"/users-edit/*",
	"/video-edit/*",
	"/favorites-reports",
	"/favorites-user&share-reports",
	"/favorites-share-reports",
	"/create"
})
@MultipartConfig
public class adminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VideoDAO videoDAO = new VideoDAOImpl();
	private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
	private ShareDAO shareDAO = new ShareDAOImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		if (path.contains("admin-videos")) {
			handleAdminVideos(req, resp);
		} else if (path.contains("admin-users")) {
			handleAdminUsers(req, resp);
		} else if (path.contains("users-edit")) {
			handleUsersEdit(req, resp);
		} else if (path.contains("video-edit")) {
			handleVideoEdit(req, resp);
		} else if (path.contains("favorites-reports")) {
			handleFavorites(req, resp);
		} else if (path.contains("favorites-user&share-reports")) {
			handleFavorites(req, resp);
		} 
	}
	
	private void handleAdminVideos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		VideoDAO videoDAO = new VideoDAOImpl();
		List<Video> videoList = videoDAO.findAll();
		req.setAttribute("videoList", videoList);
		req.getRequestDispatcher("/views/html/admin-videos.jsp").forward(req, resp);
        return; // Thoát để ngăn chặn xử lý tiếp theo
	}
	
	private void handleVideoEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String videoId = req.getParameter("id");
	    VideoDAO videoDAO = new VideoDAOImpl();
	    String action = req.getParameter("action");

	    List<Video> videoList = videoDAO.findAll();
	    req.setAttribute("videoList", videoList);

	    // Handle CREATE action
	    if ("CREATE".equals(action)) {
	        try {
	            String title = req.getParameter("title");
	            String description = req.getParameter("description");
	            String status = req.getParameter("status");
	            Part filePart = req.getPart("poster");

	            Video newVideo = new Video();
	            newVideo.setId(videoId);
	            newVideo.setTitle(title);
	            newVideo.setDescription(description);
	            newVideo.setActive("active".equals(status));

	            String posterPath;
	            if (filePart != null && filePart.getSize() > 0) {
	                posterPath = saveFile(filePart); // Lưu file và lấy đường dẫn
	            } else {
	                posterPath = "uploads/default-poster.jpg";
	            }
	            newVideo.setPoster(posterPath);

	            videoDAO.create(newVideo);
	            
	            HttpSession session = req.getSession();
                List<Video> createdVideos = videoDAO.findAllActive();
                session.setAttribute("videoList", createdVideos);
                req.getSession().setAttribute("success", "Đã thêm mới video thành công.");
	            resp.sendRedirect(req.getContextPath() + "/admin-videos");
	            return;

	        } catch (Exception e) {
	            req.setAttribute("error", "Lỗi khi tạo video: " + e.getMessage());
	            System.err.println("Lỗi khi tạo video: " + e.getMessage());
	        }
	    }

	    if (videoId != null && !videoId.isEmpty()) {
	        try {
	            videoId = java.net.URLDecoder.decode(videoId, "UTF-8");
	            Video videoedit = videoDAO.findById(videoId);
	            if (videoedit != null) {

	                if ("DELETE".equals(action)) {
	                    videoDAO.deleteById(videoId);
	                    HttpSession session = req.getSession();
	                    List<Video> deletedVideos = videoDAO.findAllActive(); // Lấy danh sách video mới nhất
	                    session.setAttribute("videoList", deletedVideos);
	                    req.getSession().setAttribute("success", "Đã xóa video thành công.");
	    	            resp.sendRedirect(req.getContextPath() + "/admin-videos");
	    	            return;
	                }

	                if ("UPDATE".equals(action)) {
	                    String title = req.getParameter("title");
	                    String description = req.getParameter("description");
	                    String status = req.getParameter("status");
	                    Part filePart = req.getPart("poster"); // Get the uploaded file

	                    videoedit.setTitle(title);
//	                    videoedit.setDescription(description);
	                    description = description.replace("\n", "<br>");
	                    videoedit.setDescription(description);
	                    
	                    videoedit.setActive("active".equals(status));

	                    // Handle the poster update
	                    String posterPath = videoedit.getPoster(); // Keep the old poster if no new one is uploaded
	                    if (filePart != null && filePart.getSize() > 0) {
	                        posterPath = saveFile(filePart); // Save the new poster
	                    }
	                    videoedit.setPoster(posterPath); // Set the updated poster

	                    videoDAO.update(videoedit);

	                    HttpSession session = req.getSession();
	                    List<Video> updatedVideos = videoDAO.findAllActive(); // Lấy danh sách video mới nhất
	                    session.setAttribute("videoList", updatedVideos);
	                    req.getSession().setAttribute("success", "Đã cập nhật video thành công.");
	                    req.getRequestDispatcher("/views/html/admin-videos.jsp").forward(req, resp);
//	                    resp.sendRedirect(req.getContextPath() + "/index");
	                    return;
	                }

	                req.setAttribute("videoedit", videoedit);
	                System.out.println("Đã tìm thấy video: " + videoedit.getTitle());
	            } else {
	                req.setAttribute("error", "Không tìm thấy video với ID: " + videoId);
	                System.err.println("Không tìm thấy video với ID: " + videoId);
	            }
	        } catch (Exception e) {
	            req.setAttribute("error", "Lỗi khi xử lý ID video: " + e.getMessage());
	            System.err.println("Lỗi khi xử lý ID video: " + e.getMessage());
	        }
	    } else {
	        req.setAttribute("error", "ID video không hợp lệ.");
	        System.err.println("ID video không hợp lệ: " + videoId);
	    }
	    req.getRequestDispatcher("/views/html/admin-videos.jsp").forward(req, resp);
	}
	
	private String saveFile(Part filePart) throws IOException {
		if (filePart == null || filePart.getSize() == 0) {
	        return "uploads/default-poster.jpg"; // Đường dẫn tương đối đến poster mặc định
	    }
	    String fileName = filePart.getSubmittedFileName();
	    String appPath = getServletContext().getRealPath(""); // Lấy đường dẫn gốc của ứng dụng
	    String filePath = appPath + "uploads/" + fileName; // Đường dẫn đầy đủ để lưu file

	    // Tạo thư mục nếu chưa tồn tại
	    File uploadDir = new File(appPath + "uploads");
	    if (!uploadDir.exists()) {
	        uploadDir.mkdir();
	    }

	    File file = new File(filePath);
	    try (InputStream inputStream = filePart.getInputStream();
	         FileOutputStream outputStream = new FileOutputStream(file)) {
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = inputStream.read(buffer)) != -1) {
	            outputStream.write(buffer, 0, bytesRead);
	        }
	    }
	    return "uploads/" + fileName; // Trả về đường dẫn tương đối
	}
	
	private void handleFavorites(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();;
		String videoId = req.getParameter("videoId");
		session.setAttribute("selectedVideoId", videoId);
	    
	    List<Video> videoList = videoDAO.findAll();
	    List<Object[]> usersLikedVideo = favoriteDAO.findUsersByVideoId(videoId);
	    List<Object[]> favoritesReports = videoDAO.findAllWithLikeCount();
	    List<Object[]> shareDetails = shareDAO.findShareDetailsByVideoId(videoId);
	    
	    // Truyền danh sách vào JSP
	    req.setAttribute("videoList", videoList);
        req.setAttribute("usersLikedVideo", usersLikedVideo);
        req.setAttribute("favoritesReports", favoritesReports);
        req.setAttribute("shareDetails", shareDetails);

	    req.getRequestDispatcher("/views/html/admin-reports.jsp").forward(req, resp);
	}
	
	private void handleUsersEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = req.getPathInfo() != null ? req.getPathInfo().substring(1) : null;

	    if (userId != null) {
	        UsersDAO usersDAO = new UsersDAOImpl();
	        Users useredit = usersDAO.findById(userId);

	        if (useredit != null) {
	            String action = req.getParameter("action");
	            if ("DELETE".equals(action)) {
	                usersDAO.deleteById(userId);
	                req.getSession().setAttribute("success", "Đã xóa người dùng thành công.");
	                resp.sendRedirect(req.getContextPath() + "/admin-users");
	                return;
	            }
	         // Handle Update
	            if ("UPDATE".equals(action)) {
	                String username = req.getParameter("username");
	                String password = req.getParameter("password");
	                String fullname = req.getParameter("fullname");
	                String email = req.getParameter("email");

	                // Update user information;
	                useredit.setId(username);
	                useredit.setPassword(password);
	                useredit.setFullname(fullname);
	                useredit.setEmail(email);

	                // Save the updated user
	                usersDAO.update(useredit);

	                // Set success message and redirect to user list
	                req.getSession().setAttribute("success", "Đã cập nhật người dùng thành công.");
	                resp.sendRedirect(req.getContextPath() + "/admin-users");
	                return;
	            }
	            req.setAttribute("useredit", useredit);
	            req.getRequestDispatcher("/admin-users").forward(req, resp);
	        } else {
	            resp.sendRedirect(req.getContextPath() + "/admin-users");
	        }
	    } else {
	        resp.sendRedirect(req.getContextPath() + "/admin-users");
	    }
	}
	
	private void handleAdminUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UsersDAO usersDAO = new UsersDAOImpl();
	    List<Users> usersList = usersDAO.findAll();  // Lấy danh sách người dùng từ cơ sở dữ liệu
	    req.setAttribute("usersList", usersList);  // Đặt danh sách người dùng vào request
	    req.getRequestDispatcher("/views/html/admin-users.jsp").forward(req, resp);  // Chuyển tiếp đến trang admin-users.jsp
	    return;
	}
		
	
}

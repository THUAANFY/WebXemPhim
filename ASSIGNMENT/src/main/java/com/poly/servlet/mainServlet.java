package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.poly.entity.Favorite;
import com.poly.entity.Share;
import com.poly.entity.Users;
import com.poly.entity.Video;
import com.poly.utils.sendMailNewPassword;
import com.poly.utils.sendMailWelcome;
import com.poly.utils.sendMailShare;
import com.poly.dao.UsersDAOImpl;
import com.poly.dao.VideoDAO;
import com.poly.dao.VideoDAOImpl;
import com.poly.dao.FavoriteDAO;
import com.poly.dao.FavoriteDAOImpl;
import com.poly.dao.ShareDAO;
import com.poly.dao.ShareDAOImpl;
import com.poly.dao.UsersDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

//import org.apache.commons.beanutils.BeanUtils;

/**
 * Servlet implementation class mainServlet
 */
@WebServlet({
	"/index",
	"/dangnhap",
	"/dangxuat",
	"/videodathich",
	"/chiase",
	"/thich",
	"/bothich",
	"/doimatkhau",
	"/chinhsua",
	"/dangky",
	"/quenmatkhau",
	"/chitietvideo"
	})
public class mainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersDAO userDAO = new UsersDAOImpl();
	private VideoDAO videoDAO = new VideoDAOImpl();
	private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.contains("dangnhap")) {
            handleLogin(req, resp);
        } else if (path.contains("dangxuat")) {
            handleLogout(req, resp);
        } else if (path.contains("videodathich")) {
            handleLikedVideos(req, resp);
        } else if (path.contains("chiase")) {
            handleShareVideo(req, resp);
        } else if (path.contains("thich")) {
            handleLikeVideo(req, resp);
        } else if (path.contains("bothich")) { 
        	handleDisLikeVideo(req, resp);
        } else if (path.contains("doimatkhau")) {
            handleChangePassword(req, resp);
        } else if (path.contains("chinhsua")) { 
        	handleEditProfile(req, resp);
        } else if (path.contains("dangky")) {
        	handleRegister(req, resp);
        } else if (path.contains("quenmatkhau")) {
        	handleForgotPassword(req, resp);
        } else if (path.contains("chitietvideo")) {
        	handleDetailsVideo(req, resp);
        } else {
        	HttpSession session = req.getSession();
        	List<Video> videoList = (List<Video>) session.getAttribute("videoList");
        	if (videoList == null) { // Nếu không có trong session, lấy từ cơ sở dữ liệu
        	    videoList = videoDAO.findAllActive(); // Lấy dữ liệu video mới nhất
        	    session.setAttribute("videoList", videoList); // Lưu vào session để lần sau không phải truy vấn lại
        	}
            req.getRequestDispatcher("/views/html/index.jsp").forward(req, resp);
        }
    }
    
    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// Kiểm tra xem người dùng đã đăng nhập hay chưa
        Users userlogin = (Users) req.getSession().getAttribute("userlogin");
        if (userlogin != null) {
            // Nếu đã đăng nhập, chuyển hướng về trang chính
            resp.sendRedirect(req.getContextPath() + "/index");
            return;
        }

        if ("GET".equalsIgnoreCase(req.getMethod())) {
            req.getRequestDispatcher("/views/html/dangnhap.jsp").forward(req, resp);
        } else if ("POST".equalsIgnoreCase(req.getMethod())) {
            String idOrEmail = req.getParameter("idOrEmail");
            String password = req.getParameter("password");

            // Tìm kiếm người dùng trong cơ sở dữ liệu
            userlogin = userDAO.findByIdOrEmail(idOrEmail);
            if (userlogin != null && userlogin.getPassword().equals(password)) {
                // Lưu thông tin người dùng vào session
                req.getSession().setAttribute("userlogin", userlogin);
                resp.sendRedirect(req.getContextPath() + "/index");
            } else {
                req.setAttribute("error", "Invalid username/email or password.");
                req.getRequestDispatcher("/views/html/dangnhap.jsp").forward(req, resp);
            }
        }
    }
    
    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath() + "/index");
    }
    
    private void handleLikedVideos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	Users userlogin = (Users) req.getSession().getAttribute("userlogin");
        if (userlogin == null) {
            // Chưa đăng nhập -> chuyển hướng về trang chủ
            req.getSession().setAttribute("error", "Bạn cần đăng nhập để xem video đã thích.");
            resp.sendRedirect(req.getContextPath() + "/index");
            return;
        }

        // Lấy danh sách video đã thích
        List<Video> likedVideos = videoDAO.findLikedVideosByUserId(userlogin.getId());
        if (likedVideos == null || likedVideos.isEmpty()) {
            req.setAttribute("message", "Bạn chưa thích video nào.");
        } else {
            req.setAttribute("likedVideos", likedVideos);
            System.out.println("Liked Videos: " + likedVideos.size()); // Kiểm tra log
        }

        // Chuyển tiếp tới trang hiển thị danh sách video đã thích
        req.getRequestDispatcher("/views/html/videodathich.jsp").forward(req, resp);
    }
    
    private void handleShareVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Users userlogin = (Users) req.getSession().getAttribute("userlogin");

        if (userlogin != null) {
            if ("GET".equalsIgnoreCase(req.getMethod())) {
                String videoId = req.getParameter("videoId");
                if (videoId != null && !videoId.isEmpty()) {
                    req.setAttribute("videoId", videoId);
                }
                req.getRequestDispatcher("/views/html/chiase.jsp").forward(req, resp);
            } 
            // Nếu là yêu cầu POST, thực hiện chia sẻ và gửi email
            else if ("POST".equalsIgnoreCase(req.getMethod())) {
                String recipientEmail = req.getParameter("email");
                String videoId = req.getParameter("videoId");

                // Kiểm tra nếu email và videoId hợp lệ
                if (recipientEmail != null && !recipientEmail.isEmpty() && videoId != null && !videoId.isEmpty()) {
                    // Lấy video từ cơ sở dữ liệu bằng videoId
                    VideoDAO videoDAO = new VideoDAOImpl(); 
                    Video video = videoDAO.findById(videoId); // Tìm video theo videoId

                    if (video != null) {
                        // Tạo đối tượng Share
                        Share share = new Share();
                        share.setUser(userlogin);
                        share.setVideo(video);
                        share.setEmails(recipientEmail);
                        share.setShareDate(new Date());

                        // Lưu vào cơ sở dữ liệu
                        ShareDAO shareDAO = new ShareDAOImpl();
                        shareDAO.create(share);

                        // Gửi email chia sẻ
                        boolean emailSent = sendMailShare.sendShareEmail(userlogin, recipientEmail, videoId);
                        if (emailSent) {
                            req.setAttribute("message", "Video đã được chia sẻ thành công!");
                            System.out.println("Video đã được chia sẻ thành công!");
                        } else {
                            req.setAttribute("error", "Có lỗi xảy ra khi gửi email chia sẻ.");
                        }
                        req.getRequestDispatcher("/views/html/chiase.jsp").forward(req, resp);
                    } else {
                        req.setAttribute("error", "Video không tồn tại.");
                        req.getRequestDispatcher("/views/html/chiase.jsp").forward(req, resp);
                    }
                } else {
                    req.setAttribute("error", "Vui lòng nhập email và video ID của người nhận.");
                    req.getRequestDispatcher("/views/html/chiase.jsp").forward(req, resp);
                }
            }
        } else {
            req.getSession().setAttribute("error", "Bạn cần đăng nhập để chia sẻ video.");
            resp.sendRedirect(req.getContextPath() + "/index");
        }
    }
    
    private void handleDisLikeVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users userlogin = (Users) req.getSession().getAttribute("userlogin");
        if (userlogin == null) {
            resp.sendRedirect(req.getContextPath() + "/dangnhap");
            return;
        }
        String videoId = req.getParameter("videoId");
        if (videoId != null) {
            try {
                Long videoIdLong = Long.parseLong(videoId);
                Favorite favorite = favoriteDAO.findFavoriteByUserAndVideo(
                    String.valueOf(userlogin.getId()),
                    String.valueOf(videoIdLong)
                );

                if (favorite != null) {
                    favoriteDAO.deleteById(favorite.getId());
                    System.out.println("Video removed from favorites.");
                } else {
                    System.out.println("Favorite not found for this user and video.");
                }
                resp.sendRedirect(req.getContextPath() + "/chitietvideo?videoId=" + videoId);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid video ID.");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Video ID is required.");
        }
    }
    
    private void handleLikeVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Users userlogin = (Users) req.getSession().getAttribute("userlogin");
        // Nếu người dùng chưa đăng nhập, trả về thông báo yêu cầu đăng nhập
        if (userlogin == null) {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"Bạn cần đăng nhập để thích video.\"}");
            return;
        }

        // Lấy videoId từ tham số trong URL
        String videoId = req.getParameter("videoId");

        // Kiểm tra nếu videoId không null và video tồn tại
        if (videoId != null) {
            Video video = videoDAO.findById(videoId);
            if (video != null) {
                // Kiểm tra xem video này đã được thích chưa
                Favorite existingFavorite = favoriteDAO.findFavoriteByUserAndVideo(userlogin.getId(), videoId);
                if (existingFavorite != null) {
                    // Nếu đã thích, trả về thông báo lỗi
                    resp.setContentType("application/json");
                    resp.getWriter().write("{\"status\": \"error\", \"message\": \"Bạn đã thích video này rồi.\"}");
                    return;
                }

                Favorite favorite = new Favorite();
                favorite.setVideo(video);
                favorite.setUser(userlogin);
                favorite.setLikeDate(new Date());
                favoriteDAO.create(favorite);

                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\": \"success\", \"message\": \"Video đã được thích.\"}");
            } else {
                // Nếu video không tồn tại, trả về thông báo lỗi
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\": \"error\", \"message\": \"Video không tồn tại.\"}");
            }
        } else {
            // Nếu videoId không hợp lệ, trả về thông báo lỗi
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"Video không hợp lệ.\"}");
        }
    }
    
    private void handleDetailsVideo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String videoId = req.getParameter("id");

        if (videoId != null && !videoId.isEmpty()) {
            HttpSession session = req.getSession();

            incrementViewCount(req, videoId);
            
            // Lấy danh sách video từ session, nếu không có thì truy vấn từ cơ sở dữ liệu
            List<Video> videoList = (List<Video>) session.getAttribute("videoList");
            if (videoList == null) {
                videoList = videoDAO.findAllActive();
                session.setAttribute("videoList", videoList);
            }

            // Tìm video đang xem trong danh sách dựa trên videoId
            Video videoWatch = null;
            for (Video video : videoList) {
                if (videoId.equals(video.getId())) {
                    videoWatch = video;
                    break;
                }
            }

            if (videoWatch != null) {
                req.setAttribute("videoWatch", videoWatch); // Video đang xem
                req.setAttribute("videoList", videoList); // Danh sách video
                req.getRequestDispatcher("/views/html/chitietVideo.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Video không tồn tại.");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID video không hợp lệ.");
        }
    }
    public void incrementViewCount(HttpServletRequest req, String videoId) {
    	// Lấy session của người dùng
        HttpSession session = req.getSession();
     // Lấy tập hợp các video đã được người dùng xem từ session
        Set<String> viewedVideos = (Set<String>) session.getAttribute("viewedVideos");
        
     // Nếu session chưa có thông tin về video đã xem, khởi tạo một Set mới
        if (viewedVideos == null) {
            viewedVideos = new HashSet<>();
            session.setAttribute("viewedVideos", viewedVideos);
        }
        
     // Kiểm tra xem người dùng đã xem video này chưa
        if (!viewedVideos.contains(videoId)) {
            // Người dùng chưa xem video này, tiến hành tăng lượt xem
            Video video = videoDAO.findById(videoId);
            if (video != null) {
                // Cập nhật số lượt xem của video
                video.setViews(video.getViews() + 1);
                videoDAO.update(video);  // Lưu lại thông tin vào cơ sở dữ liệu

                // Thêm video vào danh sách video đã xem của người dùng trong session
                viewedVideos.add(videoId);
            }
        }
    }
    
    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	if ("GET".equalsIgnoreCase(req.getMethod())) {
            // Chuyển hướng đến trang đăng ký
            req.getRequestDispatcher("/views/html/dangky.jsp").forward(req, resp);
        } else if ("POST".equalsIgnoreCase(req.getMethod())) {
            // Xử lý đăng ký người dùng
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String role = req.getParameter("role");

            // Tạo đối tượng người dùng mới
            Users newUser = new Users();
            newUser.setId(username);
            newUser.setPassword(password);
            newUser.setFullname(fullname);
            newUser.setEmail(email);
         // Chuyển đổi giá trị role sang Boolean
            Boolean isAdmin = "admin".equalsIgnoreCase(role);
            newUser.setAdmin(isAdmin);

            // Gọi phương thức tạo mới người dùng trong DAO
            userDAO.create(newUser);
            System.out.println("User created successfully: " + username);
            
            sendMailWelcome.sendWelcomeEmail(email, fullname);

            // Chuyển hướng hoặc forward đến trang thành công
            resp.sendRedirect(req.getContextPath() + "/dangnhap"); // Hoặc chuyển hướng đến trang đăng nhập
        }
    }
    
    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	if ("GET".equalsIgnoreCase(req.getMethod())) {
            // Hiển thị trang quên mật khẩu
            req.getRequestDispatcher("/views/html/quenmatkhau.jsp").forward(req, resp);
        } else if ("POST".equalsIgnoreCase(req.getMethod())) {
            String username = req.getParameter("username");
            String email = req.getParameter("email");

            // Tìm người dùng theo username hoặc email
            Users user = userDAO.findByIdOrEmail(username);
            if (user != null && user.getEmail().equalsIgnoreCase(email)) {
                // Sinh mật khẩu mới
                String newPassword = generateRandomPassword();

                // Cập nhật mật khẩu mới vào cơ sở dữ liệu
                user.setPassword(newPassword);
                userDAO.update(user);

                // Gửi email chứa mật khẩu mới
                boolean emailSent = sendMailNewPassword.sendNewPasswordEmail(email, user.getFullname(), newPassword);
                if (emailSent) {
                    req.setAttribute("message", "Mật khẩu mới đã được gửi đến email của bạn.");
                } else {
                    req.setAttribute("error", "Gửi email thất bại. Vui lòng thử lại sau.");
                }
            } else {
                req.setAttribute("error", "Username hoặc email không đúng. Vui lòng kiểm tra lại.");
            }

            // Forward lại trang quên mật khẩu với thông báo
            req.getRequestDispatcher("/views/html/quenmatkhau.jsp").forward(req, resp);
        }
    }
	 // Hàm sinh mật khẩu ngẫu nhiên
	    private String generateRandomPassword() {
	        String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
	        StringBuilder password = new StringBuilder();
	        Random random = new Random();
	        for (int i = 0; i < 5; i++) { // Mật khẩu 5 ký tự
	            password.append(charSet.charAt(random.nextInt(charSet.length())));
	        }
	        return password.toString();
	    }

    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users loggedInUser = (Users) session.getAttribute("userlogin");

        if (loggedInUser != null) {
            if ("GET".equalsIgnoreCase(req.getMethod())) {
                req.getRequestDispatcher("/views/html/doimatkhau.jsp").forward(req, resp);
            } else if ("POST".equalsIgnoreCase(req.getMethod())) {
                String currentPassword = req.getParameter("password");
                String newPassword = req.getParameter("newPassword");
                String confirmPassword = req.getParameter("confirmPassword");

                if (!currentPassword.equals(loggedInUser.getPassword())) {
                    req.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                    req.getRequestDispatcher("/views/html/doimatkhau.jsp").forward(req, resp);
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    req.setAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
                    req.getRequestDispatcher("/views/html/doimatkhau.jsp").forward(req, resp);
                    return;
                }

                loggedInUser.setPassword(newPassword);

                UsersDAOImpl userDao = new UsersDAOImpl();
                userDao.update(loggedInUser);

                req.setAttribute("message", "Mật khẩu đã được thay đổi thành công!");
                resp.sendRedirect(req.getContextPath() + "/dangnhap");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/dangnhap");
        }
    }
    
    private void handleEditProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
        Users loggedInUser = (Users) session.getAttribute("userlogin");

        if (loggedInUser != null) {
            if ("GET".equalsIgnoreCase(req.getMethod())) {
                req.setAttribute("username", loggedInUser.getId());
                req.setAttribute("password", loggedInUser.getPassword());
                req.setAttribute("fullname", loggedInUser.getFullname());
                req.setAttribute("email", loggedInUser.getEmail());

                // Đảm bảo không có response.commit() trước khi forward
                req.getRequestDispatcher("/views/html/chinhsua.jsp").forward(req, resp);
            } else if ("POST".equalsIgnoreCase(req.getMethod())) {
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String fullname = req.getParameter("fullname");
                String email = req.getParameter("email");

                loggedInUser.setId(username);
                loggedInUser.setPassword(password);
                loggedInUser.setFullname(fullname);
                loggedInUser.setEmail(email);

                UsersDAOImpl userDao = new UsersDAOImpl();
                try {
                    userDao.update(loggedInUser);
                    req.setAttribute("message", "Thông tin đã được cập nhật thành công!");
                } catch (Exception e) {
                    req.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin người dùng.");
                }
             // Sau khi cập nhật, vẫn giữ thông tin người dùng đã chỉnh sửa
                req.setAttribute("username", loggedInUser.getId());
                req.setAttribute("password", loggedInUser.getPassword());
                req.setAttribute("fullname", loggedInUser.getFullname());
                req.setAttribute("email", loggedInUser.getEmail());

                req.getRequestDispatcher("/views/html/chinhsua.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/dangnhap");
        }
    }

}


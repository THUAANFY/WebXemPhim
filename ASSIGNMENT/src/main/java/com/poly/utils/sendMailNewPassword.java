package com.poly.utils;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class sendMailNewPassword {
	public static boolean sendNewPasswordEmail(String toEmail, String fullname, String newPassword) {
	    try {
	        String fromEmail = "philtpd10207@gmail.com";
	        String password = "bmco bube dhql ytty";

	        Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.port", "587");

	     // Tạo một lớp con của Authenticator để lấy thông tin đăng nhập
            MyAuthenticator auth = new MyAuthenticator(fromEmail, password);

            // Tạo Session với thông tin xác thực
            Session session = Session.getInstance(props, auth);

	        Message message = new MimeMessage(session);
//	        message.setFrom(new InternetAddress(fromEmail));
	        try {
                message.setFrom(new InternetAddress(fromEmail, "ONLINE ENTERTAINMENT")); // Đổi tên hiển thị
            } catch (UnsupportedEncodingException e) {
                System.err.println("Lỗi mã hóa tên hiển thị: " + e.getMessage());
                return false; // Kết thúc nếu lỗi mã hóa
            }
	        message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
	        message.setSubject("Yêu cầu cấp lại mật khẩu");
	        message.setText("Xin chào " + fullname + ",\n\n"
	                + "Mật khẩu mới của bạn là: " + newPassword + "\n\n"
	                + "Vui lòng đăng nhập và thay đổi mật khẩu ngay lập tức để bảo mật tài khoản.\n\n"
	                + "Trân trọng,\nHệ thống hỗ trợ.");
	        Transport.send(message);
	        System.out.println("Mật khẩu mới đã được gửi đến: " + toEmail);
	        return true;
	    } catch (MessagingException e) {
	        e.printStackTrace();
	        System.out.println("Lỗi khi gửi email: " + e.getMessage());
	        return false;
	    }
	}
}

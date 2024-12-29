package com.poly.utils;


import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.UnsupportedEncodingException;
import java.net.Authenticator;
import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class sendMailWelcome {

    public static void sendWelcomeEmail(String toEmail, String fullname) {
        try {
            // Thiết lập các thông tin kết nối tới email server
            String fromEmail = "philtpd10207@gmail.com";
            String password = "bmco bube dhql ytty"; // Mật khẩu ứng dụng Gmail của bạn

            // Thiết lập các thuộc tính cho việc gửi email
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            // Tạo một lớp con của Authenticator để lấy thông tin đăng nhập
            MyAuthenticator auth = new MyAuthenticator(fromEmail, password);

            // Tạo Session với thông tin xác thực
            Session session = Session.getInstance(props, auth);

            // Tạo một đối tượng Message để chứa thông tin email
            Message message = new MimeMessage(session);
            try {
                message.setFrom(new InternetAddress(fromEmail, "ONLINE ENTERTAINMENT")); // Đổi tên hiển thị
            } catch (UnsupportedEncodingException e) {
                System.err.println("Lỗi mã hóa tên hiển thị: " + e.getMessage());
                return; // Kết thúc nếu lỗi mã hóa
            }
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Chào mừng bạn đến với hệ thống!");
            message.setText("Chào " + fullname + ",\n\nChúc mừng bạn đã đăng ký tài khoản thành công!");

            // Gửi email
            Transport.send(message);
            System.out.println("Email chào mừng đã được gửi đến: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }
}

class MyAuthenticator extends jakarta.mail.Authenticator {  // Sử dụng jakarta.mail.Authenticator
    private String username;
    private String password;

    public MyAuthenticator(String username, String password) {
        this.username = username;
        this.password = password;
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(username, password); // Sử dụng PasswordAuthentication từ jakarta.mail
    }
}
	


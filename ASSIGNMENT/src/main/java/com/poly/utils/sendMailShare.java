package com.poly.utils;

import java.io.UnsupportedEncodingException;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Properties;

import com.poly.entity.Users;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class sendMailShare {
	public static boolean sendShareEmail(Users user, String recipientEmail, String videoId) throws UnsupportedEncodingException {
		try {
	        // Thông tin email cấu hình
	        String fromEmail = "philtpd10207@gmail.com";
	        String password = "bmco bube dhql ytty"; // Mật khẩu ứng dụng Gmail của bạn

	        Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.port", "587");

	        MyAuthenticator auth = new MyAuthenticator(fromEmail, password);

	        Session session = Session.getInstance(props, auth);

	        Message message = new MimeMessage(session);
	        message.setFrom(new InternetAddress(fromEmail, "ONLINE ENTERTAINMENT"));
	        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
	        message.setSubject("Video đã được chia sẻ với bạn!");
	        message.setText("Chào bạn, \n\n" +
	                user.getFullname() + " đã chia sẻ một video với bạn.\n" +
//	                "Video ID: " + videoId + "\n" +
	                "Hãy xem video tại đây: " + videoId + "\n\n" +
	                "Trân trọng,\nONLINE ENTERTAINMENT");

	        // Gửi email
	        Transport.send(message);
	        return true;
	    } catch (MessagingException e) {
	        e.printStackTrace();
	        System.out.println("Lỗi khi gửi email: " + e.getMessage());
	        return false;
	    }
    }
}

package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtils {

    public static boolean sendEmail(String to, String subject, String content) {
        final String fromEmail = "tuanpm081102@gmail.com"; // mail 
        final String appPassword = "baiarklkjtunlqbt";  // mật khẩu app

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "Support Team")); // set mail gửi
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to)); // set mail nhận
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B")); // set tiêu đề mail
            message.setContent(content, "text/html; charset=UTF-8"); // set nội dung mail

            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("Gửi mail thất bại: " + e.getMessage());
            return false;
        }
    }

    // Main test
    public static void main(String[] args) {
        boolean result = sendEmail(
                "@gmail.com", // thay bằng email thật
                "Test từ Java",
                "<h3>Hello from Java</h3><p>This is a test.</p>"
        );

        System.out.println(result ? "✅ Gửi thành công!" : "❌ Gửi thất bại.");
    }
}

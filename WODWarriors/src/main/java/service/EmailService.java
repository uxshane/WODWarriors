package service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import util.PropertiesUtil;
import vo.UserVO;

@Service
public class EmailService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
    private JavaMailSender mailSender;
	
	private Map<String, String> verificationCodes = new HashMap<String, String>();
	
	public boolean emailExists(String email) {
		String sql = "SELECT COUNT(*) FROM USERS WHERE email = '" + email + "'";
		int count = jdbcTemplate.queryForInt(sql);
		return count > 0;
    }
	
	public void sendPasswordByEmail(String email) {
		String sql = "SELECT * FROM USERS WHERE email = ?";
        UserVO user = jdbcTemplate.queryForObject(sql, new Object[]{email},
        										  new BeanPropertyRowMapper<>(UserVO.class));
        String password = user.getPassword();
        String subject = "WODWarriors: 비밀번호 전송";
        String message = user.getName() + "님의 비밀번호는 " + password + " 입니다.";

        try {
            sendEmail(email, subject, message);
        } catch (MessagingException e) {
            System.out.println("어떤 오류때문에 이메일이 보내지지 않음");
        }
    }
	
    public void sendEmail(String to, String subject, String text) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");

        helper.setTo(to);
        helper.setSubject(subject);
        helper.setText(text, true);
        mailSender.send(message);
    }
    
    public void sendAdminRegiForm(String email, String name) {
        String subject = "WODWarriors: 관리자 신청서";
        String message = name + "님께서 해당 " + email + " 이메일로 신청서를 넣으셨습니다.";
        
        PropertiesUtil propertiesUtil = new PropertiesUtil("secret_key.properties");
        String to = propertiesUtil.getProperty("gmail");
        System.out.println("Gmail: " + to);
        
        try {
            sendEmail(to, subject, message);
        } catch (MessagingException e) {
            System.out.println("어떤 오류때문에 이메일이 보내지지 않음");
        }
    }
    
    public String generateAndSendVerificationCode(String email) throws MessagingException {
        String code = generateVerificationCode();
        verificationCodes.put(email, code);
        sendEmail(email, "인증코드", "인증코드는 " + code + " 입니다.");
        return code;
    }

    public boolean verifyCode(String email, String code) { // 추가된 부분
        return code.equals(verificationCodes.get(email));
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = random.nextInt(90000) + 10000;
        return String.valueOf(code);
    }
	
}














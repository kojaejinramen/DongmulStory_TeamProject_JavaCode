package com.dongmul.story.email;
import java.io.File;
import java.util.*;

import jakarta.activation.DataHandler;
import jakarta.activation.FileDataSource;
import jakarta.mail.BodyPart;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailService
{
	@Autowired
	private JavaMailSender sender;

	@Autowired
	private HttpSession session;

	public boolean sendSimpleText()
	{
		List<String> receivers = new ArrayList<>();
		receivers.add("kmjkjj999@naver.com");

		String[] arrReceiver = (String[])receivers.toArray(new String[receivers.size()]);

		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

		simpleMailMessage.setTo(arrReceiver);
		simpleMailMessage.setSubject("Spring Boot Mail Test");
		simpleMailMessage.setText("스프링에서 메일 보내기 테스트");
		//SimpleMailMessage를 사용하여 html 을 전달하더라도 수신자의 화면에는 html이 해석되지 않음
		simpleMailMessage.setText("<a href='/mail/auth/"+ createRandomStr()+"'>인증</a>");

		sender.send(simpleMailMessage);

		return true;
	}

	private String createRandomStr()
	{
		UUID randomUUID = UUID.randomUUID();
		return randomUUID.toString().replaceAll("-", "");
	}

	public boolean sendMimeMessage()
	{
		MimeMessage mimeMessage = sender.createMimeMessage();

		try {
			InternetAddress[] addressTo = new InternetAddress[1];
			addressTo[0] = new InternetAddress("kmjkjj999@naver.com");

			mimeMessage.setRecipients(Message.RecipientType.TO, addressTo);

			mimeMessage.setSubject("마임 메시지(Text) 테스트");

			mimeMessage.setContent("This is mimemessage", "text/plain;charset=utf-8");

			sender.send(mimeMessage);
			return true;
		} catch (MessagingException e) {
			log.error("에러={}", e);
		}

		return false;
	}

	public boolean sendHTMLMessage(ServletContext ctx, String email)
	{
		MimeMessage mimeMessage = sender.createMimeMessage();

		try {
			InternetAddress[] addressTo = new InternetAddress[1];   
			//String emailAddr = "kmjkjj999@naver.com";
			addressTo[0] = new InternetAddress(email); //수신자

			mimeMessage.setRecipients(Message.RecipientType.TO, addressTo);

			mimeMessage.setSubject("동물이야기 인증 코드(HTML) 테스트");

			String authCode = createRandomStr();

			Object mapObj = ctx.getAttribute("authMap");

			if(mapObj == null) {
				Map<String, String> map = new HashMap<>();
				ctx.setAttribute("authMap", map);
				mapObj = map;
			}

			Map<String, String> authMap = (Map) mapObj;
			authMap.put(email, authCode);

			ctx.setAttribute("authMap", authMap);

			// String host = "192.168.0.22"; // 호스트 변경시 매번 수정
			String host = "localhost";
			mimeMessage.setContent("<a href='http://"+host+"/mail/auth/"+email+"/"+authCode+"'>동물이야기 이메일 인증(Click!👈)</a>", "text/html;charset=utf-8");

			sender.send(mimeMessage);
			return true;
		} catch (MessagingException e) {
			log.error("에러={}", e);
		}

		return false;
	}

	public boolean sendAttachMail()
	{
		MimeMessage mimeMessage = sender.createMimeMessage();

		Multipart multipart = new MimeMultipart();

		try {
			InternetAddress[] addressTo = new InternetAddress[1];
			addressTo[0] = new InternetAddress("kmjkjj999@naver.com");

			mimeMessage.setRecipients(Message.RecipientType.TO, addressTo);

			mimeMessage.setSubject("마임 메시지(첨부파일) 테스트");

			// Fill the message
			BodyPart messageBodyPart = new MimeBodyPart();

			messageBodyPart.setContent("<a href='http://localhost/mail/auth/abc123'>메일주소 인증</a>", "text/html;charset=utf-8");

			multipart.addBodyPart(messageBodyPart);

			// Part two is attachment
			messageBodyPart = new MimeBodyPart();
			File file = new File("C:/test/첨부.txt");
			FileDataSource fds = new FileDataSource(file);
			messageBodyPart.setDataHandler(new DataHandler(fds));

			String fileName = fds.getName();
			messageBodyPart.setFileName(fileName);

			multipart.addBodyPart(messageBodyPart);

			// Put parts in message
			mimeMessage.setContent(multipart);

			sender.send(mimeMessage);

			return true;
		}catch(Exception ex) {
			log.error("에러={}", ex);
		}
		return false;
	}
}
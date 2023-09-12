package com.dongmul.story.email;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mail")
public class EmailController 
{  
	@Autowired
	public ServletContext ctx; //session이 아닌 application 영역

	@Autowired
	private EmailService svc;

	@GetMapping("/")
	public String index()
	{
		return"email/email";
	}

	//   @GetMapping("/simple")
	//   @ResponseBody
	//   public String sendSimpleText(HttpSession session)
	//   {
	//      boolean isSent = svc.sendSimpleText();
	//      //boolean isSent = svc.sendAttachMail();
	//      return isSent ? "메일 보내기 성공":"메일 보내기 실패";
	//   }
	//  
	//   @GetMapping("/mime")
	//   @ResponseBody
	//   public String sendMimeMessage(HttpSession session)
	//   {
	//      boolean isSent = svc.sendMimeMessage();
	//      //boolean isSent = svc.sendAttachMail();
	//      return isSent ? "메일 보내기 성공":"메일 보내기 실패";
	//   }
	//   
	//   @GetMapping("/attach")
	//   @ResponseBody
	//   public String sendAttachMail(HttpSession session)
	//   {
	//      boolean isSent = svc.sendAttachMail();
	//      //boolean isSent = svc.sendAttachMail();
	//      return isSent ? "메일 보내기 성공":"메일 보내기 실패";
	//   }

	@GetMapping("/html")
	@ResponseBody
	public Map sendHTMLMessage(@RequestParam("userEmail") String userEmail, @RequestParam("userEmailDomain") String userEmailDomain)
	{
		String totalEmail = userEmail + "@" + userEmailDomain;
		boolean isSent = svc.sendHTMLMessage(ctx, totalEmail);
		//boolean isSent = svc.sendAttachMail();
		Map<String, Boolean> map = new HashMap<>();
		map.put("sent", isSent);
		return map;
	}

	@GetMapping("/auth_check")
	@ResponseBody
	public Map email_auth(@RequestParam("userEmail") String userEmail, @RequestParam("userEmailDomain") String userEmailDomain) {
		Map<String, String> authMap = (Map) ctx.getAttribute("authMap");
		String totalEmail = userEmail + "@" + userEmailDomain;
		String result = authMap.get(totalEmail);

		Map<String, Boolean> resMap = new HashMap<>();

		if(result != null && result.equals("1")) {
			resMap.put("auth", true);
			authMap.remove(totalEmail);
		}
		else {
			resMap.put("auth", false);
		}

		return resMap;
	}

	@GetMapping("/auth/{userEmail}@{userEmailDomain}/{code}")  // 보낸 메일에서 이용자가 인증 링크를 클릭했을 때
	public String index(   @PathVariable("userEmail")String userEmail, @PathVariable("userEmailDomain")String userEmailDomain,
			@PathVariable("code")String returnCode)
	{
		Map<String, String> authMap = (Map)ctx.getAttribute("authMap");
		String totalEmail = userEmail + "@" + userEmailDomain;
		if(authMap.get(totalEmail).equals(returnCode)) {
			authMap.put(totalEmail, "1");
			return "/email/successMail";
		}
		log.info("인증코드 확인={}", returnCode);
		return "/email/failMail";
	}
}
package com.dongmul.story.chatting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dongmul.story.user.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ws")
public class WSChatController 
{
	@Autowired
	private WebSocketHandler webSocketHandler;

	@GetMapping("/in")   //  localhost/ws/in?userid=smith  형식으로 요청하여 로그인 테스트
	public String chatForm(HttpServletRequest request, User user, Model model)
	{   
		model.addAttribute("userId", user.getUserId());  // 이용자 아이디를 웹소켓 핸들러 안으로 전달하는 절차 시작부분
		// userid -> chat.jsp 로 전달 -> 인터셉터로 전달 -> 웹소켓핸들러에서 수신

		HttpSession session = request.getSession();

		log.info("로그인 성공({}), session={}", user.getUserId(), session.getId());

		return "chatting/chat";  //chat.jsp 보여줌
		/* chat.jsp에서 ws://localhost/ws/chat 으로 요청하면 인터셉터를 거쳐 웹소켓핸들러에 접속됨 */
	}

	//유저 목록
	@GetMapping("/userList")
	@ResponseBody
	public Map<String, Object> UserList(User user)
	{
		Map<String, Object> map = new HashMap<>();
		List<String> userList = webSocketHandler.getUserList();
		map.put("userList", userList);
		return map;
	}
}
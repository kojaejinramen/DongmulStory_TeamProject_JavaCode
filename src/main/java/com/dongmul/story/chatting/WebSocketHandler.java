package com.dongmul.story.chatting;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler 
{
	private static Map<String, WebSocketSession> userMap = new HashMap<>();

	@Override  /* 클라이언트 접속시에 호출됨 */
	public void afterConnectionEstablished(WebSocketSession session) throws Exception 
	{
		/* 인터셉터에서 전달된 userid 를 추출하여 사용하는 예 */
		String userId = (String)session.getAttributes().get("userId");
		log.info("웹소켓핸들러, userId={}", userId);

		userMap.put(userId, session);
		log.info("Client Connected");

	}

	@Override  /* 서버에 메시지 도착시 호출됨 */
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// log.info("서버에서 받은 메시지:{}", message.getPayload());

		//채팅서비스에 접속된 모든 클라이언트에게 브로드캐스팅
		Collection<WebSocketSession> coll = userMap.values();
		for(WebSocketSession ss : coll) {
			ss.sendMessage(message);
		}

		/* JSON 포맷으로 통신할 때는 아래처럼...
      JSONParser parser = new JSONParser();
      JSONObject jsObj = (JSONObject) parser.parse( message.getPayload());
      String receiver = (String)jsObj.get("receiver");

      WebSocketSession wss = userMap.get(receiver);
      wss.sendMessage(message);  // 특정 접속자에게만 메시지를 전달함
		 */

	}

	@Override   /* 접속 해제시 호출됨 */
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("Connection Closed");
		for(Entry<String, WebSocketSession> entry : userMap.entrySet())
		{
			if(entry.getValue()==session)
			{
				String userid = entry.getKey();
				userMap.remove(userid);
				log.info("퇴장:{}", userid);
				break;
			}
		}

	}

	@Override   /* 오류 발생시 호출됨 */
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.info("Error:" + exception);
		super.handleTransportError(session, exception);
	}


	// jsp로 유저 목록 전송
	public List<String> getUserList() {
		return new ArrayList<>(userMap.keySet());
	}

}
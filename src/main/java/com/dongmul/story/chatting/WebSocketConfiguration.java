package com.dongmul.story.chatting;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSocket
public class WebSocketConfiguration implements WebSocketConfigurer
{
	/* "ws://ip/ws/chat" 요청은 인터셉터를 거쳐 웹소켓 핸들러에 연결됨 */
	private final static String CHAT_ENDPOINT="/ws/chat"; 

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

		registry.addHandler(getChatWebSocketHandler(), CHAT_ENDPOINT)  /* 웹소켓핸들러 등록*/
		.addInterceptors(new HttpHandshakeInterceptor())        /* 인터셉터 등록 */
		.setAllowedOrigins("*");
		// 위에서 지정한 인터셉터를 통해 WebSocketHandler에게 필요한 속성들을 전달할 수 있다
		log.info("웹소켓 핸들러 등록 완료");
	}

	@Bean
	public WebSocketHandler getChatWebSocketHandler() {
		return new WebSocketHandler();
	}
}
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 테스트 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">

var userId = '${userId}';   /* jsp라면, '${userid}';  */
var connectedUsers = new Map();
var g_webSocket = null;

//페이지 로드 시, 강퇴된 사용자의 경우 1분 동안 접속 차단
var kickedTimestamp = localStorage.getItem('kickedUser_' + userId);
if (kickedTimestamp && (Number(kickedTimestamp) > Date.now())) { // 여기에서 로직 수정
    alert("강퇴당하셨습니다. 1분 동안 채팅문의 참여를 할 수 없습니다.");
    location.href = "/shop/";
}

window.onload = function() {
    //host = "172.20.10.2";   /* 배포시에 호스트 주소로 변경 */
   	host = "localhost";
    g_webSocket = new WebSocket("ws://"+host+"/ws/chat?userId=" + userId);
    // 위처럼 웹소켓에 접속시 userid를 파라미터로 전달하면 인터셉터에서 추출하여 웹소켓핸들러 안으로 전달할 수 있다
    
    /* 웹소켓 접속 성공시 실행 */
    g_webSocket.onopen = function(message) {
        addLineToChatBox("서버에 연결되었습니다.");
        connectedUsers.set(userId, g_webSocket); // 사용자 추가
        
     // 사용자가 입장한 메시지 추가
        var joinMessage = userId + "님이 입장하였습니다.";
        g_webSocket.send(joinMessage);
        userListUpdate()
    };
    
    
 	// 클라이언트에서 강퇴 메시지 수신 및 처리
    g_webSocket.onmessage = function(message) {
    var msg = message.data;
    
    if (msg.startsWith('[KICK]')) { // 강퇴 메시지 확인
        var kickedUserId = msg.replace('[KICK]', '').trim();
        if (kickedUserId === userId) {
        	 // 강퇴된 사용자와 로그인한 사용자의 아이디가 일치하면 연결 종료
            localStorage.setItem('kickedUser_' + userId, Date.now() + (1 * 60 * 1000)); // 강퇴 시간 설정
            g_webSocket.close();
            alert("강퇴되었습니다. 채팅방을 나갑니다.");
            return location.href="/shop/";
        } else {
            addLineToChatBox(kickedUserId + "님이 강퇴당했습니다."); // 강퇴 메시지 추가
            if (connectedUsers.has(kickedUserId)) {
                var kickedWebSocket = connectedUsers.get(kickedUserId);
                kickedWebSocket.close(); // 강퇴된 사용자 연결 해제
                connectedUsers.delete(kickedUserId);
            }
        }
    } else {
        addLineToChatBox(msg);
    }
};

    /* 웹소켓 이용자가 연결을 해제하는 경우 실행 
    g_webSocket.onclose = function(message) {
        addLineToChatBox("서버 연결을 종료합니다.");
        connectedUsers.delete(userId); // 사용자 제거
    }; */

    /* 웹소켓 에러 발생시 실행 */
    g_webSocket.onerror = function(message) {
        addLineToChatBox("Error!");
    };
    
}

//사용자가 페이지를 나갈 때 퇴장 메시지를 보내는 함수
function sendExitMessage() {
    if (g_webSocket && g_webSocket.readyState === WebSocket.OPEN) {
        var exitMessage = userId + "님이 퇴장하였습니다.";
        g_webSocket.send(exitMessage);
        userListUpdate()
    }
}

// 페이지를 나갈 때 sendExitMessage 함수 호출
window.addEventListener("beforeunload", sendExitMessage);

/* 채팅 메시지를 화면에 표시 */
function addLineToChatBox(_line) {
    if (_line == null) {
        _line = "";
    }
    
    var chatBoxArea = document.getElementById("chatBoxArea");
    chatBoxArea.value += _line + "\n";
    chatBoxArea.scrollTop = chatBoxArea.scrollHeight;     // 스크롤 효과
}

/* Send 버튼 클릭하면 서버로 메시지 전송 */
function sendButton_onclick() {
    var inputMsgBox = document.getElementById("inputMsgBox"); // $('#inputMsgBox').val();
    if (inputMsgBox == null || inputMsgBox.value == null || inputMsgBox.value.length == 0) {
        return false;
    }
    
    var chatBoxArea = document.getElementById("chatBoxArea");
    
    if (g_webSocket == null || g_webSocket.readyState == 3) {
        chatBoxArea.value += "채팅 하시려면 서버를 다시 연결해주세요.\n";
        return false;
    }
    
    // 서버로 메시지 전송
    g_webSocket.send('['+ userId +']: ' + inputMsgBox.value);
    inputMsgBox.value = "";
    inputMsgBox.focus();
    
    return true;
}


/* inputMsgBox 키 입력하는 경우 호출 */
function inputMsgBox_onkeypress() {
    if (event == null) {
        return false;
    }
    
    // 엔터키 누를 경우 서버로 메시지 전송
    var keyCode = event.keyCode || event.which;
    if (keyCode == 13) {
        sendButton_onclick();
    }
}

/*
 // Disconnect 버튼 클릭하는 경우 호출 
function disconnectButton_onclick() {
    if (g_webSocket != null) {
        g_webSocket.close();    
    }
}
 // 재연결 버튼
function connectButton_onclick() {
    if (g_webSocket == null || g_webSocket.readyState === WebSocket.CLOSED) {
        // 이전 WebSocket 연결이 닫혔거나 null인 경우에만 새로운 연결을 시도합니다.
        g_webSocket = new WebSocket("ws://" + host + "/ws/chat?userId=" + userId);
        
        g_webSocket.onopen = function(message) {
            addLineToChatBox("서버에 연결되었습니다.");
        };
        
        g_webSocket.onmessage = function(message) {
            addLineToChatBox(message.data);
        };
        
        g_webSocket.onclose = function(message) {
            addLineToChatBox("서버 연결을 종료합니다.");
        };
        
        g_webSocket.onerror = function(message) {
            addLineToChatBox("Error!");
        };
    } else {
        addLineToChatBox("서버에 이미 연결되었습니다.");
    }
}
*/

//채팅방에서 강퇴 버튼 클릭 시 호출
function kickButton_onclick() {
    var kickUserId = prompt("강퇴할 사용자의 아이디를 입력하세요:");
    if (kickUserId) {
        var kickMessage = '[KICK] ' + kickUserId;
        g_webSocket.send(kickMessage); // 강퇴 메시지 전송
    }
}

// 유저 목록 가져오기
function userListUpdate() {
    $.ajax({
        url: "/ws/userList", // 사용자 목록을 가져올 엔드포인트
        method: "get",
        dataType: "json",
        success: function(data) {
            var userListArea = $("#userListArea");
            userListArea.empty(); // 이전 데이터를 지우고 다시 그립니다.

            data.userList.forEach(function(user) {
                // 각 사용자에 대한 <li> 요소를 생성하여 userListArea에 추가합니다.
                var listItem = $("<li>").text(user);
                userListArea.append(listItem);
            });
        },
        error: function() {
            alert("사용자 목록을 불러오는데 실패했습니다.");
        }
    });
}

// 페이지 로드 후 유저 목록 업데이트
$(document).ready(function() {
    userListUpdate();
    
    // 사용자 목록 업데이트 버튼 클릭 시 사용자 목록을 다시 가져오도록 설정
    $("#updateUserListButton").click(function() {
        userListUpdate();
    });
});
</script>
<style type="text/css">
#chatBoxArea {
	background-color: #f2f2f2;
	border: none;
	border-radius: 10px;
	padding: 10px;
	font-size: 14px;
	font-family: Arial, Helvetica, sans-serif;
	resize: none;
	overflow-y: scroll;
	height: 400px;
	width: 540px;
	pointer-events: none;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

#inputMsgBox {
	display: inline-block;
	background-color: #f2f2f2;
	border: none;
	border-radius: 5px;
	padding: 10px;
	margin-right: 10px;
	font-size: 13px;
	font-family: Arial, Helvetica, sans-serif;
	width: 300px;
}

#sendButton, #disconnectButton, #connectButton, #kickButton {
	background-color: #99ee88;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px;
	cursor: pointer;
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	margin-right: 10px;
}

#sendButton:hover, #disconnectButton:hover, #connectButton:hover,
	#kickButton:hover {
	background-color: #aaeeaa;
}

h3 {
	text-align: center;
}

.userList-index {
	position: absolute;
	background-color: #eee; /* 박스 배경색 지정 */
	border: 1px solid #ccc; /* 테두리 스타일 지정 */
	border-radius: 5px; /* 테두리 둥글게 처리 */
	padding: 5px 10px; /* 안쪽 여백 지정 */
	margin-left: 800px;
	font-size: 13px; /* 글꼴 크기 지정 */
	color: #333; /* 글꼴 색상 지정 */
	display: inline-block; /* 인라인 요소로 표시 (블록 요소로 변경 가능) */
}

.refresh-button {
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 5px 10px;
	cursor: pointer;
	font-size: 14px;
	text-align: center;
	margin: 0px 40px;;
}

.refresh-button:hover {
	background-color: #45a046;
}

#userList {
	text-align: center;
	font-weight: bold;
}
</style>
</head>
<body>
	<!-- 상단 목록 -->
	<div class="top-index">
		<%@ include file="../topIndex.jsp"%>
	</div>

	<main>
		<h3>채팅문의</h3>
		<div
			style="display: flex; align-items: center; justify-content: center; flex-direction: column;">
			<textarea id="chatBoxArea" readonly="readonly"></textarea>
			<div class="userList-index">
				<div id="userList">접속 유저</div>
				<ul id="userListArea"></ul>
				<button class="refresh-button" onclick="userListUpdate();">↻</button>
			</div>

			<div
				style="margin-top: 10px; display: flex; align-items: center; justify-content: center;">
				<input id="inputMsgBox" type="text" placeholder="메시지를 입력하세요..."
					onkeypress="inputMsgBox_onkeypress()"> <input
					id="sendButton" value="전송" type="button"
					onclick="sendButton_onclick()">
				<!-- <input id="disconnectButton" value="연결 해제" type="button" onclick="disconnectButton_onclick()">
            <input id="connectButton" value="재연결" type="button" onclick="connectButton_onclick()"> -->

				<c:if test="${userId eq 'dongmul'}">
					<input id="kickButton" value="강퇴" type="button"
						onclick="kickButton_onclick()">
				</c:if>
			</div>
		</div>


	</main>
	<div class="bottom-index">
		<%@ include file="../bottom.jsp"%>
	</div>
</body>
</html>
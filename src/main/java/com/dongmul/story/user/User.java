package com.dongmul.story.user;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component("dongmulUser")
@Setter
@Getter
@ToString
@EqualsAndHashCode (exclude = {"userName","userPhone","userAddress1", "userAddress2", "userAddress3","userEmail", "userEmailDomain", "userId","userPwd", "userPwdCheck"})
@AllArgsConstructor // 다 들어있는 생성자
@NoArgsConstructor // 기본 생성자
public class User {
	private int userNum;
	private String userName;
	private String userPhone;
	private int userAddress1;
	private String userAddress2;
	private String userAddress3;
	private String userEmail;
	private String userEmailDomain;
	private String userId;
	private String userPwd;

}

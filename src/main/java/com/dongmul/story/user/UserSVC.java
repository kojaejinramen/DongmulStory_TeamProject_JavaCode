package com.dongmul.story.user;

// com.dongmul.story.user.UserSVC.java
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserSVC {

	@Autowired
	private UserDAO userDAO;


}





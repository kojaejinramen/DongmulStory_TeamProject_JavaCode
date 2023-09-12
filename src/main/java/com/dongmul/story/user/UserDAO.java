package com.dongmul.story.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.dongmul.story.user.*;

import lombok.extern.slf4j.Slf4j;

@Repository("dongmulDAO")
@Slf4j
public class UserDAO {

	@Autowired
	private UserMAP userMAP;

	public boolean addUser(User user) {
		return userMAP.addUser(user)>0;
	}


	public boolean loginUser(User user) {
		User u = userMAP.isInclude(user);
		return user.getUserId().equals(u.getUserId())&& user.getUserPwd().equals(u.getUserPwd());
	}


	public boolean checkDuplicateId(String userId) {
		return false;
	}


	public boolean checkDuplicateEmail(String userEmail) {
		return false;
	}


	public User findId(User user) {
		User u = userMAP.findId(user);
		return u;
	}


	public User findPwd(User user) {
		User u = userMAP.findPwd(user);
		return u;
	}


	public User findUser(String userId) {
		User u = userMAP.findUser(userId);
		return u;
	}


	public boolean updateUser(User user) {
		return userMAP.updateUser(user)>0;
	}


	public boolean deleteUser(User user) {
		return userMAP.deleteUser(user)>0;
	}


	public boolean checkId(User user) {
		return userMAP.checkId(user) != null;
	}


	public boolean checkEmail(User user) {
		List<User> list = userMAP.checkEmail(user);
		return list.size() > 0; // 중복된 이메일이 존재하면 true를 반환합니다.
	}


	public List<User> userList() {
		return userMAP.userList();
	}





}

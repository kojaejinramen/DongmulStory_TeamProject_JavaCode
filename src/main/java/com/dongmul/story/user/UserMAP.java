package com.dongmul.story.user;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;
import com.dongmul.story.user.User;

@Mapper
public interface UserMAP {

	public int addUser(User user);

	public User isInclude(User user);

	public User checkId(User user);

	public List<User> checkEmail(User user);

	public User findId(User user);

	public User findPwd(User user);

	public User findUser(String userId);

	public int updateUser(User user);

	public int deleteUser(User user);

	public List<User> userList();


}

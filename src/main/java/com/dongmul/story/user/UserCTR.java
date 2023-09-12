package com.dongmul.story.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
@SessionAttributes("userId")
public class UserCTR {

	@Autowired
	UserSVC svc;

	@Autowired
	UserDAO dao;


	// addForm (회원가입 폼)
	@GetMapping("/add")
	public String addForm() {
		return "user/userAdd";
	}


	// add (회원가입)
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> addUser(User user, @RequestParam("userEmailDomain") String userEmailDomain)

	{
		Map<String, Object> map = new HashMap<>();
		// 아이디 중복 확인
		boolean checkId = dao.checkId(user);
		if(checkId) {
			map.put("added", false);
			map.put("cause", "중복된 아이디입니다.");
			return map;
		}

		boolean checkEmail = dao.checkEmail(user);
		if(checkEmail) {
			map.put("added", false);
			map.put("cause", "중복된 이메일입니다.");
			return map;
		}

		boolean added = dao.addUser(user);
		map.put("added", added);
		return map;
	}


	// list (회원목록:관리자)
	@GetMapping("/list")
	public String list(Model model,
			@SessionAttribute("userId") String userId) 
	{
		if(!userId.equals("dongmul")) {
			return null;
		}
		List<User> list = dao.userList();
		model.addAttribute("list", list);
		return "user/userList";
	}


	// loginForm (로그인 폼)
	@GetMapping("/login")
	public String loginForm(HttpSession session) {
		//세션 사용자 정보
		String loginUser = (String)session.getAttribute("userId");

		if (loginUser == null) {
			return "user/userLogin";
		}

		return "error";
	}


	// login (로그인)
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> loginUser(User user, Model model){
		Map<String, Object> map = new HashMap<>();
		boolean pass = false;
		try {
			pass = dao.loginUser(user);
			if(pass) {
				String userId = user.getUserId();
				model.addAttribute("userId", userId);	// 세션에 아이디 등록				
			}
			map.put("login", pass);

		} catch (Exception e) {
			map.put("login", pass);
		}

		return map;
	}


	// logout (로그아웃)
	@PostMapping("/logout")
	@ResponseBody
	public Map<String,Boolean> logout(SessionStatus status)
	{
		Map<String,Boolean> map = new HashMap<>();
		status.setComplete();
		map.put("logout", true);
		return map;
	}


	// checkId (ID 중복 체크)
	@GetMapping("/checkId")
	@ResponseBody
	public Map<String, Boolean> checkId(User user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean isDuplicate = dao.checkId(user);
		map.put("isDuplicate", isDuplicate);
		return map;
	}


	// checkEmail (EMAIL 중복 체크)
	@GetMapping("/checkEmail")
	@ResponseBody
	public Map<String, Boolean> checkEmail(User user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean isDuplicate = dao.checkEmail(user);
		map.put("isDuplicate", isDuplicate);
		return map;
	}


	// findId (아이디 찾기 폼)
	@GetMapping("/findid")
	public String findId() {
		return "user/userFindID";
	}


	// findPwd (비밀번호 찾기 폼)
	@GetMapping("/findpwd")
	public String findPwd() {
		return "user/userFindPWD";
	}


	// findIdUser (아이디 찾기)
	@PostMapping("/findId")
	@ResponseBody
	public Map<String, Object> findIdUser(User user) {
		Map<String, Object> map = new HashMap<>();

		User foundUser = dao.findId(user);
		if (foundUser != null) {
			map.put("found", true);
			map.put("userId", foundUser.getUserId());
		} else {
			map.put("found", false);
		}
		return map;
	}

	// resultId (아이디 찾기 결과)
	@GetMapping("/resultId")
	public String resultId(Model model, User user, SessionStatus status)
	{
		model.addAttribute("findId", user.getUserId());
		status.setComplete(); // 아이디찾기했을때 세션 저장되어서 끊어줘야함
		return "user/userFindResultId";
	}

	// findPwdUser (비번 찾기)
	@PostMapping("/findPwd")
	@ResponseBody
	public Map<String, Object> findPwdUser(User user) {
		Map<String, Object> map = new HashMap<>();

		User foundUser = dao.findPwd(user);
		if (foundUser != null) {
			map.put("found", true);
			map.put("userPwd", foundUser.getUserPwd());
		} else {
			map.put("found", false);
		}

		return map;
	}


	// resultPwd (비밀번호 찾기 결과)
	@GetMapping("/resultPwd")
	public String resultPwd(Model model, User user) 
	{
		model.addAttribute("userPwd", user.getUserPwd());
		return "user/userFindResultPwd";
	}


	// myPage (마이페이지)
	@GetMapping("/mypage")
	public String myPage(Model model, @SessionAttribute("userId") String userId) {
		User indexUser = dao.findUser(userId);
		model.addAttribute("user",indexUser);
		return "user/myPage";
	}

	// adminPage (관리자페이지)
	@GetMapping("/adminpage")
	public String adminpage(Model model, @SessionAttribute("userId") String userId) {
		if(!userId.equals("dongmul")) {
			return "error";
		}
		User indexUser = dao.findUser(userId);
		model.addAttribute("user",indexUser);
		return "user/adminPage";
	}

	// myPageCheck (마이페이지 수정 폼 들어가기 위한 비밀번호 체크폼)
	@GetMapping("/mypageCheck")
	public String myPageCheckForm(Model model, @SessionAttribute("userId") String userId) {
		User indexUser = dao.findUser(userId);
		model.addAttribute("user",indexUser);
		return "user/userCheck";
	}

	//  myPageCheck (마이페이지 수정 폼 들어가기 위한 비밀번호 체크)
	@PostMapping("/mypageCheck")
	@ResponseBody
	public Map<String, Object> myPageCheck(@RequestParam("password") String password, @SessionAttribute("userId") String userId) {
		Map<String, Object> map = new HashMap<>();
		User user = dao.findUser(userId);

		if (user != null && user.getUserPwd().equals(password)) {
			// 비밀번호가 일치하는 경우, 성공 응답을 반환합니다.
			map.put("success", true);
		} else {
			// 비밀번호가 일치하지 않는 경우, 에러 응답을 반환합니다.
			map.put("success", false);
			map.put("errorMsg", "비밀번호가 일치하지 않습니다.");
		}
		return map;
	}

	// myPageUpdateForm (마이페이지 수정 폼)
	@GetMapping("/mypageUpdate")
	public String myPageUpdateForm(Model model, @SessionAttribute("userId") String userId) {
		User indexUser = dao.findUser(userId);
		model.addAttribute("user",indexUser);
		return "user/myPageUpdate";
	}

	// myPageUpdate (마이페이지 수정)
	@PostMapping("/mypageUpdate")
	@ResponseBody
	public Map<String, Object> myPageUpdate(User user)
	{
		Map<String, Object> map = new HashMap<>();
		boolean update = dao.updateUser(user);
		map.put("updated", update);
		return map;
	}


	// deleteUser (회원 탈퇴)
	@PostMapping("/deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(User user, SessionStatus status)
	{
		Map<String, Object> map = new HashMap<>();
		boolean delete = dao.deleteUser(user);
		//회원탈퇴시 유저 아이디 세션 날리기
		if(delete) {
			status.setComplete();			
		}
		map.put("deleted", delete);
		return map;
	}

}

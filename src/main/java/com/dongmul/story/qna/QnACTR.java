package com.dongmul.story.qna;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.service.annotation.HttpExchange;

import com.github.pagehelper.PageInfo;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.PathParam;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/qna")
@SessionAttributes("userId")
@Slf4j
public class QnACTR {

	@Autowired
	QnADAO dao;

	@Autowired
	QnASVC svc;

	//add
	@GetMapping("/add")
	public String addForm() {
		return "qna/add";
	}
	@PostMapping("/add")
	@ResponseBody
	public Map add(QnA qna) {
		Map map = new HashMap<>();
		boolean result = dao.add(qna);
		map.put("result", result);
		return map;
	}

	//list
	@GetMapping("/list/{order}")
	public String list(	Model model,
			@PathVariable(name="order", required = false)String order,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "10") int pageSize
			) {
		PageInfo<Map> pageInfo = svc.getList(order, pageNum, pageSize);
		model.addAttribute("qnaList", pageInfo);
		model.addAttribute("order", order);
		return "qna/list";
	}
	//selfList
	@GetMapping("/selfList/{order}")
	public String selfList(	Model model,
			@PathVariable(name="order", required = false)String order,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "10") int pageSize,
			@SessionAttribute("userId") String userId
			) {
		PageInfo<Map> pageInfo = svc.getselfList(userId, order, pageNum, pageSize);
		model.addAttribute("qnaList", pageInfo);
		model.addAttribute("order", order);
		model.addAttribute("self", userId);
		return "qna/list";
	}

	//detail
	@GetMapping("/detail/{qnaNum}")
	@Transactional
	public String detail(	QnA qna,
			Model model,
			HttpSession ss) {
		String userId = (String)ss.getAttribute("userId");
		if(userId == null) {
			return "error";
		}
		qna = dao.detail(qna);
		if(!userId.equals("dongmul")) {
			if(qna.getQnaLock()==0) {
				if(!qna.getQnaUserId().equals(userId)) {
					return "error";
				}
			}			
		}

		log.info("히트수 1증가 결과 : %b", dao.hitUp(qna));
		qna = dao.detail(qna);
		model.addAttribute("i", qna);
		return "qna/detail";
	}

	//update
	@GetMapping("/update/{qnaNum}")
	public String updateFrom(QnA qna, Model model) {
		model.addAttribute("i", dao.detail(qna));
		return "qna/update";
	}
	@PostMapping("/update")
	@ResponseBody
	public Map update(QnA qna) {
		Map map = new HashMap<>();
		map.put("result", dao.update(qna));
		return map;
	}

	//delete
	@PostMapping("/delete")
	@ResponseBody
	public Map delete(QnA qna) {
		Map map = new HashMap<>();
		map.put("result", dao.delete(qna));
		return map;
	}

	//answer
	@PostMapping("/answer")
	@ResponseBody
	public Map answer(QnA qna) {
		System.err.println(qna.toString());
		Map map = new HashMap<>();
		map.put("result", dao.answer(qna));
		return map;
	}



}

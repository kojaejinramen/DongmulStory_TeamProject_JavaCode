package com.dongmul.story.review;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
public class ReviewCTR
{
	@Autowired
	private ReviewDAO dao;
	
	@Autowired
	private ReviewSVC svc;
	
	// 리뷰 유저 확인
	@GetMapping("/add/{orderNum}")
	public String add1(	@PathVariable("orderNum") int orderNum,
						@SessionAttribute("userId") String userId,
						Model model) {
		Map map = dao.getOrderDetail(orderNum);
		//구매한 사람이 review를 적는 것인지 확인
		if(!map.get("orderUserId").equals(userId)) {
			return "error";
		}
		model.addAttribute("map", map);
		return "review/add";
	}
	
	// 리뷰 등록
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(	@RequestParam("files")MultipartFile[] mfiles,
									HttpServletRequest request,
									Review r)
	{
		boolean added = svc.addReview(mfiles, request, r);
		Map<String, Object> map = new HashMap<>();
		map.put("added", added);
		map.put("num", r.getNum());
		return map;
	}
	
	// 리뷰 목록 (아이템 번호 목록)
	@GetMapping("/list/{itemNum}/page/{pn}")
	public String getList(	@PathVariable("itemNum") int itemNum,
							@PathVariable int pn,
							Model model)
	{
		PageInfo<Map> pageInfo = dao.getList(itemNum, pn);
		model.addAttribute("pageInfo", pageInfo);
		return "review/reviewList";
	}
	
	// 리뷰 목록 (개인 작성 목록 & 관리자 목록)
	@GetMapping("/list/page/{pn}")
	public String getUserList(	@SessionAttribute("userId") String userId,
							@PathVariable int pn,
							Model model)
	{
		PageInfo<Map> pageInfo = null;
		
		if(userId.equals("dongmul")){
			pageInfo = dao.getAdminList(pn);
		}
		else {
			pageInfo = dao.getUserList(userId, pn);
		}
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("notItem",userId);
		return "review/reviewList";
	}
	
	// 상세보기
	@GetMapping("detail/get/{orderNum}")
	public String getReview(	@PathVariable int orderNum,
								Model model,
								@RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum)
	{
		Map map = svc.getReview(orderNum);
		//rfileList 만들기
		List<String> rfileList = svc.makeRfileList(map);
		model.addAttribute("review", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("rfileList", rfileList);
		return "review/detail";
	}
	
	// 업데이트 보기
	@GetMapping("/update/{orderNum}")
	public String edit(	@PathVariable int orderNum,
						Model model,
						@RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum)
	{
		Map map = dao.getReview(orderNum);
		//rfileList 만들기
		List<String> rfileList = svc.makeRfileList(map);
		model.addAttribute("review", map);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("rfileList", rfileList);
		return "review/edit";
	}
	
	// 업데이트 실행
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> update(	@RequestParam(value="files", required=false) MultipartFile[] mfiles,
										HttpServletRequest request,
										Review review)
	{
		boolean updated = svc.updateFileIncludeFiles(mfiles, request, review);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	// 리뷰 삭제
	@PostMapping("/delete")
	@ResponseBody
	public Map deleteReview(@RequestParam("reviewNum")int reviewNum,
							HttpServletRequest request)						
	{
		boolean deleted = svc.deleteReview(reviewNum, request);
		Map map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
	// 파일 개별 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public Map deleteImg(	@RequestParam("fakeName") String fakeName,
							HttpServletRequest request)
	{
		boolean deleted = svc.deleteImg(fakeName, request);
		Map map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
}
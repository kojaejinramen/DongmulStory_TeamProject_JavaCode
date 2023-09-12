package com.dongmul.story.shop;

import java.io.File;
import java.lang.module.ModuleDescriptor.Requires;
import java.util.*;

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
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.websocket.server.PathParam;

@Controller
@RequestMapping("/shop")
public class ShopCTR {
	//auto new
	@Autowired
	ShopSVC svc;
	@Autowired
	ShopDAO dao;
	//index
	@GetMapping("/")
	public String index() {
		return "shop/index";
	}
	//addForm
	@GetMapping("/add")
	public String addForm() {
		return "shop/add";
	}
	//add
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Boolean> add(@RequestParam("files") MultipartFile[] mfiles,
			HttpServletRequest request,
			Item item)
	{
		boolean result = svc.makeItemIncludeFiles(mfiles, request, item);
		Map<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	//list(animalNum = 1,2,3,4,5 : 개,냥,쥐,뱀,새)
	@GetMapping("/list/{animal}/{typeNum}/{pageNum}")
	public String ItemList(	Model model,
			@PathVariable("animal")String animal,
			@PathVariable("typeNum")int typeNum,
			@PathVariable("pageNum")int pageNum) {
		int pageSize = 8;
		int animalNum = svc.findAnimalNum(animal);
		PageInfo<Map> pageInfo = dao.getAnimalList(pageNum, pageSize, animalNum, typeNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("typeNum", typeNum);
		model.addAttribute("animal", animal);
		return "shop/list";
	}
	//detail
	@Transactional
	@GetMapping("/detail/{animal}/{typeNum}/{pageNum}/{itemNum}")
	public String detail(	Model model,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "keyword", required = false) String keyword,
			@PathVariable("animal")String animal,
			@PathVariable("typeNum")int typeNum,
			@PathVariable("pageNum")int pageNum,
			@PathVariable("itemNum")int itemNum) {
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("typeNum", typeNum);
		model.addAttribute("animal", animal);
		model.addAttribute("category", category);
		model.addAttribute("keyword", keyword);
		Map map = dao.detail(itemNum);
		model.addAttribute("map", map);
		model.addAttribute("imgList", svc.makeImagesList(map));
		model.addAttribute("reviews", dao.makeReviewsList(itemNum));
		return "shop/detail";
	}	
	//find
	@GetMapping("/searchList/{animal}/{typeNum}/{pageNum}")
	public String searchByCategory(Model model,
			@RequestParam("category") String category,
			@RequestParam("keyword") String keyword,
			@PathVariable("animal")String animal,
			@PathVariable("typeNum")int typeNum,
			@PathVariable("pageNum")int pageNum){
		int pageSize = 8;
		PageInfo<Map> pageInfo = svc.find(pageNum, pageSize, category, keyword, animal, typeNum);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("typeNum", typeNum);
		model.addAttribute("animal", animal);
		model.addAttribute("category", category);
		model.addAttribute("keyword", keyword);
		return "/shop/list";
	}
	//update
	@GetMapping("/update/{animal}/{typeNum}/{pageNum}/{itemNum}")
	public String update(	Model model,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "keyword", required = false) String keyword,
			@PathVariable("animal")String animal,
			@PathVariable("typeNum")int typeNum,
			@PathVariable("pageNum")int pageNum,
			@PathVariable("itemNum")int itemNum) {
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("typeNum", typeNum);
		model.addAttribute("animal", animal);
		model.addAttribute("category", category);
		model.addAttribute("keyword", keyword);
		Map map = dao.detail(itemNum);
		model.addAttribute("map", map);
		model.addAttribute("imgList", svc.makeImagesList(map));
		return "shop/update";
	}
	@PostMapping("/update")
	@ResponseBody
	public Map update(@RequestParam("files") MultipartFile[] mfiles,
			HttpServletRequest request,
			Item item)
	{
		boolean result = svc.updateItemIncludeFiles(mfiles, request, item);
		Map map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	//delete
	@PostMapping("/deleteAll")
	@ResponseBody
	public Map deleteAll(@RequestParam("itemNum")int itemNum, HttpServletRequest request) {
		boolean result = svc.deleteAll(itemNum, request);
		Map map = new HashMap<>();		
		map.put("result", result);
		return map;
	}
	@PostMapping("/deleteImg")
	@ResponseBody
	public Map deleteImg(@RequestParam("animal")String animal, @RequestParam("img")String ifileFakeName, HttpServletRequest request) {
		boolean result = svc.deleteImg(animal, ifileFakeName, request);
		Map map = new HashMap<>();		
		map.put("result", result);
		return map;
	}
}//class

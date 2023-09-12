package com.dongmul.story.order;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import com.github.pagehelper.PageInfo;


@Controller
@RequestMapping("/order") 
public class OrderCTR {

	@Autowired
	OrderDAO dao;

	@Autowired
	OrderSVC svc;

	//카트에서 리스트 받아와 화면에 결제 전 최종으로 보여주기
	@PostMapping("/lastlist")
	public String lastlist(@RequestParam("num") List<Integer> nums, Model model) {
		List<Map> list = dao.getLastList(nums);
		model.addAttribute("list", list);
		return "order/orderList";
	}

	// 개별 상품 구매
	@GetMapping("/lastlist/oneItem")
	public String lastlistOneItem(@RequestParam("num") List<Integer> nums, Model model) {
		List<Map> list = dao.getLastList(nums);
		dao.deleteCart(nums);
		model.addAttribute("list", list);
		return "order/orderList";
	}

	//결제내역 저장 메소드
	@PostMapping("/saveOrderlist")
	@ResponseBody
	public Map<String, Boolean> saveOrderlist(Order order,
			@RequestParam("orderItemNum") List<Integer> orderItemNums,
			@RequestParam("orderItemName") List<String> orderItemNames,
			@RequestParam("orderItemPrice") List<Integer> orderItemPrices,
			@RequestParam("orderQuantity") List<Integer> orderQuantitys,
			@RequestParam("cartNum") List<Integer> cartNums) {
		boolean saved = svc.saveOrderlist(order, orderItemNums, orderItemNames, orderItemPrices, orderQuantitys, cartNums);

		Map<String, Boolean> map = new HashMap<>();
		map.put("saved", saved);
		return map;
	}

	// 결제내역목록 메소드
	@GetMapping("/paylist")
	public String payList(Model model,
			@SessionAttribute("userId") String userId,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "10") int pageSize) {

		PageInfo<Map> payList;

		if (userId.equals("dongmul")) {
			// 관리자인 경우 모든 구매내역 조회
			payList = dao.payListForAdmin(pageNum, pageSize);
		} else {
			// 일반 사용자인 경우 해당 사용자의 구매내역 조회
			payList = dao.payList(userId, pageNum, pageSize);
		}

		model.addAttribute("payList", payList);
		return "order/payList";
	}

	// 상세보기 클릭 상세내역 메소드
	@GetMapping("/detail/{orderNum}")
	public String detail(@PathVariable int orderNum, Model model)
	{
		Map detail = dao.detail(orderNum);
		System.err.println(detail);
		model.addAttribute("d", detail);
		return "order/orderDetail";
	}

	//주문상태 수정폼 메소드
	@GetMapping("/edit/{orderNum}")
	public String edit(@PathVariable int orderNum, Model model)
	{
		Map edit = dao.detail(orderNum);
		model.addAttribute("e", edit);
		return "order/orderEdit";
	}

	//주문상태 수정 메소드
	@PostMapping("/update")
	@ResponseBody
	public Map update(Order order)
	{
		boolean updated = dao.update(order);
		Map map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}

	//주문취소 메소드
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Boolean> delete(Order order)
	{
		boolean deleted = dao.delete(order); 
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}

	// 교환접수 메소드
	@PostMapping("/exchangeOrder")
	@ResponseBody
	public Map<String, Object> exchangeOrder(int orderNum) {
		// 주문을 주문번호(orderNum)를 기준으로 찾습니다.
		Order order = dao.findByOrderNum(orderNum);
		if (order != null) {
			order.setOrderState("교환접수"); // 주문상태를 "교환접수"로 변경

			// 변경된 주문 정보를 데이터베이스에 업데이트합니다.
			boolean updated = dao.update(order);

			Map<String, Object> map = new HashMap<>();
			map.put("updated", updated);
			return map;
		} else {
			// 주문을 찾지 못한 경우에 대한 처리 (예: 오류 메시지 반환)
			// 예를 들면, 다음과 같이 에러 메시지를 반환할 수 있습니다.
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("error", "해당 주문을 찾을 수 없습니다.");
			return errorMap;
		}
	}

	// 반품접수 메소드
	@PostMapping("/returnOrder")
	@ResponseBody
	public Map<String, Object> returnOrder(int orderNum) {
		// 주문을 주문번호(orderNum)를 기준으로 찾습니다.
		Order order = dao.findByOrderNum(orderNum);
		if (order != null) {
			order.setOrderState("반품접수"); // 주문상태를 "반품접수"로 변경

			// 변경된 주문 정보를 데이터베이스에 업데이트합니다.
			boolean updated = dao.update(order);

			Map<String, Object> map = new HashMap<>();
			map.put("updated", updated);
			return map;
		} else {
			// 주문을 찾지 못한 경우에 대한 처리 (예: 오류 메시지 반환)
			// 예를 들면, 다음과 같이 에러 메시지를 반환할 수 있습니다.
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("error", "해당 주문을 찾을 수 없습니다.");
			return errorMap;
		}
	}

	// 환불접수 메소드
	@PostMapping("/refundOrder")
	@ResponseBody
	public Map<String, Object> refundOrder(int orderNum) {
		// 주문을 주문번호(orderNum)를 기준으로 찾습니다.
		Order order = dao.findByOrderNum(orderNum);
		if (order != null) {
			order.setOrderState("환불접수"); // 주문상태를 "환불접수"로 변경

			// 변경된 주문 정보를 데이터베이스에 업데이트합니다.
			boolean updated = dao.update(order);

			Map<String, Object> map = new HashMap<>();
			map.put("updated", updated);
			return map;
		} else {
			// 주문을 찾지 못한 경우에 대한 처리 (예: 오류 메시지 반환)
			// 예를 들면, 다음과 같이 에러 메시지를 반환할 수 있습니다.
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("error", "해당 주문을 찾을 수 없습니다.");
			return errorMap;
		}
	}

	// 관리자 매출관리
	@GetMapping("/admin/list/{option}")
	public String adminList(Model model,
			@SessionAttribute("userId") String userId,
			@PathVariable("option") String option,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "30") int pageSize,
			@RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate) {

		PageInfo<Map> adminList;
		
		// 관리자외 접근금지
		if(!userId.equals("dongmul"))
		{
			return null;
		}
		
		if (option.equals("date") && startDate != null && endDate != null) {
			adminList = svc.getadminList(option, pageNum, pageSize, startDate, endDate);
		} else {
			adminList = svc.getadminList(option, pageNum, pageSize);
		}

		model.addAttribute("option", option);
		model.addAttribute("adminList", adminList);

		// 날짜 포매팅을 위한 코드 추가
		if (startDate != null && endDate != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate parsedStartDate = LocalDate.parse(startDate);
			LocalDate parsedEndDate = LocalDate.parse(endDate);
			String startDateFormatted = parsedStartDate.format(formatter);
			String endDateFormatted = parsedEndDate.format(formatter);
			model.addAttribute("startDateFormatted", startDateFormatted);
			model.addAttribute("endDateFormatted", endDateFormatted);
		}

		return "order/adminList";
	}

	// 관리자 구매내역 관리
	@GetMapping("/admin/paylist/{userId}")
	public String adminPayList(Model model,
			@PathVariable("userId") String userId,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "10") int pageSize) {
		PageInfo<Map> adminPayList = dao. adminPayList(userId, pageNum, pageSize);
		model.addAttribute("adminPayList", adminPayList);
		model.addAttribute("sumPrice", adminPayList.getList().get(0).get("sumPrice"));
		return "order/adminPayList"; // 관리자용 구매내역 페이지로 이동하는 뷰 이름
	}


}


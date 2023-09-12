package com.dongmul.story.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.dongmul.story.shop.Item;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/cart")
public class CartCTR {
	@Autowired
	CartSVC svc;

	// 장바구니에 증가
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> cartAdd(Cart cart,  Model model, @SessionAttribute("userId")String userId) {
		Map<String, Object> map = new HashMap<>();
		System.err.println(cart);

		boolean success = false;

		//로그인 안했으면 false
		if(cart.getCartUserId()==null) {
			map.put("result", success);
		}
		else {
			success = svc.addCart(cart, userId);
			map.put("result", success);
		}
		return map;
	}

	// for 개별 상품 구매
	@PostMapping("/add/oneItem")
	@ResponseBody
	public Map<String, Object> cartAddOneItem(Cart cart,  Model model, @SessionAttribute("userId")String userId) {

		Map<String, Object> map = new HashMap<>();

		boolean success = false;

		//로그인 안했으면 false
		if(cart.getCartUserId()==null) {
			map.put("result", success);
		}
		else {
			success = svc.addCartOneItem(cart, userId);
			map.put("result", success);
			map.put("num", cart.getCartNum());
		}
		return map;
	}

	// 장바구니 리스트
	@GetMapping("/list")
	public String cartList(Model model, @SessionAttribute("userId") String userId) {
		List<Map> cartList = svc.allList(userId);
		// AnimalName 추가(장바구니 목록에서 상품제목 누르면 아이템 상세페이지를 들어가기 위한)
		for (int i=0; i<cartList.size(); i++) {
			Map cart = cartList.get(i);
			int itemAnimalNum = (Integer) cart.get("itemAnimalNum");
			String itemAnimalName = svc.findAnimalName(itemAnimalNum);
			cart.put("itemAnimalName", itemAnimalName);
		}
		int pageNum = 1;
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("itemCart", cartList);
		return "cart/cartList";
	}

	// 장바구니 아이템 수량 수정
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> cartUpdate(@RequestParam("cartNum") int cartNum, 
			@RequestParam("cartQuantity") int cartQuantity,
			Cart cart) {
		Map<String, Object> map = new HashMap<>();
		boolean updated = svc.updateCart(cart);
		map.put("updated", updated);
		return map;
	}

	// 장바구니 아이템 개별 삭제
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> cartDelete(@RequestBody List<Integer> cartNums) {
		Map<String, Object> map = new HashMap<>();
		boolean deleted = svc.deleteCart(cartNums);
		map.put("deleted", deleted);
		return map;
	}
}

package com.dongmul.story.cart;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dongmul.story.shop.Item;

@Service
public class CartSVC {
	@Autowired
	CartDAO dao;

	public boolean addCart(Cart cart ,String userId) {
		cart.setCartUserId(userId);
		boolean added = false;

		// 같은아이템을 담았을 경우 장바구니목록에 추가하는 것이 아닌 수량만 변경
		Cart find = dao.findByItemNum(cart);

		if(find != null) {
			added =  dao.updateQty(find, cart);
		}
		else {
			added = dao.cartAdd(cart);
		}
		return added;
	}

	public boolean addCartOneItem(Cart cart, String userId) {
		cart.setCartUserId(userId);
		boolean added = false;
		added = dao.cartAdd(cart);
		return added;
	}


	public List<Map> allList(String userId) {
		return dao.allList(userId);
	}

	public boolean updateCart(Cart cart){
		return dao.cartUpdate(cart);
	}

	public boolean deleteCart(List<Integer> cartNums) {
		return dao.cartDelete(cartNums);
	}
	
	// 장바구니목록에서 상품 클릭시 상세보기 들어가기 위한 동물명 url코드
	public String findAnimalName(int itemAnimalNum) {
		switch (itemAnimalNum) {
		case 1: return "dog";
		case 2 : return "cat";
		case 3 : return "mouse";
		case 4 : return "dragon";
		case 5 : return "bird";
		default: return "";
		}
	}
}

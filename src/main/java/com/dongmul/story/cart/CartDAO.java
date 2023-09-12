package com.dongmul.story.cart;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dongmul.story.shop.Item;

@Repository
public class CartDAO {
	@Autowired
	CartMAP map;

	//카트에 아이템 추가
	public boolean cartAdd(Cart cart)
	{
		return map.addCart(cart)>0;
	}

	//카트 목록
	public List<Map> allList(String userId) {
		return map.allList(userId);
	}


	// 카트 아이템 수량 수정
	public boolean cartUpdate(Cart cart) {
		return map.updateCart(cart)>0;
	}

	//카트 아이템 삭제
	public boolean cartDelete(List<Integer> cartNums)
	{
		return map.deleteCart(cartNums)>0;
	}

	public Cart findByItemNum(Cart cart) {
		return map.findByItemNum(cart);
	}

	//동일 상품명 장바구니 담기
	public boolean updateQty(Cart find, Cart cart) {
		//기존수량 + 추가수량
		find.setCartQuantity(find.getCartQuantity()+cart.getCartQuantity());
		//세션 이름
		find.setCartUserId(cart.getCartUserId());
		return map.updateCart(find)>0;
	}


}

package com.dongmul.story.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dongmul.story.shop.Item;

@Mapper
public interface CartMAP {
	public int addCart(Cart cart);

	public List<Map> allList(String userId);

	public int deleteCart(List<Integer> cartNums);

	public int updateCart(Cart cart);

	public Cart findByItemNum(Cart cart);

}

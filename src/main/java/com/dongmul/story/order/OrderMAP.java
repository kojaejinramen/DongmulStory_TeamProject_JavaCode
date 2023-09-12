package com.dongmul.story.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dongmul.story.cart.Cart;
import com.github.pagehelper.PageInfo;

@Mapper
public interface OrderMAP {
	//first list
	public List<Map> getLastList(List<Integer> nums);

	//add
	public int saveOrderlist(List<Order> list);

	//order up
	public int addQuatityAtItem(List<Order> list);

	//delete cart
	public int deleteCart(List<Integer> cartNums);

	//pay List	
	public List<Map<String, String>> payList(Map m);
	//pay List 관리자	
	public List<Map<String, String>> payListForAdmin();	

	//detail 주문상세 	
	public Map detail(int orderNum);

	//update 주문상태(관리자)	
	public int update(Order order);

	//delete 주문취소
	public int delete(Order order);

	//교환,반품,환불접수
	public Order findByOrderNum(int orderNum);

	//관리자 매출관리
	public List<Map> getUserOrder();
	public List<Map> getItemOrder();
	public List<Map> getDateOrder(@Param("startDate") String startDate, @Param("endDate") String endDate);
	public List<Map> getAnimalOrder();

	public List<Map> getDateOrder();

	//관리자 구매내역 관리 
	public List<Map<String, String>> adminPayList(Map m);


}

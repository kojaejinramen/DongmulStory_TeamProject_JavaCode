package com.dongmul.story.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dongmul.story.cart.Cart;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Repository
public class OrderDAO {

	@Autowired
	OrderMAP map;

	//First list	
	public List<Map> getLastList(List<Integer> nums) {
		return map.getLastList(nums);
	}
	//add
	public boolean saveOrderlist(List<Order> list) {
		return map.saveOrderlist(list)>0;
	}
	// add = true -> order += qty
	public boolean addQuatityAtItem(List<Order> list) {
		return map.addQuatityAtItem(list)>0;
	}
	// add = ture -> delete cart
	public boolean deleteCart(List<Integer> cartNums) {
		return map.deleteCart(cartNums)>0;
	}
	//pay List
	public PageInfo<Map> payList(String userId, int pageNum, int pageSize) {
		Map m = new HashMap<>();
		m.put("userId", userId);
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Map> pageInfo = new PageInfo<>(map.payList(m));
		return pageInfo;
	}
	// payList 관리자
	public PageInfo<Map> payListForAdmin(int pageNum, int pageSize) {
		Map m = new HashMap<>();
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Map> pageInfo = new PageInfo<>(map.payListForAdmin());
		return pageInfo;
	}

	// detail 주문 상세보기	
	public Map detail(int orderNum) {
		return map.detail(orderNum);
	}

	// 관리자 update	
	public boolean update(Order order) {
		return map.update(order)>0;
	}

	// delete 주문취소
	public boolean delete(Order order) {
		return map.delete(order)>0;
	}

	// 교환,반품,환불 접수	
	public Order findByOrderNum(int orderNum) {
		return map.findByOrderNum(orderNum);
	}

	// 관리자 매출관리
	public PageInfo<Map> getUserOrder(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getUserOrder());
	}
	public PageInfo<Map> getItemOrder(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getItemOrder());
	}
	public PageInfo<Map> getDateOrder(int pageNum, int pageSize, String startDate, String endDate) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getDateOrder(startDate, endDate));
	}
	public PageInfo<Map> getAnimalOrder(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getAnimalOrder());
	}

	public PageInfo<Map> getDateOrder(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getDateOrder());
	}

	// 관리자 구매내역 관리
	public PageInfo<Map> adminPayList(String userId, int pageNum, int pageSize) {
		Map m = new HashMap<>();
		m.put("userId", userId);
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Map> pageInfo = new PageInfo<>(map.adminPayList(m));
		return pageInfo;
	}


}

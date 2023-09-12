package com.dongmul.story.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageInfo;

@Service
public class OrderSVC 
{
	@Autowired
	OrderDAO dao;

	@Transactional
	public boolean saveOrderlist(Order order,
			List<Integer> orderItemNums,
			List<String> orderItemNames,
			List<Integer> orderItemPrices, 
			List<Integer> orderQuantitys,
			List<Integer> cartNums) {

		List<Order> list = new ArrayList<>();
		// 주문 아이템의 개수만큼 반복하여 Order 객체를 생성하고 파라미터들을 추가
		for (int i = 0; i < orderItemNums.size(); i++) {
			Order makeOneItem = new Order();
			makeOneItem.setOrderUserId(order.getOrderUserId());
			makeOneItem.setOrderPhone(order.getOrderPhone());
			makeOneItem.setOrderAddress1(order.getOrderAddress1());
			makeOneItem.setOrderAddress2(order.getOrderAddress2());
			makeOneItem.setOrderAddress3(order.getOrderAddress3());
			makeOneItem.setOrderDate(order.getOrderDate());
			makeOneItem.setOrderNote(order.getOrderNote());
			makeOneItem.setOrderNum(order.getOrderNum());
			makeOneItem.setOrderState(order.getOrderState());
			makeOneItem.setOrderUserName(order.getOrderUserName());

			// order에 못받은 값들만 별도로 추가
			makeOneItem.setOrderGroup(cartNums.get(0));
			makeOneItem.setOrderItemNum(orderItemNums.get(i));
			makeOneItem.setOrderItemName(orderItemNames.get(i));
			makeOneItem.setOrderItemPrice(orderItemPrices.get(i));
			makeOneItem.setOrderQuantity(orderQuantitys.get(i));

			// 주문 객체를 리스트에 추가
			list.add(makeOneItem);
		}
		boolean result = false;
		// OrderDAO를 통해 주문 리스트를 저장
		result = dao.saveOrderlist(list);
		// 결제에 성공했다면 item에 있는 order 수 quatity만큼 증가
		if(result) {
			result = dao.addQuatityAtItem(list);
		}
		// 결제에 성공했다면 카트에 있는 정보는 지운다.
		if(result) {
			dao.deleteCart(cartNums);
		}       
		return result;
	}

	public PageInfo<Map> getadminList(String option, int pageNum, int pageSize, String startDate, String endDate) {
		switch(option)
		{
		case "user": 
			return dao.getUserOrder(pageNum, pageSize);
		case "item": 
			return dao.getItemOrder(pageNum, pageSize);
		case "date": 
			return dao.getDateOrder(pageNum, pageSize, startDate, endDate);
		case "animal": 
			return dao.getAnimalOrder(pageNum, pageSize);
		}
		return null;
	}

	public PageInfo<Map> getadminList(String option, int pageNum, int pageSize) {
		switch(option)
		{
		case "user": 
			return dao.getUserOrder(pageNum, pageSize);
		case "item": 
			return dao.getItemOrder(pageNum, pageSize);
		case "date": 
			return dao.getDateOrder(pageNum, pageSize);
		case "animal": 
			return dao.getAnimalOrder(pageNum, pageSize);
		}
		return null;
	}

}

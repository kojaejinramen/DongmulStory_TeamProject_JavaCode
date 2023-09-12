package com.dongmul.story.order;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Order {

	private int orderNum;
	private String orderUserId;
	private String orderPhone;
	private String orderUserName;
	private String orderAddress1;
	private String orderAddress2;
	private String orderAddress3;
	private java.sql.Date orderDate;
	private String orderState;
	private String orderNote;

	private int orderGroup;
	private int orderItemNum;
	private String orderItemName;
	private int orderItemPrice;
	private int orderQuantity;


}

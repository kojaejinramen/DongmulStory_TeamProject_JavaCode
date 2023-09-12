package com.dongmul.story.cart;

import java.util.List;

import org.springframework.stereotype.Component;

import com.dongmul.story.shop.Item;

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
public class Cart {
	private int cartNum;
	private String cartUserId;
	private int cartItemNum;
	private int cartQuantity;

}

package com.dongmul.story.shop;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@EqualsAndHashCode(exclude = {"name", "animalNum", "typeNum", "price", "contents", "order", "list"})
@NoArgsConstructor
@AllArgsConstructor
@Component
public class Item {
	private int num;
	private String name;
	private int animalNum;
	private int typeNum;
	private int price;
	private String contents;
	private int order;
	private List<Ifile> list;
}

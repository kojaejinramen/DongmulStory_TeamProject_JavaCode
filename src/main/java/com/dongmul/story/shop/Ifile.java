package com.dongmul.story.shop;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@EqualsAndHashCode(exclude = {"itemNum", "name", "type", "fakeName"})
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Component
public class Ifile {
	private int num;
	private int itemNum;
	private String name;
	private String type;
	private String fakeName;
}

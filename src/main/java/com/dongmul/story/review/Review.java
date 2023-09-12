package com.dongmul.story.review;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@Setter
@Getter
@ToString
@EqualsAndHashCode(exclude = {"itemNum", "title", "userId", "date", "contents", "grade", "rfList"})
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private int num;
	private int itemNum;
	private String title;
	private String userId;
	private Date date;
	private String contents;
	private int grade;
	private List<Rfile> rfList;
	private int orderNum;
}
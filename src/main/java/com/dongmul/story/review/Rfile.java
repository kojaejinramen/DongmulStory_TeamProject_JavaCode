package com.dongmul.story.review;

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
@EqualsAndHashCode(exclude = {"reviewNum", "name", "fakeName", "type"})
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Rfile
{
	private int rnum;
	private int reviewNum;
	private String name;
	private String fakeName;
	private String type;
	
}

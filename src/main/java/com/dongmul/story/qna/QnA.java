package com.dongmul.story.qna;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QnA {
	private int qnaNum;
	private String qnaCategory;
	private String qnaTitle;
	private String qnaContents;
	private String qnaUserId;
	private String qnaAnswer;
	private int qnaHit;
	private Date qnaDate;
	private int qnaLock;
}

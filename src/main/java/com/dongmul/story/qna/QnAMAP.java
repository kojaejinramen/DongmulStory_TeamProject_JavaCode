package com.dongmul.story.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnAMAP {

	public int add(QnA qna);

	public List<Map> getNlist();

	public List<Map> getOlist();

	public List<Map> getHlist();

	public List<Map> getNSelfList(String userId);

	public List<Map> getOSelfList(String userId);

	public List<Map> getHSelfList(String userId);

	public QnA detail(QnA qna);

	public int hitUp(QnA qna);

	public int update(QnA qna);

	public int delete(QnA qna);

	public int answer(QnA qna);



}

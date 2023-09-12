package com.dongmul.story.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Repository
public class QnADAO {

	@Autowired
	QnAMAP map;
	//add
	public boolean add(QnA qna) {
		return map.add(qna)>0;
	}
	//list
	public PageInfo<Map> getNlist(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getNlist());
	}
	public PageInfo<Map> getOlist(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getOlist());
	}
	public PageInfo<Map> getHlist(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getHlist());
	}
	//selfList
	public PageInfo<Map> getNSelfList(String userId, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getNSelfList(userId));
	}
	public PageInfo<Map> getOSelfList(String userId, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getOSelfList(userId));
	}
	public PageInfo<Map> getHSelfList(String userId, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return new PageInfo<>(map.getHSelfList(userId));
	}

	//detail
	public QnA detail(QnA qna) {
		return map.detail(qna);
	}
	//hitUp
	public boolean hitUp(QnA qna) {
		return map.hitUp(qna)>0;
	}
	//update
	public boolean update(QnA qna) {
		return map.update(qna)>0;
	}
	//delete
	public Object delete(QnA qna) {
		return map.delete(qna)>0;
	}
	public Object answer(QnA qna) {
		return map.answer(qna)>0;
	}





}

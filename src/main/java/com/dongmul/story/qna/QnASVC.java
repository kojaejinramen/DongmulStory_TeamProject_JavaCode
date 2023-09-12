package com.dongmul.story.qna;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class QnASVC {

	@Autowired
	QnADAO dao;

	//list
	public PageInfo<Map> getList(String order, int pageNum, int pageSize) {
		switch(order) {
		case "new": 
			return dao.getNlist(pageNum, pageSize);
		case "old": 
			return dao.getOlist(pageNum, pageSize);
		case "hit": 
			return dao.getHlist(pageNum, pageSize);
		}
		return null;
	}
	//selfList
	public PageInfo<Map> getselfList(String userId, String order, int pageNum, int pageSize) {
		switch(order) {
		case "new": 
			return dao.getNSelfList(userId, pageNum, pageSize);
		case "old": 
			return dao.getOSelfList(userId, pageNum, pageSize);
		case "hit": 
			return dao.getHSelfList(userId, pageNum, pageSize);
		}
		return null;
	}


}

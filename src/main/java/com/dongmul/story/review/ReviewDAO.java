package com.dongmul.story.review;

import java.util.*;
import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dongmul.story.shop.Ifile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Repository
public class ReviewDAO 
{
	@Autowired
	ReviewMAP Map;
	
	// 리뷰 추가 창(유저 확인)
	public Map getOrderDetail(int orderNum) {
		return Map.getOrderDetail(orderNum);
	}

	// 리뷰 등록
	@Transactional
	public boolean addReview(Review review)
	{
		boolean rSaved = Map.addAndGetKey(review)>0;
		//파일 등록을 안하면 여기서 끝!
		if(review.getRfList().isEmpty()) {
			return rSaved;
		}
		List<Rfile> rfList = review.getRfList();
		for(int i=0;i<rfList.size();i++) {
			rfList.get(i).setReviewNum(review.getNum());
		}
		boolean rfSaved = Map.addRfile(rfList)>0;
		return rSaved && rfSaved;
	}
	
	// 리뷰 목록 - 상품
	public PageInfo<Map> getList(int itemNum, int pageNum)
	{
		PageHelper.startPage(pageNum, 8);
		PageInfo<Map> pageInfo = new PageInfo<>(Map.getList(itemNum));
		return pageInfo;
	}
	
	// 리뷰 목록 - 관리자
	public PageInfo<Map> getAdminList(int pageNum) {
		PageHelper.startPage(pageNum, 8);
		PageInfo<Map> pageInfo = new PageInfo<>(Map.getAdminList());
		return pageInfo;
	}
	
	// 리뷰 목록 - 유저
	public PageInfo<Map> getUserList(String userId, int pageNum) {
		PageHelper.startPage(pageNum, 8);
		PageInfo<Map> pageInfo = new PageInfo<>(Map.getUserList(userId));
		return pageInfo;
	}

	// 리뷰 상세 - 주문번호 사용
	public Map getReview(int orderNum)
	{
		Map map = Map.getReview(orderNum);
		return map;
	}
	
	// 리뷰 상세 - 리뷰번호 사용
	public Map getReview2(int reviewNum)
	{
		Map map = Map.getReview2(reviewNum);
		return map;
	}
	
	// 리뷰 업데이트
	@Transactional
	public boolean update(Review review) 
	{
		//상품 내용 DB 저장
		boolean resultReview = Map.update(review)>0;
		//파일 등록을 안하면 여기서 끝!
		if(review.getRfList().isEmpty()) {
			return resultReview;
		}
		//모든 파일에 아이템번호(itemNum) 넣어주기
		List<Rfile> rfList = review.getRfList();
		for(int i=0;i<rfList.size();i++) {
			Rfile f = rfList.get(i);
			f.setReviewNum(review.getNum());
		}
		System.err.println(rfList.toString());
		//파일도 DB 저장
		boolean resultFiles = Map.addRfile(rfList)>0;
		//둘 다 잘 작동해야 true 출력
		return resultReview && resultFiles;
	}

	// 리뷰 삭제
	public boolean deleteReview(int num) 
	{
		return Map.deleteReview(num)>0;
	}

	// 리뷰 사진 삭제
	public boolean deleteFile(String fakeName) 
	{
		return Map.deleteFile(fakeName)>0;
	}

}
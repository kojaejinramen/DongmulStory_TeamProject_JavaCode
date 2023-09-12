package com.dongmul.story.review;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewMAP 
{

	// 리뷰 등록시 아이디 비교
	public Map getOrderDetail(int orderNum);
	
	// 리뷰 등록
	public int addAndGetKey(Review review);
	
	// 파일 등록
	public int addRfile(List<Rfile> rfList);

	// 리뷰 목록 - 아이탬
	public List<Map> getList(int itemNum);
	
	// 리뷰 목록 - 관리자
	public List<Map> getAdminList();

	// 리뷰 목록 - 유저
	public List<Map> getUserList(String userId);

	// 리뷰 상세 - 주문번호
	public Map<String, Object> getReview(int orderNum); 
	
	// 리뷰 상세 - 리뷰번호
	public Map getReview2(int reviewNum);

	// 리뷰 업데이트
	public int update(Review review);

	// 리뷰 삭제
	public int deleteReview(int num);
	
	// 리뷰 파일 삭제
	public int deleteFile(String fakeName);

}
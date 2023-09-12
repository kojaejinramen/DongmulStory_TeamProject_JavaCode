package com.dongmul.story.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Repository
public class ShopDAO {
	@Autowired
	ShopMAP map;

	@Transactional //DB저장 하다가 하나라도 실패시 둘 다 rollback
	public boolean add(Item item) {
		//상품 내용 DB 저장
		boolean resultItem = map.add(item)>0;
		//파일 등록을 안하면 여기서 끝!
		if(item.getList().size()==0) {
			return resultItem;
		}
		//모든 파일에 아이템번호(itemNum) 넣어주기
		List<Ifile> fileList = item.getList();
		for(int i=0;i<fileList.size();i++) {
			Ifile f = fileList.get(i);
			f.setItemNum(item.getNum());
		}
		//파일도 DB 저장
		boolean resultFiles = map.addFiles(fileList)>0;
		//둘 다 잘 작동해야 true 출력
		return resultItem && resultFiles;
	}

	//list(animalNum = 1,2,3,4,5 : 개,냥,쥐,뱀,새)
	public PageInfo<Map> getAnimalList(int pageNum, int pageSize, int animalNum, int typeNum) {
		Map m = new HashMap<>();
		m.put("animalNum", animalNum);
		m.put("typeNum", typeNum);
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Map> pageInfo = new PageInfo<>(map.getAnimalList(m));
		return pageInfo;
	}
	//detail
	public Map detail(int itemNum) {
		return map.detail(itemNum);
	}
	//find
	public PageInfo<Map> find(int pageNum, int pageSize, String category, String keyword, int animalNum, int typeNum) {
		Map m = new HashMap<>();
		m.put("category", category);
		m.put("keyword",keyword);
		m.put("animalNum", animalNum);
		m.put("typeNum", typeNum);
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<Map> pageInfo = new PageInfo<>(map.find(m));
		System.out.println(pageInfo.toString());
		return pageInfo;
	}
	//update
	@Transactional //DB저장 하다가 하나라도 실패시 둘 다 rollback
	public boolean update(Item item) {

		//상품 내용 DB 저장
		boolean resultItem = map.update(item)>0;
		//파일 등록을 안하면 여기서 끝!
		if(item.getList().size()==0) {
			return resultItem;
		}
		//모든 파일에 아이템번호(itemNum) 넣어주기
		List<Ifile> fileList = item.getList();
		for(int i=0;i<fileList.size();i++) {
			Ifile f = fileList.get(i);
			f.setItemNum(item.getNum());
		}
		//파일도 DB 저장
		boolean resultFiles = map.addFiles(fileList)>0;
		//둘 다 잘 작동해야 true 출력
		return resultItem && resultFiles;
	}
	//delete
	public boolean deleteAll(int itemNum) {
		return map.deleteAll(itemNum)>0;
	}
	public boolean deleteImg(String ifileFakeName) {
		return map.deleteImg(ifileFakeName)>0;
	}

	public List<Map> makeReviewsList(int itemNum) {
		return map.makeReviewsList(itemNum);
	}


}

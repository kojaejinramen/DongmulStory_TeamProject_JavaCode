package com.dongmul.story.shop;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopMAP {

	public int add(Item item);

	public int addFiles(List<Ifile> fileList);

	public List<Map<String, String>> getAnimalList(Map m);

	public Map detail(int itemNum);

	public List<Map> makeReviewsList(int itemNum);

	public List<Map<String, String>> find(Map m);

	public int deleteAll(int itemNum);

	public int deleteImg(String ifileFakeName);

	public int update(Item item);


}

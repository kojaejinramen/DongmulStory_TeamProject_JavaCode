package com.dongmul.story.shop;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class ShopSVC {
	@Autowired
	ShopDAO dao;

	//add
	public boolean makeItemIncludeFiles(@RequestParam("files") MultipartFile[] mfiles,
			HttpServletRequest request,
			Item item)
	{
		try {
			//MultipartFile[] 읽어와서 list로 출력하는 메소드
			List<Ifile> flist = makeImgList(mfiles, request, item);
			item.setList(flist);
			//최종적으로 추가하려고하는 상품 정보와 파일들이 VO안에 저장됨.
			//VO에 있는 상품 내용 DB에 저장
			boolean result = dao.add(item);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//find
	public PageInfo<Map> find(int pageNum, int pageSize, String category, String keyword, String animal, int typeNum) {
		int animalNum = findAnimalNum(animal);
		return dao.find(pageNum, pageSize, category, keyword, animalNum, typeNum);
	}

	//delete all ( DB and Files )
	@Transactional
	public boolean deleteAll(int itemNum, HttpServletRequest request) {
		boolean del = deleteFiles(itemNum, request);
		boolean result = dao.deleteAll(itemNum);
		return del && result;
	}

	//delete img ( DB and File )
	@Transactional
	public boolean deleteImg(String animal, String ifileFakeName, HttpServletRequest request) {
		boolean del = deleteFile(animal, ifileFakeName, request);
		boolean result = dao.deleteImg(ifileFakeName);
		return del && result;
	}

	//delete files use itemNum
	public boolean deleteFiles(int itemNum, HttpServletRequest request) {
		boolean del = false;
		Map map = dao.detail(itemNum);
		int itemAnimalNum = (int) map.get("itemAnimalNum");
		String animal = findAnimalName(itemAnimalNum);
		String files = (String) map.get("ifileFakeNames");
		String[] file = files.split(",");		

		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/files/"+animal);

		for(int i=0;i<file.length;i++) {
			File delFile = new File(savePath,file[i]);
			del = delFile.delete();
			if(!del) return del;
		}
		return del;
	}

	//delete file use ifileFakeName
	public boolean deleteFile(String animal, String ifileFakeName, HttpServletRequest request) {
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/files/"+animal);

		File delFile = new File(savePath,ifileFakeName);
		boolean del = delFile.delete();
		return del;
	}

	//update item information
	public boolean updateItemIncludeFiles(MultipartFile[] mfiles, HttpServletRequest request, Item item) {
		try {
			//MultipartFile[] 읽어와서 list로 출력하는 메소드
			List<Ifile> flist = makeImgList(mfiles, request, item);
			item.setList(flist);
			//최종적으로 추가하려고하는 상품 정보와 파일들이 VO안에 저장됨.
			//VO에 있는 상품 내용 DB에 저장
			boolean result = dao.update(item);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//MultipartFile[] 읽어와서 list로 출력하는 메소드
	public List<Ifile> makeImgList(	MultipartFile[] mfiles,
									HttpServletRequest request,
									Item item) throws Exception{
		//(WEB-INF/files/itemName 파일에 저장될 예정)
		String animal = findAnimalName(item.getAnimalNum());
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/files/"+animal);
		// 파일 읽기(불러와서 list에 담아 VO에 저장)
		List<Ifile> flist = new ArrayList<>();
		for(int i=0;i<mfiles.length;i++) {
			//파일이 없으면 다음 것 확인
			if(mfiles[i].getSize()==0) continue;
			//있으면 리스트에 추가 (name, type)

			//10자리 유니크한 문자열 생성
			String UniqueString = makeUniqueString(10);
			String fakeName = UniqueString+"-동물이야기-"+mfiles[i].getOriginalFilename();
			mfiles[i].transferTo(new File(savePath+"/"+fakeName));
			Ifile f = new Ifile();
			f.setName(mfiles[i].getOriginalFilename());
			f.setType(mfiles[i].getContentType());
			f.setFakeName(fakeName);
			flist.add(f);
		}
		return flist;
	}

	//파일 저장할 때 유니크한 fakename을 만들기 위해 시간을 이용해 고유한 문자열을 출력
	public String makeUniqueString(int num) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
		LocalDateTime now = LocalDateTime.now();
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder sb = new StringBuilder(num);
		Random random = new Random();
		for (int j = 0; j < num; j++) {
			int index = random.nextInt(characters.length());
			sb.append(characters.charAt(index));
		}
		return sb.toString();
	}

	//animalNum return 
	public int findAnimalNum(String animal) {
		switch (animal) {
		case "dog": return 1;
		case "cat" : return 2;
		case "mouse" : return 3;
		case "dragon" : return 4;
		case "bird" : return 5;
		default: return 0;
		}
	}

	//animalName return
	public String findAnimalName(int animalNum) {
		switch (animalNum) {
		case 1: return "dog";
		case 2 : return "cat";
		case 3 : return "mouse";
		case 4 : return "dragon";
		case 5 : return "bird";
		default: return "";
		}
	}

	//imgList return
	public List<String> makeImagesList(Map detailResultMap) {
		List<String> imgList = new ArrayList<>();
		String imgs = (String) detailResultMap.get("ifileFakeNames");
		String[] img = imgs.split(",");
		for(int i=1;i<img.length;i++) {
			imgList.add(img[i]);
		}
		return imgList;
	}

}

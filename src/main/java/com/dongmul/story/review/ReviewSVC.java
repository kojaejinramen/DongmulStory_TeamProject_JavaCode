package com.dongmul.story.review;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.sql.Date;

import org.apache.ibatis.javassist.Loader.Simple;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dongmul.story.shop.Ifile;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class ReviewSVC {
	
	@Autowired
	ReviewDAO dao;
	
	// 리뷰 등록
	public boolean addReview(	MultipartFile[] mfiles,
								HttpServletRequest request,
								Review r) {
		try {
			//MultipartFile[] 읽어와서 list로 출력하는 메소드
			List<Rfile> rflist = makeImgList(mfiles, request, r);
			r.setRfList(rflist);
			//최종적으로 추가하려고하는 상품 정보와 파일들이 VO안에 저장됨.
			//VO에 있는 상품 내용 DB에 저장
			boolean added = dao.addReview(r);
			return added;
		} catch(Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}
	
	// 리뷰 목록
	public PageInfo<Review> getList(int itemNum, int pageNumber)
	{
		List<Review> list = new ArrayList<>();
		PageInfo<Map> pageInfo = dao.getList(itemNum, pageNumber);
		List<Map> listMap = pageInfo.getList();
		
		for(int i=0;i<listMap.size();i++) {
			Map m = listMap.get(i);
			Review r = getReviewIn(m);
			r.setRfList(getRfileIn(m));
			list.add(r);
		}
		PageInfo<Review> pi = new PageInfo<>();
		pi.setList(list);
		pi.setNavigatepageNums(pageInfo.getNavigatepageNums());
		pi.setPageNum(pageInfo.getPageNum());
		return pi;
	}
	
	// 상세보기
	private Review getReviewIn(Map m) {
	    int num = Integer.parseInt(m.get("reviewNum").toString());
	    String title = m.get("reviewTitle").toString();
	    String userId = m.get("reviewUserId").toString();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    java.sql.Date date = (Date)m.get("reviewDate");
	    int grade = Integer.parseInt(m.get("reviewGrade").toString());
	    String contents = m.get("reviewContents").toString();

	    Review r = new Review();
	    r.setNum(num);
	    r.setTitle(title);
	    r.setUserId(userId);
	    r.setDate(date);
	    r.setGrade(grade);
	    r.setContents(contents);
	    return r;
	}
	
	// 상세보기
	public Map<String, Object> getReview(int orderNum) {
	    Map<String, Object> map = dao.getReview(orderNum);
	    
	    List<String> list = new ArrayList<>();
	    // 이미지 파일들 처리
	    String rfileNames = (String) map.get("rfileNames");
	    if (rfileNames != null) {
	        String[] rfileName = rfileNames.split(",");
	        for (String name : rfileName) {
	            list.add(name.trim());
	        }
	    }
	    map.put("fnames", list);
	    
	    return map;
	}
	
	// 상세보기
	private List<Rfile> getRfileIn(Map m) {
	    if (m.get("name") == null) {
	        return null;
	    }
	    
	    String[] rnums = m.get("rnums").toString().split(",");
		String[] reviewNums = m.get("reviewNums").toString().split(",");
		String[] names = m.get("names").toString().split(",");
		String[] types = m.get("types").toString().split(",");
	    
	    List<Rfile> list = new ArrayList<>();
	    for(int i=0;i<rnums.length;i++) {
	    	 Rfile rf = new Rfile();
	    	 rf.setRnum(Integer.valueOf(rnums[i]));
	    	 rf.setReviewNum(Integer.valueOf(reviewNums[i]));
	    	 rf.setName(names[i]);
	    	 rf.setType(types[i]);
	    }
	    return list;
	}
	
	// 리뷰 삭제
	@Transactional
	public boolean deleteReview(int reviewNum, HttpServletRequest request)
	{
		boolean del = deleteFiles(reviewNum, request);
		boolean deleted = dao.deleteReview(reviewNum);
		return del && deleted;
	}
	// 리뷰 삭제시 로컬 파일 전부 삭제
	public boolean deleteFiles(int reviewNum, HttpServletRequest request) {
		boolean del = false;
		Map map = dao.getReview2(reviewNum);
		if (map != null) {
			if(map.get("rfileFakeNames") == null) {
				return true;
	        }
			String review = "review";
			String files = (String) map.get("rfileFakeNames");
			String[] file = files.split(",");
			
			ServletContext context = request.getServletContext();
			String savePath = context.getRealPath("/files/" + review);
			
			for (int i = 0; i < file.length; i++) {
				File delFile = new File(savePath, file[i]);
				del = delFile.delete();
				if (!del) return del;
			}
		}
		return del;
	}
	// 리뷰 사진 하나 삭제
	public boolean deleteImg(String fakeName, HttpServletRequest request)
	{
		boolean del = deleteFile(fakeName, request);
		boolean deleted = dao.deleteFile(fakeName);
		return del && deleted;
	}
	
	public boolean deleteFile(String fakeName, HttpServletRequest request) {
		String file = "review";
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/files/"+file);
		
		File delFile = new File(savePath,fakeName);
		boolean del = delFile.delete();
		return del;
	}
	
	// 업데이트 실행
	public boolean updateFileIncludeFiles(MultipartFile[] mfiles, HttpServletRequest request, Review review)
	{
		try {
			if(mfiles != null) {
				List<Rfile> flist = makeImgList(mfiles, request, review);
				review.setRfList(flist);
			}
			
			boolean updated = dao.update(review);
			return updated;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//MultipartFile[] 읽어와서 list로 출력하는 메소드
	public List<Rfile> makeImgList(MultipartFile[] mfiles, HttpServletRequest request, Review review) throws Exception{
		//(WEB-INF/files/review 파일에 저장될 예정)
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/files/review");
		// 파일 읽기(불러와서 list에 담아 VO에 저장)
		List<Rfile> rflist = new ArrayList<>();
		for(int i=0;i<mfiles.length;i++) {
			//파일이 없으면 다음 것 확인
			if(mfiles[0].getSize()==0) continue;
			//있으면 리스트에 추가 (name, type)
			
			//10자리 유니크한 문자열 생성
			String UniqueString = makeUniqueString(10);
			String fakeName = UniqueString+"-동물이야기-"+mfiles[i].getOriginalFilename();
			
			//로컬폴더에 파일 저장
			mfiles[i].transferTo(new File(savePath+"/"+fakeName));		
			
			Rfile rf = new Rfile();
			rf.setName(mfiles[i].getOriginalFilename());
			rf.setType(mfiles[i].getContentType());
			rf.setFakeName(fakeName);
			rflist.add(rf);
		}
		return rflist;
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

	public List<String> makeRfileList(Map map) {
		List<String> rfileList = new ArrayList<>();
		String rfiles = (String) map.get("rfileFakeNames");
		if(rfiles != null) {
			String[] rfile = rfiles.split(",");
			for(int i=0;i<rfile.length;i++) {
				rfileList.add(rfile[i]);				
			}
			return rfileList;
		}
		return null;
	}
}
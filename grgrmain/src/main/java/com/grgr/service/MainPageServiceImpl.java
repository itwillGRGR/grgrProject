package com.grgr.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.grgr.dao.MainPageDAO;
import com.grgr.dao.NoticeBoardDAO;
import com.grgr.dto.NoticeBoard;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MainPageServiceImpl implements MainPageService{
	private final MainPageDAO mainPageDAO;
	private final NoticeBoardService noticeBoardService;
	


	@Override
	public Map<String, Object> selectNewPost() {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("newInfoList", mainPageDAO.selectNewInfo());
		map.put("newFreeList", mainPageDAO.selectNewFree());
		map.put("newSalesList", mainPageDAO.selectNewSales());
		//map.put("latestNotice", noticeBoardDAO.selectLatestNotice());
		return map;
	}
	
//	public HttpSession latestNotice(HttpSession session) {
//		NoticeBoard latestNotice = noticeBoardService.getLatestNotice();
//		session.setAttribute("latestNoticeNo",latestNotice.getNoticeBno());
//		session.setAttribute("latestNoticeTitle",latestNotice.getNoticeTitle());
//		
//		return session;	
//	}
}

package com.grgr.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.grgr.dto.QnaBoard;
import com.grgr.dto.QnaFile;

//0914 - 안소연/사진 업로드 추가
public interface QnaBoardMapper {
	int qnaBoardCount(Map<String, Object> map);
	int insertQnaBoard(QnaBoard qnaBoard);
	int updateQnaBoard(QnaBoard qnaBoard);
	int deleteQnaBoard(@Param("qnaBno") int qnaBno, @Param("uno") int uno);
	int blindQnaBoard(Map<String, Object> map);
	int increaseQnaViewCnt(int qnaBno);
	QnaBoard selectQnaBoard(int qnaBno);
	Integer selectPrevQnaBno(Map<String, Object> map);
	Integer selectNextQnaBno(Map<String, Object> map);
	List<QnaBoard> selectQnaBoardList(Map<String, Object> map);
	
	int insertQnaFile(QnaFile qnaFile);
	List<QnaFile> selectQnaFile(int qnaBno);
	
	int deleteQnaFile(int qnaFileNo);
}

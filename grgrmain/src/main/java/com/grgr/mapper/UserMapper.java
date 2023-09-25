package com.grgr.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.grgr.dto.MyBoardWriteDTO;
import com.grgr.dto.MyCommentDTO;
import com.grgr.dto.MyLike;
import com.grgr.dto.MyOrderListDTO;
import com.grgr.dto.ReportAdmin;
import com.grgr.dto.UserVO;

public interface UserMapper {
	/* 회원등록 */
	int userJoin(UserVO user);

	/* 아이디 중복 검사 */
	int idCheck(String userId);

	/* 닉네임 중복 검사 */
	int nickNameCheck(String nickName);

	/* 로그인 */
	public UserVO userLogin(UserVO user);

	/* 회원 조회(마이페이지) */
	UserVO userProfile(int uno);

	/* 회원 정보 수정 */
	int updateUserProfile(UserVO user);

	/* 회원 탈퇴 */
	int deleteUserProfile(int uno);

	/* 내가 쓴 댓글 조회 */
	List<MyCommentDTO> getCommentList(@Param("uno") int uno, @Param("startRow") int startRow,
			@Param("endRow") int endRow);

	/* 내가 쓴 게시글 조회 */
	List<MyBoardWriteDTO> getBoardWriteList(@Param("uno") int uno, @Param("startRow") int startRow,
			@Param("endRow") int endRow);

	/* 전체 내가 쓴 게시글 수 */
	int selectWriteCount(int uno);

	/* 전체 내가 쓴 댓글 수 */
	int selectCommentCount(int uno);

	/* 관심게시글 조회 */
	List<MyLike> getLikeList(@Param("uno") int uno, @Param("startRow") int startRow, @Param("endRow") int endRow);

	/* 전체 관심게시글 수 */
	int selectLikeCount(int uno);

	/* 관리자 - 회원보기 */
	List<UserVO> getAllUsers(Map<String, Object> map);

	/* 전체 회원 수 */
	int selectUserCount();

	/* 관리자 - 회원 정보 수정 */
	void updateUser(UserVO user);

	/* 관리자 - 신고 조회 */
	List<ReportAdmin> getReportList(Map<String, Object> map);

	/* 전체 신고 수 */
	int selectReportCount();

	/* 아이디 찾기 */
	String findUserIdByNameAndEmail(@Param("name") String name, @Param("email") String email);

	UserVO findUserByIdAndEmail(String userId, String email);

	void updateUserPassword(UserVO user);

	/* 사용자 접속 위치 정보 업데이트 */
	void getAddressFromCoordinate(@Param("loginId") String loginId, @Param("address") String address);

	/* 휴면계정으로 전환 */
	int updateUserDisactivate();

	/* 활동계정으로 전환 */
	int updateUserActivate(Map<String, Object> map);

	/* 마지막 로그인 날짜 변경 */
	int updateLastLoginDate(UserVO user);

	/* 나의 주문목록 조회 */
	MyOrderListDTO selectMyOrderList(@Param("uno") int uno);
}

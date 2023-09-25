package com.grgr.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.grgr.dto.MyBoardWriteDTO;
import com.grgr.dto.MyCommentDTO;
import com.grgr.dto.MyLike;
import com.grgr.dto.MyOrderListDTO;
import com.grgr.dto.ReportAdmin;
import com.grgr.dto.UserVO;
import com.grgr.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDAOImpl implements UserDAO {

	private final UserMapper userMapper;
	private final String NAMESPACE = "com.grgr.mapper.UserMapper.";
	private final SqlSession sqlSession;

	/* 회원 등록 */
	@Override
	public int userJoin(UserVO user) {
		return sqlSession.getMapper(UserMapper.class).userJoin(user);
	}

	/* 아이디 중복 검사 */
	@Override
	public int idCheck(String userId) {
		return sqlSession.getMapper(UserMapper.class).idCheck(userId);
	}

	/* 닉네임 중복 검사 */
	@Override
	public int nickNameCheck(String nickName) {
		return sqlSession.getMapper(UserMapper.class).nickNameCheck(nickName);
	}

	/* 로그인 */
	@Override
	public UserVO userLogin(UserVO user) {
		return sqlSession.getMapper(UserMapper.class).userLogin(user);
	}

	/* 회원 조회(마이페이지) */
	@Override
	public UserVO userProfile(int uno) {
		return sqlSession.getMapper(UserMapper.class).userProfile(uno);
	}

	/* 회원 정보 수정 */
	@Override
	public int updateUserProfile(UserVO user) {
		return sqlSession.getMapper(UserMapper.class).updateUserProfile(user);
	}

	/* 회원 탈퇴 */
	@Override
	public int deleteUserProfile(int uno) {
		return sqlSession.getMapper(UserMapper.class).deleteUserProfile(uno);
	}

	/* 내가 쓴 댓글 조회 */
	@Override
	public List<MyCommentDTO> getCommentList(int uno, int startRow, int endRow) {
		return sqlSession.getMapper(UserMapper.class).getCommentList(uno, startRow, endRow);
	}

	/* 내가 쓴 게시글 조회 */
	@Override
	public List<MyBoardWriteDTO> getBoardWriteList(int uno, int startRow, int endRow) {

		return sqlSession.getMapper(UserMapper.class).getBoardWriteList(uno, startRow, endRow);
	}

	/* 전체 내가 쓴 댓글 수 */
	@Override
	public int selectCommentCount(int uno) {
		return sqlSession.getMapper(UserMapper.class).selectCommentCount(uno);
	}

	/* 전체 내가 쓴 게시글 수 */
	@Override
	public int selectWriteCount(int uno) {
		return sqlSession.getMapper(UserMapper.class).selectWriteCount(uno);
	}

	/* 관리자 - 회원보기 */
	@Override
	public List<UserVO> getAllUsers(Map<String, Object> map) {
		return sqlSession.getMapper(UserMapper.class).getAllUsers(map);
	}

	/* 전체 회원 수 */
	@Override
	public int selectUserCount() {
		return sqlSession.getMapper(UserMapper.class).selectUserCount();
	}

	/* 관리자 - 회원 정보 수정 */
	@Override
	public void updateUser(UserVO user) {
		sqlSession.update(NAMESPACE + "updateUser", user);

	}

	/* 아이디 찾기 */
	@Override
	public String findUserIdByNameAndEmail(String name, String email) {
		return userMapper.findUserIdByNameAndEmail(name, email);
	}

	@Override
	public UserVO findUserByIdAndEmail(String userId, String email) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("email", email);
		return sqlSession.selectOne("com.grgr.mapper.UserMapper.findUserByIdAndEmail", params);
	}

	@Override
	public void updateUserPassword(UserVO user) {
		sqlSession.update("com.grgr.mapper.UserMapper.updateUserPassword", user);
	}

	@Override
	public void getAddressFromCoordinate(String loginId, String address) {
		Map<Object, String> parameterMap = new HashMap<>();
		parameterMap.put("loginId", loginId);
		parameterMap.put("address", address);
		sqlSession.update("getAddressFromCoordinate", parameterMap);
	}

	/* 관심게시글 조회 */
	@Override
	public List<MyLike> getLikeList(int uno, int startRow, int endRow) {
		return sqlSession.getMapper(UserMapper.class).getLikeList(uno, startRow, endRow);
	}

	/* 전체 관심게시글 수 */
	@Override
	public int selectLikeCount(int uno) {
		return sqlSession.getMapper(UserMapper.class).selectLikeCount(uno);
	}

	@Override
	public List<ReportAdmin> getReportList(Map<String, Object> map) {
		return sqlSession.getMapper(UserMapper.class).getReportList(map);
	}

	@Override
	public int selectReportCount() {
		return sqlSession.getMapper(UserMapper.class).selectReportCount();
	}

	/* 휴면계정으로 전환 */
	@Override
	public int updateUserDisactivate() {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(UserMapper.class).updateUserDisactivate();
	}

	/* 활동계정으로 전환 */
	@Override
	public int updateUserActivate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(UserMapper.class).updateUserActivate(map);
	}

	@Override
	public int updateLastLoginDate(UserVO user) {
		return sqlSession.getMapper(UserMapper.class).updateLastLoginDate(user);
	}

	@Override
	public MyOrderListDTO selectMyOrderList(int uno) {
		return sqlSession.getMapper(UserMapper.class).selectMyOrderList(uno);
	}

}

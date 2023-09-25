package com.grgr.controller;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.grgr.dto.MyBoardWriteDTO;
import com.grgr.dto.MyCommentDTO;
import com.grgr.dto.MyOrderListDTO;
import com.grgr.dto.UserVO;
import com.grgr.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class UserProfileController {

	private final UserService userService;
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	/* 회원 조회(마이페이지) */
	@GetMapping("/userProfile")
	public String userProfilePageGet(HttpSession session, Model model) {
		logger.info("회원 마이페이지 진입");

		Integer loginUno = (Integer) session.getAttribute("loginUno");
		model.addAttribute("user", userService.userProfile(loginUno));
		return "mypage/userProfile";
	}

	/* 회원 정보 수정 페이지 이동 */
	@GetMapping("/updateUserProfile")
	public String updateUserProfileGet(HttpSession session, Model model) {
		logger.info("회원 정보 수정 페이지 진입");
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		model.addAttribute("user", userService.userProfile(loginUno));
		model.addAttribute("loginUno", loginUno);

		Integer userStatus = (Integer) session.getAttribute("loginUserStatus");
		if (userStatus == 4) {
			// userStatus가 4라면 강제로 mypage/userProfile로 이동
			return "redirect:/mypage/userProfile";
		}

		return "mypage/updateUserProfile";
	}

	/* 회원 정보 수정 */
	@PostMapping("/updateUserProfile")
	public String updateUserProfilePost(UserVO user, HttpSession session, RedirectAttributes rttr) {

		String rawPw = "";
		String encodePw = "";

		rawPw = user.getUserPw(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		user.setUserPw(encodePw); // 인코딩된 비밀번호를 user 객체에 다시 저장

		userService.updateUserProfile(user);
		session.setAttribute("user", userService.userProfile(user.getUno()));
		rttr.addFlashAttribute("result", "update success");

		return "redirect:/mypage/userProfile?uno=" + user.getUno();
	}

	@PostMapping("/deleteUserProfile")
	public String deleteUserProfilePost(int uno, HttpSession session, RedirectAttributes rttr) {
		userService.deleteUserProfile(uno);

		// 세션 무효화를 통한 로그아웃 처리
		session.invalidate();
		rttr.addFlashAttribute("result", "delete success");

		return "redirect:/main";

	}

	/* 내가 쓴 댓글 조회페이지 이동 */
	@GetMapping("/myCommentList")
	public void myCommentListGet(HttpSession session, @RequestParam(defaultValue = "1") int pageNum, Model model) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> map = userService.getCommentList(loginUno, pageNum);

		model.addAttribute("pager", map.get("pager"));
		model.addAttribute("commentList", map.get("commentList"));

	}

	/* 내가 쓴 게시글 조회 페이지 이동 */
	@GetMapping("/myBoardWriteList")
	public void myBoardWriteListGet(HttpSession session, @RequestParam(defaultValue = "1") int pageNum, Model model) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> map = userService.getBoardWriteList(loginUno, pageNum);
		model.addAttribute("pager", map.get("pager"));
		model.addAttribute("boardWriteList", map.get("boardWriteList"));

	}

	/* 관심게시글 조회 페이지 이동 */
	@GetMapping("/myLikeList")
	public void myLikeListGet(HttpSession session, @RequestParam(defaultValue = "1") int pageNum, Model model) {
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		Map<String, Object> map = userService.getLikeList(loginUno, pageNum);
		model.addAttribute("pager", map.get("pager"));
		model.addAttribute("likeList", map.get("likeList"));
	}

	/* 휴면계정 안내 및 활성화 */
	@GetMapping("/activateUser")
	public String activateUser(HttpSession session) {
		if ((Integer) session.getAttribute("loginActive") != 2) {
			return "/404";
		}
		return "/mypage/activateUser";
	}

	/* 내가 쓴 댓글 조회페이지 이동 */
	@GetMapping("/myOrderList")
	public String myOrderListGet(HttpSession session, Model model) {
		MyOrderListDTO orderList = new MyOrderListDTO();
		Integer loginUno = (Integer) session.getAttribute("loginUno");
		orderList.setUno(loginUno);
		System.out.println("로그인 번호" + loginUno);
		model.addAttribute("orderList", userService.getMyOrderList(loginUno));
		return "/mypage/myOrderList";
	}
}
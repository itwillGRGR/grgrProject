package com.grgr.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.grgr.dto.UserVO;
import com.grgr.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
	
    private final UserService userService;
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	/* 관리자 - 회원 목록 조회*/
    @GetMapping("/user-list")
    public String getUserListGET(@RequestParam(defaultValue = "1") int pageNum,Model model) {
        Map<String, Object> map = userService.getAllUsers(pageNum);
        model.addAttribute("pager", map.get("pager"));
		model.addAttribute("userList", map.get("userList"));
		Gson gson = new Gson();
	    String userListJson = gson.toJson(map.get("userList"));
	    model.addAttribute("userListJson", userListJson);
		
        return "admin/user-list"; 
    }
    
 	/* 관리자 - 회원 정보 수정*/
    @PostMapping("/user-update")
    @ResponseBody
    public ResponseEntity<String> updateUserPOST(@RequestBody UserVO user) {
        try {
            userService.updateUser(user);
            return new ResponseEntity<>("success", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}

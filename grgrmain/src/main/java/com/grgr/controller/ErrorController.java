package com.grgr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
	@RequestMapping("/404")
	public String handle404() {
		return "404";
	}
}

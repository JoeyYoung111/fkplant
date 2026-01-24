package com.szrj.business.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.szrj.business.dao.LogDao;

@Controller
@SessionAttributes("userSession")
public class HeiController {

	@Autowired 
	private LogDao logDao;
	
}

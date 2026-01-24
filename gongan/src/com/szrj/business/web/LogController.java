package com.szrj.business.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.Log;
@Controller
@SessionAttributes("userSession")
public class LogController {
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getLog.do")
	@ResponseBody
	public Map<String,Object>  getLog(Log log,NewPageModel pm,int page){
		pm.setPageNumber(page);
		NewPageModel basicMsgTemp=logDao.searchLog(log, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", basicMsgTemp.getTotal());
	        result.put("data", basicMsgTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/getEventLog.do")
	@ResponseBody
	public Map<String,Object>  getEventLog(Log log,NewPageModel pm,int page){
		pm.setPageNumber(page);
		NewPageModel basicMsgTemp=logDao.searchEventLog(log, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", basicMsgTemp.getTotal());
	        result.put("data", basicMsgTemp.getRows().toArray());
	        return result;
	}
}

package com.szrj.business.web.information;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.model.information.InfoTimeLine;

@Controller
@SessionAttributes("userSession")
public class InfoTimeLineController {

	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	
	@RequestMapping("/searchInfoTimeLine.do")
	@ResponseBody
	public String searchInfoTimeLine(InfoTimeLine infoTimeLine){
		List<InfoTimeLine> list = new ArrayList<InfoTimeLine>();
		list = infoTimeLineDao.searchList(infoTimeLine);
		return JSONObject.fromObject(list).toString();
		
	}
	
	
}

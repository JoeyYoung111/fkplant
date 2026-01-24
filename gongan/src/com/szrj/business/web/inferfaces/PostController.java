package com.szrj.business.web.inferfaces;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aladdin.util.CardnumberInfo;
import com.szrj.business.dao.event.WorkInfoDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.event.WorkInfo;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelExtend;
import com.szrj.business.model.personel.Relation;

@Controller
public class PostController {
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private WorkInfoDao workInfoDao;
	
	@RequestMapping("/getPersonnelShowinfo.post")
	public String getPersonnelShowinfo(int personnelid,ModelMap model){
		System.out.println("getPersonnelShowinfo.post.................personnelid="+personnelid);
		String url="";
		model.addAttribute("menuid",1);
		model.addAttribute("buttons","");
		url="/jsp/personel/whole/showinfoPost";
		
		Personnel personnel=personnelDao.getById(personnelid);//获取基本信息
		model.addAttribute("personnel",personnel);
		int age=CardnumberInfo.getAge(personnel.getCardnumber());
		model.addAttribute("age",age);
	    Relation relation=relationDao.searchrelation(personnelid);	//社会关系
		model.addAttribute("relation",relation);
		return url;
	}
	
	@RequestMapping("/getWorkInfoShowinfo.post")
	public String getWorkInfoShowinfo(int id,ModelMap model) throws Exception{
		WorkInfo workInfo = workInfoDao.getById(id);
		model.addAttribute("workInfo",workInfo);
		return "/jsp/event/contradictionInfo/workInfo/tsd/showinfo";
	}
}

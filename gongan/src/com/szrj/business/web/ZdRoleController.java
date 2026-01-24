package com.szrj.business.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.ZdRoleDao;
import com.szrj.business.model.ZdRole;

@Controller
@SessionAttributes("userSession")
public class ZdRoleController {
	@Autowired
	private ZdRoleDao zdRoleDao;
	@Autowired
	private LogDao logDao;

	
	@RequestMapping("/searchZdRole.do")
	@ResponseBody
	public Map<String,Object>  searchZdRole(ZdRole zdRole,NewPageModel pm,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			pm.setPageNumber(page);
			NewPageModel zdRoleTemp=zdRoleDao.searchZdRole(zdRole, pm);
		    result.put("code", 0);
		    result.put("count", zdRoleTemp.getTotal());
		    result.put("data", zdRoleTemp.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return result;
	}
	
	/**
	 * 添加
	 */
	@RequestMapping("/addZdRole.do")
	public  @ResponseBody String addZdRole(ZdRole zdRole,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			zdRoleDao.add(zdRole);
			message= new Message("true","中队管理派出所添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "中队管理派出所添加", userSession.getLoginUserName(), addtime, "添加成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","中队管理派出所添加失败！");	
			message.setFlag(-1);
			logDao.recordLog(menuid, "中队管理派出所添加", userSession.getLoginUserName(), addtime, "添加成功", "");			 		 			
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateZdRole.do")
	public @ResponseBody String updateZdRole(ZdRole zdRole,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			zdRoleDao.update(zdRole);		
			message= new Message("true","中队管理派出所修改成功！");
			message.setFlag(1);	
			logDao.recordLog(menuid, "中队管理派出所修改", userSession.getLoginUserName(), addtime, "修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","中队管理派出所修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "中队管理派出所修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelZdRole.do")
	public  @ResponseBody String cancelZdRole(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {			
			zdRoleDao.cancel(id);
			message= new Message("true","中队管理派出所删除成功！");
			message.setFlag(1);		
			logDao.recordLog(menuid, "中队管理派出所删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {			
			 message = new Message("false","中队管理派出所删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "中队管理派出所删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getZdRole.do")
	public String getZdRole(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid",menuid);
		ZdRole zdRole = zdRoleDao.getById(id);
		model.addAttribute("zdRole",zdRole);
		return "/jsp/basic/zdrole/update";
	}
}
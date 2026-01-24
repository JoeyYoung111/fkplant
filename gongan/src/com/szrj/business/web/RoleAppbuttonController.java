package com.szrj.business.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.UserSession;
import com.szrj.business.dao.AppButtonDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.RoleAppbuttonDao;
import com.szrj.business.model.AppButton;
import com.szrj.business.model.RoleAppbutton;

/**
 *@author:lt
 */
@Controller
@SessionAttributes("userSession")
public class RoleAppbuttonController {
	@Autowired
	public RoleAppbuttonDao roleAppbuttonDao;
	@Autowired
	public AppButtonDao appButtonDao;
	@Autowired 
	private LogDao logDao;
	
	@RequestMapping("/getAppbuttonList.do")
	public void getAppbuttonList(AppButton appButton,HttpServletResponse response){
		try {
			List<AppButton> appbuttonList = appButtonDao.searchAllAppButton(appButton);
			JSONArray json = JSONArray.fromObject(appbuttonList);
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().print(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getRoleAppbuttonByRoleid.do")
	@ResponseBody
	public ModelMap getRoleAppbuttonByRoleid(int roleid){
		ModelMap modelMap=new ModelMap();
		try {
			RoleAppbutton roleAppbutton=roleAppbuttonDao.getRoleAppbuttonByRoleid(roleid);
			modelMap.put("roleAppbutton", roleAppbutton);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modelMap;
	}
	
	@RequestMapping("/updateRoleAppbutton.do")
	public @ResponseBody String updateRoleAppbutton(RoleAppbutton roleAppbutton,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			int id = roleAppbuttonDao.find(roleAppbutton);
			roleAppbutton.setAddtime(addtime);
			roleAppbutton.setAddoperator(userSession.getLoginUserName());
			if(id==0){
				roleAppbuttonDao.add(roleAppbutton);
			}else{
				roleAppbuttonDao.updateAppbuttonIds(roleAppbutton);
			}
			message= new Message("true","角色权限修改成功！");
			message.setFlag(1);	
			logDao.recordLog(menuid, "角色权限修改", userSession.getLoginUserName(), addtime, "修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","角色权限修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "角色权限修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
}

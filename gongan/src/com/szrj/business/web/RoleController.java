package com.szrj.business.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;


import com.aladdin.model.Message;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserSession;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.MenuDao;
import com.szrj.business.dao.RoleDao;
import com.szrj.business.dao.RoleMenuDao;
import com.szrj.business.dao.RoleUserDao;
import com.szrj.business.model.Menu;
import com.szrj.business.model.Role;
import com.szrj.business.model.RoleMenu;
import com.szrj.business.model.RoleUser;

/**
 *@author:华夏
 *@date:2020-3-9 下午01:56:25
 */
@Controller
@SessionAttributes("userSession")
public class RoleController {
	@Autowired
	public RoleDao roleDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private MenuDao	menuDao;
	@Autowired 
	private RoleMenuDao roleMenuDao;
	@Autowired 
	private RoleUserDao roleUserDao;
	
	@RequestMapping("/getRoleList.do")
	@ResponseBody
	public List<Role> getRoleList(){
		Role role=new Role();
		role.setId(0);
		List<Role> roleList=roleDao.getRoleList(role);
		return roleList;
	}
	
	@RequestMapping("/getRoleMenuList.do")
	@ResponseBody
	public ModelMap getRoleMenuList(int roleId){
		ModelMap roleMenu=new ModelMap();
		List<Menu> zhuList=menuDao.getZhuMenu();
		for (int i = 0; i < zhuList.size(); i++) {
			RoleMenu zhuMenu=new RoleMenu();
			zhuMenu.setParentId(zhuList.get(i).getId());
			zhuMenu.setRoleid(roleId);
			List<RoleMenu> ziList=roleMenuDao.getRoleZiMenuList(zhuMenu);
			zhuList.get(i).setZiList(ziList);
			roleMenu.addAttribute("roleMenuListSize", zhuList.size());
			roleMenu.addAttribute("roleMenuList", zhuList);
		}
		return roleMenu;
	}
	@RequestMapping("/getRUList.do")
	@ResponseBody
	public List<RoleUser> getRUList(int roleid){
		RoleUser roleUser=new RoleUser();
		roleUser.setRoleid(roleid);
		List<RoleUser> ruList=roleUserDao.getRoleUserList(roleUser);
		return ruList;
	}
	@RequestMapping("/getRoleUserList.do")
	@ResponseBody
	public ModelMap getRoleUserList(int listFlag,int roleid){
		ModelMap roleUserList=new ModelMap();
	
		return roleUserList;
	}
	
	@RequestMapping("/addRole.do")
	public @ResponseBody String addRole(Role role,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addRole.do.......................");
		try {
			role.setAddtime(addtime);
			role.setAddoperator(userSession.getLoginUserName());
			role.setValidflag(1);
			roleDao.add(role);
			message= new Message("true","新增角色成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统角色添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addRole.do.......................添加成功");
		} catch (Exception e) {
			message = new Message("false","新增角色失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统角色添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addRole.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getRoleUpdate.do")
	public String getRoleUpdate(int id,int menuid,ModelMap model) throws Exception{
		System.out.println("getRoleUpdate.do.................");
		model.addAttribute("menuid",menuid);
		Role role=roleDao.getById(id);
		model.addAttribute("role",role);
		return "/jsp/basic/role/updateRole";
	}
	
	@RequestMapping("/updateRole.do")
	public @ResponseBody String updateRole(Role role,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateRole.do.......................");
		try {
			roleDao.update(role);
			message= new Message("true","修改角色成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统角色修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateRole.do.......................修改成功");
		} catch (Exception e) {
			message = new Message("false","修改角色失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统角色修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateRole.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelRole.do")
	public @ResponseBody String cancelRole(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelRole.do.......................");
		try {
			roleDao.cancel(id);
			message= new Message("true","删除角色成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统角色删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelRole.do.......................删除成功");
		} catch (Exception e) {
			message = new Message("false","删除角色失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统角色删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelRole.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/setRoleMenu.do")
	public @ResponseBody String setRoleMenu(int roleId,int menuid,String checkList,String noCheckList,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("setRoleMenu.do.......................");
	
		try {
			
			String[] noCheckStrings=noCheckList.split(",");
			if(!checkList.equals("")){
			JSONArray array=JSONObject.fromObject(checkList).getJSONArray("change");
			for (int i = 0; i < array.size(); i++) {
				JSONObject object=(JSONObject) array.get(i);
				RoleMenu roleMenu=(RoleMenu) JSONObject.toBean(object,RoleMenu.class);				
				roleMenu.setValidflag(1);
				roleMenu.setRoleid(roleId);
			   int findId=roleMenuDao.find(roleMenu);
				if(findId>0){
					roleMenu.setId(findId);
					roleMenuDao.update(roleMenu);
				}else{
					roleMenu.setAddtime(addtime);
					roleMenu.setAddoperator(userSession.getLoginUserName());
					roleMenuDao.add(roleMenu);
				}
			}
			}
		
			if(!noCheckList.equals("")){
				for (int i = 0; i < noCheckStrings.length; i++) {
					RoleMenu roleMenu=new RoleMenu();
					roleMenu.setValidflag(0);
					roleMenu.setRoleid(roleId);
					roleMenu.setMenuid(Integer.parseInt(noCheckStrings[i]));
					roleMenu.setButtons("");
					int findId=roleMenuDao.find(roleMenu);
					if(findId>0){
						roleMenu.setId(findId);
						roleMenuDao.update(roleMenu);
					}else{
						roleMenu.setButtons("");
						roleMenu.setAddtime(addtime);
						roleMenu.setAddoperator(userSession.getLoginUserName());
						roleMenuDao.add(roleMenu);
					}
				}
			}
			
			message= new Message("true","角色权限设置成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "角色权限设置", userSession.getLoginUserName(), addtime, "设置成功", "");
			System.out.println("setRoleMenu.do.......................设置成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","角色权限设置失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "角色权限设置", userSession.getLoginUserName(), addtime, "设置失败", "");
			System.out.println("setRoleMenu.do.......................设置失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/addRoleUser.do")
	public @ResponseBody String addRoleUser(int roleid,int menuid,String useridStr,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addRoleUser.do.......................");
		System.out.println("useridStr.do......................."+useridStr);
		try {
			String[] useridStrings=useridStr.split(",");
			
			if(!useridStr.equals("")){
				for (int i = 0; i < useridStrings.length; i++) {
					RoleUser roleUser=new RoleUser();
					roleUser.setValidflag(1);
					roleUser.setRoleid(roleid);
					roleUser.setUserid(Integer.parseInt(useridStrings[i]));
					int findId=roleUserDao.find(roleUser);
					if(findId>0){
						roleUser.setId(findId);
						roleUserDao.update(roleUser);
					}else{
						roleUser.setAddtime(addtime);
						roleUser.setAddoperator(userSession.getLoginUserName());
						roleUserDao.add(roleUser);
					}
				}
			}
			
			message= new Message("true","角色用户配置成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "角色用户配置", userSession.getLoginUserName(), addtime, "配置成功", "");
			System.out.println("addRoleUser.do.......................配置成功");
		} catch (Exception e) {
			message = new Message("false","角色用户配置失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "角色用户配置", userSession.getLoginUserName(), addtime, "配置失败", "");
			System.out.println("addRoleUser.do.......................配置失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelRoleUser.do")
	public @ResponseBody String cancelRoleUser(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelRoleUser.do.......................");
		try {
			roleUserDao.cancel(id);
			message= new Message("true","删除角色用户成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "角色用户删除", userSession.getLoginUserName(), addtime, "用户删除成功", "");
			System.out.println("cancelRoleUser.do.......................删除成功");
		} catch (Exception e) {
			message = new Message("false","删除角色失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "角色用户删除", userSession.getLoginUserName(), addtime, "用户删除失败", "");
			System.out.println("cancelRoleUser.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getRoleJSON.do")
	public ModelAndView getRoleJSON(){
		ModelAndView view = new ModelAndView(JsonView.instance);
		Role role=new Role();
		role.setId(1);
		List<Role> resultList = roleDao.getRoleList(role);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<resultList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(resultList.get(i).getRolename());
			sm.setValue(String.valueOf(resultList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	@RequestMapping("/findMenuButtons.do")
	@ResponseBody
	public Map<String,Object> findMenuButtons(RoleMenu roleMenu){
		roleMenu = roleMenuDao.findMenuButtons(roleMenu);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("roleMenu", roleMenu);
		return result;
	}
}

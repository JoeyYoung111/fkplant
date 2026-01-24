package com.szrj.business.web;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.Md5Util;
import com.aladdin.util.TreeSelect;
import com.aladdin.web.JsonView;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;


import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.MenuDao;
import com.szrj.business.dao.RoleMenuDao;
import com.szrj.business.dao.RoleUserDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Menu;
import com.szrj.business.model.RoleMenu;
import com.szrj.business.model.RoleUser;
import com.szrj.business.model.User;

@Controller
@SessionAttributes("userSession")
public class UserController {
	@Autowired
	private UserDao userDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private BasicMsgDao basicMsgDao;
   @Autowired
	private RoleUserDao roleUserDao;
   @Autowired
	private RoleMenuDao roleMenuDao;
	
	@RequestMapping("/toPageindex.do")
	public String toPageindex(ModelMap model,@ModelAttribute("userSession")UserSession userSession){
	
		System.out.println("登录成功，查询菜单==========");
		/*
		 * 1.查询当前用户拥有的主菜单
		 * 2.查询当前用户拥有的子菜单
		 * 3.查询当前用户系统皮肤颜色
		 * */
		/*-------1.查询当前用户拥有的主菜单-------*/
	
		List<Menu> menuZhuTemp=menuDao.getRoleZhuMenu(userSession.getLoginUserID());
		for(int i=0;i<menuZhuTemp.size();i++){
			Menu menu=new Menu();
			menu.setId(userSession.getLoginUserID());
			menu.setParentid(menuZhuTemp.get(i).getId());
			List<Menu> ziList = menuDao.getRoleZiMenu(menu);
			menuZhuTemp.get(i).setSublist(ziList);
			model.addAttribute("menuListSize", menuZhuTemp.size());
			model.addAttribute("menuList", menuZhuTemp);
			
		}
		RoleMenu rolemenu=new RoleMenu();
		rolemenu.setRoleid(userSession.getLoginUserRoleid());
		rolemenu.setMenuid(216);
		rolemenu=roleMenuDao.findMenuButtons(rolemenu);
		int count=0;//判断是否有风险人员-综合查询  查看权限
		if(rolemenu!=null&&rolemenu.getValidflag()>0)count=rolemenu.getId();
		int flag=0;
		if(count>0){
			flag=1;
		}else{
			flag=2;
		}
		model.addAttribute("flag", flag);//记录是否存在 风险人员的综合查询按钮
		return "/index";		
	}		
	
	/**
	 * 登录
	 * @author wangting
	 * @param user
	 * @return ModelAndView
	 */
	@RequestMapping("/loginUser.do")
	public ModelAndView loginUser(ServletRequest request,User user,String page){
		System.out.println("系统登录验证。。。。。");
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		ModelAndView view = new ModelAndView(JsonView.instance);
		try {
			boolean shuzi=false;
			if(user.getCardnumber()!=null&&!"".equals(user.getCardnumber())){
				user=userDao.getByCardnumber(user.getCardnumber());
				shuzi=true;
			}
			if(user!=null){
				/*
				 * 1.检查该用户是否存在
				 * 2.检查密码是否正确
				 * 3.如果都对则记录当前登录信息
				 * */
				/*-------1.检查该用户是否存在-------*/
				int i = userDao.getUserInUse(user.getUsercode());		
				System.out.println("系统登录验证。。。。。1111");
				if(i == 0){
					Message message = new Message("false","登录失败，该用户不存在！");
					message.setFlag(-1);
					view.addObject(JsonView.JSON_ROOT, message);
				}else{
					
					/*-------2.检查密码是否正确-------*/
					if(!shuzi){
						Md5Util md5 = new Md5Util();
						user.setUserpassword(md5.md5s(user.getUserpassword()));
					}
					i = userDao.checkUserMsg(user);
					System.out.println("系统登录验证。。。。。22222");
					if(i == 0){
						Message message = new Message("false","登录失败，密码错误！");
						message.setFlag(-1);
						view.addObject(JsonView.JSON_ROOT, message);
					}else{	
						
						/*-------3.如果都对则记录当前登录信息-------*/
						User temp = userDao.getUserByCodeAndPwd(user);	
						System.out.println("系统登录验证。。。。。33333");
						//if(temp.getValidflag()==1){
						//session中依次存放，  账号id、账号、姓名、角色id、部门id、部门名称、角色数据过滤（是/否）、数据过滤字段
						UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
						view.getModelMap().addAttribute("userSession",userSession);
						HttpServletRequest httpRequest = (HttpServletRequest) request;
						HttpSession session = httpRequest.getSession();
						session.setAttribute("LOGIN_SUCCESS", "LOGIN_SUCCESS");
						
						RoleMenu rolemenu=new RoleMenu();
						rolemenu.setRoleid(temp.getRoleid());
						rolemenu.setMenuid(216);
						rolemenu=roleMenuDao.findMenuButtons(rolemenu);
						int count=0;//判断是否有风险人员-综合查询  查看权限
						if(rolemenu!=null&&rolemenu.getValidflag()>0)count=rolemenu.getId();
						Message message = new Message("true","登录成功！");
						if(count>0){
							message.setFlag(1);
						}else{
							message.setFlag(2);
						}
						view.addObject(JsonView.JSON_ROOT, message);
						logDao.recordLog(0, "系统登录", userSession.getLoginUserName(), addtime, "登录成功", "账号："+temp.getUsercode()+" 部门:"+temp.getDepartname());
						//登录成功，生成操作日志
						UserActionLog log = CreateLogXML.AssignUserLog(userSession);
						log.setOperate_Type(0);//0：登录；1：查询；2：新增；3：修改；4：删除
						log.setOperate_Result("1");
						log.setOperate_Name("系统验证登录");
						log.setOperate_Condition("");
						log.setTerminal_ID(request.getRemoteAddr());
						CreateLogXML.UserActionLog(log);
					}
				}
			}else {
				Message message = new Message("false","未查询到账号，请创建领悟账号或维护领悟账号身份证！");
				message.setFlag(-1);
				view.addObject(JsonView.JSON_ROOT, message);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Message message = new Message("false","登录失败，请联系管理员！");
			message.setFlag(-1);
			view.addObject(JsonView.JSON_ROOT, message);
		}
		return view;
	}
	
	/**
	 * 修改密码
	 * @author xuxj
	 * @param user
	 * @param userSession
	 * @return ModelAndView
	 */
	@RequestMapping("/changeUserPWD.do")
	public ModelAndView changeUserPWD(ServletRequest request,User user,@ModelAttribute("userSession")UserSession userSession,String old_userpassword){
		ModelAndView view = new ModelAndView(JsonView.instance);
		Md5Util md5 = new Md5Util();
        user.setUserpassword(md5.md5s(user.getUserpassword()));
        old_userpassword = md5.md5s(old_userpassword);
        try {
			user.setId(userSession.getLoginUserID());
			User olduser=userDao.getById(userSession.getLoginUserID());
			if(old_userpassword.equals(olduser.getUserpassword())){
				int i = userDao.changePWD(user);
				Message message = new Message("true","用户密码修改成功，请重新登录！");
				message.setFlag(i);
				view.addObject(JsonView.JSON_ROOT, message);
				
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");
				log.setOperate_Name("用户修改密码");
				String operate_Condition = "用户ID='"+user.getId()+ "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else{
				Message message = new Message("false","输入的旧密码不正确！");
				message.setFlag(-1);
				view.addObject(JsonView.JSON_ROOT, message);
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("0");
				log.setOperate_Name("用户修改密码");
				String operate_Condition = "用户ID='"+user.getId()+ "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			Message message = new Message("false","用户密码修改失败！");
			message.setFlag(-1);
			view.addObject(JsonView.JSON_ROOT, message);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");
			log.setOperate_Name("用户修改密码");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return view;
	}
	
	@RequestMapping("/resetPWD.do")
	public @ResponseBody String resetPWD(User user,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		Md5Util md5 = new Md5Util();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("resetPWD.do.......................");
        try {
        	user.setUserpassword(md5.md5s(user.getUserpassword()));
			userDao.changePWD(user);
			message= new Message("true","密码重置成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "密码重置", userSession.getLoginUserName(), addtime, "密码重置成功", "");
			System.out.println("resetPWD.do.......................密码重置成功");
		} catch (Exception e) {
			message = new Message("false","密码重置失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "密码重置", userSession.getLoginUserName(), addtime, "密码重置失败", "");
			System.out.println("resetPWD.do.......................密码重置失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/setUserRoles.do")
	public @ResponseBody String setUserRoles(int roleid,String ids,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("setUserRoles.do.......................");
		try {
			String[] idStrings=ids.split(",");
			for (int i = 0; i < idStrings.length; i++) {
				int id=Integer.parseInt(idStrings[i]);
				User user=userDao.getById(id);
				user.setRoleid(roleid);
				userDao.update(user);
				RoleUser roleUser=new RoleUser();
				roleUser.setUserid(user.getId());
				roleUser.setRoleid(user.getRoleid());
				roleUserDao.updateRoleid(roleUser);
			}
			message= new Message("true","批量修改角色成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "批量修改角色", userSession.getLoginUserName(), addtime, "批量修改角色成功", "");
			System.out.println("setUserRoles.do.......................批量修改角色成功");
		} catch (Exception e) {
			message = new Message("false","批量修改角色失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "批量修改角色", userSession.getLoginUserName(), addtime, "批量修改角色失败", "");
			System.out.println("setUserRoles.do.......................批量修改角色失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getUser.do")
	@ResponseBody
	public Map<String,Object>  getUser(User user,NewPageModel pm,int page){
		System.out.println("getUser.do.......................用户列表查询");
		pm.setPageNumber(page);		
		NewPageModel userTemp=userDao.searchUser(user, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", userTemp.getTotal());
	        result.put("data", userTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/addUser.do")
	public @ResponseBody String addUser(String pages,User user,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addUser.do.......................");
		try {
			int i = userDao.getUserInUse(user.getUsercode());
			if(i>0){
				message= new Message("false","系统账号已存在！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "系统账号添加", userSession.getLoginUserName(), addtime, "账号添加失败", "");
				System.out.println("addUser.do.......................添加失败");
			}else{
				user.setAddtime(addtime);
				user.setAddoperator(userSession.getLoginUserName());
				Md5Util md5 = new Md5Util();
				user.setUserpassword(md5.md5s(user.getUserpassword()));
				int a=userDao.add(user);
				RoleUser roleUser=new RoleUser();	
				roleUser.setRoleid(user.getRoleid());
			    roleUser.setUserid(a);
				roleUser.setAddtime(addtime);
				roleUser.setValidflag(1);
				roleUser.setAddoperator(userSession.getLoginUserName());
				roleUserDao.add(roleUser);
				
				message= new Message("true","系统账号添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "系统账号添加", userSession.getLoginUserName(), addtime, "账号添加成功", "");
				System.out.println("addUser.do.......................添加成功");
			}
		} catch (Exception e) {
			message = new Message("false","系统账号添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统账号添加", userSession.getLoginUserName(), addtime, "账号添加失败", "");
			System.out.println("addUser.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getUserUpdate.do")
	public String getUserUpdate(int id,int menuid,ModelMap model,String page) throws Exception{
		System.out.println("getUserUpdate.do.................");
		User user=userDao.getById(id);
		model.addAttribute("user", user);
		model.addAttribute("menuid", menuid);
		String urlString="";
		urlString="/jsp/basic/user/update";
		return urlString;
	}
	
	@RequestMapping("/updateUser.do")
	public @ResponseBody String updateUser(User user,int menuid,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateUser.do.......................");
		try {
			int i = userDao.getUserInUse(user.getUsercode());
			if(i>0&&i!=user.getId()){
				message= new Message("false","系统账号已存在！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "系统账号修改", userSession.getLoginUserName(), addtime, "账号修改失败", "");
				System.out.println("updateUser.do.......................修改失败");
			}else{
				userDao.update(user);
				RoleUser roleUser=new RoleUser();
				roleUser.setUserid(user.getId());
				roleUser.setRoleid(user.getRoleid());
				roleUserDao.updateRoleid(roleUser);
				message= new Message("true","系统账号修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "系统账号修改", userSession.getLoginUserName(), addtime, "账号修改成功", "");
				System.out.println("updateUser.do.......................修改成功");
			}
		} catch (Exception e) {
			message= new Message("false","系统账号修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统账号修改", userSession.getLoginUserName(), addtime, "账号修改失败", "");
			System.out.println("updateUser.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelUser.do")
	public @ResponseBody String cancelUser(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelUser.do.......................");
		try {
			userDao.cancel(id);
			message= new Message("true","系统账号删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统账号删除", userSession.getLoginUserName(), addtime, "账号删除成功", "");
			System.out.println("cancelUser.do.......................删除成功");
		} catch (Exception e) {
			message= new Message("false","系统账号删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统账号删除", userSession.getLoginUserName(), addtime, "账号删除失败", "");
			System.out.println("cancelUser.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/revStop.do")
	public @ResponseBody String revStop(String flag,User user,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());	
		String flagName="";
		if(flag.equals("1")){
			user.setValidflag(2);
			flagName="暂停";
		}else if(flag.equals("2")){
			user.setValidflag(1);
			flagName="启用";
		}
		try {						
			userDao.revStop(user);	
			message= new Message("true","系统账号"+flagName+"成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统账号"+flagName, userSession.getLoginUserName(), addtime, "账号"+flagName+"成功", "");
			
		} catch (Exception e) {
			message= new Message("false","系统账号"+flagName+"失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统账号"+flagName, userSession.getLoginUserName(), addtime, "账号"+flagName+"失败", "");
			
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
	@RequestMapping("/getRoleUser.do")
	public ModelAndView getRoleUser(int roleid) throws Exception{
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<User> user = new ArrayList<User>();
		try{
			user = userDao.getRoleUser(roleid);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		view.addObject(JsonView.JSON_ROOT, user);
		return view;
	}
	
	@RequestMapping("/getUserSession.do")
	@ResponseBody
	public Map<String, Object> getUserSession(@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			System.out.println(userSession);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		result.put("userSession", userSession);
		return result;
	}
	
	@RequestMapping("/getUsersByDepartmentid.do")
	public ModelAndView getUsersByDepartmentid(int departmentid) {
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		List<User> list=new ArrayList<User>();
		try {
			list=userDao.getUsersByDepartmentid(departmentid);
			for(int i=0;i<list.size();i++){
				SelectModel sm = new SelectModel();
				sm.setText(list.get(i).getStaffName());
				sm.setValue(String.valueOf(list.get(i).getId()));
				sm.setMemo(list.get(i).getContactnumber());
				smList.add(sm);
			}
			view.addObject(JsonView.JSON_ROOT, smList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}
	/**
	 * treeselect 使用
	 * @param departmentid
	 * @param response
	 */
	@RequestMapping("/getUsersByDepartidJSON.do")
	 public void  getUsersByDepartidJSON(int departmentid,HttpServletResponse response){
		System.out.println("/getUsersByDepartidJSON.do......................");
		try{
		List<User> bmList=userDao.getUsersByDepartmentid(departmentid);
		List nodes=new ArrayList();
		for (int i = 0; i < bmList.size(); i++) {
		     HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", bmList.get(i).getId());
				tsNode.put("name",bmList.get(i).getStaffName());
				nodes.add(tsNode);
		}
		JSONArray json=new JSONArray();
		 json=JSONArray.fromObject(nodes);
		response.setCharacterEncoding("UTF-8");
		System.out.println("/getUsersByDepartidJSON.do......................="+json.toString());
		response.getWriter().print(json.toString());
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}   
	}
	/**
	 * treeselect 使用
	 * @param departmentid
	 * @param response
	 */
	@RequestMapping("/getUserByIdsJson.do")
	 public void  getUserByIdsJson(String ids,HttpServletResponse response){
		System.out.println("/getUserByIdsJson.do.....................ids="+ids);
		try{
		List<User> bmList=userDao.getUserByIds(ids);
		List nodes=new ArrayList();
		for (int i = 0; i < bmList.size(); i++) {
		     HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", bmList.get(i).getId());
				tsNode.put("name",bmList.get(i).getStaffName());
				nodes.add(tsNode);
		}
		JSONArray json=new JSONArray();
		 json=JSONArray.fromObject(nodes);
		response.setCharacterEncoding("UTF-8");
		System.out.println("/getUserByIdsJson.do......................="+json.toString());
		response.getWriter().print(json.toString());
	} catch (IOException e) {
		e.printStackTrace();
	}   
	}
}

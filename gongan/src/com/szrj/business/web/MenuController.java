package com.szrj.business.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserSession;
import com.aladdin.web.JsonView;

import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.MenuDao;
import com.szrj.business.model.Menu;
import com.szrj.business.model.TreeTableModel;


/**
 * 登录
 * @author xjx
 * @param menu
 * @return ModelAndView
 */
@Controller
@SessionAttributes("userSession")
public class MenuController {
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private LogDao logDao;

	
	@RequestMapping("/getMenu.do")
	@ResponseBody
	public Map<String,Object>  getMenu(Menu menu,NewPageModel pm,int page,String demoReload){
		System.out.println(demoReload);
		menu.setMenuname(demoReload);
		pm.setPageNumber(page);
		System.out.println(pm.getStart());
		NewPageModel menuZhuTemp=menuDao.searchMenu(menu, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", menuZhuTemp.getTotal());
	        result.put("data", menuZhuTemp.getRows().toArray());
	        return result;
}
	@RequestMapping("/getMenuTreeTable.do")
	 @ResponseBody
	 public Map<String,Object>  getMenu3(Menu menu){
		System.out.println("/getMenuTreeTable.do......................");
	  List<Menu> getAllList = menuDao.searchMenu1(menu);
	  TreeTableModel ttm = new TreeTableModel(getAllList);
	   Map<String, Object> result = new HashMap<String, Object>();
	         result.put("code", 0);
	         result.put("count", ttm.getCount());
	         result.put("data", ttm.getData());
	         return result;
	}
	/**
	 * 添加菜单
	 * @author xuxj
	 * @param menu
	 * @param userSession
	 * @return ModelAndView
	 */
	@RequestMapping("/addMenu.do")
	
	public  @ResponseBody String addMenu(Menu menu,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addMenu.do.......................menuid="+menuid);
		try {
			if(menu.getMenutype() == 1){
				menu.setParentid(0);
			}
			menu.setAddtime(addtime);
			menu.setAddoperator(userSession.getLoginUserName());
			menuDao.add(menu);
			message= new Message("true","菜单添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统菜单添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addMenu.do.......................添加成功");
		} catch (Exception e) {
			message = new Message("false","菜单添加失败！");	
			message.setFlag(-1);
			System.out.println("addMenu.do.......................添加失败");
			logDao.recordLog(menuid, "系统菜单添加", userSession.getLoginUserName(), addtime, "添加成功", "");			 		 			
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getMenuAdd.do")
	public String getMenuupdate(Menu menu,int menuid,ModelMap model,String page) throws Exception{	
		System.out.println("getMenuupdate.do.................menuid=");
	    List<String> buttons=menuDao.searchbuttons();
		String url = "";
		url = "/jsp/basic/menutree/add";
		model.addAttribute("buttons",buttons);
		model.addAttribute("menu",menu);
		model.addAttribute("menuid",menuid);
		return url;
	}
	
	
	
	
	@RequestMapping("/getMenuUpdate.do")
	public String getMenuupdate(int id,int menuid,ModelMap model,String page) throws Exception{	
		System.out.println("getMenuupdate.do.................menuid="+menuid);
		Menu   menu = menuDao.getById(id);
		model.addAttribute("menu",menu);
		List<String> buttons=menuDao.searchbuttons();
		model.addAttribute("buttons",buttons);
		String url = "";
		if("update".equals(page)){
		List<Menu> menuList = menuDao.getZhuMenu();
		model.addAttribute("menuList", menuList);		
		model.addAttribute("id",id);
		url = "/jsp/basic/menu/update";
		}else if("updateZhu".equals(page)){
			url = "/jsp/basic/menu/updatezhu";
		}else if("menutree".equals(page)){
			url = "/jsp/basic/menutree/update";
		}
		model.addAttribute("menuid",menuid);
		return url;
	}
	
	/**
	 * 修改
	 * @author xjx
	 * @param menu
	 * @return ModelAndView
	 */
	@RequestMapping("/updateMenu.do")
	public @ResponseBody String updateMenu(Menu menu,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("updateMenu.do.......................menuid="+menuid);
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			menu.setAddtime(addtime);
			menu.setAddoperator(userSession.getLoginUserName());
			int i = menuDao.update(menu);		
			message= new Message("true","数据修改成功！");
			message.setFlag(1);	
			logDao.recordLog(menuid, "系统菜单修改", userSession.getLoginUserName(), addtime, "修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","数据修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统菜单修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	/**
	 * 删除菜单
	 * @author xjx
	 * @param menu
	 * @param userSession
	 * @return ModelAndView
	 */	
@RequestMapping("/cancelMenu.do")
	public  @ResponseBody String cancelMenu(Menu menu,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelMenu.do.......................");
		try {			
			menuDao.cancel(id);
			message= new Message("true","数据删除成功！");
			message.setFlag(1);		
			logDao.recordLog(menuid, "系统菜单删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {			
			 message = new Message("false","数据删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统菜单删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	/**
	 * 以JSON形式返回所有主菜单信息
     * @return ModelAndView
	 */
	@RequestMapping("/getZhuMenuToJSON.do")
	public ModelAndView getZhuMenuToJSON(){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<Menu> menuList = menuDao.getAllZhu();
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<menuList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(menuList.get(i).getMenuname());
			sm.setValue(String.valueOf(menuList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
}
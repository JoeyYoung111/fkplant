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

import com.szrj.business.dao.AppButtonDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.AppButton;
import com.szrj.business.model.TreeTableModel;


/**
 * 登录
 * @author lt
 * @param menu
 * @return ModelAndView
 */
@Controller
@SessionAttributes("userSession")
public class AppButtonController {
	@Autowired
	private AppButtonDao appButtonDao;
	@Autowired
	private LogDao logDao;

	
	@RequestMapping("/searchAppButton.do")
	@ResponseBody
	public Map<String,Object>  searchAppButton(AppButton appButton,NewPageModel pm,int page){
		pm.setPageNumber(page);
		System.out.println(pm.getStart());
		NewPageModel appButtonTemp=appButtonDao.searchAppButton(appButton, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", appButtonTemp.getTotal());
	        result.put("data", appButtonTemp.getRows().toArray());
	        return result;
}
	/**
	 * 添加
	 * @author lt
	 * @param appButton
	 * @param userSession
	 * @return ModelAndView
	 */
	@RequestMapping("/addAppButton.do")
	public  @ResponseBody String addAppButton(AppButton appButton,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			if(appButton.getBtntype() == 1){
				appButton.setParentid(0);
			}
			appButton.setAddtime(addtime);
			appButton.setAddoperator(userSession.getLoginUserName());
			appButtonDao.add(appButton);
			message= new Message("true","移动端按钮添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "移动端按钮添加", userSession.getLoginUserName(), addtime, "添加成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","移动端按钮添加失败！");	
			message.setFlag(-1);
			logDao.recordLog(menuid, "移动端按钮添加", userSession.getLoginUserName(), addtime, "添加成功", "");			 		 			
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 以JSON形式返回所有主按钮信息
     * @return ModelAndView
	 */
	@RequestMapping("/getZhuButtonToJSON.do")
	public ModelAndView getZhuButtonToJSON(){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<AppButton> buttonList = appButtonDao.getZhuButton();
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<buttonList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(buttonList.get(i).getBtnname());
			sm.setValue(String.valueOf(buttonList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	@RequestMapping("/getAppButtonTreeTable.do")
	 @ResponseBody
	 public Map<String,Object>  getAppButtonTreeTable(AppButton appButton){
		System.out.println("/getMenuTreeTable.do......................");
	  List<AppButton> getAllList = appButtonDao.searchAllAppButton(appButton);
	  TreeTableModel ttm = new TreeTableModel(getAllList);
	   Map<String, Object> result = new HashMap<String, Object>();
	         result.put("code", 0);
	         result.put("count", ttm.getCount());
	         result.put("data", ttm.getData());
	         return result;
	}
	
	@RequestMapping("/getAppButtonUpdate.do")
	public String getAppButtonUpdate(int id,int menuid,ModelMap model) throws Exception{
		AppButton appButton = appButtonDao.getById(id);
		model.addAttribute("appButton",appButton);
		List<AppButton> buttonList = appButtonDao.getZhuButton();
		model.addAttribute("buttonList", buttonList);		
		model.addAttribute("id",id);
		model.addAttribute("menuid",menuid);
		return "/jsp/basic/appbutton/update";
	}
	
	@RequestMapping("/updateAppButton.do")
	public @ResponseBody String updateAppButton(AppButton appButton,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("updateMenu.do.......................menuid="+menuid);
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			appButton.setAddtime(addtime);
			appButton.setAddoperator(userSession.getLoginUserName());
			appButtonDao.update(appButton);		
			message= new Message("true","移动端按钮修改成功！");
			message.setFlag(1);	
			logDao.recordLog(menuid, "移动端按钮修改", userSession.getLoginUserName(), addtime, "修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","移动端按钮修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "移动端按钮修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelAppButton.do")
	public  @ResponseBody String cancelAppButton(AppButton appButton,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {			
			appButtonDao.cancel(id);
			message= new Message("true","移动端按钮删除成功！");
			message.setFlag(1);		
			logDao.recordLog(menuid, "移动端按钮删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {			
			 message = new Message("false","移动端按钮删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "移动端按钮删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
}
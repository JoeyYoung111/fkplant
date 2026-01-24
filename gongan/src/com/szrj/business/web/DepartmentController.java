package com.szrj.business.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.TreeSelect;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.Department;
import com.szrj.business.model.TreeTableModel;

@Controller
@SessionAttributes("userSession")
public class DepartmentController {
	@Autowired
	private DepartmentDao	departmentDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getDepartmentTreeTable.do")
	 @ResponseBody
	 public Map<String,Object>  getDepartmentTreeTable(Department department){
		System.out.println("/getDepartmentTreeTable.do......................");
	   List<Department> getAllList = departmentDao.getDepartmentList(department);
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
	@RequestMapping("/addDepartment.do")
	
	public  @ResponseBody String addDepartment(Department department,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addDepartment.do.......................menuid="+menuid);
		try {
			
			department.setAddtime(addtime);
			department.setAddoperator(userSession.getLoginUserName());
			departmentDao.add(department);
			message= new Message("true","系统部门添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "系统部门添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addDepartment.do.......................添加成功");
		} catch (Exception e) {
			message = new Message("false","系统部门添加失败！");	
			message.setFlag(-1);
			System.out.println("addDepartment.do.......................添加失败");
			logDao.recordLog(menuid, "系统部门添加", userSession.getLoginUserName(), addtime, "添加成功", "");			 		 			
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getDepartmentUpdate.do")
	public String getMenuupdate(int id,int menuid,ModelMap model,String page) throws Exception{	
		System.out.println("getDepartmentUpdate.do.................menuid="+menuid);
		Department department = departmentDao.getById(id);
		model.addAttribute("department",department);
		String url = "";
		if("update".equals(page)){
		url = "/jsp/basic/department/update";
		}
		model.addAttribute("menuid",menuid);
		return url;
	}
	
	/**
	 * 修改
	 * @author wangting
	 * @param department
	 * @return ModelAndView
	 */
	@RequestMapping("/updateDepartment.do")
	public @ResponseBody String updateDepartment(Department department,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("updateDepartment.do.......................menuid="+menuid);
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		try {
			department.setUpdatetime(updatetime);
			department.setUpdateoperator(userSession.getLoginUserName());
			int i = departmentDao.update(department);		
			message= new Message("true","数据修改成功！");
			message.setFlag(1);	
			logDao.recordLog(menuid, "系统部门修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","数据修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统部门修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			
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
	@RequestMapping("/cancelDepartment.do")
	public  @ResponseBody String cancelDepartment(Department department,int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelDepartment.do.......................");
		try {			
			departmentDao.cancel(id);
			message= new Message("true","数据删除成功！");
			message.setFlag(1);		
			logDao.recordLog(menuid, "系统部门删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {			
			 message = new Message("false","数据删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "系统部门删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			
		}
		 return JSONObject.fromObject(message).toString();
	}
	//查询全部部门类型查询部门树状结果
	@RequestMapping("/getDepartmentTree.do")
	public void getBasicTypeTree(Department department,HttpServletResponse response){
		try {
			System.out.println("查询数据字典节点getBasicTypeTree=====");
			List<Department> list1=new ArrayList<Department>();
			department.setDeparttype("0");
			list1=departmentDao.getDepartmentList(department);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "departname","departtype", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//可根据部门类型查询部门树状结果
	@RequestMapping("/getDepartmentTreeBytype.do")
	public void getDepartmentTreeBytype(Department department,HttpServletResponse response){
		try {
			System.out.println("getDepartmentTreeBytype=====");
			List<Department> list1=new ArrayList<Department>();
			list1=departmentDao.getDepartmentList(department);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON_New(list1, "departname","departtype", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getAllReceiver.do")
	public void getAllReceiver(Department department,HttpServletResponse response){
		try {
			List<Department> depList = departmentDao.getAllReceiver(department);
			JSONArray json = JSONArray.fromObject(depList);
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().print(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/xiduguanxiaTree.do")
	public ModelAndView xiduguanxiaTree(int departtype){
		ModelAndView view = new ModelAndView(JsonView.instance);
		Department dpmt = new Department();
		dpmt.setDeparttype(departtype+"");
		List<Department> deList = departmentDao.getDepartmentList(dpmt);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<deList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(deList.get(i).getDepartname());
			sm.setValue(deList.get(i).getDepartname());
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT,smList);
		return view;
	}
	
	@RequestMapping("/xiduguanxiaTree2.do")
	public ModelAndView xiduguanxiaTree2(int departtype){
		ModelAndView view = new ModelAndView(JsonView.instance);
		Department dpmt = new Department();
		dpmt.setDeparttype(departtype+"");
		List<Department> deList = departmentDao.getDepartmentList(dpmt);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<deList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(deList.get(i).getDepartname());
			sm.setValue(deList.get(i).getId()+"");
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT,smList);
		return view;
	}
	
	@RequestMapping("/getDeptSelectByParentid.do")
	public ModelAndView getDeptSelectByParentid (int parentid){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<Department> deList = departmentDao.getByParentid(parentid);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<deList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(deList.get(i).getDepartname());
			sm.setValue(deList.get(i).getId()+"");
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT,smList);
		return view;
	}
}

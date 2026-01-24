package com.szrj.business.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.aladdin.util.TreeSelect;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.BasicTypeDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.BasicType;

@Controller
@SessionAttributes("userSession")
public class BasicTypeController {
	@Autowired
	private BasicTypeDao basicTypeDao;
	@Autowired
	private BasicMsgDao	basicMsgDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getBasicTypeTree.do")
	public void getBasicTypeTree(HttpServletResponse response){
		try {
			System.out.println("查询数据字典节点getBasicTypeTree=====");
			List<BasicType> list1=new ArrayList<BasicType>();
			list1=basicTypeDao.getAll();
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "basicTypeName","istree", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 数据字典 左边树状结构
	 * @param response
	 */
	@RequestMapping("/getBasicTypeTree1.do")
	public void getBasicTypeTree1(HttpServletResponse response){
		try {
			System.out.println("查询数据字典节点getBasicTypeTree=====");
			List<BasicType> list1=new ArrayList<BasicType>();
			list1=basicTypeDao.getAll();
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "basicTypeName1","istree", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/getBasicTypeRootTree.do")
	public void getBasicTypeRootTree(HttpServletResponse response){
		try {
			System.out.println("查询数据字典节点getBasicTypeTree=====");
			List<BasicType> list1=new ArrayList<BasicType>();
			list1=basicTypeDao.getAll();
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "basicTypeName","istree","parentid", true,true);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/addBasicType.do")
	public @ResponseBody String addBasicType(BasicType basicType,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addBasicType.do.......................");
		try {
//			int i=basicTypeDao.getTypeNameExit(basicType);
//			if(i>0){
//				message= new Message("false","不能添加相同的名称！");
//				message.setFlag(-1);
//				logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加失败", "");
//				System.out.println("addBasicType.do.......................添加失败");
//			}else{
				basicType.setAddtime(addtime);
				basicType.setAddoperator(userSession.getLoginUserName());
				int validflag=1;
				basicType.setValidflag(validflag);
				basicTypeDao.add(basicType);
				message= new Message("true","数据添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addBasicType.do.......................添加成功");
			//}
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","数据添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addBasicType.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getBasicTypeUpdate.do")
	public String getBasicTypeUpdate(int id,int menuid,ModelMap model) throws Exception{
		System.out.println("getBasicTypeUpdate.do.................");
		model.addAttribute("menuid",menuid);
		BasicType basicType=basicTypeDao.getById(id);
		model.addAttribute("basicType",basicType);
		return "/jsp/basic/msg/updateNode";
	}
	
	@RequestMapping("/updateBasicType.do")
	public @ResponseBody String updateBasicType(BasicType basicType,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updateBasicType.do.......................");
		try {
			int i=basicTypeDao.getTypeNameExit(basicType);
			if(i>0&&i!=basicType.getId()){
				message= new Message("false","不能修改相同的名称！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "数据字典修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
				System.out.println("updateBasicType.do.......................修改失败");
			}else{
				basicType.setAddtime(updatetime);
				basicType.setAddoperator(userSession.getLoginUserName());
				basicTypeDao.update(basicType);
				message= new Message("true","数据修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "数据字典修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updateBasicType.do.......................修改成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","数据修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据字典修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updateBasicType.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelBasicType.do")
	public @ResponseBody String cancelBasicType(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelBasicType.do.......................");
		try {
			List<BasicMsg> bmList=basicMsgDao.getByType(id);
			for (int i = 0; i < bmList.size(); i++) {
				basicMsgDao.cancel(bmList.get(i).getId());
			}
			basicTypeDao.cancel(id);
			message= new Message("true","数据删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "数据删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelBasicType.do.......................删除成功");
		} catch (Exception e) {
			message= new Message("false","数据删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelBasicType.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
}

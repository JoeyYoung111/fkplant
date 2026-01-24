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
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.StringUtil;
import com.aladdin.util.TreeSelect;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.BasicTypeDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.BasicType;
import com.szrj.business.model.Menu;
import com.szrj.business.model.TreeTableModel;
import com.szrj.business.model.User;



@Controller
@SessionAttributes("userSession")
public class BasicMsgController {
	@Autowired
	private BasicMsgDao	basicMsgDao;
	@Autowired
	private BasicTypeDao basicTypeDao;
	@Autowired
	private LogDao logDao;
	
	private StringUtil stringUtil;
	
	@RequestMapping("/getBasicMsg.do")
	@ResponseBody
	public Map<String,Object>  getBasicMsg(BasicMsg basicMsg,NewPageModel pm,int page){
		pm.setPageNumber(page);
		NewPageModel basicMsgTemp=basicMsgDao.searchBasicMsg(basicMsg, pm);
		 Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", basicMsgTemp.getTotal());
	        result.put("data", basicMsgTemp.getRows().toArray());
	        return result;
	}
	/**
	 * selecfromt  selecttree 使用
	 * @param basicType
	 * @param response
	 */
	@RequestMapping("/getbasicMsgJSON.do")
	 public void  getbasicMsgJSON(int basicType,HttpServletResponse response){
		System.out.println("/getbasicMsgJSON.do......................");
		try{
		List<BasicMsg> bmList=basicMsgDao.getByType(basicType);
		JSONArray json=new JSONArray();
		json=TreeSelect.listToTreeSelectJSON(bmList, "basicName","basicType", "parentid", true,false);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(json.toString());
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}   
	}

	/**
	 * 根据字典类型查询基础数据 - 简化版本
	 * 返回 [{basicname: "xxx"}, ...]格式
	 * @param basicType
	 * @return
	 */
	@RequestMapping("/getBasicMsgByType.do")
	@ResponseBody
	public List<Map<String, Object>> getBasicMsgByType(int basicType){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			List<BasicMsg> bmList = basicMsgDao.getByType(basicType);
			for(BasicMsg bm : bmList){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("basicname", bm.getBasicName());
				map.put("id", bm.getId());
				result.add(map);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 根据字典类型查询基础数据 
	 * 返回给select使用value=id text=name
	 * @param basicType
	 * @return
	 */
	@RequestMapping("/getBMByTypeToJSON.do")
	public ModelAndView getBMByTypeToJSON(int basicType){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.getByType(basicType);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(String.valueOf(bmList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	/**
	 * 根据字典类型查询基础数据 
	 * 返回给select使用value=name text=name
	 * @param basicType
	 * @return
	 */
	@RequestMapping("/getBMByTypeToJSON1.do")
	public ModelAndView getBMByTypeToJSON1(int basicType){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.getByType(basicType);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(bmList.get(i).getBasicName());
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}

	/**
	 * 治安人员模块统一数据字典接口
	 * 返回格式：[{value: "xxx", text: "xxx"}, ...]
	 * @param basicType 数据字典类型
	 * @return
	 */
	@RequestMapping("/getZaDictionary.do")
	@ResponseBody
	public List<Map<String, Object>> getZaDictionary(int basicType){
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			List<BasicMsg> bmList = basicMsgDao.getByType(basicType);
			for(BasicMsg bm : bmList){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("value", bm.getBasicName());
				map.put("text", bm.getBasicName());
				result.add(map);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * treetable 展示
	 * @param basicMsg
	 * @return
	 */
	@RequestMapping("/getBasicMsgTreeTable.do")
	 @ResponseBody
	 public Map<String,Object>  getMenu3(BasicMsg basicMsg){
		System.out.println("/getBasicMsgTreeTable.do......................");
	  List<BasicMsg> getAllList = basicMsgDao.getByType(basicMsg.getBasicType());
	  TreeTableModel ttm = new TreeTableModel(getAllList);
	   Map<String, Object> result = new HashMap<String, Object>();
	         result.put("code", 0);
	         result.put("count", ttm.getCount());
	         result.put("data", ttm.getData());
	         return result;
	}
	@RequestMapping("/addBasicMsg.do")
	public @ResponseBody String addBasicMsg(BasicMsg basicMsg,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addBasicMsg.do.......................");
		try {
			int i = basicMsgDao.getBasicNameExit(basicMsg);
			if(i>0){
				message= new Message("false","不能添加相同的名称！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加失败", "");
				System.out.println("addBasicMsg.do.......................添加失败");
			}else{
			basicMsg.setAddtime(addtime);
			basicMsg.setAddoperator(userSession.getLoginUserName());
			int validflag=1;
			basicMsg.setValidflag(validflag);
			basicMsgDao.add(basicMsg);
			message= new Message("true","数据添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addBasicMsg.do.......................添加成功");
			}
			} catch (Exception e) {
				e.printStackTrace();
			message = new Message("false","数据添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据字典添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addBasicMsg.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelBasicMsg.do")
	public @ResponseBody String cancelBasicMsg(int id,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelBasicMsg.do.......................");
		try {
			basicMsgDao.cancel(id);
			message= new Message("true","数据删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "数据字典删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelBasicMsg.do.......................删除成功");
		} catch (Exception e) {
			message= new Message("false","数据删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据字典删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelBasicMsg.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getBasicMsgUpdate.do")
	public String getBasicMsgUpdate(int id,int menuid,ModelMap model,String page) throws Exception{
		System.out.println("getBasicMsgUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		if(page.equals("add")){
			url="/jsp/basic/msg/add";
			BasicType basicType=basicTypeDao.getById(id);//baseType id
			model.addAttribute("basicType",basicType);
			if(basicType.getIsexternal()>0){
				int externalid=basicType.getExternalid();
				List<BasicMsg> msglist=basicMsgDao.getByType(externalid);
				model.addAttribute("msglist",msglist);
				BasicType externalType=basicTypeDao.getById(externalid);
				model.addAttribute("externalname",externalType.getBasicTypeName());
			}
		}else if(page.equals("update")){
			url="/jsp/basic/msg/update";
			BasicMsg basicMsg=basicMsgDao.getById(id);//basicMsg id
			model.addAttribute("basicMsg",basicMsg);
			BasicType basicType=basicTypeDao.getById(basicMsg.getBasicType());//baseType id
			model.addAttribute("basicType",basicType);
			if(basicType.getIsexternal()>0){
				int externalid=basicType.getExternalid();
				List<BasicMsg> msglist=basicMsgDao.getByType(externalid);
				model.addAttribute("msglist",msglist);
				BasicType externalType=basicTypeDao.getById(externalid);
				model.addAttribute("externalname",externalType.getBasicTypeName());
			}

		}else if(page.equals("updateMsgNode")){
			BasicMsg basicMsg=basicMsgDao.getById(id);//basicMsg id
			model.addAttribute("basicMsg",basicMsg);
			url="/jsp/basic/msg/updateMsgNode";
		}
		return url;
	}
	
	@RequestMapping("/updateBasicMsg.do")
	public @ResponseBody String updateBasicMsg(BasicMsg basicMsg,int menuid,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateBasicMsg.do.......................");
		try {
			int i = basicMsgDao.getBasicNameExit(basicMsg);
			if(i>0&&i!=basicMsg.getId()){
				message= new Message("false","不能添加相同的名称！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "数据修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			}else{
				basicMsgDao.update(basicMsg);
				message= new Message("true","数据修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "数据字典修改", userSession.getLoginUserName(), addtime, "修改成功", "");
				System.out.println("updateBasicMsg.do.......................修改成功");
			}
			} catch (Exception e) {
			message= new Message("false","数据修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "数据字典修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateBasicMsg.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getBMById.do")
	public @ResponseBody String getBMById(int id){
		Message message;
		BasicMsg basicMsg = basicMsgDao.getById(id);
		BasicMsg newMsg = basicMsgDao.getById(basicMsg.getParentid());
		message =new Message("true",newMsg.getBasicName());
		message.setFlag(newMsg.getId());
		return JSONObject.fromObject(message).toString();
	}
  /**
   * select 使用
   * @param parentid
   * @return
   */
	@RequestMapping("/getBMByParentIdToJSON.do")
	public ModelAndView getBMByParentIdToJSON(int parentid){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.getBMByParentIdToJSON(parentid);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(String.valueOf(bmList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	@RequestMapping("/getBMByParentBasicNameToJSON.do")
	public ModelAndView getBMByParentBasicNameToJSON(String parentBasicName){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.getBMByParentBasicNameToJSON(parentBasicName);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(String.valueOf(bmList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	@RequestMapping("/getBMByparenttype.do")
	public ModelAndView getBMByparenttype(BasicMsg basicMsg){
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.getBMByparenttype(basicMsg);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(String.valueOf(bmList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	/**
	 * treeselect 使用
	 * @param basicType
	 * @param response
	 */
	@RequestMapping("/getBasicMsgTreeSelect.do")
	 public void  getBasicMsgTreeSelect(int basicType,HttpServletResponse response){
		System.out.println("/getBasicMsgTreeSelect.do.....................basicType="+basicType);
		try{
			List<BasicMsg> bmList=basicMsgDao.getByType(basicType);
		    List nodes=new ArrayList();
		for (int i = 0; i < bmList.size(); i++) {
		     HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", bmList.get(i).getId());
				tsNode.put("name",bmList.get(i).getBasicName());
				nodes.add(tsNode);
		}
			JSONArray json=new JSONArray();
			 json=JSONArray.fromObject(nodes);
			response.setCharacterEncoding("UTF-8");
			System.out.println("/getBasicMsgTreeSelect.do......................="+json.toString());
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
	}
	
	@RequestMapping("/selectChemicalName.do")
	 public ModelAndView selectChemicalName(Integer id,HttpServletResponse response){
		System.out.println("/selectChemicalName.do......................");
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<BasicMsg> bmList=basicMsgDao.selectChemicalName(id);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getBasicName());
			sm.setValue(bmList.get(i).getId()+"");
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
		
	}
	
	@RequestMapping("/getMsgByid.do")
	public void getMsgByid(Integer parentid,HttpServletResponse response){
		try {
			HashMap<String,Object> map=new HashMap<String,Object>();
    		map.put("parrentId", parentid);
			String idString = basicMsgDao.basicMsgQueryChildren(map);
			List<BasicMsg> bmList=basicMsgDao.getMsgByid(idString);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON_New(bmList, "basicName","validflag", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

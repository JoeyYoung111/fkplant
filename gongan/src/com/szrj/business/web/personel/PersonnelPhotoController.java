package com.szrj.business.web.personel;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TreeSelect;
import com.aladdin.web.JsonView;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.PersonnelPhotoDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.BasicType;
import com.szrj.business.model.Menu;
import com.szrj.business.model.Role;
import com.szrj.business.model.TreeTableModel;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.CustomLabel;
import com.szrj.business.model.personel.PersonLabel;
import com.szrj.business.model.personel.PersonnelPhoto;
import com.szrj.business.model.personel.RelationBank;
import com.szrj.business.model.personel.WenGrade;
import com.szrj.business.model.personel.WenJointControlLevel;

@Controller
@SessionAttributes("userSession")
public class PersonnelPhotoController {
	@Autowired
	private PersonnelPhotoDao photoDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private LogDao logDao;
	

	@RequestMapping("/getPersonnelPhotoFlowList.do")
	@ResponseBody
	public Map<String,Object> getPersonnelPhotoFlowList(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/getPersonnelPhotoFlowList.do------------------------");
		List<PersonnelPhoto> list=photoDao.getByPersonnelid(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("count", list.size());
        result.put("photos", list);
        //生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询涉黑人员");
		String operate_Condition = "";
		operate_Condition += "人员id = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
        return result;
	}
	
	@RequestMapping("/addPersonnelPhoto.do")
	public @ResponseBody String addPersonnelPhoto(PersonnelPhoto personnelPhoto,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPersonnelPhoto.do.......................");
		try {
			personnelPhoto.setValidflag(1);
			personnelPhoto.setAddoperator(userSession.getLoginUserName());
			personnelPhoto.setAddtime(addtime);
			photoDao.add(personnelPhoto);
			message = new Message("true","风险人员照片上传成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员照片上传", userSession.getLoginUserName(), addtime, "上传成功", "");
			System.out.println("addPersonnelPhoto.do.......................上传成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("风险人员照片上传");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","风险人员照片上传失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员照片上传", userSession.getLoginUserName(), addtime, "上传失败", "");
			System.out.println("addPersonnelPhoto.do.......................上传失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("风险人员照片上传");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updatePersonnelPhoto.do")
	public @ResponseBody String updatePersonnelPhoto(int id,int defaultid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatePersonnelPhoto.do.......................");
		try {
			PersonnelPhoto photo=photoDao.getById(id);
			photo.setDefaultflag(1);
			photo.setUpdateoperator(userSession.getLoginUserName());
			photo.setUpdatetime(addtime);
			photoDao.update(photo);
			
			if(defaultid>0){
				PersonnelPhoto defaultPhoto=photoDao.getById(defaultid);
				defaultPhoto.setDefaultflag(0);
				defaultPhoto.setUpdateoperator(userSession.getLoginUserName());
				defaultPhoto.setUpdatetime(addtime);
				photoDao.update(defaultPhoto);
			}
			
			message = new Message("true","默认照片设置成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "默认照片设置", userSession.getLoginUserName(), addtime, "设置成功", "");
			System.out.println("updatePersonnelPhoto.do.......................设置成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("默认照片设置");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","默认照片设置失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "默认照片设置", userSession.getLoginUserName(), addtime, "设置失败", "");
			System.out.println("updatePersonnelPhoto.do.......................设置失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("默认照片设置");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelPersonnelPhoto.do")
	public @ResponseBody String cancelPersonnelPhoto(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPersonnelPhoto.do.......................");
		try {
			photoDao.cancel(id);
			
			message = new Message("true","照片删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "照片删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPersonnelPhoto.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除照片");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","照片删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "照片删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPersonnelPhoto.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除照片");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  *********************************************************************风险人员 人员属性标签***************************************************************  **/
	@RequestMapping("/getAttributeLabelTree.do")
	@ResponseBody
	public Map<String,Object> getAttributeLabelTree(AttributeLabel attributelabel,HttpServletResponse response){
		  List<AttributeLabel> getAllList = personnelDao.searchAttributeLabel();
		  TreeTableModel ttm = new TreeTableModel(getAllList);
		   Map<String, Object> result = new HashMap<String, Object>();
		         result.put("code", 0);
		         result.put("count", ttm.getCount());
		         result.put("data", ttm.getData());
		         return result;
	}
	
	@RequestMapping("/getAttributeLabelTreeByparentid.do")
	@ResponseBody
	public Map<String,Object> getAttributeLabelTreeByparentid(AttributeLabel attributelabel,HttpServletResponse response){
		System.out.println("getAttributeLabelTreeByparentid.do.......................");
		  List<AttributeLabel> getAllList = personnelDao.getChildrenLabelByParentid(attributelabel.getParentid());
		  TreeTableModel ttm = new TreeTableModel(getAllList);
		   Map<String, Object> result = new HashMap<String, Object>();
		         result.put("code", 0);
		         result.put("count", ttm.getCount());
		         result.put("data", ttm.getData());
		         return result;
	}
	@RequestMapping("/getAttributeLabelTreeByparentid1.do")
	@ResponseBody
	public Map<String,Object> getAttributeLabelTreeByparentid1(AttributeLabel attributelabel,int isfilter,@ModelAttribute("userSession")UserSession userSession,HttpServletResponse response){
		System.out.println("getAttributeLabelTreeByparentid.do.......................");
		 List<AttributeLabel> getAllList=new ArrayList();
		if(attributelabel.getExamineflag()==-1){//查询全部
			  getAllList = personnelDao.getChildrenLabelByParentid1(attributelabel.getParentid());
			
		}else{//只查询未审核标签
			if(isfilter==0){//不过滤责任部门
				attributelabel.setDepartmentid("0");
			}else{
				attributelabel.setDepartmentid(userSession.getLoginUserDepartmentid()+"");
			}
			String ids=personnelDao.getAttributeLabelnoexamine(attributelabel);	//查询未审核标签
		    System.out.println("ids======"+ids);
		    String parentids="";
		    StringBuffer allparentids=new StringBuffer();
		    if(ids!=null&&ids!=""){
		    	String[] id=ids.split(",");
		    	for(int i=0;i<id.length;i++){
		    		 HashMap<String,Object> map=new HashMap<String,Object>();
		    		 map.put("id", id[i]);
		    	   	 parentids=personnelDao.selectParentIds(map)+",";
		    	   	 allparentids.append(parentids);
		    		
		    	}
		    	getAllList=personnelDao.getAttributeLabelbyids(allparentids.toString().substring(0,allparentids.toString().length()-1));
		    }
		}
		
		TreeTableModel ttm = new TreeTableModel(getAllList);
		   Map<String, Object> result = new HashMap<String, Object>();
		   result.put("code", 0);
		   result.put("count", ttm.getCount());
		   result.put("data", ttm.getData());
		   return result;
	}
	@RequestMapping("/getCustomLabelTreeSelect.do")
	public void getAttributeLabelTreeSelect(HttpServletResponse response){
		try {
			System.out.println("getCustomLabelTree=====");
			List<AttributeLabel> list1=new ArrayList<AttributeLabel>();
			list1=  personnelDao.searchAllAttributeLabel();
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "attributelabel","","parentid", true,true);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/addattributelabel.do")
	public @ResponseBody String addattributelabel(AttributeLabel attributelabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addpersonlabel.do.......................");
		try {
			attributelabel.setValidflag(1);
			attributelabel.setAddoperator(userSession.getLoginUserName());
			attributelabel.setAddoperatorid(userSession.getLoginUserID());
			attributelabel.setAdddepartmentid(userSession.getLoginUserDepartmentid());
			attributelabel.setAddtime(addtime);
			int newId = personnelDao.addattributelabel(attributelabel);
			
			/**
			 * 调http接口 package com.szrj.business.web.inferfaces.SendChat
			 * http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp
			 * formId 发送人
			 * tolds 接收人 用,隔开
			 * content 发送内容
			 */
			String formId = userSession.getLoginUserCode();//第一参数 formId 发送人
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("id", newId+"");
			String parentidsList=personnelDao.selectParentIds(map);

			Integer parentid = Integer.parseInt(parentidsList.substring(parentidsList.lastIndexOf(",")+1));//rootID
		    
			attributelabel.setRootid(parentid);//給AttributeLabel加上rootid
			personnelDao.updaterootid(attributelabel);
			
			
			String toIds = personnelDao.getUserCodeForSendChat(parentid);//第二参数 tolds 接收人 用,隔开
			
			
			if(attributelabel.getExamineflag()==0){
				HashMap<String,Object> map1=new HashMap<String,Object>();
				
				
				String content = personnelDao.getContentSendChat(newId);
				map1.put("event", content);
	            content = new String(URLEncoder.encode(content, "UTF-8").getBytes());
				
				String param="fromId="+userSession.getLoginUserCode()+"&toIds="+toIds+"&content="+content;
				String url = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param;
				
				SendChat sendchat=new SendChat();
				String result=sendchat.doHttpGet(url);
				System.out.println("领悟消息中心接口发送========"+result);
				
				map1.put("user_tag", formId);//发送人
				map1.put("jsf_tag", toIds);//接受人
				String parame=JSONObject.fromObject(map1).toString();
				System.out.println("方正消息中心接口参数========parame="+parame);
				//String fzresult=sendchat.doHttpPost("http://50.66.189.145:9014/api/szsh/saveSzshSjNotFj", parame);//测试
				String fzresult=sendchat.doHttpPost("http://50.64.128.56:9004/api/szsh/saveSzshSjNotFj", parame);
				System.out.println("方正消息中心接口发送========fzresult="+fzresult);
				
				
			}
			
			
			
			message = new Message("true","人员属性标签-添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员属性标签-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addpersonlabel.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","人员属性标签-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员属性标签-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addpersonlabel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateattributelabel.do")
	public @ResponseBody String updateattributelabel(AttributeLabel attributelabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateattributelabel.do.......................");
		try {
			attributelabel.setUpdateoperator(userSession.getLoginUserName());
			attributelabel.setUpdatetime(addtime);
			personnelDao.updateattributelabel(attributelabel);
			message = new Message("true","人员属性标签-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员属性标签-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatepersonlabel.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签修改");
			String operate_Condition = "";
			operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员属性标签-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员属性标签-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatepersonlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签修改");
			String operate_Condition = "";
			operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelattributelabel.do")
	public @ResponseBody String cancelattributelabel(AttributeLabel attributelabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelattributelabel.do.......................");
		try {
			attributelabel.setUpdateoperator(userSession.getLoginUserName());
			attributelabel.setUpdatetime(addtime);
			personnelDao.cancelattributelabel(attributelabel);
			message = new Message("true","人员属性标签-作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员属性标签-作废", userSession.getLoginUserName(), addtime, "作废成功", "");
			System.out.println("cancelattributelabel.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签作废");
			String operate_Condition = "";
			operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员属性标签-作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员属性标签-作废", userSession.getLoginUserName(), addtime, "作废失败", "");
			System.out.println("cancelattributelabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("人员属性标签作废");
			String operate_Condition = "";
			operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getAttributeLabelByid.do")
	public String getAttributeLabelByid(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid", menuid);
		System.out.println("getAttributeLabelByid.do.................");
		AttributeLabel attributelabel=personnelDao.getAttributeLabelByid(id);
		model.addAttribute("attributelabel", attributelabel);
		String  urlString="/jsp/personel/attributelabel/update";
		return urlString;
	}
	@RequestMapping("/getAttributeLabelByLabelid.do")
	@ResponseBody
	public AttributeLabel getAttributeLabelByLabelid(int id,ModelMap model) throws Exception{
		AttributeLabel attributelabel=personnelDao.getAttributeLabelByid(id);
		if(attributelabel==null)attributelabel=new AttributeLabel();
		return attributelabel;
	}
	
	
	
	@RequestMapping("/examineattributelabel.do")
	public @ResponseBody String examineattributelabel(AttributeLabel attributelabel,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("examineattributelabel.do.......................");
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    attributelabel.setExamineman(userSession.getLoginUserName());
			    attributelabel.setExaminetime(addtime);
			    personnelDao.examineattributelabel(attributelabel);
				message= new Message("true","人员标签-新标签申请审核成功！");
				message.setFlag(1);
				logDao.recordLog(0, "人员标签-新标签申请审核", userSession.getLoginUserName(), addtime, "审核成功", "");
				System.out.println("examineattributelabel.do.......................审核成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("人员标签审核");
				String operate_Condition = "";
				operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","人员标签-新标签申请审核失败！");
			message.setFlag(-1);
			logDao.recordLog(0, "人员标签-新标签申请审核", userSession.getLoginUserName(), addtime, "审核失败", "");
			System.out.println("examineattributelabel.do......................审核失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("人员标签审核");
			String operate_Condition = "";
			operate_Condition += "属性标签id = '" + attributelabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getAttributeLabelByParentid.do")
	@ResponseBody
	public List<AttributeLabel> getAttributeLabelByParentid(){
		List<AttributeLabel> personlabellist=personnelDao.getAttributeLabelByParentid(0);
		return personlabellist;
	}
	
	@RequestMapping("/getAttributeLabelByDepartmentid.do")
	@ResponseBody
	public List<AttributeLabel> getAttributeLabelByDepartmentid(@ModelAttribute("userSession")UserSession userSession){
		AttributeLabel attributelabel=new AttributeLabel();
		attributelabel.setParentid(0);
		attributelabel.setDepartmentid(userSession.getLoginUserDepartmentid()+"");
		int roleid=userSession.getLoginUserRoleid();
		List<AttributeLabel> personlabellist=null;
		if(roleid==1||roleid==41)personlabellist=personnelDao.getAttributeLabelByParentid(0);
		else personlabellist=personnelDao.getAttributeLabelByDepartmentid(attributelabel);
		return personlabellist;
	}
	//根据根节点迭代查询子节点
	@RequestMapping("/getAttributeLabelTreeSelect1.do")
	public void getAttributeLabelTreeSelect1(int parentid,HttpServletResponse response){
		try {
			System.out.println("getAttributeLabelTreeSelect1=====");
			List<AttributeLabel> list1=new ArrayList<AttributeLabel>();
			list1=  personnelDao.getChildrenLabelByParentid1(parentid);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "attributelabel","","parentid", false,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**  *********************************************************************风险人员 警种标签***************************************************************  **/
	@RequestMapping("/searchPersonLabel.do")
	@ResponseBody
	public List<PersonLabel> getRoleList(ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		List<PersonLabel> personlabellist=personnelDao.searchPersonLabel();
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询人员类型标签");
		String operate_Condition = "";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return personlabellist;
	}
	@RequestMapping("/addpersonlabel.do")
	public @ResponseBody String addpersonlabel(PersonLabel personlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addpersonlabel.do.......................");
		try {
			personlabel.setValidflag(1);
			personlabel.setAddoperator(userSession.getLoginUserName());
			personlabel.setAddtime(addtime);
			personnelDao.addpersonlabel(personlabel);
			message = new Message("true","人员类型标签-添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addpersonlabel.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加人员类型标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","人员类型标签-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addpersonlabel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加人员类型标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updatepersonlabel.do")
	public @ResponseBody String updatepersonlabel(PersonLabel personlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatepersonlabel.do.......................");
		try {
			personlabel.setUpdateoperator(userSession.getLoginUserName());
			personlabel.setUpdatetime(addtime);
			personnelDao.updatepersonlabel(personlabel);
			message = new Message("true","人员类型标签-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatepersonlabel.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改人员类型标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员类型标签-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatepersonlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改人员类型标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelpersonlabel.do")
	public @ResponseBody String cancelpersonlabel(PersonLabel personlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelpersonlabel.do.......................");
		try {
			personlabel.setUpdateoperator(userSession.getLoginUserName());
			personlabel.setUpdatetime(addtime);
			personnelDao.cancelpersonlabel(personlabel);
			message = new Message("true","人员类型标签-作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-作废", userSession.getLoginUserName(), addtime, "作废成功", "");
			System.out.println("cancelpersonlabel.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("作废人员类型标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员类型标签-作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-作废", userSession.getLoginUserName(), addtime, "作废失败", "");
			System.out.println("cancelpersonlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("作废人员类型标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getPersonLabelByid.do")
	public String getPersonLabelByid(int id,int menuid,String page,ModelMap model) throws Exception{
		model.addAttribute("menuid", menuid);
		System.out.println("getPersonLabelByid.do.................page="+page);
		PersonLabel personlabel=personnelDao.getPersonLabelByid(id);
		model.addAttribute("personlabel", personlabel);
		String  urlString="/jsp/personel/personlabel/update";
		if(page.equals("attributelabels")){
			urlString="/jsp/personel/personlabel/attributelabels";
		}
		return urlString;
	}
	
	@RequestMapping("/getAttributelabels.do")
	public ModelAndView getRoleUser(int personlabelid) throws Exception{
		ModelAndView view = new ModelAndView(JsonView.instance);
		List<AttributeLabel> attributelabellist = new ArrayList<AttributeLabel>();
		try{
			PersonLabel personlabel=personnelDao.getPersonLabelByid(personlabelid);//获得已配置人员属性标签名称
			if(personlabel.getAttributelabels()==null || personlabel.getAttributelabels().equals("")){
				
			}else{
				attributelabellist = personnelDao.getAttributeLabelByids(personlabel.getAttributelabels());
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		view.addObject(JsonView.JSON_ROOT, attributelabellist);
		return view;
	}
	//删除警种配置人员属性标签
	@RequestMapping("/deleteAttributelabels.do")
	public @ResponseBody String deleteAttributelabels(PersonLabel personlabel,int attributelabelid, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("deleteAttributelabels.do.......................");
		try {
			personlabel=personnelDao.getPersonLabelByid(personlabel.getId());
			String[] labelstr=personlabel.getAttributelabels().split(",");
			int[] labelint=new int[labelstr.length];
			for (int i = 0; i < labelstr.length; i++) {
				labelint[i]=Integer.parseInt(labelstr[i]);
			}
			Arrays.sort(labelint);//数组排序
			int labelindex=Arrays.binarySearch(labelint,attributelabelid);//attributelabelid-要删除的人员属性id
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex){
					if(newlabel!="")newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			System.out.println("deleteAttributelabels.do......................newlabel="+newlabel);
			personlabel.setAttributelabels(newlabel);
			personlabel.setUpdateoperator(userSession.getLoginUserName());
			personlabel.setUpdatetime(addtime);
			personnelDao.updateattributelabels(personlabel);
			message = new Message("true","人员类型标签-人员属性标签作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-人员属性标签作废", userSession.getLoginUserName(), addtime, "作废成功", "");
			System.out.println("cancelpersonlabel.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除警种配置人员属性标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员类型标签-人员属性标签作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-人员属性标签作废", userSession.getLoginUserName(), addtime, "作废失败", "");
			System.out.println("cancelpersonlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除警种配置人员属性标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	//更新警种配置人员属性标签
	@RequestMapping("/updateAttributelabels.do")
	public @ResponseBody String updateAttributelabels(PersonLabel personlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateAttributelabels.do.......................");
		try {
			
			personlabel.setUpdateoperator(userSession.getLoginUserName());
			personlabel.setUpdatetime(addtime);
			personnelDao.updateattributelabels(personlabel);
			message = new Message("true","人员类型标签-人员属性标签修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-人员属性标签修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateAttributelabels.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("更新警种配置人员属性标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","人员类型标签-人员属性标签修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-人员属性标签修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateAttributelabels.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("更新警种配置人员属性标签");
			String operate_Condition = "";
			operate_Condition += "人员类型标签id = '" + personlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * formSelects 使用
	 * @param departmentid
	 * @param response
	 */
	@RequestMapping("/getAttributelabelsByidJSON.do")
	 public void  getAttributelabelsByidJSON(int id,HttpServletResponse response){
		System.out.println("/getAttributelabelsByidJSON.do......................");
		try{
		PersonLabel personlabel=personnelDao.getPersonLabelByid(id);
		List<AttributeLabel> attributelabellist = personnelDao.getAttributeLabelByids(personlabel.getAttributelabels());
		List nodes=new ArrayList();
		for (int i = 0; i < attributelabellist.size(); i++) {
		     HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", attributelabellist.get(i).getId());
				tsNode.put("name",attributelabellist.get(i).getAttributelabel());
				nodes.add(tsNode);
		}
		JSONArray json=new JSONArray();
		 json=JSONArray.fromObject(nodes);
		response.setCharacterEncoding("UTF-8");
		System.out.println("/getAttributelabelsByidJSON.do......................="+json.toString());
		response.getWriter().print(json.toString());
	} catch (IOException e) {
		e.printStackTrace();
	}   
	}
	
	
	 /**  *********************************************************************风险人员 人员工作标签***************************************************************  **/	
	@RequestMapping("/getCustomLabelTreeTable.do")
	 @ResponseBody
	 public Map<String,Object>  getCustomLabelTreeTable(CustomLabel customlabel){
		System.out.println("/getCustomLabelTreeTable.do......................");
	  List<CustomLabel> customlabelList = personnelDao.searchCustomLabel(customlabel);
	  TreeTableModel ttm = new TreeTableModel(customlabelList);
	   Map<String, Object> result = new HashMap<String, Object>();
	         result.put("code", 0);
	         result.put("count", ttm.getCount());
	         result.put("data", ttm.getData());
	         return result;
	}
	@RequestMapping("/getCustomLabelTree.do")
	public void getCustomLabelTree(CustomLabel customlabel,HttpServletResponse response){
		try {
			System.out.println("getCustomLabelTree=====");
			List<CustomLabel> list1=new ArrayList<CustomLabel>();
			list1= personnelDao.searchCustomLabel(customlabel);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "customlabel","","parentid", true,true);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/getCustomLabelTagtree.do")
	public void getCustomLabelTagtree(CustomLabel customlabel,HttpServletResponse response){
		try {
			System.out.println("getCustomLabelTree=====");
			List<CustomLabel> list1=new ArrayList<CustomLabel>();
			list1= personnelDao.searchCustomLabel(customlabel);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTagtreeJSON(list1,"customlabel","parentid");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/addcustomlabel.do")
	public @ResponseBody String addcustomlabel(CustomLabel customlabel,int menuid,@ModelAttribute("userSession")UserSession userSession,ServletRequest request){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addcustomlabel.do.......................");
		try {
			customlabel.setValidflag(1);
			customlabel.setAddoperator(userSession.getLoginUserName());
			customlabel.setAddtime(addtime);
			personnelDao.addcustomlabel(customlabel);
			message = new Message("true","自定义标签-添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addcustomlabel.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("自定义标签添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","自定义标签-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addcustomlabel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("自定义标签添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getCustomLabelByid.do")
	public String getCustomLabelByid(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid", menuid);
		System.out.println("getCustomLabelByid.do.................");
		CustomLabel customlabel=personnelDao.getCustomLabelByid(id);
		model.addAttribute("customlabel", customlabel);
		String  urlString="/jsp/personel/customlabel/update";
		return urlString;
	}
	
	@RequestMapping("/updatecustomlabel.do")
	public @ResponseBody String updatecustomlabel(CustomLabel customlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatecustomlabel.do.......................");
		try {
			customlabel.setUpdateoperator(userSession.getLoginUserName());
			customlabel.setUpdatetime(addtime);
			personnelDao.updatecustomlabel(customlabel);
			message = new Message("true","自定义标签-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatecustomlabel.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("自定义标签修改");
			String operate_Condition = "";
			operate_Condition += "自定义标签id = '" + customlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","自定义标签-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatecustomlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("自定义标签修改");
			String operate_Condition = "";
			operate_Condition += "自定义标签id = '" + customlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelcustomlabel.do")
	public @ResponseBody String cancelcustomlabel(CustomLabel customlabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelcustomlabel.do.......................");
		try {
			customlabel.setUpdateoperator(userSession.getLoginUserName());
			customlabel.setUpdatetime(addtime);
			personnelDao.cancelcustomlabel(customlabel);
			message = new Message("true","自定义标签-作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-作废", userSession.getLoginUserName(), addtime, "作废成功", "");
			System.out.println("cancelcustomlabel.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("自定义标签作废");
			String operate_Condition = "";
			operate_Condition += "自定义标签id = '" + customlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","自定义标签-作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员类型标签-自定义标签-作废", userSession.getLoginUserName(), addtime, "作废失败", "");
			System.out.println("cancelcustomlabel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("自定义标签作废");
			String operate_Condition = "";
			operate_Condition += "自定义标签id = '" + customlabel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
}

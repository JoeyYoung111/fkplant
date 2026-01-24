package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletRequest;
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
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.personel.JointControlRecordDao;
import com.szrj.business.dao.personel.WenVisitDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Log;
import com.szrj.business.model.personel.JointControlRecord;
import com.szrj.business.model.personel.WenVisit;

@Controller
@SessionAttributes("userSession")
public class WenVisitController {
	@Autowired
	private WenVisitDao wenVisitDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private JointControlRecordDao jointControlRecordDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchWenVisit.do")
	@ResponseBody
	public Map<String,Object> searchWenVisit(WenVisit wenVisit,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=wenVisitDao.searchWenVisit(wenVisit, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉访涉诉经历");
			String operate_Condition = "";
			if(wenVisit.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + wenVisit.getPersonnelid() + "'";
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询涉访涉诉经历");
			String operate_Condition = "";
			if(wenVisit.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + wenVisit.getPersonnelid() + "'";
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/getWenVisitUpdate.do")
	public String getWenVisitUpdate(WenVisit visit,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getWenVisitUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		
		List<BasicMsg> activitytype=basicMsgDao.getByType(25);//涉稳-行为活动类别
		model.addAttribute("activitytype",activitytype);
		
		List<BasicMsg> nodename=basicMsgDao.getByType(77);//涉稳-敏感节点名称
		model.addAttribute("nodename",nodename);
		
		List<BasicMsg> relatedplace=basicMsgDao.getByType(26);//涉稳-行为活动涉及场所
		model.addAttribute("relatedplace",relatedplace);
		
		List<BasicMsg> activityform_show=basicMsgDao.getByType(79);//涉稳-行为活动具体形式-表示方式
		model.addAttribute("activityform_show",activityform_show);
		List<BasicMsg> activityform_disturb=basicMsgDao.getByType(80);//涉稳-行为活动具体形式-扰乱秩序行为
		model.addAttribute("activityform_disturb",activityform_disturb);
		
		List<BasicMsg> activitything=basicMsgDao.getByType(28);//涉稳-行为活动携带物品
		model.addAttribute("activitything",activitything);
		
		List<BasicMsg> handleresult=basicMsgDao.getByType(29);//涉稳-现场处置结果情况
		model.addAttribute("handleresult",handleresult);
		
		List<BasicMsg> returnvehicle=basicMsgDao.getByType(73);//涉稳-行为人员返回使用交通工具
		model.addAttribute("returnvehicle",returnvehicle);
		
		if (page.equals("add")) {
			model.addAttribute("personnelid",visit.getPersonnelid());
			url="/jsp/personel/wen/visit/add";
		}else if(page.equals("update")){
			WenVisit wenVisit=wenVisitDao.getById(visit.getId());
			model.addAttribute("wenVisit",wenVisit);
			url="/jsp/personel/wen/visit/update";
		}else if(page.equals("showinfo")){
			WenVisit wenVisit=wenVisitDao.getById(visit.getId());
			model.addAttribute("wenVisit",wenVisit);
			url="/jsp/personel/wen/visit/showinfo";
		}
		return url;
	}
	
	@RequestMapping("/addWenVisit.do")
	public @ResponseBody String addWenVisit(WenVisit wenVisit,int jointcontrolid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addWenVisit.do.......................");
		try {
			wenVisit.setAddoperator(userSession.getLoginUserName());
			wenVisit.setAddtime(addtime);
			wenVisit.setValidflag(1);
			int wenvisitid=wenVisitDao.add(wenVisit);
			
			if(jointcontrolid>0){
				JointControlRecord jointControlRecord=new JointControlRecord();
				jointControlRecord.setId(jointcontrolid);
				jointControlRecord.setWenvisitid(wenvisitid);
				jointControlRecordDao.updateWenVisit(jointControlRecord);
			}
			
			message = new Message("true","涉稳人员-涉诉涉访经历添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-涉诉涉访经历添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addWenVisit.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加涉访涉诉经历");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-涉诉涉访经历添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-涉诉涉访经历添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addWenVisit.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉访涉诉经历");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateWenVisit.do")
	public @ResponseBody String updateWenVisit(WenVisit wenVisit,int jointcontrolid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateWenVisit.do.......................");
		try {
			wenVisit.setUpdateoperator(userSession.getLoginUserName());
			wenVisit.setUpdatetime(addtime);
			int wenvisitid=wenVisit.getId();
			wenVisitDao.update(wenVisit);
			
			if(jointcontrolid>=0)jointControlRecordDao.unlinkWenVisit(wenvisitid);
			
			if(jointcontrolid>0){
				JointControlRecord jointControlRecord=new JointControlRecord();
				jointControlRecord.setId(jointcontrolid);
				jointControlRecord.setWenvisitid(wenvisitid);
				jointControlRecordDao.updateWenVisit(jointControlRecord);
			}
			
			message = new Message("true","涉稳人员-涉诉涉访经历修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-涉诉涉访经历修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateWenVisit.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加涉访涉诉经历");
			String operate_Condition = "";
			operate_Condition += "涉访涉诉经历id = '" + wenVisit.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉诉涉访经历修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "涉诉涉访经历修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateWenVisit.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉访涉诉经历");
			String operate_Condition = "";
			operate_Condition += "涉访涉诉经历id = '" + wenVisit.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelWenVisit.do")
	public @ResponseBody String cancelWenVisit(WenVisit wenVisit,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelWenVisit.do.......................");
		try {
			wenVisit.setUpdateoperator(userSession.getLoginUserName());
			wenVisit.setUpdatetime(addtime);
			wenVisitDao.cancel(wenVisit);
			message = new Message("true","涉稳人员-涉诉涉访经历删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-涉诉涉访经历删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelWenVisit.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除涉访涉诉经历");
			String operate_Condition = "";
			operate_Condition += "涉访涉诉经历id = '" + wenVisit.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-涉诉涉访经历删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-涉诉涉访经历删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelWenVisit.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除涉访涉诉经历");
			String operate_Condition = "";
			operate_Condition += "涉访涉诉经历id = '" + wenVisit.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchWenVisit_zfw.do")
	@ResponseBody
	public Map<String,Object> searchWenVisit_zfw(WenVisit wenVisit,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=wenVisitDao.searchWenVisit_zfw(wenVisit, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/getWenVisitUpdate_zfw.do")
	public String getWenVisitUpdate_zfw(WenVisit visit,int menuid,ModelMap model,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		
		List<BasicMsg> activitytype=basicMsgDao.getByType(25);//涉稳-行为活动类别
		model.addAttribute("activitytype",activitytype);
		
		List<BasicMsg> nodename=basicMsgDao.getByType(77);//涉稳-敏感节点名称
		model.addAttribute("nodename",nodename);
		
		List<BasicMsg> relatedplace=basicMsgDao.getByType(26);//涉稳-行为活动涉及场所
		model.addAttribute("relatedplace",relatedplace);
		
		List<BasicMsg> activityform_show=basicMsgDao.getByType(79);//涉稳-行为活动具体形式-表示方式
		model.addAttribute("activityform_show",activityform_show);
		List<BasicMsg> activityform_disturb=basicMsgDao.getByType(80);//涉稳-行为活动具体形式-扰乱秩序行为
		model.addAttribute("activityform_disturb",activityform_disturb);
		
		List<BasicMsg> activitything=basicMsgDao.getByType(28);//涉稳-行为活动携带物品
		model.addAttribute("activitything",activitything);
		
		List<BasicMsg> handleresult=basicMsgDao.getByType(29);//涉稳-现场处置结果情况
		model.addAttribute("handleresult",handleresult);
		
		List<BasicMsg> returnvehicle=basicMsgDao.getByType(73);//涉稳-行为人员返回使用交通工具
		model.addAttribute("returnvehicle",returnvehicle);
		
		WenVisit wenVisit=wenVisitDao.getById_zfw(visit.getId());
		model.addAttribute("wenVisit",wenVisit);
		return "/jsp/personel/wen/visit/showinfo_zfw";
	}
	
	@RequestMapping("/zfwWenVisit_check.do")
	@ResponseBody
	public String zfwWenVisit_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		WenVisit wenVisit=wenVisitDao.getById_zfw(id);
		try {
			wenVisitDao.add(wenVisit);
			wenVisit.setValidflag(2);
			wenVisit.setId(id);
			wenVisitDao.update_zfw(wenVisit);
			message= new Message("true","审查政法委涉访涉诉经历成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险人员-审查政法委涉访涉诉经历");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("涉访涉诉经历id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委涉访涉诉经历失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
}

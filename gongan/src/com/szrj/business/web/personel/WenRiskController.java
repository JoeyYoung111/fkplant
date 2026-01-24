package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.personel.MaintainrateDao;
import com.szrj.business.dao.personel.WenRiskDao;
import com.szrj.business.model.personel.Maintainrate;
import com.szrj.business.model.personel.WenRisk;

@Controller
@SessionAttributes("userSession")
public class WenRiskController {
	@Autowired
	private WenRiskDao wenRiskDao;
	@Autowired
	private MaintainrateDao maintainrateDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getWenRiskByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getWenRiskByPersonnelid(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			WenRisk wenRisk=wenRiskDao.getByPersonnelid(personnelid);
			
			if(wenRisk==null)result.put("firstRisk",0);
			else result.put("firstRisk",1);
			
			result.put("wenRisk",wenRisk);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询风险背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询风险背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/getWenRiskByPersonnelid_zfw.do")
	@ResponseBody
	public Map<String,Object> getWenRiskByPersonnelid_zfw(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			WenRisk wenRisk=wenRiskDao.getByPersonnelid_zfw(personnelid);
			if(wenRisk==null)result.put("firstRisk",0);
			else result.put("firstRisk",1);
			result.put("wenRisk",wenRisk);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/searchWenRisk.do")
	@ResponseBody
	public Map<String,Object> searchWenRisk(WenRisk wenRisk,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=wenRiskDao.searchWenRisk(wenRisk, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询风险背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + wenRisk.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询风险背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + wenRisk.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/addWenRisk.do")
	@ResponseBody
	public String addWenRisk(WenRisk wenRisk,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			wenRisk.setValidflag(2);
			wenRisk.setAddoperator(userSession.getLoginUserName());
			wenRisk.setAddtime(addtime);
			wenRiskDao.add(wenRisk);
			message= new Message("true","涉稳人员-风险背景添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-风险背景添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加风险背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-风险背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-风险背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加风险背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
	
	@RequestMapping("/updateWenRisk.do")
	public @ResponseBody String updateWenRisk(WenRisk wenRisk,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateWenRisk.do.......................");
		try {
			if (wenRisk.getId()>0) {
				wenRisk.setUpdateoperator(userSession.getLoginUserName());
				wenRisk.setUpdatetime(addtime);
				wenRisk.setValidflag(1);//历史
				wenRiskDao.update(wenRisk);
			}
			
			wenRisk.setAddoperator(userSession.getLoginUserName());
			wenRisk.setAddtime(addtime);
			wenRisk.setValidflag(2);//当前
			wenRiskDao.add(wenRisk);
			
			/*****涉稳人员维护率计算***Parameter5**/
			int maintainrate1=0,filepoints=0;
			if(!wenRisk.getConflictdetails().equals(""))maintainrate1+=5;		//矛盾风险产生的经过、详情			5分
			if(!wenRisk.getRiskappeal().equals(""))maintainrate1+=5;		//目前风险状态及人员诉求			5分
			//附件（上限4分）
			if(!wenRisk.getFileattachments().equals("")){
				String[] fileStrings=wenRisk.getFileattachments().split(",");
				filepoints+=fileStrings.length;
			}
			if(!wenRisk.getVideoattachments().equals("")){
				String[] videoStrings=wenRisk.getFileattachments().split(",");
				filepoints+=videoStrings.length;
			}
			if(filepoints>4)filepoints=4;
			maintainrate1+=filepoints;
			Maintainrate maintainrate=new Maintainrate();
			maintainrate.setPersonlabel(1);
			maintainrate.setPersonnelid(wenRisk.getPersonnelid());
			maintainrate=maintainrateDao.getMaintainrate(maintainrate);
			if(maintainrate!=null){
				maintainrate.setParameter5(maintainrate1);
				maintainrateDao.update(maintainrate);
			}
			
			message = new Message("true","涉稳人员-风险背景修改成功！");
			message.setFlag(wenRisk.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-涉稳人员-风险背景修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateWenRisk.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改风险背景");
			String operate_Condition = "";
			operate_Condition += "风险背景id = '" + wenRisk.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-风险背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-风险背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("updateWenRisk.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改风险背景");
			String operate_Condition = "";
			operate_Condition += "风险背景id = '" + wenRisk.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/searchWenRisk_zfw.do")
	@ResponseBody
	public Map<String,Object> searchWenRisk_zfw(WenRisk wenRisk,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=wenRiskDao.searchWenRisk_zfw(wenRisk, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

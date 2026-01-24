package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.personel.JointControlRecord;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationBank;
import com.szrj.business.model.personel.RelationDriver;
import com.szrj.business.model.personel.RelationHouse;
import com.szrj.business.model.personel.RelationIdentity;
import com.szrj.business.model.personel.RelationLegal;
import com.szrj.business.model.personel.RelationPassport;
import com.szrj.business.model.personel.RelationPayment;
import com.szrj.business.model.personel.RelationPhone;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.RelationWifi;
import com.szrj.business.model.personel.SocialRelations;
import com.szrj.business.model.personel.TrajectoryRecord;

@Controller
@SessionAttributes("userSession")
public class RelationController {
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private LogDao logDao;
	 /**  *********************************************************************风险人员 关联信息***************************************************************  **/
	@RequestMapping("/searchsocialrelations.do")
	@ResponseBody
	public Map<String,Object>  searchsocialrelations(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchsocialrelations.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchsocialrelations(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询社会关系");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/searchsocialrelationsbypost.post")
	@ResponseBody
	public Map<String,Object>  searchsocialrelationsbypost(int personnelid,int page,NewPageModel pm){
		System.out.println("/searchsocialrelations.do..............="+personnelid);
		pm.setPageNumber(page);
		NewPageModel listTemp=relationDao.searchsocialrelations(personnelid, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		return result;
	}
	@RequestMapping("/addrelation.do")
	public @ResponseBody String addrelationbank(Relation relation,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addrelation.do.......................");
		try {
			   int  count=relationDao.getrelationcount(relation.getPersonnelid());
			   if(count==0){
				    relation.setAddtime(addtime);
				    relation.setAddoperator(userSession.getLoginUserName());
				    relationDao.addrelation(relation);
			   }else{
				    relation.setUpdatetime(addtime);
				    relation.setUpdateoperator(userSession.getLoginUserName());
				    relationDao.updaterelation(relation);
			   }
			
			    message= new Message("true","风险人员-关联信息更新成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-关联信息更新", userSession.getLoginUserName(), addtime, "更新成功", "");
				System.out.println("addrelation.do.......................更新成功");
			    //生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("新增风险人员-关联信息");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","风险人员-关联信息更新失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-关联信息更新", userSession.getLoginUserName(), addtime, "更新失败", "");
			System.out.println("addrelation.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("新增风险人员-关联信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchsocialrelations_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchsocialrelations_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchsocialrelations_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/zfwsocialrelations_check.do")
	@ResponseBody
	public String zfwsocialrelations_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		SocialRelations socialRelations=relationDao.getsocialrelationsbyid_zfw(id);
		try {
			relationDao.addsocialrelations(socialRelations);
			socialRelations.setValidflag(2);
			socialRelations.setId(id);
			relationDao.updatesocialrelations_zfw(socialRelations);
			message= new Message("true","审查政法委社会关系成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险人员-审查政法委社会关系");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("社会关系id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委社会关系失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	/**  **************************************************************************银行账号关联信息***************************************************************  **/
	@RequestMapping("/searchrelationbank.do")
	@ResponseBody
	public Map<String,Object>  searchrelationbank(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationbank.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationbank(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询银行账号");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationbank.do")
	public @ResponseBody String addrelationbank(RelationBank relationbank,int menuid,@ModelAttribute("userSession")UserSession userSession,ServletRequest request){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addrelationbank.do.......................");
		try {
			    relationbank.setAddtime(addtime);
			    relationbank.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationbank(relationbank);
				message= new Message("true","关联信息-银行账号添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-银行账号添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationbank.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("银行账号添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-银行账号添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-银行账号添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationbank.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("银行账号添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationbank.do")
	public @ResponseBody String updaterelationbank(RelationBank relationbank,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationbank.do.......................");
		try {
			    relationbank.setUpdatetime(updatetime);
			    relationbank.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.updaterelationbank(relationbank);
				message= new Message("true","关联信息-银行账号修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-银行账号修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updaterelationbank.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("银行账号修改");
				String operate_Condition = "";
				operate_Condition += "银行账号id = '" + relationbank.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","银行账号修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "银行账号修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationbank.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("银行账号修改");
			String operate_Condition = "";
			operate_Condition += "银行账号id = '" + relationbank.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationbank.do")
	public @ResponseBody String cancelrelationbank(RelationBank relationbank,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationbank.do.......................");
		try {
			    relationbank.setUpdatetime(updatetime);
			    relationbank.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.cancelrelationbank(relationbank);
				message= new Message("true","关联信息-银行账号作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-银行账号作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("cancelrelationbank.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("银行账号作废");
				String operate_Condition = "";
				operate_Condition += "银行账号id = '" + relationbank.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-银行账号作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-银行账号作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationbank.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("银行账号作废");
			String operate_Condition = "";
			operate_Condition += "银行账号id = '" + relationbank.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationbankbyid.do")
	public String getrelationbankbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationbankbyid.do.................");
		RelationBank relationbank=relationDao.getrelationbankbyid(id);
		model.addAttribute("relationbank", relationbank);
		String  urlString="/jsp/personel/relation/relationbank/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询银行账号");
		String operate_Condition = "";
		operate_Condition += "银行账号id = '" + relationbank.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getbankaccount.do")
	public @ResponseBody String getbankaccount(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getbankaccount(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("bankaccount");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationbank_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationbank_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationbank_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationbank_zfw.do")
	@ResponseBody
	public String checkrelationbank_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationBank relationBank = relationDao.getrelationbankbyid_zfw(id);
		try {
			relationDao.addrelationbank(relationBank);
			relationBank.setValidflag(2);
			relationBank.setId(id);
			relationDao.updaterelationbank_zfw(relationBank);
			message= new Message("true","审查政法委关联信息-银行账号成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-银行账号");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-银行账号id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-银行账号失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************驾驶证件信息***************************************************************  **/
	@RequestMapping("/searchrelationdriver.do")
	@ResponseBody
	public Map<String,Object>  searchrelationdriver(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationdriver.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationdriver(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询银行账号");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationdriver.do")
	public @ResponseBody String addrelationdriver(RelationDriver relationdriver,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    relationdriver.setAddtime(addtime);
			    relationdriver.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationdriver(relationdriver);
				message= new Message("true","关联信息-驾驶证件添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-驾驶证件添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationdriver.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("驾驶证件添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-驾驶证件添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-驾驶证件添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationdriver.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("驾驶证件添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationdriver.do")
	public @ResponseBody String updaterelationdriver(RelationDriver relationdriver,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationdriver.do.......................");
		try {
			    relationdriver.setUpdatetime(updatetime);
			    relationdriver.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.updaterelationdriver(relationdriver);
				message= new Message("true","关联信息-驾驶证件修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-驾驶证件修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updaterelationdriver.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("驾驶证件修改");
				String operate_Condition = "";
				operate_Condition += "驾驶证件id = '" + relationdriver.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-驾驶证件修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-驾驶证件修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationdriver.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("驾驶证件修改");
			String operate_Condition = "";
			operate_Condition += "驾驶证件id = '" + relationdriver.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationdriver.do")
	public @ResponseBody String cancelrelationdriver(RelationDriver relationdriver,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationdriver.do.......................");
		try {
			    relationdriver.setUpdatetime(updatetime);
			    relationdriver.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.cancelrelationdriver(relationdriver);
				message= new Message("true","关联信息-驾驶证件作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-驾驶证件作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("cancelrelationdriver.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("驾驶证件作废");
				String operate_Condition = "";
				operate_Condition += "驾驶证件id = '" + relationdriver.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-驾驶证件作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-驾驶证件作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationdriver.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("驾驶证件作废");
			String operate_Condition = "";
			operate_Condition += "驾驶证件id = '" + relationdriver.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationdriverbyid.do")
	public String getrelationdriverbyid(int id,ModelMap model) throws Exception{
		System.out.println("getrelationdriverbyid.do.................id="+id);
		RelationDriver relationdriver=relationDao.getrelationdriverbyid(id);
		model.addAttribute("relationdriver", relationdriver);
		String  urlString="/jsp/personel/relation/relationdriver/update";
		return urlString;
	}
	@RequestMapping("/getdrivertype.do")
	public @ResponseBody String getdrivertype(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getdrivertype(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relateddriver");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationdriver_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationdriver_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationdriver_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationdriver_zfw.do")
	@ResponseBody
	public String checkrelationdriver_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationDriver relationDriver = relationDao.getrelationdriverbyid_zfw(id);
		try {
			relationDao.addrelationdriver(relationDriver);
			relationDriver.setValidflag(2);
			relationDriver.setId(id);
			relationDao.updaterelationdriver_zfw(relationDriver);
			message= new Message("true","审查政法委关联信息-驾驶证件成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-驾驶证件");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-驾驶证件id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-驾驶证件失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************房产信息***************************************************************  **/
	@RequestMapping("/searchrelationhouse.do")
	@ResponseBody
	public Map<String,Object>  searchrelationhouse(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationhouse.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationhouse(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询房产信息");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationhouse.do")
	public @ResponseBody String addrelationhouse(RelationHouse relationhouse,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    relationhouse.setAddtime(addtime);
			    relationhouse.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationhouse(relationhouse);
				message= new Message("true","关联信息-房产信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-房产信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationhouse.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("添加房产信息");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-房产信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-房产信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationhouse.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加房产信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationhouse.do")
	public @ResponseBody String updaterelationhouse(RelationHouse relationhouse,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationhouse.do.......................");
		try {
			relationhouse.setUpdatetime(updatetime);
			relationhouse.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.updaterelationhouse(relationhouse);
				message= new Message("true","关联信息-房产信息修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-房产信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updaterelationhouse.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("修改房产信息");
				String operate_Condition = "";
				operate_Condition += "房产信息id = '" + relationhouse.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-房产信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-房产信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationhouse.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改房产信息");
			String operate_Condition = "";
			operate_Condition += "房产信息id = '" + relationhouse.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationhouse.do")
	public @ResponseBody String cancelrelationhouse(RelationHouse relationhouse,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationhouse.do.......................");
		try {
			    relationhouse.setUpdatetime(updatetime);
			    relationhouse.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.cancelrelationhouse(relationhouse);
				message= new Message("true","关联信息-房产信息作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-房产信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("cancelrelationhouse.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("作废房产信息");
				String operate_Condition = "";
				operate_Condition += "房产信息id = '" + relationhouse.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-房产信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-房产信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationhouse.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("作废房产信息");
			String operate_Condition = "";
			operate_Condition += "房产信息id = '" + relationhouse.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationhousebyid.do")
	public String getrelationhousebyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationhousebyid.do.................");
		RelationHouse relationhouse=relationDao.getrelationhousebyid(id);
		model.addAttribute("relationhouse", relationhouse);
		String  urlString="/jsp/personel/relation/relationhouse/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询房产信息");
		String operate_Condition = "";
		operate_Condition += "房产信息id = '" + relationhouse.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/gethousetype.do")
	public @ResponseBody String gethousetype(int personnelid){
		Message message;
		try {
			    String msg=relationDao.gethousetype(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relatedhouse");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationhouse_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationhouse_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationhouse_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationhouse_zfw.do")
	@ResponseBody
	public String checkrelationhouse_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationHouse relationHouse = relationDao.getrelationhousebyid_zfw(id);
		try {
			relationDao.addrelationhouse(relationHouse);
			relationHouse.setValidflag(2);
			relationHouse.setId(id);
			relationDao.updaterelationhouse_zfw(relationHouse);
			message= new Message("true","审查政法委关联信息-房产信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-房产信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-房产信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-房产信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************虚拟身份信息***************************************************************  **/
	@RequestMapping("/searchrelationidentity.do")
	@ResponseBody
	public Map<String,Object>  searchrelationidentity(int personnelid,int page,NewPageModel pm){
		   System.out.println("/searchrelationidentity.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationidentity(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	@RequestMapping("/addrelationidentity.do")
	public @ResponseBody String addrelationidentity(RelationIdentity relationidentity,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    relationidentity.setAddtime(addtime);
			    relationidentity.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationidentity(relationidentity);
				message= new Message("true","关联信息-虚拟身份信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-虚拟身份信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationidentity.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("虚拟身份信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-虚拟身份信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-虚拟身份信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationhouse.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("虚拟身份信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationidentity.do")
	public @ResponseBody String updaterelationidentity(RelationIdentity relationidentity,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationidentity.do.......................");
		try {
			    relationidentity.setUpdatetime(updatetime);
			    relationidentity.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.updaterelationidentity(relationidentity);
				message= new Message("true","关联信息-虚拟身份信息修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-虚拟身份信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updaterelationidentity.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("虚拟身份信息修改");
				String operate_Condition = "";
				operate_Condition += "虚拟身份信息 = '" + relationidentity.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-虚拟身份信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-虚拟身份信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationidentity.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("虚拟身份信息修改");
			String operate_Condition = "";
			operate_Condition += "虚拟身份信息 = '" + relationidentity.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationidentity.do")
	public @ResponseBody String cancelrelationidentity(RelationIdentity relationidentity,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationidentity.do.......................");
		try {
		    relationidentity.setUpdatetime(updatetime);
 		    relationidentity.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationidentity(relationidentity);
			message= new Message("true","关联信息-虚拟身份信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-虚拟身份信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationidentity.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("虚拟身份信息作废");
			String operate_Condition = "";
			operate_Condition += "虚拟身份信息id = '" + relationidentity.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-虚拟身份信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-虚拟身份信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationidentity.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("虚拟身份信息作废");
			String operate_Condition = "";
			operate_Condition += "虚拟身份信息id = '" + relationidentity.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationidentitybyid.do")
	public String getrelationidentitybyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationidentitybyid.do.................");
		RelationIdentity relationidentity=relationDao.getrelationidentitybyid(id);
		model.addAttribute("relationidentity", relationidentity);
		String  urlString="/jsp/personel/relation/relationidentity/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询虚拟身份信息");
		String operate_Condition = "";
		operate_Condition += "虚拟身份信息id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getidentitytype.do")
	public @ResponseBody String getidentitytype(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getidentitytype(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("netidentity");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationidentity_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationidentity_zfw(int personnelid,int page,NewPageModel pm){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationidentity_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationidentity_zfw.do")
	@ResponseBody
	public String checkrelationidentity_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationIdentity relationIdentity = relationDao.getrelationidentitybyid_zfw(id);
		try {
			relationDao.addrelationidentity(relationIdentity);
			relationIdentity.setValidflag(2);
			relationIdentity.setId(id);
			relationDao.updaterelationidentity_zfw(relationIdentity);
			message= new Message("true","审查政法委关联信息-虚拟身份信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-虚拟身份信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-虚拟身份信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-虚拟身份信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************法人组织信息***************************************************************  **/
	@RequestMapping("/searchrelationlegal.do")
	@ResponseBody
	public Map<String,Object>  searchrelationlegal(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationlegal.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationlegal(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询法人组织信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationlegal.do")
	public @ResponseBody String addrelationlegal(RelationLegal relationlegal,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
		    relationlegal.setAddtime(addtime);
		    relationlegal.setAddoperator(userSession.getLoginUserName());
		    relationDao.addrelationlegal(relationlegal);
			message= new Message("true","关联信息-法人组织信息添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-法人组织信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addrelationlegal.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-法人组织信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-法人组织信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationhouse.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationlegal.do")
	public @ResponseBody String updaterelationlegal(RelationLegal relationlegal,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationlegal.do.......................");
		try {
			relationlegal.setUpdatetime(updatetime);
			relationlegal.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationlegal(relationlegal);
			message= new Message("true","关联信息-法人组织信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-法人组织信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationlegal.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息修改");
			String operate_Condition = "";
			operate_Condition += "法人组织信息ID = '" + relationlegal.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","法人组织信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "法人组织信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationlegal.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息修改");
			String operate_Condition = "";
			operate_Condition += "法人组织信息ID = '" + relationlegal.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationlegal.do")
	public @ResponseBody String cancelrelationlegal(RelationLegal relationlegal,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationlegal.do.......................");
		try {
		    relationlegal.setUpdatetime(updatetime);
		    relationlegal.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationlegal(relationlegal);
			message= new Message("true","关联信息-法人组织信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-法人组织信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationlegal.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息作废");
			String operate_Condition = "";
			operate_Condition += "法人组织信息ID = '" + relationlegal.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-法人组织信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-法人组织信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationidentity.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("法人组织信息作废");
			String operate_Condition = "";
			operate_Condition += "法人组织信息ID = '" + relationlegal.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getrelationlegalbyid.do")
	public String getrelationlegalbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationlegalbyid.do.................");
		RelationLegal relationlegal=relationDao.getrelationlegalbyid(id);
		model.addAttribute("relationlegal", relationlegal);
		String  urlString="/jsp/personel/relation/relationlegal/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询法人组织信息");
		String operate_Condition = "";
		operate_Condition += "法人组织信息ID = '" + relationlegal.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getlegalname.do")
	public @ResponseBody String getlegalname(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getlegalname(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relatedlegal");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationlegal_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationlegal_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationlegal_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationlegal_zfw.do")
	@ResponseBody
	public String checkrelationlegal_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationLegal relationLegal = relationDao.getrelationlegalbyid_zfw(id);
		try {
			relationDao.addrelationlegal(relationLegal);
			relationLegal.setValidflag(2);
			relationLegal.setId(id);
			relationDao.updaterelationlegal_zfw(relationLegal);
			message= new Message("true","审查政法委关联信息-法人组织信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-法人组织信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-法人组织信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-法人组织信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************护照信息***************************************************************  **/
	@RequestMapping("/searchrelationpassport.do")
	@ResponseBody
	public Map<String,Object>  searchrelationpassport(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationlegal.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationpassport(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询护照信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationpassport.do")
	public @ResponseBody String addrelationpassport(RelationPassport relationpassport,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    relationpassport.setAddtime(addtime);
			    relationpassport.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationpassport(relationpassport);
				message= new Message("true","关联信息-护照信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-护照信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationpassport.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("护照信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-护照信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-护照信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationhouse.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("护照信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationpassport.do")
	public @ResponseBody String updaterelationpassport(RelationPassport relationpassport,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationpassport.do.......................");
		try {
		    relationpassport.setUpdatetime(updatetime);
		    relationpassport.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationpassport(relationpassport);
			message= new Message("true","关联信息-护照信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-护照信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationpassport.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("护照信息修改");
			String operate_Condition = "";
			operate_Condition += "护照信息ID = '" + relationpassport.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","护照信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "护照信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationpassport.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("护照信息修改");
			String operate_Condition = "";
			operate_Condition += "护照信息ID = '" + relationpassport.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationpassport.do")
	public @ResponseBody String cancelrelationpassport(RelationPassport relationpassport,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationpassport.do.......................");
		try {
		    relationpassport.setUpdatetime(updatetime);
		    relationpassport.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationpassport(relationpassport);
			message= new Message("true","关联信息-护照信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-护照信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationpassport.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("护照信息作废");
			String operate_Condition = "";
			operate_Condition += "护照信息ID = '" + relationpassport.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-护照信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-护照信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationpassport.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("护照信息作废");
			String operate_Condition = "";
			operate_Condition += "护照信息ID = '" + relationpassport.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationpassportbyid.do")
	public String getrelationpassportbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationpassportbyid.do.................");
		RelationPassport relationpassport=relationDao.getrelationpassportbyid(id);
		model.addAttribute("relationpassport", relationpassport);
		String  urlString="/jsp/personel/relation/relationpassport/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询护照信息");
		String operate_Condition = "";
		operate_Condition += "护照信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getpassporttype.do")
	public @ResponseBody String getpassporttype(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getpassporttype(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relatedpassport");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationpassport_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationpassport_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationpassport_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationpassport_zfw.do")
	@ResponseBody
	public String checkrelationpassport_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationPassport relationPassport = relationDao.getrelationpassportbyid_zfw(id);
		try {
			relationDao.addrelationpassport(relationPassport);
			relationPassport.setValidflag(2);
			relationPassport.setId(id);
			relationDao.updaterelationpassport_zfw(relationPassport);
			message= new Message("true","审查政法委关联信息-护照信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-护照信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-护照信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-护照信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************网络支付信息***************************************************************  **/
	@RequestMapping("/searchrelationpayment.do")
	@ResponseBody
	public Map<String,Object>  searchrelationpayment(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationpayment.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationpayment(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询网络支付信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationpayment.do")
	public @ResponseBody String addrelationpayment(RelationPayment relationpayment,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			relationpayment.setAddtime(addtime);
			relationpayment.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationpayment(relationpayment);
				message= new Message("true","关联信息-网络支付信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-网络支付信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationpayment.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("网络支付信息添加");
				String operate_Condition = "";
				operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-网络支付信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-网络支付信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationpayment.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("网络支付信息添加");
			String operate_Condition = "";
			operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationpayment.do")
	public @ResponseBody String updaterelationpayment(RelationPayment relationpayment,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationpayment.do.......................");
		try {
			relationpayment.setUpdatetime(updatetime);
			relationpayment.setUpdateoperator(userSession.getLoginUserName());
			    relationDao.updaterelationpayment(relationpayment);
				message= new Message("true","关联信息-网络支付信息修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-网络支付信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updaterelationpayment.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("网络支付信息修改");
				String operate_Condition = "";
				operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","网络支付信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "网络支付信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationpayment.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("网络支付信息修改");
			String operate_Condition = "";
			operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationpayment.do")
	public @ResponseBody String cancelrelationpayment(RelationPayment relationpayment,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationpayment.do.......................");
		try {
			relationpayment.setUpdatetime(updatetime);
			relationpayment.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationpayment(relationpayment);
			message= new Message("true","关联信息-网络支付信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-网络支付信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationpayment.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("网络支付信息作废");
			String operate_Condition = "";
			operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-网络支付信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-网络支付信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationpayment.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("网络支付信息作废");
			String operate_Condition = "";
			operate_Condition += "网络支付信息ID = '" + relationpayment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationpaymentbyid.do")
	public String getrelationpaymentbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationpaymentbyid.do.................");
		RelationPayment relationpayment=relationDao.getrelationpaymentbyid(id);
		model.addAttribute("relationpayment", relationpayment);
		String  urlString="/jsp/personel/relation/relationpayment/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询网络支付信息");
		String operate_Condition = "";
		operate_Condition += "网络支付信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getpaymentname.do")
	public @ResponseBody String getpaymentname(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getpaymentname(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("netpayment");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationpayment_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationpayment_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationpayment_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationpayment_zfw.do")
	@ResponseBody
	public String checkrelationpayment_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationPayment relationPayment = relationDao.getrelationpaymentbyid_zfw(id);
		try {
			relationDao.addrelationpayment(relationPayment);
			relationPayment.setValidflag(2);
			relationPayment.setId(id);
			relationDao.updaterelationpayment_zfw(relationPayment);
			message= new Message("true","审查政法委关联信息-网络支付信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-网络支付信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-网络支付信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-网络支付信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************使用手机信息***************************************************************  **/
	@RequestMapping("/searchrelationphone.do")
	@ResponseBody
	public Map<String,Object>  searchrelationphone(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationphone.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationphone(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询使用手机信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationphone.do")
	public @ResponseBody String addrelationphone(RelationPhone relationphone,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			relationphone.setAddtime(addtime);
			relationphone.setAddoperator(userSession.getLoginUserName());
			    relationDao.addrelationphone(relationphone);
				message= new Message("true","关联信息-使用手机信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "关联信息-使用手机信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addrelationphone.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("使用手机信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-使用手机信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-使用手机信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationphone.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("使用手机信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationphone.do")
	public @ResponseBody String updaterelationphone(RelationPhone relationphone,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationphone.do.......................");
		try {
			relationphone.setUpdatetime(updatetime);
			relationphone.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationphone(relationphone);
			message= new Message("true","关联信息-使用手机信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-使用手机信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationphone.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("使用手机信息修改");
			String operate_Condition = "";
			operate_Condition += "使用手机信息ID = '" + relationphone.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-使用手机信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-使用手机信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationphone.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("使用手机信息修改");
			String operate_Condition = "";
			operate_Condition += "使用手机信息ID = '" + relationphone.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationphone.do")
	public @ResponseBody String cancelrelationphone(RelationPhone relationphone,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationphone.do.......................");
		try {
			relationphone.setUpdatetime(updatetime);
			relationphone.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationphone(relationphone);
			message= new Message("true","关联信息-使用手机信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-使用手机信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationphone.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("使用手机信息作废");
			String operate_Condition = "";
			operate_Condition += "使用手机信息ID = '" + relationphone.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-使用手机信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-使用手机信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationphone.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("使用手机信息作废");
			String operate_Condition = "";
			operate_Condition += "使用手机信息ID = '" + relationphone.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationphonebyid.do")
	public String getrelationphonebyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationphonebyid.do.................");
		RelationPhone relationphone=relationDao.getrelationphonebyid(id);
		model.addAttribute("relationphone", relationphone);
		String  urlString="/jsp/personel/relation/relationphone/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询使用手机信息");
		String operate_Condition = "";
		operate_Condition += "使用手机信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/gettelbrand.do")
	public @ResponseBody String gettelbrand(int personnelid){
		Message message;
		try {
			    String msg=relationDao.gettelbrand(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("telephone");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委-使用手机**/
	@RequestMapping("/searchrelationphone_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationphone_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationphone_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationphone_zfw.do")
	@ResponseBody
	public String checkrelationphone_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationPhone relationphone = relationDao.getrelationphonebyid_zfw(id);
		try {
			relationDao.addrelationphone(relationphone);
			relationphone.setValidflag(2);
			relationphone.setId(id);
			relationDao.updaterelationphone_zfw(relationphone);
			message= new Message("true","审查政法委关联信息-使用手机成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-使用手机");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-使用手机id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-使用手机失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************手机号码信息***************************************************************  **/
	@RequestMapping("/searchrelationtelnumber.do")
	@ResponseBody
	public Map<String,Object>  searchrelationtelnumber(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
			Map<String, Object> result = new HashMap<String, Object>();
			try {
				System.out.println("/searchrelationtelnumber.do..............="+personnelid);
			    pm.setPageNumber(page);
			    NewPageModel listTemp=relationDao.searchrelationtelnumber(personnelid, pm);
		        result.put("code", 0);
		        result.put("count", listTemp.getTotal());
		        result.put("data", listTemp.getRows().toArray());
		        //生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("查询手机号码信息");
				String operate_Condition = "";
				operate_Condition += "人员ID = '" + personnelid + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			} catch (Exception e) {
				e.printStackTrace();
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("0");	//0：失败 1：成功
				log.setOperate_Name("查询手机号码信息");
				String operate_Condition = "";
				operate_Condition += "人员ID = '" + personnelid + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
	        return result;
	}
	@RequestMapping("/addrelationtelnumber.do")
	public @ResponseBody String addrelationtelnumber(RelationTelnumber relationtelnumber,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			relationtelnumber.setAddtime(addtime);
			relationtelnumber.setAddoperator(userSession.getLoginUserName());
		    relationDao.addrelationtelnumber(relationtelnumber);
			message= new Message("true","关联信息-手机号码信息添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-手机号码信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addrelationtelnumber.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-手机号码信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-手机号码信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationtelnumber.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationtelnumber.do")
	public @ResponseBody String updaterelationtelnumber(RelationTelnumber relationtelnumber,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationtelnumber.do.......................");
		try {
			relationtelnumber.setUpdatetime(updatetime);
			relationtelnumber.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationtelnumber(relationtelnumber);
			message= new Message("true","关联信息-手机号码信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-手机号码信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationtelnumber.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息修改");
			String operate_Condition = "";
			operate_Condition += "手机号码信息ID = '" + relationtelnumber.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-手机号码信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-手机号码信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationtelnumber.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息修改");
			String operate_Condition = "";
			operate_Condition += "手机号码信息ID = '" + relationtelnumber.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationtelnumber.do")
	public @ResponseBody String cancelrelationtelnumber(RelationTelnumber relationtelnumber,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationtelnumber.do.......................");
		try {
			relationtelnumber.setUpdatetime(updatetime);
			relationtelnumber.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationtelnumber(relationtelnumber);
			message= new Message("true","关联信息-手机号码信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-手机号码信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationtelnumber.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息作废");
			String operate_Condition = "";
			operate_Condition += "手机号码信息ID = '" + relationtelnumber.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","手机号码信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "手机号码信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationtelnumber.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("手机号码信息作废");
			String operate_Condition = "";
			operate_Condition += "手机号码信息ID = '" + relationtelnumber.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationtelnumberbyid.do")
	public String getrelationtelnumberbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationtelnumberbyid.do.................");
		RelationTelnumber relationtelnumber=relationDao.getrelationtelnumberbyid(id);
		model.addAttribute("relationtelnumber", relationtelnumber);
		String  urlString="/jsp/personel/relation/relationtelnumber/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询手机号码信息");
		String operate_Condition = "";
		operate_Condition += "手机号码信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/gettelnumber.do")
	public @ResponseBody String gettelnumber(int personnelid){
		Message message;
		try {
			    String msg=relationDao.gettelnumber(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("telnumber");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationtelnumber_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationtelnumber_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
			Map<String, Object> result = new HashMap<String, Object>();
			try {
			    pm.setPageNumber(page);
			    NewPageModel listTemp=relationDao.searchrelationtelnumber_zfw(personnelid, pm);
		        result.put("code", 0);
		        result.put("count", listTemp.getTotal());
		        result.put("data", listTemp.getRows().toArray());
			} catch (Exception e) {
				e.printStackTrace();
			}
	        return result;
	}
	
	@RequestMapping("/checkrelationtelnumber_zfw.do")
	@ResponseBody
	public String checkrelationtelnumber_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationTelnumber relationTelnumber = relationDao.getrelationtelnumberbyid_zfw(id);
		try {
			relationDao.addrelationtelnumber(relationTelnumber);
			relationTelnumber.setValidflag(2);
			relationTelnumber.setId(id);
			relationDao.updaterelationtelnumber_zfw(relationTelnumber);
			message= new Message("true","审查政法委关联信息-手机号码成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-手机号码");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-手机号码id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-手机号码失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************交通工具信息***************************************************************  **/
	@RequestMapping("/searchrelationvehicle.do")
	@ResponseBody
	public Map<String,Object>  searchrelationvehicle(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationvehicle.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationvehicle(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询交通工具信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationvehicle.do")
	public @ResponseBody String addrelationvehicle(RelationVehicle relationvehicle,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
		    relationvehicle.setAddtime(addtime);
		    relationvehicle.setAddoperator(userSession.getLoginUserName());
		    relationDao.addrelationvehicle(relationvehicle);
			message= new Message("true","关联信息-交通工具信息添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-交通工具信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addrelationvehicle.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-交通工具信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-交通工具信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationvehicle.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationvehicle.do")
	public @ResponseBody String updaterelationvehicle(RelationVehicle relationvehicle,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationvehicle.do.......................");
		try {
			relationvehicle.setUpdatetime(updatetime);
			relationvehicle.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationvehicle(relationvehicle);
			message= new Message("true","关联信息-交通工具信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-交通工具信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationvehicle.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息修改");
			String operate_Condition = "";
			operate_Condition += "交通工具信息ID = '" + relationvehicle.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","交通工具信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "交通工具信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationvehicle.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息修改");
			String operate_Condition = "";
			operate_Condition += "交通工具信息ID = '" + relationvehicle.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationvehicle.do")
	public @ResponseBody String cancelrelationvehicle(RelationVehicle relationvehicle,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationvehicle.do.......................");
		try {
			relationvehicle.setUpdatetime(updatetime);
			relationvehicle.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationvehicle(relationvehicle);
			message= new Message("true","关联信息-交通工具信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-交通工具信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationvehicle.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息作废");
			String operate_Condition = "";
			operate_Condition += "交通工具信息ID = '" + relationvehicle.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-交通工具信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-交通工具信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationvehicle.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("交通工具信息作废");
			String operate_Condition = "";
			operate_Condition += "交通工具信息ID = '" + relationvehicle.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getrelationvehiclebyid.do")
	public String getrelationvehiclebyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		RelationVehicle relationvehicle=relationDao.getrelationvehiclebyid(id);
		model.addAttribute("relationvehicle", relationvehicle);
		String  urlString="/jsp/personel/relation/relationvehicle/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据id查询交通工具信息");
		String operate_Condition = "";
		operate_Condition += "交通工具信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getvehicletype.do")
	public @ResponseBody String getvehicletype(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getvehicletype(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relatedvehicle");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationvehicle_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationvehicle_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationvehicle_zfw(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	
	@RequestMapping("/checkrelationvehicle_zfw.do")
	@ResponseBody
	public String checkrelationvehicle_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationVehicle relationVehicle = relationDao.getrelationvehiclebyid_zfw(id);
		try {
			relationDao.addrelationvehicle(relationVehicle);
			relationVehicle.setValidflag(2);
			relationVehicle.setId(id);
			relationDao.updaterelationvehicle_zfw(relationVehicle);
			message= new Message("true","审查政法委关联信息-交通工具信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-交通工具信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-交通工具信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-交通工具信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	 /**  **************************************************************************WIFI信息***************************************************************  **/
	@RequestMapping("/searchrelationwifi.do")
	@ResponseBody
	public Map<String,Object>  searchrelationwifi(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchrelationwifi.do..............="+personnelid);
		    pm.setPageNumber(page);
		    NewPageModel listTemp=relationDao.searchrelationwifi(personnelid, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询WIFI信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addrelationwifi.do")
	public @ResponseBody String addrelationwifi(RelationWifi relationwifi,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
		    relationwifi.setAddtime(addtime);
		    relationwifi.setAddoperator(userSession.getLoginUserName());
		    relationDao.addrelationwifi(relationwifi);
			message= new Message("true","关联信息-WIFI信息添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-WIFI信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addrelationwifi.do.......................添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-WIFI信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-WIFI信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addrelationwifi.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updaterelationwifi.do")
	public @ResponseBody String updaterelationwifi(RelationWifi relationwifi,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updaterelationwifi.do.......................");
		try {
		    relationwifi.setUpdatetime(updatetime);
		    relationwifi.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updaterelationwifi(relationwifi);
			message= new Message("true","关联信息-WIFI信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-WIFI信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updaterelationwifi.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息修改");
			String operate_Condition = "";
			operate_Condition += "WIFI信息ID = '" + relationwifi.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","关联信息-WIFI信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "关联信息-WIFI信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updaterelationwifi.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息修改");
			String operate_Condition = "";
			operate_Condition += "WIFI信息ID = '" + relationwifi.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelrelationwifi.do")
	public @ResponseBody String cancelrelationwifi(RelationWifi relationwifi,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelrelationwifi.do.......................");
		try {
		    relationwifi.setUpdatetime(updatetime);
		    relationwifi.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelrelationwifi(relationwifi);
			message= new Message("true","关联信息-WIFI信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "关联信息-WIFI信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelrelationwifi.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息作废");
			String operate_Condition = "";
			operate_Condition += "WIFI信息ID = '" + relationwifi.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","WIFI信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "WIFI信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelrelationwifi.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("WIFI信息作废");
			String operate_Condition = "";
			operate_Condition += "WIFI信息ID = '" + relationwifi.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getrelationwifibyid.do")
	public String getrelationwifibyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getrelationwifibyid.do.................");
		RelationWifi relationwifi=relationDao.getrelationwifibyid(id);
		model.addAttribute("relationwifi", relationwifi);
		String  urlString="/jsp/personel/relation/relationwifi/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询WIFI信息");
		String operate_Condition = "";
		operate_Condition += "WIFI信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	
	/**政法委**/
	@RequestMapping("/searchrelationwifi_zfw.do")
	@ResponseBody
	public Map<String,Object>  searchrelationwifi_zfw(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
	    pm.setPageNumber(page);
	    NewPageModel listTemp=relationDao.searchrelationwifi_zfw(personnelid, pm);
	    Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("count", listTemp.getTotal());
        result.put("data", listTemp.getRows().toArray());
        return result;
	}
	
	@RequestMapping("/checkrelationwifi_zfw.do")
	@ResponseBody
	public String checkrelationwifi_zfw(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		RelationWifi relationWifi = relationDao.getrelationwifibyid_zfw(id);
		try {
			relationDao.addrelationwifi(relationWifi);
			relationWifi.setValidflag(2);
			relationWifi.setId(id);
			relationDao.updaterelationwifi_zfw(relationWifi);
			message= new Message("true","审查政法委关联信息-WIFI信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("涉稳人员-审查政法委关联信息-WIFI信息");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("关联信息-WIFI信息id："+id);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委关联信息-WIFI信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getssid.do")
	public @ResponseBody String getssid(int personnelid){
		Message message;
		try {
			    String msg=relationDao.getssid(personnelid);
			    Relation relation=new Relation();
			    relation.setRelationvalue(msg);
			    relation.setRelationname("relatedwifi");
			    relation.setPersonnelid(personnelid);
			    relationDao.updaterelationbypersonnelid(relation);
				message= new Message("true",msg);
				message.setFlag(1);
			} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","");
				message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}	

	@RequestMapping("/addsocialrelations.do")
	public @ResponseBody String addsocialrelations(SocialRelations socialrelations,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    //检查该社会人员是否为风险人员
			     int count =personnelDao.findPersonInPersonnel(socialrelations.getCardnumber());
			    if (count==0) {
			        socialrelations.setRiskpersonnel(0);//非风险人员
			    }else{
			    	socialrelations.setRiskpersonnel(1);//风险人员，存在风险库中
			    }
			    socialrelations.setAddtime(addtime);
			    socialrelations.setAddoperator(userSession.getLoginUserName());
			    relationDao.addsocialrelations(socialrelations);
				message= new Message("true","风险人员-社会关系信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-社会关系信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addsocialrelations.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("社会关系信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","风险人员-社会关系信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-社会关系信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addsocialrelations.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("社会关系信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updatesocialrelations.do")
	public @ResponseBody String updatesocialrelations(SocialRelations socialrelations,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatesocialrelations.do.......................");
		try {
			socialrelations.setUpdatetime(updatetime);
			socialrelations.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.updatesocialrelations(socialrelations);
			message= new Message("true","风险人员-社会关系信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-社会关系信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatesocialrelations.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("社会关系信息修改");
			String operate_Condition = "";
			operate_Condition += "社会关系信息ID = '" + socialrelations.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","风险人员-社会关系信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-社会关系信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatesocialrelations.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("社会关系信息修改");
			String operate_Condition = "";
			operate_Condition += "社会关系信息ID = '" + socialrelations.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelsocialrelations.do")
	public @ResponseBody String cancelsocialrelations(SocialRelations socialrelations,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelsocialrelations.do.......................");
		try {
		    socialrelations.setUpdatetime(updatetime);
		    socialrelations.setUpdateoperator(userSession.getLoginUserName());
		    relationDao.cancelsocialrelations(socialrelations);
			message= new Message("true","风险人员-社会关系信息作废成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-社会关系信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
			System.out.println("cancelsocialrelations.do.......................作废成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("社会关系信息作废");
			String operate_Condition = "";
			operate_Condition += "社会关系信息ID = '" + socialrelations.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","风险人员-社会关系信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-社会关系信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelsocialrelations.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("社会关系信息作废");
			String operate_Condition = "";
			operate_Condition += "社会关系信息ID = '" + socialrelations.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getsocialrelationsbyid.do")
	public String getsocialrelationsbyid(int id,String page,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getsocialrelationsbyid.do.................");
		SocialRelations socialrelations=relationDao.getsocialrelationsbyid(id);
		model.addAttribute("socialrelations", socialrelations);
		String  urlString="";
		if(page.equals("update")){
			urlString="/jsp/personel/socialrelations/update";
		}else{
			urlString="/jsp/personel/socialrelations/showinfo";
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询社会关系信息");
		String operate_Condition = "";
		operate_Condition += "社会关系信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/getsocialrelationsbyidbypost.post")
	public String getsocialrelationsbyidbypost(int id,String page,ModelMap model) throws Exception{
		System.out.println("getsocialrelationsbyid.do.................");
		SocialRelations socialrelations=relationDao.getsocialrelationsbyid(id);
		model.addAttribute("socialrelations", socialrelations);
		String  urlString="";
		if(page.equals("update")){
			urlString="/jsp/personel/socialrelations/update";
		}else{
			urlString="/jsp/personel/socialrelations/showinfo";
		}
		return urlString;
	}
	@RequestMapping("/getsocialrelationscount.do")
	public @ResponseBody String getsocialrelationscount(SocialRelations socialrelations){
		Message message;
		System.out.println("getsocialrelationscount.do.......................");
		try {
			     int count=relationDao.getsocialrelationscount(socialrelations);
				 message= new Message("true","检查存在重复身份证");
				 message.setFlag(count);
		} catch (Exception e) {
				e.printStackTrace();
				message= new Message("false","*");
				message.setFlag(-1);
	   }
		return JSONObject.fromObject(message).toString();
	}	
	/**
	 * 查询该社会关系中与风险人员库中其他社会关系
	 * @param socialrelations
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getsocialrelationsbycardnumber.do")
	public String getsocialrelationsbycardnumber(SocialRelations socialrelations,ModelMap model) throws Exception{
		System.out.println("getsocialrelationsbycardnumber.do.................");
		String  urlString;
		//是否风险人员0-否1-是
		if(socialrelations.getRiskpersonnel()==1){//风险人员  查询详情
			     Personnel personnel=personnelDao.getPersonnelByCardnumber(socialrelations.getCardnumber());
				 model.addAttribute("personnel",personnel);
				 int age=CardnumberInfo.getAge(socialrelations.getCardnumber());
				 model.addAttribute("age",age);
				 Relation relation=relationDao.searchrelation(personnel.getId());	//关联信息
			     model.addAttribute("relation",relation);
			    urlString="/jsp/personel/showinfo";
		}else{//非风险人员
			List<SocialRelations> socialrelations_list=relationDao.getsocialrelationsbycardnumber(socialrelations);
			model.addAttribute("socialrelations_list", socialrelations_list);
		    urlString="/jsp/personel/socialrelations/personelrelations";
		}
		return urlString;
	}
	
	 /**  ***********************************************************************轨迹信息***************************************************************  **/
	@RequestMapping("/searchtrajectoryrecord.do")
	@ResponseBody
	public Map<String,Object>  searchtrajectoryrecord(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchtrajectoryrecord.do..............="+personnelid);
		    pm.setPageNumber(page);
		    String telnumber=relationDao.getrelationtelnumber(personnelid);//查询风险人员 关联手机号
		    Map<String, Object> result = new HashMap<String, Object>();
		    if(telnumber==null||telnumber.equals("")){
		    	System.out.println("/searchtrajectoryrecord.do..............telnumber=空");
	    	    ArrayList list=new ArrayList();
	    	    TrajectoryRecord tr=new TrajectoryRecord();
	    	    list.add(tr);
		        result.put("code", 0);
		        result.put("count", 0);
		        result.put("data", list.toArray());
		    }else{
			   	System.out.println("/searchtrajectoryrecord.do..............telnumber="+telnumber);
	    	    NewPageModel listTemp=relationDao.gettrajectoryrecord(telnumber, pm);
		        result.put("code", 0);
		        result.put("count", listTemp.getTotal());
		        result.put("data", listTemp.getRows().toArray());
		    }
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询轨迹信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		    return result;
	}
}

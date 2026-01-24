package com.szrj.business.web.daily;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.daily.DutyDao;
import com.szrj.business.model.daily.Duty;
import com.szrj.business.model.daily.Secret;

@Controller
@SessionAttributes("userSession")
public class DutyController {
	@Autowired
	private DutyDao dutyDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getgetAllDutyList.do")
	@ResponseBody
	public List<Duty> getgetAllDutyList(ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		List<Duty> list=dutyDao.getAllDuty();
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询值班管理信息");
		String operate_Condition = "";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return list;
	}
	
	@RequestMapping("/getDutyUpdate.do")
	public String getDutyUpdate(Duty dutyDaily,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		model.addAttribute("menuid",menuid);
		try {
			String field=dutyDaily.getField();
			Duty duty=new Duty();
			duty.setId(dutyDaily.getId());
			Duty resultDuty=dutyDao.getByIdOrDepartid(duty);
			dutyDaily.setDepartid(resultDuty.getDepartid());
			JSONObject object=JSONObject.fromObject(resultDuty);
			String fieldString="";
			if(object.get(field)!=null)fieldString=(String)object.get(field).toString();
			dutyDaily.setFieldString(fieldString);
			model.addAttribute("duty",dutyDaily);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询值班管理信息");
			String operate_Condition = "";
			if(dutyDaily.getId()!= 0){
				operate_Condition += "值班管理信息id = '" + dutyDaily.getId() + "'";
			}
			if(dutyDaily.getDepartid()!= 0){
				if("".equals(operate_Condition)){
					operate_Condition += "部门id = '" + dutyDaily.getDepartid() + "'";
				}else{
					operate_Condition += " and 部门id = '" + dutyDaily.getDepartid() + "'";
				}
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
			log.setOperate_Name("根据ID查询值班管理信息");
			String operate_Condition = "";
			if(dutyDaily.getId()!= 0){
				operate_Condition += "值班管理信息id = '" + dutyDaily.getId() + "'";
			}
			if(dutyDaily.getDepartid()!= 0){
				if("".equals(operate_Condition)){
					operate_Condition += "部门id = '" + dutyDaily.getDepartid() + "'";
				}else{
					operate_Condition += " and 部门id = '" + dutyDaily.getDepartid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return "/jsp/daily/duty/update";
	}
	
	@RequestMapping("/updateDailyDuty.do")
	public @ResponseBody String updateDailyDuty(Duty duty,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws DataAccessException{
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateDailyDuty.do.......................");
		try {
			duty.setUpdateoperator(userSession.getLoginUserName());
			duty.setUpdatetime(addtime);
			dutyDao.update(duty);
			message = new Message("true","值班管理-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "值班管理-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateDailyDuty.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改值班管理信息");
			String operate_Condition = "";
			operate_Condition += "值班管理信息id = '" + duty.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","值班管理-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "值班管理-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateDailyDuty.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改值班管理信息");
			String operate_Condition = "";
			operate_Condition += "值班管理信息id = '" + duty.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getSecret.do")
	@ResponseBody
	public Secret getSecret(ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Secret secret=dutyDao.getSecret();
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("获取保密教育内容");
		String operate_Condition = "";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return secret;
	}
	
	@RequestMapping("/updateDailySecret.do")
	public @ResponseBody String updateDailySecret(Secret secret,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws DataAccessException{
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateDailySecret.do.......................");
		try {
			secret.setUpdateoperator(userSession.getLoginUserName());
			secret.setUpdatetime(addtime);
			dutyDao.updateSecret(secret);
			message = new Message("true","保密教育-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "保密教育-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateDailySecret.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改保密教育内容");
			String operate_Condition = "";
			operate_Condition += "保密教育id = '" + secret.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","保密教育-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "保密教育-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateDailySecret.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改保密教育内容");
			String operate_Condition = "";
			operate_Condition += "保密教育id = '" + secret.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
}

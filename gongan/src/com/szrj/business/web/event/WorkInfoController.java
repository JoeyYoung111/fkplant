package com.szrj.business.web.event;

import java.util.ArrayList;
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
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.event.DefuseInfoDao;
import com.szrj.business.dao.event.EventsInfoDao;
import com.szrj.business.dao.event.KeypersonnelDao;
import com.szrj.business.dao.event.LeadsInfoDao;
import com.szrj.business.dao.event.WorkInfoDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.model.Log;
import com.szrj.business.model.User;
import com.szrj.business.model.event.DefuseInfo;
import com.szrj.business.model.event.EventsInfo;
import com.szrj.business.model.event.Keypersonnel;
import com.szrj.business.model.event.LeadsInfo;
import com.szrj.business.model.event.WorkInfo;

@Controller
@SessionAttributes("userSession")
public class WorkInfoController {
	@Autowired
	private WorkInfoDao workInfoDao;
	@Autowired
	private DefuseInfoDao defuseInfoDao;
	@Autowired
	private EventsInfoDao eventsInfoDao;
	@Autowired
	private LeadsInfoDao leadsInfoDao;
	@Autowired
	private KeypersonnelDao keypersonnelDao;
	@Autowired
	private UserDao userDao;
	@Autowired 
	private LogDao logDao;
	
	@RequestMapping("/searchWorkInfo.do")
	@ResponseBody
	public Map<String,Object> searchWorkInfo(WorkInfo workInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = workInfoDao.search(workInfo, pm);
			if(workInfo.getCdtid()!=0){
				List<WorkInfo> workInfoList = workInfoDao.getWorkInfoNum(workInfo);
				result.put("workInfoList", workInfoList);
			}
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询工作交办信息");
			String operate_Condition = "";
			if(workInfo.getCdtid() != 0){
				operate_Condition += "矛盾id = '" + workInfo.getCdtid() + "'";
			}
			if(workInfo.getCdtname() != null && !"".equals(workInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + workInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + workInfo.getCdtname() + "'";
				}
			}
			if(workInfo.getWtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作单类别 = '" + workInfo.getWtype() + "'";
				}else{
					operate_Condition += " and 工作单类别 = '" + workInfo.getWtype() + "'";
				}
			}
			if(workInfo.getNowstates() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新状态 = '" + workInfo.getNowstates() + "'";
				}else{
					operate_Condition += " and 最新状态 = '" + workInfo.getNowstates() + "'";
				}
			}
			if(workInfo.getStartTime() != null && !"".equals(workInfo.getStartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "下发时间 >= '" + workInfo.getStartTime() + "'";
				}else{
					operate_Condition += " and 下发时间 >= '" + workInfo.getStartTime() + "'";
				}
			}
			if(workInfo.getEndTime() != null && !"".equals(workInfo.getEndTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "下发时间 <= '" + workInfo.getEndTime() + "'";
				}else{
					operate_Condition += " and 下发时间 <= '" + workInfo.getEndTime() + "'";
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
			log.setOperate_Name("查询工作交办信息");
			String operate_Condition = "";
			if(workInfo.getCdtid() != 0){
				operate_Condition += "矛盾id = '" + workInfo.getCdtid() + "'";
			}
			if(workInfo.getCdtname() != null && !"".equals(workInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + workInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + workInfo.getCdtname() + "'";
				}
			}
			if(workInfo.getWtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作单类别 = '" + workInfo.getWtype() + "'";
				}else{
					operate_Condition += " and 工作单类别 = '" + workInfo.getWtype() + "'";
				}
			}
			if(workInfo.getNowstates() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新状态 = '" + workInfo.getNowstates() + "'";
				}else{
					operate_Condition += " and 最新状态 = '" + workInfo.getNowstates() + "'";
				}
			}
			if(workInfo.getStartTime() != null && !"".equals(workInfo.getStartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "下发时间 >= '" + workInfo.getStartTime() + "'";
				}else{
					operate_Condition += " and 下发时间 >= '" + workInfo.getStartTime() + "'";
				}
			}
			if(workInfo.getEndTime() != null && !"".equals(workInfo.getEndTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "下发时间 <= '" + workInfo.getEndTime() + "'";
				}else{
					operate_Condition += " and 下发时间 <= '" + workInfo.getEndTime() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addWorkInfo.do")
	@ResponseBody
	public String addDefuseInfo(WorkInfo workInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			int codenum = workInfoDao.getMaxCode(workInfo);
			if(codenum<999){
				codenum+=1;
			}else{
				codenum=1;
			}
			String code = String.format("%03d", codenum);
			workInfo.setCode(code);
			workInfo.setXftime(addtime);
			workInfo.setXfpername(userSession.getLoginUserName());
			workInfo.setXfperid(userSession.getLoginUserID());
			workInfo.setXfperdep(userSession.getLoginUserDepartname());
			int workInfoid=workInfoDao.add(workInfo);
			message= new Message("true","新增工作交办情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("标题："+workInfo.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			HashMap<String,Object> header=new HashMap<String,Object>();
			header.put("appId", "3a2246a62e771ef900dda58075d6bbdf");
			header.put("level", "2");
			header.put("creatBy", userSession.getLoginUserCode());
			header.put("creatByName", userSession.getLoginUserName());
			User receiverUser=userDao.getById(workInfo.getReceiverid());
			if (receiverUser.getCardnumber()!=null&&!"".equals(receiverUser.getCardnumber())) {
				HashMap<String,Object> receives=new HashMap<String,Object>();
				receives.put("receiveId",receiverUser.getCardnumber());
				receives.put("receiveType","1");
				ArrayList<Object> receivesList=new ArrayList<Object>();
				receivesList.add(receives);
				header.put("receives",receivesList);
				
				HashMap<String,Object> body=new HashMap<String,Object>();
				body.put("title", "风控2.0");
				HashMap<String,Object> content=new HashMap<String,Object>();
				content.put("lx", "指令");
				content.put("qssj", addtime);
				content.put("wcsj", addtime);
				content.put("nr", workInfo.getWcontent());
				content.put("bz", "");
				body.put("content", content);
				body.put("remark", "http://50.64.130.123:9088/JYRiskManage/getWorkInfoShowinfo.post?id="+workInfoid);
				
				HashMap<String,Object> param=new HashMap<String,Object>();
				param.put("sync","false");
				param.put("header",header);
				param.put("body",body);
				//String param="sync=false&header="+JSONObject.fromObject(header).toString()+"&body="+JSONObject.fromObject(body).toString();
				String url = "http://50.64.128.50:6041/message/send/msgc-f96e86229abd";
				SendChat sendchat=new SendChat();
				String result=sendchat.doHttpPost(url,JSONObject.fromObject(param).toString());
				System.out.println("消息中心工作交办推送========"+result);
			}
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("工作交办情况添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增工作交办情况失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+workInfo.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("工作交办情况添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/signWorkInfo.do")
	@ResponseBody
	public String signWorkInfo(WorkInfo workInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		WorkInfo work = workInfoDao.getById(workInfo.getId());
		try {
			workInfo.setQsperid(userSession.getLoginUserID());
			workInfo.setQspername(userSession.getLoginUserName());
			workInfo.setQstime(addtime);
			workInfoDao.sign(workInfo);
			message= new Message("true","签收工作交办情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况签收");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("标题："+work.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("签收工作交办情况");
			String operate_Condition = "";
			operate_Condition += "工作交办情况id = '" + workInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","签收工作交办情况失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况签收");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+work.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("签收工作交办情况");
			String operate_Condition = "";
			operate_Condition += "工作交办情况id = '" + workInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getFeedback.do")
	public String getFeedback(int id,int menuid,ModelMap model,String page) throws Exception{
		model.addAttribute("menuid",menuid);
		WorkInfo workInfo=workInfoDao.getFeedback(id);
		//计算稳控化解数量
		DefuseInfo defuseInfo = new DefuseInfo();
		defuseInfo.setCdtid(workInfo.getCdtid());
		defuseInfo.setWorkinfoid(id);
		workInfo.setDefuseInfocount(defuseInfoDao.search_count(defuseInfo));
		//计算涉稳事件数量
		EventsInfo eventsInfo = new EventsInfo();
		eventsInfo.setCdtid(workInfo.getCdtid());
		eventsInfo.setWorkinfoid(id);
		workInfo.setEventsInfocount(eventsInfoDao.search_count(eventsInfo));
		//计算情报线索数量
		LeadsInfo leadsInfo = new LeadsInfo();
		leadsInfo.setCdtid(workInfo.getCdtid());
		leadsInfo.setWorkinfoid(id);
		workInfo.setLeadsInfocount(leadsInfoDao.search_count(leadsInfo));
		//计算主要组织人员数量
		Keypersonnel keypersonnel = new Keypersonnel();
		keypersonnel.setCdtid(workInfo.getCdtid());
		keypersonnel.setWorkinfoid(id);
		workInfo.setKeypersonnelcount(keypersonnelDao.search_count(keypersonnel));
		model.addAttribute("workInfo",workInfo);
		model.addAttribute("page",page);
		return "/jsp/event/contradictionInfo/workInfo/tsd/feedback";
	}
	
	@RequestMapping("/feedbackWorkInfo.do")
	@ResponseBody
	public String feedbackWorkInfo(WorkInfo workInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		WorkInfo work = workInfoDao.getById(workInfo.getId());
		try {
			workInfo.setFkperid(userSession.getLoginUserID());
			workInfo.setFkname(userSession.getLoginUserName());
			workInfo.setFktime(addtime);
			workInfoDao.feedback(workInfo);
			message= new Message("true","反馈工作交办情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况反馈");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("标题："+work.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("反馈工作交办情况");
			String operate_Condition = "";
			operate_Condition += "工作交办情况id = '" + workInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","反馈工作交办情况失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-工作交办情况反馈");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+work.getWtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("反馈工作交办情况");
			String operate_Condition = "";
			operate_Condition += "工作交办情况id = '" + workInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/printWorkInfo.do")
	public String printWorkInfo(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		WorkInfo workInfo = workInfoDao.getById(id);
		model.addAttribute("workInfo",workInfo);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("打印工作交办情况");
		String operate_Condition = "";
		operate_Condition += "工作交办情况id = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/contradictionInfo/workInfo/tsd/print";
	}
	
	@RequestMapping("/showWorkInfo.do")
	public String showWorkInfo(int id,ModelMap model) throws Exception{
		WorkInfo workInfo = workInfoDao.getById(id);
		model.addAttribute("workInfo",workInfo);
		return "/jsp/event/contradictionInfo/workInfo/tsd/showinfo";
	}
}

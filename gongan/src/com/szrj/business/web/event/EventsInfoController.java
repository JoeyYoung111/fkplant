package com.szrj.business.web.event;

import java.util.HashMap;
import java.util.Iterator;
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
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.dao.event.EventsInfoDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.EventsInfo;

@Controller
@SessionAttributes("userSession")
public class EventsInfoController {
	@Autowired
	private EventsInfoDao eventsInfoDao;
	@Autowired 
	private LogDao logDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	
	@RequestMapping("/searchEventsInfo.do")
	@ResponseBody
	public Map<String,Object> searchEventsInfo(EventsInfo eventsInfo,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = eventsInfoDao.search(eventsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询引发涉稳事件");
			String operate_Condition = "";
			operate_Condition += "矛盾id = '" + eventsInfo.getCdtid() + "'";
			if(eventsInfo.getWorkinfoid()!= 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + eventsInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + eventsInfo.getWorkinfoid() + "'";
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
			log.setOperate_Name("查询引发涉稳事件");
			String operate_Condition = "";
			operate_Condition += "矛盾id = '" + eventsInfo.getCdtid() + "'";
			if(eventsInfo.getWorkinfoid()!= 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + eventsInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + eventsInfo.getWorkinfoid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/searchEventsInfoSynthetic.do")
	@ResponseBody
	public Map<String,Object> searchEventsInfoSynthetic(EventsInfo eventsInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		//根据风险类别查询
		if(eventsInfo.getCdttype()!=null&&!"".equals(eventsInfo.getCdttype())){
			String sql="";
			if(!eventsInfo.getCdttype().contains(",")){
				sql = "FIND_IN_SET("+eventsInfo.getCdttype()+",ct.cdttype)";
			}else{
				String cdttypes[] = eventsInfo.getCdttype().split(",");
				sql = "FIND_IN_SET("+cdttypes[0]+",ct.cdttype)";
				for(int i=1;i<cdttypes.length;i++){
					sql +=" OR FIND_IN_SET("+cdttypes[i]+",ct.cdttype)"; 
				}
			}
			eventsInfo.setSql(sql);
		}
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = eventsInfoDao.searchSynthetic(eventsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("综合查询引发涉稳事件");
			String operate_Condition = "";
			if(eventsInfo.getCdtlevel() != null && !"".equals(eventsInfo.getCdtlevel())){
				operate_Condition += "风险等级 = '" + eventsInfo.getCdtlevel() + "'";
			}
			if(eventsInfo.getCdtname() != null && !"".equals(eventsInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + eventsInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + eventsInfo.getCdtname() + "'";
				}
			}
			if(eventsInfo.getEtitle() != null && !"".equals(eventsInfo.getEtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "事件标题 LIKE '" + eventsInfo.getEtitle() + "'";
				}else{
					operate_Condition += " and 事件标题 LIKE '" + eventsInfo.getEtitle() + "'";
				}
			}
			if(eventsInfo.getSjgk() != null && !"".equals(eventsInfo.getSjgk())){
				if("".equals(operate_Condition)){
					operate_Condition += "事件概况 LIKE '" + eventsInfo.getSjgk() + "'";
				}else{
					operate_Condition += " and 事件概况 LIKE '" + eventsInfo.getSjgk() + "'";
				}
			}
			if(eventsInfo.getSfbwd() != null && !"".equals(eventsInfo.getSfbwd())){
				if("".equals(operate_Condition)){
					operate_Condition += "事发部位 LIKE '" + eventsInfo.getSfbwd() + "'";
				}else{
					operate_Condition += " and 事发部位 LIKE '" + eventsInfo.getSfbwd() + "'";
				}
			}
			if(eventsInfo.getXwfs() != null && !"".equals(eventsInfo.getXwfs())){
				if("".equals(operate_Condition)){
					operate_Condition += "行为方式 LIKE '" + eventsInfo.getXwfs() + "'";
				}else{
					operate_Condition += " and 行为方式 LIKE '" + eventsInfo.getXwfs() + "'";
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
			log.setOperate_Name("综合查询引发涉稳事件");
			String operate_Condition = "";
			if(eventsInfo.getCdtlevel() != null && !"".equals(eventsInfo.getCdtlevel())){
				operate_Condition += "风险等级 = '" + eventsInfo.getCdtlevel() + "'";
			}
			if(eventsInfo.getCdtname() != null && !"".equals(eventsInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + eventsInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + eventsInfo.getCdtname() + "'";
				}
			}
			if(eventsInfo.getEtitle() != null && !"".equals(eventsInfo.getEtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "事件标题 LIKE '" + eventsInfo.getEtitle() + "'";
				}else{
					operate_Condition += " and 事件标题 LIKE '" + eventsInfo.getEtitle() + "'";
				}
			}
			if(eventsInfo.getSjgk() != null && !"".equals(eventsInfo.getSjgk())){
				if("".equals(operate_Condition)){
					operate_Condition += "事件概况 LIKE '" + eventsInfo.getSjgk() + "'";
				}else{
					operate_Condition += " and 事件概况 LIKE '" + eventsInfo.getSjgk() + "'";
				}
			}
			if(eventsInfo.getSfbwd() != null && !"".equals(eventsInfo.getSfbwd())){
				if("".equals(operate_Condition)){
					operate_Condition += "事发部位 LIKE '" + eventsInfo.getSfbwd() + "'";
				}else{
					operate_Condition += " and 事发部位 LIKE '" + eventsInfo.getSfbwd() + "'";
				}
			}
			if(eventsInfo.getXwfs() != null && !"".equals(eventsInfo.getXwfs())){
				if("".equals(operate_Condition)){
					operate_Condition += "行为方式 LIKE '" + eventsInfo.getXwfs() + "'";
				}else{
					operate_Condition += " and 行为方式 LIKE '" + eventsInfo.getXwfs() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addEventsInfo.do")
	@ResponseBody
	public Map<String,Object> addEventsInfo(EventsInfo eventsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			eventsInfo.setAddtime(addtime);
			eventsInfo.setAddoperator(userSession.getLoginUserName());
			eventsInfo.setAddoperatorid(userSession.getLoginUserID());
			eventsInfo.setValidflag(1);
			int id=eventsInfoDao.add(eventsInfo);
			eventsInfo.setId(id);
			result.put("msg", "新增引发涉稳事件成功！");
			result.put("flag", 1);
			result.put("data", eventsInfo);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("事件标题："+eventsInfo.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//更新时间
			ContradictionInfo contradictionInfo = new ContradictionInfo();
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setId(eventsInfo.getCdtid());
			contradictionInfoDao.updateTime(contradictionInfo);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "新增引发涉稳事件失败！");
			result.put("flag", -1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("事件标题："+eventsInfo.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
	
	@RequestMapping("/getEventsInfo.do")
	public String getEventsInfo(int id,int menuid,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		EventsInfo eventsInfo = eventsInfoDao.getById(id);
		model.addAttribute("eventsInfo",eventsInfo);
		model.addAttribute("page",page);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("根据ID查询引发涉稳事件");
		String operate_Condition = "";
		operate_Condition += "引发涉稳事件id = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/contradictionInfo/eventsInfo/update";
	}
	
	@RequestMapping("/updateEventsInfo.do")
	@ResponseBody
	public Map<String,Object> updateEventsInfo(EventsInfo eventsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			EventsInfo eventsInfotemp = eventsInfoDao.getById(eventsInfo.getId());
			eventsInfo.setUpdateoperator(userSession.getLoginUserName());
			eventsInfo.setUpdatetime(addtime);
			eventsInfoDao.update(eventsInfo);
			result.put("msg", "修改引发涉稳事件成功！");
			result.put("flag", 1);
			result.put("data", eventsInfo);
			//判断修改了哪些字段
			JSONObject columnNameObject=JSONObject.fromObject(EventsInfo.columnName);
			JSONObject updateObject=JSONObject.fromObject(eventsInfo);
			JSONObject databaseObject=JSONObject.fromObject(eventsInfotemp);
			Iterator resultIt=columnNameObject.keys();
			String updateColumn="";
			while (resultIt.hasNext()) {
				String keyString=String.valueOf(resultIt.next()).toString();
				String updateString=(String)updateObject.get(keyString).toString();
				String databaseString=(String)databaseObject.get(keyString).toString();
				String columnName=(String)columnNameObject.get(keyString).toString();
				if(!updateString.equals(databaseString)){
					if("".equals(updateColumn)){
						updateColumn=columnName;
					}else{
						updateColumn+=","+columnName;
					}
				}
			}
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult(updateColumn);
			log.setMemo("事件标题："+eventsInfo.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件修改");
			String operate_Condition = "";
			operate_Condition += "引发涉稳事件id = '" + eventsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "修改引发涉稳事件失败！");
			result.put("flag", -1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("事件标题："+eventsInfo.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件修改");
			String operate_Condition = "";
			operate_Condition += "引发涉稳事件id = '" + eventsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
	
	@RequestMapping("/cancelEventsInfo.do")
	@ResponseBody
	public String cancelEventsInfo(EventsInfo eventsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		EventsInfo events=eventsInfoDao.getById(eventsInfo.getId());
		try {
			eventsInfo.setUpdateoperator(userSession.getLoginUserName());
			eventsInfo.setUpdatetime(addtime);
			eventsInfoDao.cancel(eventsInfo);
			message= new Message("true","删除引发涉稳事件成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("事件标题："+events.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件删除");
			String operate_Condition = "";
			operate_Condition += "引发涉稳事件id = '" + eventsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","删除引发涉稳事件失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-引发涉稳事件删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("事件标题："+events.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("引发涉稳事件删除");
			String operate_Condition = "";
			operate_Condition += "引发涉稳事件id = '" + eventsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 显示详情页面
	 * @param id
	 * @param model
	 * @return String
	 */
	
	@RequestMapping("/showInfoEventsInfo.do")
	public String showInfoEventsInfo(int id,ModelMap model){
		EventsInfo eventsInfo = eventsInfoDao.getById(id);
		model.addAttribute("eventsInfo", eventsInfo);
		return "/jsp/event/contradictionInfo/eventsInfo/showinfo";
	}
	
	@RequestMapping("/countEventByWorkinfoid.do")
	@ResponseBody
	public Map<String,Object> countEventByWorkinfoid(EventsInfo eventsInfo){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			int count = eventsInfoDao.countEventByWorkinfoid(eventsInfo);
	        result.put("count", count);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	/**
	 * 政法委
	 * @param eventsInfo
	 * @param pm
	 * @param page
	 * @param request
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/searchEventsInfo_zfw.do")
	@ResponseBody
	public Map<String,Object> searchEventsInfo_zfw(EventsInfo eventsInfo,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = eventsInfoDao.search_zfw(eventsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/showInfoEventsInfo_zfw.do")
	public String showInfoEventsInfo_zfw(int id,ModelMap model){
		EventsInfo eventsInfo = eventsInfoDao.getById_zfw(id);
		model.addAttribute("eventsInfo", eventsInfo);
		return "/jsp/event/contradictionInfo/eventsInfo/showinfo";
	}
	
	@RequestMapping("/zfwEventsInfo_check.do")
	@ResponseBody
	public String zfwEventsInfo_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		EventsInfo events=eventsInfoDao.getById_zfw(id);
		try {
			eventsInfoDao.add(events);
			events.setValidflag(2);
			eventsInfoDao.update_zfw(id);
			message= new Message("true","审查政法委涉稳事件成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-审查政法委涉稳事件");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("事件标题："+events.getEtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委涉稳事件失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
}

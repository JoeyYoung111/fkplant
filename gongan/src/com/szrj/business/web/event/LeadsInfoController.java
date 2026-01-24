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
import com.szrj.business.dao.event.LeadsInfoDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.LeadsInfo;

@Controller
@SessionAttributes("userSession")
public class LeadsInfoController {
	@Autowired
	private LeadsInfoDao leadsInfoDao;
	@Autowired 
	private LogDao logDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	
	@RequestMapping("/searchLeadsInfo.do")
	@ResponseBody
	public Map<String,Object> searchLeadsInfo(LeadsInfo leadsInfo,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = leadsInfoDao.search(leadsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询情报线索信息");
			String operate_Condition = "";
			if(leadsInfo.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + leadsInfo.getCdtid() + "'";
			}
			if(leadsInfo.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + leadsInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + leadsInfo.getWorkinfoid() + "'";
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
			log.setOperate_Name("查询情报线索信息");
			String operate_Condition = "";
			if(leadsInfo.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + leadsInfo.getCdtid() + "'";
			}
			if(leadsInfo.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + leadsInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + leadsInfo.getWorkinfoid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/searchLeadsInfoSynthetic.do")
	@ResponseBody
	public Map<String,Object> searchLeadsInfoSynthetic(LeadsInfo leadsInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		//根据风险类别查询
		if(leadsInfo.getCdttype()!=null&&!"".equals(leadsInfo.getCdttype())){
			String sql="";
			if(!leadsInfo.getCdttype().contains(",")){
				sql = "FIND_IN_SET("+leadsInfo.getCdttype()+",ct.cdttype)";
			}else{
				String cdttypes[] = leadsInfo.getCdttype().split(",");
				sql = "FIND_IN_SET("+cdttypes[0]+",ct.cdttype)";
				for(int i=1;i<cdttypes.length;i++){
					sql +=" OR FIND_IN_SET("+cdttypes[i]+",ct.cdttype)"; 
				}
			}
			leadsInfo.setSql(sql);
		}
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = leadsInfoDao.searchSynthetic(leadsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("综合查询情报线索信息");
			String operate_Condition = "";
			if(leadsInfo.getCdtname() != null && !"".equals(leadsInfo.getCdtname())){
				operate_Condition += "风险名称 LIKE '" + leadsInfo.getCdtname() + "'";
			}
			if(leadsInfo.getCdtlevel() != null && !"".equals(leadsInfo.getCdtlevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险等级 LIKE '" + leadsInfo.getCdtlevel() + "'";
				}else{
					operate_Condition += " and 风险等级 LIKE '" + leadsInfo.getCdtlevel() + "'";
				}
			}
			if(leadsInfo.getLtitle() != null && !"".equals(leadsInfo.getLtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索标题 LIKE '" + leadsInfo.getLtitle() + "'";
				}else{
					operate_Condition += " and 线索标题 LIKE '" + leadsInfo.getLtitle() + "'";
				}
			}
			if(leadsInfo.getLpointto() != null && !"".equals(leadsInfo.getLpointto())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索指向 LIKE '" + leadsInfo.getLpointto() + "'";
				}else{
					operate_Condition += " and 线索指向 LIKE '" + leadsInfo.getLpointto() + "'";
				}
			}
			if(leadsInfo.getLsource() != null && !"".equals(leadsInfo.getLsource())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索来源 LIKE '" + leadsInfo.getLsource() + "'";
				}else{
					operate_Condition += " and 线索来源 LIKE '" + leadsInfo.getLsource() + "'";
				}
			}
			if(leadsInfo.getLcontent() != null && !"".equals(leadsInfo.getLcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索内容 LIKE '" + leadsInfo.getLcontent() + "'";
				}else{
					operate_Condition += " and 线索内容 LIKE '" + leadsInfo.getLcontent() + "'";
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
			log.setOperate_Name("综合查询情报线索信息");
			String operate_Condition = "";
			if(leadsInfo.getCdtname() != null && !"".equals(leadsInfo.getCdtname())){
				operate_Condition += "风险名称 LIKE '" + leadsInfo.getCdtname() + "'";
			}
			if(leadsInfo.getCdtlevel() != null && !"".equals(leadsInfo.getCdtlevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险等级 LIKE '" + leadsInfo.getCdtlevel() + "'";
				}else{
					operate_Condition += " and 风险等级 LIKE '" + leadsInfo.getCdtlevel() + "'";
				}
			}
			if(leadsInfo.getLtitle() != null && !"".equals(leadsInfo.getLtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索标题 LIKE '" + leadsInfo.getLtitle() + "'";
				}else{
					operate_Condition += " and 线索标题 LIKE '" + leadsInfo.getLtitle() + "'";
				}
			}
			if(leadsInfo.getLpointto() != null && !"".equals(leadsInfo.getLpointto())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索指向 LIKE '" + leadsInfo.getLpointto() + "'";
				}else{
					operate_Condition += " and 线索指向 LIKE '" + leadsInfo.getLpointto() + "'";
				}
			}
			if(leadsInfo.getLsource() != null && !"".equals(leadsInfo.getLsource())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索来源 LIKE '" + leadsInfo.getLsource() + "'";
				}else{
					operate_Condition += " and 线索来源 LIKE '" + leadsInfo.getLsource() + "'";
				}
			}
			if(leadsInfo.getLcontent() != null && !"".equals(leadsInfo.getLcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "线索内容 LIKE '" + leadsInfo.getLcontent() + "'";
				}else{
					operate_Condition += " and 线索内容 LIKE '" + leadsInfo.getLcontent() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addLeadsInfo.do")
	@ResponseBody
	public String addLeadsInfo(LeadsInfo leadsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			leadsInfo.setAddtime(addtime);
			leadsInfo.setAddoperator(userSession.getLoginUserName());
			leadsInfo.setAddoperatorid(userSession.getLoginUserID());
			leadsInfo.setValidflag(1);
			leadsInfoDao.add(leadsInfo);
			message= new Message("true","新增情报线索信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-情报线索信息添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("线索标题："+leadsInfo.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//更新时间
			ContradictionInfo contradictionInfo = new ContradictionInfo();
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setId(leadsInfo.getCdtid());
			contradictionInfoDao.updateTime(contradictionInfo);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增情报线索信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-情报线索信息添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("线索标题："+leadsInfo.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getLeadsInfo.do")
	public String getLeadsInfo(int id,int menuid,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		LeadsInfo leadsInfo = leadsInfoDao.getById(id);
		model.addAttribute("leadsInfo",leadsInfo);
		model.addAttribute("page",page);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("根据ID查询情报线索信息");
		String operate_Condition = "";
		operate_Condition += "情报线索ID = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/contradictionInfo/leadsInfo/update";
	}
	
	@RequestMapping("/updateLeadsInfo.do")
	@ResponseBody
	public String updateLeadsInfo(LeadsInfo leadsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			LeadsInfo leadsInfotemp = leadsInfoDao.getById(leadsInfo.getId());
			leadsInfo.setUpdateoperator(userSession.getLoginUserName());
			leadsInfo.setUpdatetime(addtime);
			leadsInfoDao.update(leadsInfo);
			message= new Message("true","修改情报线索信息成功！");
			message.setFlag(1);
			//判断修改了哪些字段
			JSONObject columnNameObject=JSONObject.fromObject(LeadsInfo.columnName);
			JSONObject updateObject=JSONObject.fromObject(leadsInfo);
			JSONObject databaseObject=JSONObject.fromObject(leadsInfotemp);
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
			log.setOperation("风险事件-情报线索信息修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult(updateColumn);
			log.setMemo("线索标题："+leadsInfo.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息修改");
			String operate_Condition = "";
			operate_Condition += "情报线索ID = '" + leadsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","修改情报线索信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-情报线索信息修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("线索标题："+leadsInfo.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息修改");
			String operate_Condition = "";
			operate_Condition += "情报线索ID = '" + leadsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelLeadsInfo.do")
	@ResponseBody
	public String cancelLeadsInfo(LeadsInfo leadsInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		LeadsInfo leads=leadsInfoDao.getById(leadsInfo.getId());
		try {
			leadsInfo.setUpdateoperator(userSession.getLoginUserName());
			leadsInfo.setUpdatetime(addtime);
			leadsInfoDao.cancel(leadsInfo);
			message= new Message("true","删除情报线索信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-情报线索信息删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("线索标题："+leads.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息删除");
			String operate_Condition = "";
			operate_Condition += "情报线索ID = '" + leadsInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","删除情报线索信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-情报线索信息删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("线索标题："+leads.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("情报线索信息删除");
			String operate_Condition = "";
			operate_Condition += "情报线索ID = '" + leadsInfo.getId() + "'";
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
	
	@RequestMapping("/showInfoLeadsInfo.do")
	public String showInfoLeadsInfo(int id,ModelMap model){
		LeadsInfo leadsInfo = leadsInfoDao.getById(id);
		model.addAttribute("leadsInfo", leadsInfo);
		return "/jsp/event/contradictionInfo/leadsInfo/showinfo";
	}
	
	/**
	 * 政法委
	 */
	@RequestMapping("/searchLeadsInfo_zfw.do")
	@ResponseBody
	public Map<String,Object> searchLeadsInfo_zfw(LeadsInfo leadsInfo,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = leadsInfoDao.search_zfw(leadsInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/showInfoLeadsInfo_zfw.do")
	public String showInfoLeadsInfo_zfw(int id,ModelMap model){
		LeadsInfo leadsInfo = leadsInfoDao.getById_zfw(id);
		model.addAttribute("leadsInfo", leadsInfo);
		return "/jsp/event/contradictionInfo/leadsInfo/showinfo";
	}
	
	@RequestMapping("/zfwLeadsInfo_check.do")
	@ResponseBody
	public String zfwLeadsInfo_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		LeadsInfo leadsInfo = leadsInfoDao.getById_zfw(id);
		try {
			leadsInfoDao.add(leadsInfo);
			leadsInfo.setValidflag(2);
			leadsInfoDao.update_zfw(id);
			message= new Message("true","审查政法委情报线索成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-审查政法委情报线索");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("线索标题："+leadsInfo.getLtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委情报线索失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
}

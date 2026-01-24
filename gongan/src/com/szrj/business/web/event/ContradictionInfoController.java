package com.szrj.business.web.event;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import cn.afterturn.easypoi.word.WordExportUtil;
import com.aladdin.model.AxisEvent;
import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.TimeAxis;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeAxisUtil;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.event.AuditRecordDao;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.AuditRecord;
import com.szrj.business.model.event.ContradictionInfo;

@Controller
@SessionAttributes("userSession")
public class ContradictionInfoController {
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private AuditRecordDao auditRecordDao;
	
	@RequestMapping("/searchContradictionInfo.do")
	@ResponseBody
	public Map<String,Object> searchContradictionInfo(ContradictionInfo contradictionInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//是否需要根据角色过滤
			if(contradictionInfo.getCdtname()==null||"".equals(contradictionInfo.getCdtname())){
				if(userSession.getLoginRoleEventFilter()==1){
					contradictionInfo.setRolefilterdept(userSession.getLoginUserDepartmentid());
				}
			}
			if(contradictionInfo.getType()==1){
				//是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
						case 4:
							//巡特警中队过滤多个所属派出所
							contradictionInfo.setZdDeptid(userSession.getLoginUserDepartmentid());
						break;
					}
				}
			}else if(contradictionInfo.getType()==2){
				//是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
						case 1:
							contradictionInfo.setUnitFilter(userSession.getLoginUserDepartmentid());
						break;
						case 2:
							contradictionInfo.setPersonFilter(userSession.getLoginUserID());
						break;
					}
				}
			}
			
			//根据风险类别查询
			if(contradictionInfo.getCdttype()!=null&&!"".equals(contradictionInfo.getCdttype())){
				String sql="";
				if(!contradictionInfo.getCdttype().contains(",")){
					sql = "FIND_IN_SET('"+contradictionInfo.getCdttype()+"',A.cdttype)";
				}else{
					String cdttypes[] = contradictionInfo.getCdttype().split(",");
					sql = "FIND_IN_SET('"+cdttypes[0]+"',A.cdttype)";
					for(int i=1;i<cdttypes.length;i++){
						sql +=" OR FIND_IN_SET('"+cdttypes[i]+"',A.cdttype)"; 
					}
				}
				contradictionInfo.setSql(sql);
			}
	        result.put("code", 0);
			pm.setPageNumber(page);
			NewPageModel pagelist = contradictionInfoDao.searchContradictionInfo(contradictionInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询矛盾风险信息");
			String operate_Condition = "";
			if(contradictionInfo.getCdtlevel() != null && !"".equals(contradictionInfo.getCdtlevel())){
				operate_Condition += "风险等级 LIKE '" + contradictionInfo.getCdtlevel() + "'";
			}
			if(contradictionInfo.getRkdept() != null && !"".equals(contradictionInfo.getRkdept())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加人单位ID IN '" + contradictionInfo.getRkdept() + "'";
				}else{
					operate_Condition += " and 添加人单位ID IN '" + contradictionInfo.getRkdept() + "'";
				}
			}
			if(contradictionInfo.getZbdept() != null && !"".equals(contradictionInfo.getZbdept())){
				if("".equals(operate_Condition)){
					operate_Condition += "主办部门ID IN '" + contradictionInfo.getZbdept() + "'";
				}else{
					operate_Condition += " and 主办部门ID IN '" + contradictionInfo.getZbdept() + "'";
				}
			}
			if(contradictionInfo.getCdtresult() != null && !"".equals(contradictionInfo.getCdtresult())){
				if("".equals(operate_Condition)){
					operate_Condition += "处置结果 LIKE '" + contradictionInfo.getCdtresult() + "'";
				}else{
					operate_Condition += " and 处置结果 LIKE '" + contradictionInfo.getCdtresult() + "'";
				}
			}
			if(contradictionInfo.getIsshield() != -1){
				if("".equals(operate_Condition)){
					operate_Condition += "是否屏蔽 = '" + contradictionInfo.getIsshield() + "'";
				}else{
					operate_Condition += " and 是否屏蔽 = '" + contradictionInfo.getIsshield() + "'";
				}
			}
			if(contradictionInfo.getCdtname() != null && !"".equals(contradictionInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + contradictionInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + contradictionInfo.getCdtname() + "'";
				}
			}
			if(contradictionInfo.getCdtcontent() != null && !"".equals(contradictionInfo.getCdtcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险矛盾概况 LIKE '" + contradictionInfo.getCdtcontent() + "'";
				}else{
					operate_Condition += " and 风险矛盾概况 LIKE '" + contradictionInfo.getCdtcontent() + "'";
				}
			}
			if(contradictionInfo.getNowstate() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新状态 = '" + contradictionInfo.getNowstate() + "'";
				}else{
					operate_Condition += " and 最新状态 = '" + contradictionInfo.getNowstate() + "'";
				}
			}
			if(contradictionInfo.getStartTime() != null && !"".equals(contradictionInfo.getStartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 >= '" + contradictionInfo.getStartTime() + "'";
				}else{
					operate_Condition += " and 添加时间 >= '" + contradictionInfo.getStartTime() + "'";
				}
			}
			if(contradictionInfo.getEndTime() != null && !"".equals(contradictionInfo.getEndTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 <= '" + contradictionInfo.getEndTime() + "'";
				}else{
					operate_Condition += " and 添加时间 <= '" + contradictionInfo.getEndTime() + "'";
				}
			}
			if(contradictionInfo.getUpdatestartTime() != null && !"".equals(contradictionInfo.getUpdatestartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "最新修改时间 >= '" + contradictionInfo.getUpdatestartTime() + "'";
				}else{
					operate_Condition += " and 最新修改时间 >= '" + contradictionInfo.getUpdatestartTime() + "'";
				}
			}
			if(contradictionInfo.getUpdateendTime() != null && !"".equals(contradictionInfo.getUpdateendTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "最新修改时间 <= '" + contradictionInfo.getUpdateendTime() + "'";
				}else{
					operate_Condition += " and 最新修改时间 <= '" + contradictionInfo.getUpdateendTime() + "'";
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
			log.setOperate_Name("查询矛盾风险信息");
			String operate_Condition = "";
			if(contradictionInfo.getCdtlevel() != null && !"".equals(contradictionInfo.getCdtlevel())){
				operate_Condition += "风险等级 LIKE '" + contradictionInfo.getCdtlevel() + "'";
			}
			if(contradictionInfo.getRkdept() != null && !"".equals(contradictionInfo.getRkdept())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加人单位ID IN '" + contradictionInfo.getRkdept() + "'";
				}else{
					operate_Condition += " and 添加人单位ID IN '" + contradictionInfo.getRkdept() + "'";
				}
			}
			if(contradictionInfo.getZbdept() != null && !"".equals(contradictionInfo.getZbdept())){
				if("".equals(operate_Condition)){
					operate_Condition += "主办部门ID IN '" + contradictionInfo.getZbdept() + "'";
				}else{
					operate_Condition += " and 主办部门ID IN '" + contradictionInfo.getZbdept() + "'";
				}
			}
			if(contradictionInfo.getCdtresult() != null && !"".equals(contradictionInfo.getCdtresult())){
				if("".equals(operate_Condition)){
					operate_Condition += "处置结果 LIKE '" + contradictionInfo.getCdtresult() + "'";
				}else{
					operate_Condition += " and 处置结果 LIKE '" + contradictionInfo.getCdtresult() + "'";
				}
			}
			if(contradictionInfo.getIsshield() != -1){
				if("".equals(operate_Condition)){
					operate_Condition += "是否屏蔽 = '" + contradictionInfo.getIsshield() + "'";
				}else{
					operate_Condition += " and 是否屏蔽 = '" + contradictionInfo.getIsshield() + "'";
				}
			}
			if(contradictionInfo.getCdtname() != null && !"".equals(contradictionInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + contradictionInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + contradictionInfo.getCdtname() + "'";
				}
			}
			if(contradictionInfo.getCdtcontent() != null && !"".equals(contradictionInfo.getCdtcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险矛盾概况 LIKE '" + contradictionInfo.getCdtcontent() + "'";
				}else{
					operate_Condition += " and 风险矛盾概况 LIKE '" + contradictionInfo.getCdtcontent() + "'";
				}
			}
			if(contradictionInfo.getNowstate() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新状态 = '" + contradictionInfo.getNowstate() + "'";
				}else{
					operate_Condition += " and 最新状态 = '" + contradictionInfo.getNowstate() + "'";
				}
			}
			if(contradictionInfo.getStartTime() != null && !"".equals(contradictionInfo.getStartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 >= '" + contradictionInfo.getStartTime() + "'";
				}else{
					operate_Condition += " and 添加时间 >= '" + contradictionInfo.getStartTime() + "'";
				}
			}
			if(contradictionInfo.getEndTime() != null && !"".equals(contradictionInfo.getEndTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 <= '" + contradictionInfo.getEndTime() + "'";
				}else{
					operate_Condition += " and 添加时间 <= '" + contradictionInfo.getEndTime() + "'";
				}
			}
			if(contradictionInfo.getUpdatestartTime() != null && !"".equals(contradictionInfo.getUpdatestartTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "最新修改时间 >= '" + contradictionInfo.getUpdatestartTime() + "'";
				}else{
					operate_Condition += " and 最新修改时间 >= '" + contradictionInfo.getUpdatestartTime() + "'";
				}
			}
			if(contradictionInfo.getUpdateendTime() != null && !"".equals(contradictionInfo.getUpdateendTime())){
				if("".equals(operate_Condition)){
					operate_Condition += "最新修改时间 <= '" + contradictionInfo.getUpdateendTime() + "'";
				}else{
					operate_Condition += " and 最新修改时间 <= '" + contradictionInfo.getUpdateendTime() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addContradictionInfo.do")
	@ResponseBody
	public String addContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			contradictionInfo.setAddtime(addtime);
			contradictionInfo.setAddoperator(userSession.getLoginUserName());
			contradictionInfo.setAdddepartment(userSession.getLoginUserDepartmentid());
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setValidflag(1);
			contradictionInfoDao.add(contradictionInfo);
			message= new Message("true","新增矛盾风险信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("添加矛盾风险信息");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增矛盾风险信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("添加矛盾风险信息");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getContradictionInfo.do")
	public String getContradictionInfo(int id,int menuid,String buttons,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		try {
			System.out.println("getContradictionInfo........................buttons="+buttons);
			model.addAttribute("menuid",menuid);
			model.addAttribute("buttons",buttons);
			ContradictionInfo contradictionInfo=contradictionInfoDao.getById(id);
			List<String> cdtnameList = contradictionInfoDao.searchCdtname();
			model.addAttribute("contradictionInfo",contradictionInfo);
			model.addAttribute("cdtnameList",cdtnameList);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("根据ID查询矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + id + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("根据ID查询矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + id + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		
		if("update".equals(page)){
			return "/jsp/event/contradictionInfo/update";
		}else{
			return "/jsp/event/contradictionInfo/updateCheck";
		}
	}
	
	@RequestMapping("/getZbEvent.do")
	public String getZbEvent(int id,int menuid,String buttons,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		try {
			model.addAttribute("menuid",menuid);
			model.addAttribute("buttons",buttons);
			ContradictionInfo contradictionInfo=contradictionInfoDao.getById(id);
			model.addAttribute("contradictionInfo",contradictionInfo);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("根据ID查询政保信息");
			String operate_Condition = "";
			operate_Condition += "政保信息id = '" + id + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);		//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("根据ID查询政保信息");
			String operate_Condition = "";
			operate_Condition += "政保信息id = '" + id + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return "/jsp/event/zbEvent/update";
	}
	
	@RequestMapping("/getCheckContradictionInfo.do")
	public String getCheckContradictionInfo(int id,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		ContradictionInfo contradictionInfo=contradictionInfoDao.getCheckContradictionInfo(id);
		model.addAttribute("contradictionInfo",contradictionInfo);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("根据ID查询矛盾风险信息");
		String operate_Condition = "";
		operate_Condition += "矛盾风险信息id = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/check/check";
	}
	
	@RequestMapping("/updateContradictionInfo.do")
	@ResponseBody
	public String updateContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			ContradictionInfo contradictionInfotemp = contradictionInfoDao.getById(contradictionInfo.getId());
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfoDao.update(contradictionInfo);
			message= new Message("true","修改矛盾风险信息成功！");
			message.setFlag(1);
			//判断修改了哪些字段
			JSONObject columnNameObject=JSONObject.fromObject(ContradictionInfo.columnName);
			JSONObject updateObject=JSONObject.fromObject(contradictionInfo);
			JSONObject databaseObject=JSONObject.fromObject(contradictionInfotemp);
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
			log.setOperation("风险事件-矛盾风险信息修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult(updateColumn);
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("修改矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","修改矛盾风险信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			e.printStackTrace();
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("修改矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelContradictionInfo.do")
	@ResponseBody
	public String cancelContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfoDao.cancel(contradictionInfo);
			message= new Message("true","删除矛盾风险信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("删除矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","删除角色失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("删除矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/checkContradictionInfo.do")
	@ResponseBody
	public String checkContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			contradictionInfo.setExamineman(userSession.getLoginUserName());
			contradictionInfo.setExaminetime(addtime);
			contradictionInfoDao.check(contradictionInfo);
			//记录
			AuditRecord auditRecord = new AuditRecord();
			auditRecord.setCdtid(contradictionInfo.getId());
			auditRecord.setExamineman(userSession.getLoginUserName());
			auditRecord.setExamineopinion(contradictionInfo.getExamineopinion());
			auditRecord.setExaminetime(addtime);
			if(contradictionInfo.getNowstate()==2){
				auditRecord.setResult("审核通过");
			}else if(contradictionInfo.getNowstate()==3){
				auditRecord.setResult("审核不通过");
			}
			auditRecordDao.add(auditRecord);
			contradictionInfo = contradictionInfoDao.getById(contradictionInfo.getId());
			message= new Message("true","审核矛盾风险信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息审核");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("风险名称："+contradictionInfo.getCdtname()+"结果："+auditRecord.getResult());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("审核矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			contradictionInfo = contradictionInfoDao.getById(contradictionInfo.getId());
			message = new Message("false","审核矛盾风险信息失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息审核");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("审核矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/searchTimeaxis.do")
	public String searchTimeaxis(ContradictionInfo contradictionInfo,ModelMap model){
		try {
			contradictionInfo=contradictionInfoDao.getById(contradictionInfo.getId());
			List<AxisEvent> axisTemp = contradictionInfoDao.searchTimeaxis(contradictionInfo);
			List<TimeAxis> axisList = new ArrayList<TimeAxis>();
			if(axisTemp.size()!=0){
				axisList = TimeAxisUtil.getTimeAxis(axisTemp);
			}
			model.addAttribute("axisList",axisList);
			model.addAttribute("contradictionInfo",contradictionInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "/jsp/event/contradictionInfo/timeaxis";
	}
	
	@RequestMapping("/showContradictionInfo.do")
	public String showContradictionInfo(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid",menuid);
		ContradictionInfo contradictionInfo=contradictionInfoDao.getDetailById(id);
		model.addAttribute("contradictionInfo",contradictionInfo);
		if(contradictionInfo.getNowstate()==2){
			return "/jsp/event/contradictionInfo/showinfoCheck";
		}else{
			return "/jsp/event/contradictionInfo/showinfo";
		}
	}
	
	@RequestMapping("/searchCdtname.do")
	@ResponseBody
	public Map<String,Object> searchCdtname(){
		List<String> cdtnameList = contradictionInfoDao.searchCdtname();
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("data", cdtnameList);
		return result;
	}
	
	@RequestMapping("/searchAuditRecord.do")
	@ResponseBody
	public Map<String,Object> searchAuditRecord(AuditRecord auditRecord,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = auditRecordDao.search(auditRecord, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/blockContradictionInfo.do")
	@ResponseBody
	public String blockContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfoDao.block(contradictionInfo);
			message= new Message("true","修改矛盾风险信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息屏蔽");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("屏蔽矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","修改角色失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息屏蔽");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("屏蔽矛盾风险信息");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/addZbEvent.do")
	@ResponseBody
	public String addZbEvent(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			contradictionInfo.setAddtime(addtime);
			contradictionInfo.setAddoperator(userSession.getLoginUserName());
			contradictionInfo.setAdddepartment(userSession.getLoginUserDepartmentid());
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setValidflag(1);
			contradictionInfoDao.addZbEvent(contradictionInfo);
			message= new Message("true","新增政保事件成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保事件添加", userSession.getLoginUserName(), addtime, "政保事件添加成功", "");
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("新增政保事件");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增政保事件失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保事件添加", userSession.getLoginUserName(), addtime, "政保事件添加失败", "");
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("新增政保事件");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/showZbEvent.do")
	public String showZbEvent(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid",menuid);
		ContradictionInfo contradictionInfo=contradictionInfoDao.getDetailById(id);
		model.addAttribute("contradictionInfo",contradictionInfo);
		return "/jsp/event/zbEvent/showinfo";
	}
	
	@RequestMapping("/searchByKeyperson.do")
	@ResponseBody
	public Map<String,Object> searchByKeyperson(ContradictionInfo contradictionInfo,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		//是否需要根据角色过滤
		if(contradictionInfo.getCdtname()==null||"".equals(contradictionInfo.getCdtname())){
			if(userSession.getLoginRoleEventFilter()==1){
				contradictionInfo.setRolefilterdept(userSession.getLoginUserDepartmentid());
			}
		}
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = contradictionInfoDao.searchByKeyperson(contradictionInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/exportContradictionInfo.do")
	public void exportContradictionInfo(ContradictionInfo contradictionInfo,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession,int menuid){
		try {
			ContradictionInfo exportContradictionInfo = contradictionInfoDao.exportContradictionInfo(contradictionInfo);
			//模板位置
			String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\event\\template\\ysyb.docx";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cdtname", exportContradictionInfo.getCdtname());
			if(exportContradictionInfo.getCdtlevel()!=null){
				map.put("cdtlevel", exportContradictionInfo.getCdtlevel());
			}else{
				map.put("cdtlevel", " ");
			}
			if(exportContradictionInfo.getSponsorname()!=null){
				map.put("sponsorname", exportContradictionInfo.getSponsorname());
			}else{
				map.put("sponsorname", " ");
			}
			if(exportContradictionInfo.getTypename()!=null){
				map.put("typename", exportContradictionInfo.getTypename());
			}else{
				map.put("typename", " ");
			}
			if(exportContradictionInfo.getSsrs()!=null){
				map.put("ssrs", exportContradictionInfo.getSsrs());
			}else{
				map.put("ssrs", " ");
			}
			map.put("sjje", exportContradictionInfo.getSjje());
			if(exportContradictionInfo.getSdpcsldxx()!=null){
				map.put("sdpcsldxx", exportContradictionInfo.getSdpcsldxx());
			}else{
				map.put("sdpcsldxxs", " ");
			}
			if(exportContradictionInfo.getSdpcsmjxx()!=null){
				map.put("sdpcsmjxx", exportContradictionInfo.getSdpcsmjxx());
			}else{
				map.put("sdpcsmjxx", " ");
			}
			if(exportContradictionInfo.getZfqtmbxx()!=null){
				map.put("zfqtmbxx", exportContradictionInfo.getZfqtmbxx());
			}else{
				map.put("zfqtmbxx", " ");
			}
			if(exportContradictionInfo.getCdtcontent()!=null){
				map.put("cdtcontent", exportContradictionInfo.getCdtcontent());
			}else{
				map.put("cdtcontent", " ");
			}
			if(exportContradictionInfo.getJtsq()!=null){
				map.put("jtsq", exportContradictionInfo.getJtsq());
			}else{
				map.put("jtsq", " ");
			}
			if(exportContradictionInfo.getExportEventsInfo()!=null&&exportContradictionInfo.getExportEventsInfo().getSjgk()!=null&&!"".equals(exportContradictionInfo.getExportEventsInfo().getSjgk())){
				map.put("sjgk", exportContradictionInfo.getExportEventsInfo().getSjgk());
			}else{
				map.put("sjgk", " ");
			}
			if(exportContradictionInfo.getExportLeadsInfo()!=null&&exportContradictionInfo.getExportLeadsInfo().getLcontent()!=null&&!"".equals(exportContradictionInfo.getExportLeadsInfo().getLcontent())){
				map.put("lcontent", exportContradictionInfo.getExportLeadsInfo().getLcontent());
			}else{
				map.put("lcontent", " ");
			}
			if(exportContradictionInfo.getExportLeadsInfo()!=null&&exportContradictionInfo.getExportLeadsInfo().getCzqkgs()!=null&&!"".equals(exportContradictionInfo.getExportLeadsInfo().getCzqkgs())){
				map.put("czqkgs", exportContradictionInfo.getExportLeadsInfo().getCzqkgs());
			}else{
				map.put("czqkgs", " ");
			}
			if(exportContradictionInfo.getExportDefuseInfo()!=null&&exportContradictionInfo.getExportDefuseInfo().getLsqkks()!=null&&!"".equals(exportContradictionInfo.getExportDefuseInfo().getLsqkks())){
				map.put("lsqkks", exportContradictionInfo.getExportDefuseInfo().getLsqkks());
			}else{
				map.put("lsqkks", " ");
			}
			if(exportContradictionInfo.getExportWorkInfo()!=null&&exportContradictionInfo.getExportWorkInfo().getWcontent()!=null&&!"".equals(exportContradictionInfo.getExportWorkInfo().getWcontent())){
				map.put("wcontent", exportContradictionInfo.getExportWorkInfo().getWcontent());
			}else{
				map.put("wcontent", " ");
			}
			if(exportContradictionInfo.getExportHandleInfo()!=null&&exportContradictionInfo.getExportHandleInfo().getHcontent()!=null&&!"".equals(exportContradictionInfo.getExportHandleInfo().getHcontent())){
				map.put("hcontent", exportContradictionInfo.getExportHandleInfo().getHcontent());
			}else{
				map.put("hcontent", " ");
			}
			XWPFDocument doc = WordExportUtil.exportWord07(templateFileName, map);
			/*设置输出文件名称*/
			String title = exportContradictionInfo.getCdtname()+"_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".docx", "UTF-8"));
			OutputStream outputStream=response.getOutputStream();
			doc.write(outputStream);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息导出");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(TimeFormate.getISOTimeToNow());
			log.setOperationResult("成功");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("矛盾风险信息导出");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾风险信息导出");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(TimeFormate.getISOTimeToNow());
			log.setOperationResult("失败");
			log.setMemo("风险名称："+contradictionInfo.getCdtname());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("矛盾风险信息导出");
			String operate_Condition = "";
			operate_Condition += "矛盾风险信息id = '" + contradictionInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
	}
	
	@RequestMapping("/getMaodunSecurityDist.post")
	public String getQuanjingSecurityDist(ModelMap model,int menuid){
		try {
			model.addAttribute("menuid", menuid);
			ContradictionInfo contradictionInfo=new ContradictionInfo();
			contradictionInfo.setType(1);
			contradictionInfo.setIsshield(0);
			contradictionInfo.setSortsql("order by addtime desc");
			NewPageModel events = contradictionInfoDao.searchContradictionInfo(contradictionInfo,new NewPageModel());
			model.addAttribute("events", events.getRows().toArray());
			List<SelectModel> cdtresults=contradictionInfoDao.countByCdtresult();
			int eventcount=0;
			for (int i = 0; i < cdtresults.size(); i++) {
				eventcount+=Integer.parseInt(cdtresults.get(i).getValue());
			}
			model.addAttribute("eventcount", eventcount);
			model.addAttribute("cdtresults", cdtresults);
			List<SelectModel> eventpercent=contradictionInfoDao.countEventPercentByDepartment();
			model.addAttribute("eventpercent", JSONArray.fromObject(eventpercent).toString());
			List<SelectModel> cdttypes=contradictionInfoDao.countByCdttype();
			model.addAttribute("cdttypes", JSONArray.fromObject(cdttypes).toString());
			//选出最大值
			int max = 0;
			for(int i=0;i<cdttypes.size();i++){
				int value = Integer.parseInt(cdttypes.get(i).getValue());
				if(value>max){
					max = value;
				}
			}
			ArrayList<SelectModel> indicator = new ArrayList<SelectModel>();
			for(int i=0;i<cdttypes.size();i++){
				SelectModel tempModel = new SelectModel();
				tempModel.setName(cdttypes.get(i).getName());
				tempModel.setMax(max);
				indicator.add(tempModel);
			}
			model.addAttribute("indicator", JSONArray.fromObject(indicator).toString());
			List<SelectModel> cdtlevels=contradictionInfoDao.countByCdtlevel();
			model.addAttribute("cdtlevels", cdtlevels);
			List<SelectModel> ssrss=contradictionInfoDao.countBySsrs();
			model.addAttribute("ssrss", JSONArray.fromObject(ssrss).toString());
			List<SelectModel> trend=contradictionInfoDao.countAllTrendEvent();
			model.addAttribute("trend", JSONArray.fromObject(trend).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/security-dist/maodun";
	}
	
	@RequestMapping("/searchContradictionInfo_zfw.do")
	@ResponseBody
	public Map<String,Object> searchContradictionInfo_zfw(ContradictionInfo contradictionInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//根据风险类别查询
			if(contradictionInfo.getCdttype()!=null&&!"".equals(contradictionInfo.getCdttype())){
				String sql="";
				if(!contradictionInfo.getCdttype().contains(",")){
					sql = "FIND_IN_SET('"+contradictionInfo.getCdttype()+"',A.cdttype)";
				}else{
					String cdttypes[] = contradictionInfo.getCdttype().split(",");
					sql = "FIND_IN_SET('"+cdttypes[0]+"',A.cdttype)";
					for(int i=1;i<cdttypes.length;i++){
						sql +=" OR FIND_IN_SET('"+cdttypes[i]+"',A.cdttype)"; 
					}
				}
				contradictionInfo.setSql(sql);
			}
	        result.put("code", 0);
			pm.setPageNumber(page);
			NewPageModel pagelist = contradictionInfoDao.searchContradictionInfo_zfw(contradictionInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/getContradictionInfo_zfw.do")
	public String getContradictionInfo_zfw(int id,int menuid,String buttons,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		try {
			model.addAttribute("menuid",menuid);
			model.addAttribute("buttons",buttons);
			ContradictionInfo contradictionInfo=contradictionInfoDao.getById_zfw(id);
			List<String> cdtnameList = contradictionInfoDao.searchCdtname();
			model.addAttribute("contradictionInfo",contradictionInfo);
			model.addAttribute("cdtnameList",cdtnameList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/event/zfw_check/check";
	}
	
	@RequestMapping("/checkZfwContradictionInfo.do")
	@ResponseBody
	public String checkZfwContradictionInfo(ContradictionInfo contradictionInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			String cdtname = contradictionInfo.getCdtname();
			contradictionInfo.setExamineman(userSession.getLoginUserName());
			contradictionInfo.setExaminetime(addtime);
			contradictionInfoDao.check_zfw(contradictionInfo);
			String result="";
			if(contradictionInfo.getNowstate()==2){
				result="审核通过";
			}else if(contradictionInfo.getNowstate()==3){
				result="审核不通过";
			}
			contradictionInfo = contradictionInfoDao.getById(contradictionInfo.getId());
			message= new Message("true","审核政法委风险信息成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-政法委风险信息审核");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("风险名称："+cdtname+"结果："+result);
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审核矛盾风险信息失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
}

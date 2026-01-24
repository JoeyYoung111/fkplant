package com.szrj.business.web.event;

import java.util.HashMap;
import java.util.Iterator;
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
import com.szrj.business.dao.event.HandleInfoDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.HandleInfo;

@Controller
@SessionAttributes("userSession")
public class HandleInfoController {
	@Autowired
	private HandleInfoDao handleInfoDao;
	@Autowired 
	private LogDao logDao;
	
	@RequestMapping("/searchHandleInfo.do")
	@ResponseBody
	public Map<String,Object> searchHandleInfo(HandleInfo handleInfo,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = handleInfoDao.search(handleInfo, pm);
			List<HandleInfo> handleInfoList = handleInfoDao.getHandleInfoNum(handleInfo);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        result.put("handleInfoList", handleInfoList);
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询领导交办情况");
			String operate_Condition = "";
			operate_Condition += "矛盾id = '" + handleInfo.getCdtid() + "'";
			operate_Condition += " and 工作单类别 = '" + handleInfo.getHtype() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询领导交办情况");
			String operate_Condition = "";
			operate_Condition += "矛盾id = '" + handleInfo.getCdtid() + "'";
			operate_Condition += " and 工作单类别 = '" + handleInfo.getHtype() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/searchHandleInfoSynthetic.do")
	@ResponseBody
	public Map<String,Object> searchHandleInfoSynthetic(HandleInfo handleInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = handleInfoDao.searchSynthetic(handleInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("综合查询领导交办情况");
			String operate_Condition = "";
			if(handleInfo.getHtype()!= 0){
				operate_Condition += "工作单类别 = '" + handleInfo.getHtype() + "'";
			}
			if(handleInfo.getCdtname() != null && !"".equals(handleInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + handleInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + handleInfo.getCdtname() + "'";
				}
			}
			if(handleInfo.getHtitle() != null && !"".equals(handleInfo.getHtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + handleInfo.getHtitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + handleInfo.getHtitle() + "'";
				}
			}
			if(handleInfo.getHcontent() != null && !"".equals(handleInfo.getHcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + handleInfo.getHcontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + handleInfo.getHcontent() + "'";
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
			log.setOperate_Name("综合查询领导交办情况");
			String operate_Condition = "";
			if(handleInfo.getHtype()!= 0){
				operate_Condition += "工作单类别 = '" + handleInfo.getHtype() + "'";
			}
			if(handleInfo.getCdtname() != null && !"".equals(handleInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + handleInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + handleInfo.getCdtname() + "'";
				}
			}
			if(handleInfo.getHtitle() != null && !"".equals(handleInfo.getHtitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + handleInfo.getHtitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + handleInfo.getHtitle() + "'";
				}
			}
			if(handleInfo.getHcontent() != null && !"".equals(handleInfo.getHcontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + handleInfo.getHcontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + handleInfo.getHcontent() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addHandleInfo.do")
	@ResponseBody
	public String addHandleInfo(HandleInfo handleInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
			String title="";
			if(handleInfo.getHtype()==1){
				title="领导批示";
			}else if(handleInfo.getHtype()==2){
				title="涉稳专报";
			}else if(handleInfo.getHtype()==3){
				title="维稳专报";
			}else if(handleInfo.getHtype()==4){
				title="涉稳风险交办处置建议";
			}else if(handleInfo.getHtype()==5){
				title="专题会议纪要";
			}
		try {
			handleInfo.setAddtime(addtime);
			handleInfo.setAddoperator(userSession.getLoginUserName());
			handleInfo.setAddoperatorid(userSession.getLoginUserID());
			handleInfo.setValidflag(1);
			handleInfoDao.add(handleInfo);
			message= new Message("true","添加"+title+"成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-交办情况-"+title+"-添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("标题："+handleInfo.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("新增领导交办情况");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("true","添加"+title+"失败！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-交办情况-"+title+"-添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+handleInfo.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("新增领导交办情况");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getHandleInfo.do")
	public String getHandleInfo(int id,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		HandleInfo handleInfo = handleInfoDao.getById(id);
		model.addAttribute("handleInfo",handleInfo);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("根据ID查询领导交办情况");
		String operate_Condition = "";
		operate_Condition += "领导交办情况ID = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/contradictionInfo/handleInfo/update";
	}
	
	@RequestMapping("/updateHandleInfo.do")
	@ResponseBody
	public String updateDefuseInfo(HandleInfo handleInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
			String title="";
			if(handleInfo.getHtype()==1){
				title="领导批示";
			}else if(handleInfo.getHtype()==2){
				title="涉稳专报";
			}else if(handleInfo.getHtype()==3){
				title="维稳专报";
			}else if(handleInfo.getHtype()==4){
				title="涉稳风险交办处置建议";
			}else if(handleInfo.getHtype()==5){
				title="专题会议纪要";
			}
		try {
			HandleInfo handleInfotemp = handleInfoDao.getById(handleInfo.getId());
			handleInfo.setUpdateoperator(userSession.getLoginUserName());
			handleInfo.setUpdatetime(addtime);
			handleInfoDao.update(handleInfo);
			message= new Message("true","修改"+title+"成功！");
			message.setFlag(1);
			//判断修改了哪些字段
			JSONObject columnNameObject=JSONObject.fromObject(HandleInfo.columnName);
			JSONObject updateObject=JSONObject.fromObject(handleInfo);
			JSONObject databaseObject=JSONObject.fromObject(handleInfotemp);
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
			log.setOperation("风险事件-交办情况-"+title+"-修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult(updateColumn);
			log.setMemo("标题："+handleInfo.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("修改领导交办情况");
			String operate_Condition = "";
			operate_Condition += "领导交办情况ID = '" + handleInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message= new Message("true","修改"+title+"失败！");
			message.setFlag(-1);
			e.printStackTrace();
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-交办情况-"+title+"-修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+handleInfo.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("修改领导交办情况");
			String operate_Condition = "";
			operate_Condition += "领导交办情况ID = '" + handleInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelHandleInfo.do")
	@ResponseBody
	public String cancelHandleInfo(HandleInfo handleInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		String title="";
		if(handleInfo.getHtype()==1){
			title="领导批示";
		}else if(handleInfo.getHtype()==2){
			title="涉稳专报";
		}else if(handleInfo.getHtype()==3){
			title="维稳专报";
		}else if(handleInfo.getHtype()==4){
			title="涉稳风险交办处置建议";
		}else if(handleInfo.getHtype()==5){
			title="专题会议纪要";
		}
		HandleInfo handle = handleInfoDao.getById(handleInfo.getId());
		try {
			handleInfo.setUpdateoperator(userSession.getLoginUserName());
			handleInfo.setUpdatetime(addtime);
			handleInfoDao.cancel(handleInfo);
			message= new Message("true","删除"+title+"成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-交办情况-"+title+"-删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("标题："+handle.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("删除领导交办情况");
			String operate_Condition = "";
			operate_Condition += "领导交办情况ID = '" + handleInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			handleInfo = handleInfoDao.getById(handleInfo.getId());
			message= new Message("true","删除"+title+"失败！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-交办情况-"+title+"-删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("标题："+handle.getHtitle());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("删除领导交办情况");
			String operate_Condition = "";
			operate_Condition += "领导交办情况ID = '" + handleInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/showHandleInfo.do")
	public String showHandleInfo(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid",menuid);
		HandleInfo handleInfo = handleInfoDao.getById(id);
		model.addAttribute("handleInfo",handleInfo);
		return "/jsp/event/contradictionInfo/handleInfo/showinfo";
	}
}

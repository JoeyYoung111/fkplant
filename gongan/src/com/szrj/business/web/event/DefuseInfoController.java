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
import com.szrj.business.dao.event.DefuseInfoDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.DefuseInfo;

@Controller
@SessionAttributes("userSession")
public class DefuseInfoController {
	@Autowired
	private DefuseInfoDao defuseInfoDao;
	@Autowired 
	private LogDao logDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	
	@RequestMapping("/searchDefuseInfo.do")
	@ResponseBody
	public Map<String,Object> searchDefuseInfo(DefuseInfo defuseInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = defuseInfoDao.search(defuseInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询稳控化解情况");
			String operate_Condition = "";
			if(defuseInfo.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + defuseInfo.getCdtid() + "'";
			}
			if(defuseInfo.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + defuseInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + defuseInfo.getWorkinfoid() + "'";
				}
			}
			if(defuseInfo.getCdtname() != null && !"".equals(defuseInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + defuseInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + defuseInfo.getCdtname() + "'";
				}
			}
			if(defuseInfo.getCsgs() != null && !"".equals(defuseInfo.getCsgs())){
				if("".equals(operate_Condition)){
					operate_Condition += "措施概述 LIKE '" + defuseInfo.getCsgs() + "'";
				}else{
					operate_Condition += " and 措施概述 LIKE '" + defuseInfo.getCsgs() + "'";
				}
			}
			if(defuseInfo.getLsqkks() != null && !"".equals(defuseInfo.getLsqkks())){
				if("".equals(operate_Condition)){
					operate_Condition += "落实情况概述 LIKE '" + defuseInfo.getLsqkks() + "'";
				}else{
					operate_Condition += " and 落实情况概述 LIKE '" + defuseInfo.getLsqkks() + "'";
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
			log.setOperate_Name("查询稳控化解情况");
			String operate_Condition = "";
			if(defuseInfo.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + defuseInfo.getCdtid() + "'";
			}
			if(defuseInfo.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + defuseInfo.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + defuseInfo.getWorkinfoid() + "'";
				}
			}
			if(defuseInfo.getCdtname() != null && !"".equals(defuseInfo.getCdtname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险名称 LIKE '" + defuseInfo.getCdtname() + "'";
				}else{
					operate_Condition += " and 风险名称 LIKE '" + defuseInfo.getCdtname() + "'";
				}
			}
			if(defuseInfo.getCsgs() != null && !"".equals(defuseInfo.getCsgs())){
				if("".equals(operate_Condition)){
					operate_Condition += "措施概述 LIKE '" + defuseInfo.getCsgs() + "'";
				}else{
					operate_Condition += " and 措施概述 LIKE '" + defuseInfo.getCsgs() + "'";
				}
			}
			if(defuseInfo.getLsqkks() != null && !"".equals(defuseInfo.getLsqkks())){
				if("".equals(operate_Condition)){
					operate_Condition += "落实情况概述 LIKE '" + defuseInfo.getLsqkks() + "'";
				}else{
					operate_Condition += " and 落实情况概述 LIKE '" + defuseInfo.getLsqkks() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addDefuseInfo.do")
	@ResponseBody
	public String addDefuseInfo(DefuseInfo defuseInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			defuseInfo.setAddtime(addtime);
			defuseInfo.setAddoperator(userSession.getLoginUserName());
			defuseInfo.setAddoperatorid(userSession.getLoginUserID());
			defuseInfo.setValidflag(1);
			defuseInfoDao.add(defuseInfo);
			message= new Message("true","新增稳控化解情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-稳控化解情况添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("措施概述："+defuseInfo.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//更新时间
			ContradictionInfo contradictionInfo = new ContradictionInfo();
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setId(defuseInfo.getCdtid());
			contradictionInfoDao.updateTime(contradictionInfo);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增稳控化解情况失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-稳控化解情况添加");
			log.setOperator(addtime);
			log.setOperationTime(TimeFormate.getISOTimeToNow());
			log.setOperationResult("失败");
			log.setMemo("措施概述："+defuseInfo.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getDefuseInfo.do")
	public String getDefuseInfo(int id,int menuid,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		DefuseInfo defuseInfo = defuseInfoDao.getById(id);
		model.addAttribute("defuseInfo",defuseInfo);
		model.addAttribute("page",page);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("根据ID查询稳控化解情况");
		String operate_Condition = "";
		operate_Condition += "稳控化解情况id = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/event/contradictionInfo/defuseInfo/update";
	}
	
	@RequestMapping("/updateDefuseInfo.do")
	@ResponseBody
	public String updateDefuseInfo(DefuseInfo defuseInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			DefuseInfo defuseInfotemp = defuseInfoDao.getById(defuseInfo.getId());
			defuseInfo.setUpdateoperator(userSession.getLoginUserName());
			defuseInfo.setUpdatetime(addtime);
			defuseInfoDao.update(defuseInfo);
			message= new Message("true","修改稳控化解情况成功！");
			message.setFlag(1);
			//判断修改了哪些字段
			JSONObject columnNameObject=JSONObject.fromObject(DefuseInfo.columnName);
			JSONObject updateObject=JSONObject.fromObject(defuseInfo);
			JSONObject databaseObject=JSONObject.fromObject(defuseInfotemp);
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
			log.setOperation("风险事件-稳控化解情况修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult(updateColumn);
			log.setMemo("措施概述："+defuseInfo.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况修改");
			String operate_Condition = "";
			operate_Condition += "稳控化解情况id = '" + defuseInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","修改稳控化解情况失败！");
			message.setFlag(-1);
			e.printStackTrace();
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-稳控化解情况修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("措施概述："+defuseInfo.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况修改");
			String operate_Condition = "";
			operate_Condition += "稳控化解情况id = '" + defuseInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelDefuseInfo.do")
	@ResponseBody
	public String cancelDefuseInfo(DefuseInfo defuseInfo,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		DefuseInfo defuse = defuseInfoDao.getById(defuseInfo.getId());
		try {
			defuseInfo.setUpdateoperator(userSession.getLoginUserName());
			defuseInfo.setUpdatetime(addtime);
			defuseInfoDao.cancel(defuseInfo);
			message= new Message("true","删除稳控化解情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-稳控化解情况删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("措施概述："+defuse.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况删除");
			String operate_Condition = "";
			operate_Condition += "稳控化解情况id = '" + defuseInfo.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","删除稳控化解情况失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-稳控化解情况删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("措施概述："+defuse.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("稳控化解情况删除");
			String operate_Condition = "";
			operate_Condition += "稳控化解情况id = '" + defuseInfo.getId() + "'";
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
	
	@RequestMapping("/showInfoDefuseInfo.do")
	public String showInfoDefuseInfo(int id,ModelMap model){
		DefuseInfo defuseInfo = defuseInfoDao.getById(id);
		model.addAttribute("defuseInfo", defuseInfo);
		return "/jsp/event/contradictionInfo/defuseInfo/showinfo";
	}
	
	@RequestMapping("/searchDefuseInfo_zfw.do")
	@ResponseBody
	public Map<String,Object> searchDefuseInfo_zfw(DefuseInfo defuseInfo,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = defuseInfoDao.search_zfw(defuseInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/zfwDefuseInfo_check.do")
	@ResponseBody
	public String zfwDefuseInfo_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		DefuseInfo defuseInfo=defuseInfoDao.getById_zfw(id);
		try {
			defuseInfoDao.add(defuseInfo);
			defuseInfo.setValidflag(2);
			defuseInfoDao.update_zfw(id);
			message= new Message("true","审查政法委稳控化解情况成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-审查政法委稳控化解情况");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("措施概述："+defuseInfo.getCsgs());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委稳控化解情况失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/showInfoDefuseInfo_zfw.do")
	public String showInfoDefuseInfo_zfw(int id,ModelMap model){
		DefuseInfo defuseInfo = defuseInfoDao.getById_zfw(id);
		model.addAttribute("defuseInfo", defuseInfo);
		return "/jsp/event/contradictionInfo/defuseInfo/showinfo";
	}
}

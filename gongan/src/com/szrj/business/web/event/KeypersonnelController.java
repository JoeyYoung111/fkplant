package com.szrj.business.web.event;

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
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.dao.event.KeypersonnelDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.Keypersonnel;

@Controller
@SessionAttributes("userSession")
public class KeypersonnelController {
	@Autowired
	private KeypersonnelDao keypersonnelDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private PersonnelDao personnelDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	
	@RequestMapping("/searchKeypersonnel.do")
	@ResponseBody
	public Map<String,Object> searchKeypersonnel(Keypersonnel keypersonnel,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = keypersonnelDao.search(keypersonnel, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询矛盾主要组织人员");
			String operate_Condition = "";
			if(keypersonnel.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + keypersonnel.getCdtid() + "'";
			}
			if(keypersonnel.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + keypersonnel.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + keypersonnel.getWorkinfoid() + "'";
				}
			}
			if(keypersonnel.getCardnumber() != null && !"".equals(keypersonnel.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 LIKE '" + keypersonnel.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 LIKE '" + keypersonnel.getCardnumber() + "'";
				}
			}
			if(keypersonnel.getPersonname() != null && !"".equals(keypersonnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + keypersonnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + keypersonnel.getPersonname() + "'";
				}
			}
			if(keypersonnel.getHouseplace() != null && !"".equals(keypersonnel.getHouseplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "户籍地详址 LIKE '" + keypersonnel.getHouseplace() + "'";
				}else{
					operate_Condition += " and 户籍地详址 LIKE '" + keypersonnel.getHouseplace() + "'";
				}
			}
			if(keypersonnel.getHomeplace() != null && !"".equals(keypersonnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + keypersonnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + keypersonnel.getHomeplace() + "'";
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
			log.setOperate_Name("查询矛盾主要组织人员");
			String operate_Condition = "";
			if(keypersonnel.getCdtid()!= 0){
				operate_Condition += "矛盾id = '" + keypersonnel.getCdtid() + "'";
			}
			if(keypersonnel.getWorkinfoid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "工作交办ID = '" + keypersonnel.getWorkinfoid() + "'";
				}else{
					operate_Condition += " and 工作交办ID = '" + keypersonnel.getWorkinfoid() + "'";
				}
			}
			if(keypersonnel.getCardnumber() != null && !"".equals(keypersonnel.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 LIKE '" + keypersonnel.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 LIKE '" + keypersonnel.getCardnumber() + "'";
				}
			}
			if(keypersonnel.getPersonname() != null && !"".equals(keypersonnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + keypersonnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + keypersonnel.getPersonname() + "'";
				}
			}
			if(keypersonnel.getHouseplace() != null && !"".equals(keypersonnel.getHouseplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "户籍地详址 LIKE '" + keypersonnel.getHouseplace() + "'";
				}else{
					operate_Condition += " and 户籍地详址 LIKE '" + keypersonnel.getHouseplace() + "'";
				}
			}
			if(keypersonnel.getHomeplace() != null && !"".equals(keypersonnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + keypersonnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + keypersonnel.getHomeplace() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/searchKeypersonnel_ZbEvent.do")
	@ResponseBody
	public Map<String,Object> searchKeypersonnel_ZbEvent(Keypersonnel keypersonnel,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = keypersonnelDao.search_Zbevent(keypersonnel, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addKeypersonnel.do")
	@ResponseBody
	public String addKeypersonnel(Keypersonnel keypersonnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		keypersonnel.setAddtime(addtime);
		keypersonnel.setAddoperator(userSession.getLoginUserName());
		keypersonnel.setAddoperatorid(userSession.getLoginUserID());
		keypersonnel.setValidflag(1);
		int id = 0;
		if(keypersonnel.getPersonnelid()!=0){
			id=keypersonnel.getPersonnelid();
		}else{
			//判断是否数据库中已存在
			id = personnelDao.findPersonInPersonnel(keypersonnel.getCardnumber());
		}
		if(id>0){
			//存在,新增关联
			try {
				keypersonnel.setPersonnelid(id);
				if(keypersonnelDao.count_link(keypersonnel)==0){
					keypersonnelDao.add(keypersonnel);
					message= new Message("true","新增关联成功！");
					message.setFlag(1);
					//日志
					Log log = new Log();
					log.setMenuId(menuid);
					log.setOperation("风险事件-人员关联添加");
					log.setOperator(userSession.getLoginUserName());
					log.setOperationTime(addtime);
					log.setOperationResult("成功");
					log.setMemo("人员身份证："+keypersonnel.getCardnumber());
					log.setOperatedept(userSession.getLoginUserDepartname());
					logDao.recordEventLog(log);
					//更新时间
					ContradictionInfo contradictionInfo = new ContradictionInfo();
					contradictionInfo.setUpdatetime(addtime);
					contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
					contradictionInfo.setId(keypersonnel.getCdtid());
					contradictionInfoDao.updateTime(contradictionInfo);
					
					//生成操作日志
					UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
					alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
					alog.setOperate_Result("1");	//0：失败 1：成功
					alog.setOperate_Name("人员关联添加");
					String operate_Condition = "";
					alog.setOperate_Condition(operate_Condition);
					alog.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(alog);
				}else{
					if(keypersonnel.getWorkinfoid()==0){
						message= new Message("true","关联已存在！");
						message.setFlag(-2);
						//日志
						Log log = new Log();
						log.setMenuId(menuid);
						log.setOperation("风险事件-人员关联已存在");
						log.setOperator(userSession.getLoginUserName());
						log.setOperationTime(addtime);
						log.setOperationResult("风险事件-人员关联已存在");
						log.setMemo("人员身份证："+keypersonnel.getCardnumber());
						log.setOperatedept(userSession.getLoginUserDepartname());
						logDao.recordEventLog(log);
						//生成操作日志
						UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
						alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
						alog.setOperate_Result("0");	//0：失败 1：成功
						alog.setOperate_Name("人员关联添加");
						String operate_Condition = "";
						alog.setOperate_Condition(operate_Condition);
						alog.setTerminal_ID(request.getRemoteAddr());
						CreateLogXML.UserActionLog(alog);
					}else{
						keypersonnelDao.updateLink(keypersonnel);
						message= new Message("true","关联交办工作成功！");
						message.setFlag(2);
						//日志
						Log log = new Log();
						log.setMenuId(menuid);
						log.setOperation("风险事件-人员关联交办工作");
						log.setOperator(userSession.getLoginUserName());
						log.setOperationTime(addtime);
						log.setOperationResult("成功");
						log.setMemo("人员身份证："+keypersonnel.getCardnumber());
						log.setOperatedept(userSession.getLoginUserDepartname());
						logDao.recordEventLog(log);
						
						//生成操作日志
						UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
						alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
						alog.setOperate_Result("1");	//0：失败 1：成功
						alog.setOperate_Name("风险事件-人员关联交办工作");
						String operate_Condition = "";
						operate_Condition += "风险人员id = '" + keypersonnel.getPersonnelid() + "'";
						alog.setOperate_Condition(operate_Condition);
						alog.setTerminal_ID(request.getRemoteAddr());
						CreateLogXML.UserActionLog(alog);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				message = new Message("false","新增关联失败！");
				message.setFlag(-1);
				//日志
				Log log = new Log();
				log.setMenuId(menuid);
				log.setOperation("风险事件-人员关联添加");
				log.setOperator(userSession.getLoginUserName());
				log.setOperationTime(addtime);
				log.setOperationResult("失败");
				log.setMemo("人员身份证："+keypersonnel.getCardnumber());
				log.setOperatedept(userSession.getLoginUserDepartname());
				logDao.recordEventLog(log);
				//生成操作日志
				UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
				alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				alog.setOperate_Result("0");	//0：失败 1：成功
				alog.setOperate_Name("人员关联添加");
				String operate_Condition = "";
				alog.setOperate_Condition(operate_Condition);
				alog.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(alog);
			}
		}else{
			message = new Message("false","组织人员不存在");
			message.setFlag(0);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelKeypersonnel.do")
	@ResponseBody
	public String cancelKeypersonnel(Keypersonnel keypersonnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			keypersonnel.setUpdateoperator(userSession.getLoginUserName());
			keypersonnel.setUpdatetime(addtime);
			keypersonnelDao.cancel(keypersonnel);
			message= new Message("true","删除矛盾主要组织人员成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾主要组织人员删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("人员身份证："+keypersonnel.getCardnumber());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("矛盾主要组织人员删除");
			String operate_Condition = "";
			operate_Condition += "矛盾主要组织人员id = '" + keypersonnel.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			message = new Message("false","删除矛盾主要组织人员失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-矛盾主要组织人员删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("人员身份证："+keypersonnel.getCardnumber());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("矛盾主要组织人员删除");
			String operate_Condition = "";
			operate_Condition += "矛盾人员关联id = '" + keypersonnel.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 政法委
	 * @param keypersonnel
	 * @param pm
	 * @param request
	 * @param userSession
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchKeypersonnel_zfw.do")
	@ResponseBody
	public Map<String,Object> searchKeypersonnel_zfw(Keypersonnel keypersonnel,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = keypersonnelDao.search_zfw(keypersonnel, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/zfwKeypersonnel_check.do")
	@ResponseBody
	public String zfwKeypersonnel_check(int id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		Keypersonnel keypersonnel=keypersonnelDao.getById_zfw(id);
		try {
			keypersonnelDao.add(keypersonnel);
			keypersonnel.setValidflag(2);
			keypersonnelDao.update_zfw(id);
			message= new Message("true","审查政法委主要组织人员成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险事件-审查政法委主要组织人员");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("人员身份证："+keypersonnel.getCardnumber());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审查政法委主要组织人员失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateKpImportance.do")
	@ResponseBody
	public Map<String,Object> updateKpImportance(Keypersonnel keypersonnel){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			keypersonnelDao.updateKpImportance(keypersonnel);
			result.put("msg", "修改重要程度成功！");
			result.put("flag", 1);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "修改重要程度失败！");
			result.put("flag", -1);
		}
		return result;
	}
}

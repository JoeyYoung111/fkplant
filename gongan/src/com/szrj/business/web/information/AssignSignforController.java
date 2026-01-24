package com.szrj.business.web.information;

import java.text.SimpleDateFormat;
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
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.information.AssignSignforDao;
import com.szrj.business.dao.information.InfoAssignDao;
import com.szrj.business.model.information.AssignSignfor;
import com.szrj.business.model.information.InfoAssign;

@Controller
@SessionAttributes("userSession")
public class AssignSignforController {

	@Autowired
	private InfoAssignDao infoAssignDao;
	@Autowired
	private AssignSignforDao assignSignforDao;
	@Autowired
	private LogDao logDao;
	
	/**
	 * 查询接收的交办的信息
	 * @param infoAssign
	 * @param pm
	 * @return
	 */
	@RequestMapping("/searchAssignSignfor.do")
	@ResponseBody
	public Map<String, Object> search(AssignSignfor assignSignfor,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchAssignSignfor.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			NewPageModel pagelist = assignSignforDao.search(assignSignfor, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total",pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询交办签收反馈");
			String operate_Condition = "";
			if(assignSignfor.getAssignid()!= 0){
				operate_Condition += "交办信息id = '" + assignSignfor.getAssignid() + "'";
			}
			if(assignSignfor.getReceiveid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "接收单位id = '" + assignSignfor.getReceiveid() + "'";
				}else{
					operate_Condition += " and 接收单位id = '" + assignSignfor.getReceiveid() + "'";
				}
			}
			if(assignSignfor.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(1-未签收 2-已签收（未反馈） 3-已反馈) = '" + assignSignfor.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(1-未签收 2-已签收（未反馈） 3-已反馈) = '" + assignSignfor.getValidflag() + "'";
				}
			}
			if(assignSignfor.getAssigntitle() != null && !"".equals(assignSignfor.getAssigntitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + assignSignfor.getAssigntitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + assignSignfor.getAssigntitle() + "'";
				}
			}
			if(assignSignfor.getAssigncontent() != null && !"".equals(assignSignfor.getAssigncontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + assignSignfor.getAssigncontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + assignSignfor.getAssigncontent() + "'";
				}
			}
			if(assignSignfor.getUrgentflag() != null && !"".equals(assignSignfor.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + assignSignfor.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + assignSignfor.getUrgentflag() + "'";
				}
			}
			if(assignSignfor.getCategory() != null && !"".equals(assignSignfor.getCategory())){
				if("".equals(operate_Condition)){
					operate_Condition += "类别 = '" + assignSignfor.getCategory() + "'";
				}else{
					operate_Condition += " and 类别 = '" + assignSignfor.getCategory() + "'";
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
			log.setOperate_Name("查询交办签收反馈");
			String operate_Condition = "";
			if(assignSignfor.getAssignid()!= 0){
				operate_Condition += "交办信息id = '" + assignSignfor.getAssignid() + "'";
			}
			if(assignSignfor.getReceiveid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "接收单位id = '" + assignSignfor.getReceiveid() + "'";
				}else{
					operate_Condition += " and 接收单位id = '" + assignSignfor.getReceiveid() + "'";
				}
			}
			if(assignSignfor.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(1-未签收 2-已签收（未反馈） 3-已反馈) = '" + assignSignfor.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(1-未签收 2-已签收（未反馈） 3-已反馈) = '" + assignSignfor.getValidflag() + "'";
				}
			}
			if(assignSignfor.getAssigntitle() != null && !"".equals(assignSignfor.getAssigntitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + assignSignfor.getAssigntitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + assignSignfor.getAssigntitle() + "'";
				}
			}
			if(assignSignfor.getAssigncontent() != null && !"".equals(assignSignfor.getAssigncontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + assignSignfor.getAssigncontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + assignSignfor.getAssigncontent() + "'";
				}
			}
			if(assignSignfor.getUrgentflag() != null && !"".equals(assignSignfor.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + assignSignfor.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + assignSignfor.getUrgentflag() + "'";
				}
			}
			if(assignSignfor.getCategory() != null && !"".equals(assignSignfor.getCategory())){
				if("".equals(operate_Condition)){
					operate_Condition += "类别 = '" + assignSignfor.getCategory() + "'";
				}else{
					operate_Condition += " and 类别 = '" + assignSignfor.getCategory() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 查询详情
	 * @return
	 */
	@RequestMapping("/getAssignSignforById.do")
	public String getAssignSignforById(Integer id, ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		AssignSignfor assignSignfor = assignSignforDao.getById(id);
		InfoAssign infoAssign  =infoAssignDao.getById(assignSignfor.getAssignid());
		List<AssignSignfor> list = assignSignforDao.searchByassignid(assignSignfor);
		
		model.addAttribute("info", infoAssign);
		model.addAttribute("list", list);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询交办签收反馈");
		String operate_Condition = "";
		operate_Condition += "交办签收反馈id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/jsp/information/info_assign_show";
	}
	
	/**
	 * 签收反馈
	 * @param id
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateAssignSignfor.do")
	public @ResponseBody String updateAssignSignfor(AssignSignfor assignSignfor,int menuid,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		System.out.println("updateAssignSignfor.do ...");
		String report = "";
		try {
			if("qianshou".equals(page)){
				report = "签收交办情报";
				assignSignfor.setValidflag(2);
				assignSignfor.setSignoper(userSession.getLoginUserName());
				assignSignfor.setSigntime(updatetime);
			}else if("fankui".equals(page)){
				report = "反馈交办情报";
				assignSignfor.setValidflag(3);
				assignSignfor.setFeedbackoper(userSession.getLoginUserName());
				assignSignfor.setFeedbacktime(updatetime);
				assignSignfor.setFeedbackcontent(assignSignfor.getFeedbackcontent());
			}
			assignSignforDao.update(assignSignfor);
			message = new Message("false",report+"成功");
			message.setFlag(1);
			logDao.recordLog(menuid, report+"成功", userSession.getLoginUserName(), updatetime, report+"成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("签收交办情报");
			String operate_Condition = "";
			operate_Condition += "交办签收反馈id = '" + assignSignfor.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false",report+"失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, report+"失败", userSession.getLoginUserName(), updatetime, report+"失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("签收交办情报");
			String operate_Condition = "";
			operate_Condition += "交办签收反馈id = '" + assignSignfor.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

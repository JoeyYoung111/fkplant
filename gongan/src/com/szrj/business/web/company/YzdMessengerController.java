package com.szrj.business.web.company;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import com.szrj.business.dao.company.YzdMessengerDao;
import com.szrj.business.model.company.YzdMessenger;

/**
 * @author 李昊
 * Sep 6, 2021
 */
@Controller
@SessionAttributes("userSession")
public class YzdMessengerController {

	@Autowired
	private YzdMessengerDao messengerDao;
	@Autowired
	private LogDao logDao;
	
	/**
	 * 分页查询
	 * @param messenger
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchMessenger.do")
	@ResponseBody
	public Map<String, Object> searchmessenger(YzdMessenger messenger, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchmessenger.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = messengerDao.searchYzdMessenger(messenger, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询办证人员信息");
			String operate_Condition = "";
			if(messenger.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + messenger.getCompanyid() + "'";
			}
			if(messenger.getCardnumber() != null && !"".equals(messenger.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + messenger.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + messenger.getCardnumber() + "'";
				}
			}
			if(messenger.getPersonname() != null && !"".equals(messenger.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + messenger.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + messenger.getPersonname() + "'";
				}
			}
			if(messenger.getTelephone() != null && !"".equals(messenger.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + messenger.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + messenger.getTelephone() + "'";
				}
			}
			if(messenger.getSexes() != null && !"".equals(messenger.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + messenger.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + messenger.getSexes() + "'";
				}
			}
			if(messenger.getEducation() != null && !"".equals(messenger.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + messenger.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + messenger.getEducation() + "'";
				}
			}
			if(messenger.getNation() != null && !"".equals(messenger.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + messenger.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + messenger.getNation() + "'";
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
			log.setOperate_Name("查询办证人员信息");
			String operate_Condition = "";
			if(messenger.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + messenger.getCompanyid() + "'";
			}
			if(messenger.getCardnumber() != null && !"".equals(messenger.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + messenger.getCardnumber() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + messenger.getCardnumber() + "'";
				}
			}
			if(messenger.getPersonname() != null && !"".equals(messenger.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + messenger.getPersonname() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + messenger.getPersonname() + "'";
				}
			}
			if(messenger.getTelephone() != null && !"".equals(messenger.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + messenger.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + messenger.getTelephone() + "'";
				}
			}
			if(messenger.getSexes() != null && !"".equals(messenger.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + messenger.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + messenger.getSexes() + "'";
				}
			}
			if(messenger.getEducation() != null && !"".equals(messenger.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + messenger.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + messenger.getEducation() + "'";
				}
			}
			if(messenger.getNation() != null && !"".equals(messenger.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + messenger.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + messenger.getNation() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 根据Id查询
	 * @param id
	 * @param menuid
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getMessengerById.do")
	public String getById(int id, int menuid, String companyname, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getmessenger.do ... menuid="+menuid);
		String url = "";
		
		YzdMessenger messenger = new YzdMessenger();
		try {
			messenger = messengerDao.getById(id);
			model.addAttribute("messenger",messenger);
			model.addAttribute("id", id);
			model.addAttribute("menuid",menuid);
			model.addAttribute("companyname",companyname);
			if(page.equals("showinfo")){
				url = "/jsp/company/messenger_showinfo";
			}else if(page.equals("update")){
				url = "/jsp/company/messenger_update";
			}
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return url;
	}
	
	/**
	 * 添加化学品种类
	 * @param messenger
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addMessenger.do")
	public @ResponseBody String addmessenger(YzdMessenger messenger,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addmessenger.do ... menuid="+menuid);
		messenger.setAddtime(addtime);
		messenger.setAddoperator(userSession.getLoginUserName());
		try {
			messengerDao.add(messenger);
			message = new Message("true","添加成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加办证人员信息成功", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addmessenger.do ... 添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加办证人员信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "添加办证人员信息失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addmessenger.do ... 添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加办证人员信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除化学品种类
	 * @param messenger
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelMessenger.do")
	@ResponseBody
	public String cancelmessenger(YzdMessenger messenger, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelmessenger.do ... menuid="+ menuid);
		try {
			messengerDao.cancel(messenger.getId());
			message = new Message("true","办证人员信息已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "办证人员信息已删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			System.out.println("cancelmessenger.do ... 删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + messenger.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","办证人员信息删除失败");
			message.setFlag(-1);
			System.out.println("cancelmessenger.do ... 删除失败");
			logDao.recordLog(menuid, "办证人员信息删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + messenger.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改化学品种类信息
	 * @param messenger
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateMessenger.do")
	@ResponseBody
	public String updatemessenger(YzdMessenger messenger, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelmessenger.do ... menuid="+ menuid);
		messenger.setUpdateoperator(userSession.getLoginUserName());
		messenger.setUpdatetime(updatetime);
		try {
			messengerDao.update(messenger);
			message = new Message("true","办证人员信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "办证人员信息修改成功", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatemessenger.do ... 修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + messenger.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","办证人员信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "办证人员信息修改失败", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatemessenger.do ... 修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改办证人员信息");
			String operate_Condition = "";
			operate_Condition += "办证人员信息id = '" + messenger.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

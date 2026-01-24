package com.szrj.business.web.sysapp;

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
import com.szrj.business.dao.RoleMenuDao;
import com.szrj.business.dao.sysapp.NoticeDao;
import com.szrj.business.model.RoleMenu;
import com.szrj.business.model.sysapp.MessageRemind;
import com.szrj.business.model.sysapp.Notice;

@Controller
@SessionAttributes("userSession")
public class NoticeController {
	@Autowired
	private NoticeDao noticeDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private RoleMenuDao roleMenuDao;
	
	@RequestMapping("/searchNotice.do")
	@ResponseBody
	public Map<String,Object> searchNotice(Notice notice,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = noticeDao.search(notice, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询通知公告");
			String operate_Condition = "";
			if(notice.getNoticetype() != null && !"".equals(notice.getNoticetype())){
				operate_Condition += "通知类型 LIKE '" + notice.getNoticetype() + "'";
			}
			if(notice.getNoticetitle() != null && !"".equals(notice.getNoticetitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + notice.getNoticetitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + notice.getNoticetitle() + "'";
				}
			}
			if(notice.getNoticetext() != null && !"".equals(notice.getNoticetext())){
				if("".equals(operate_Condition)){
					operate_Condition += "通知内容 LIKE '" + notice.getNoticetext() + "'";
				}else{
					operate_Condition += " and 通知内容 LIKE '" + notice.getNoticetext() + "'";
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
			log.setOperate_Name("查询通知公告");
			String operate_Condition = "";
			if(notice.getNoticetype() != null && !"".equals(notice.getNoticetype())){
				operate_Condition += "通知类型 LIKE '" + notice.getNoticetype() + "'";
			}
			if(notice.getNoticetitle() != null && !"".equals(notice.getNoticetitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + notice.getNoticetitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + notice.getNoticetitle() + "'";
				}
			}
			if(notice.getNoticetext() != null && !"".equals(notice.getNoticetext())){
				if("".equals(operate_Condition)){
					operate_Condition += "通知内容 LIKE '" + notice.getNoticetext() + "'";
				}else{
					operate_Condition += " and 通知内容 LIKE '" + notice.getNoticetext() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addNotice.do")
	@ResponseBody
	public String addNotice(Notice notice,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			notice.setAddtime(addtime);
			notice.setAddoperator(userSession.getLoginUserName());
			notice.setAddoperatorid(userSession.getLoginUserID());
			notice.setValidflag(1);
			noticeDao.add(notice);
			message= new Message("true","新增通知公告成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "通知公告添加", userSession.getLoginUserName(), addtime, "通知公告添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("新增通知公告");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","新增通知公告失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "通知公告添加", userSession.getLoginUserName(), addtime, "通知公告添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("新增通知公告");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getNotice.do")
	public String getNotice(int id,int menuid,ModelMap model) throws Exception{
		model.addAttribute("menuid",menuid);
		Notice notice = noticeDao.getById(id);
		model.addAttribute("notice",notice);
		return "/jsp/sysapp/notice/update";
	}
	
	@RequestMapping("/updateNotice.do")
	@ResponseBody
	public String updateNotice(Notice notice,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			notice.setUpdateoperator(userSession.getLoginUserName());
			notice.setUpdatetime(addtime);
			noticeDao.update(notice);
			message= new Message("true","修改通知公告成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "通知公告修改", userSession.getLoginUserName(), addtime, "通知公告修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改通知公告");
			String operate_Condition = "";
			operate_Condition += "通知公告id = '" + notice.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","修改通知公告失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "通知公告修改", userSession.getLoginUserName(), addtime, "通知公告修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改通知公告");
			String operate_Condition = "";
			operate_Condition += "通知公告id = '" + notice.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelNotice.do")
	@ResponseBody
	public String cancelNotice(Notice notice,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			notice.setUpdateoperator(userSession.getLoginUserName());
			notice.setUpdatetime(addtime);
			noticeDao.cancel(notice);
			message= new Message("true","删除通知公告成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "通知公告删除", userSession.getLoginUserName(), addtime, "通知公告删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除通知公告");
			String operate_Condition = "";
			operate_Condition += "通知公告id = '" + notice.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","删除通知公告失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "通知公告删除", userSession.getLoginUserName(), addtime, "通知公告删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除通知公告");
			String operate_Condition = "";
			operate_Condition += "通知公告id = '" + notice.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getNewMessageRemind.do")
	@ResponseBody
	public Map<String,Object> getNewMessageRemind(@ModelAttribute("userSession")UserSession userSession){
		System.out.println("-----消息框消息查询-----");
		Map<String, Object> result = new HashMap<String, Object>();
		MessageRemind messageRemind = new MessageRemind();
		RoleMenu roleMenu = new RoleMenu();
		roleMenu.setRoleid(userSession.getLoginUserRoleid());
		roleMenu.setMenuid(173);
		roleMenu = roleMenuDao.findMenuButtons(roleMenu);
		if(roleMenu.getButtons().indexOf("审核")>-1){
			messageRemind.setIsCheck(1);
		}
		messageRemind.setDepartmentid(userSession.getLoginUserDepartmentid());
		messageRemind.setAddoperatorid(userSession.getLoginUserID());
		List<MessageRemind> messageRemindList = noticeDao.getNewMessageRemind(messageRemind);
        result.put("messageRemindList", messageRemindList);
        return result;
	}
	
	@RequestMapping("/showNotice.do")
	public String showNotice(int id,ModelMap model) throws Exception{
		Notice notice = noticeDao.getById(id);
		model.addAttribute("notice",notice);
		return "/jsp/sysapp/notice/showinfo";
	}
}

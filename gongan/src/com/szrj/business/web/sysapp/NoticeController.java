package com.szrj.business.web.sysapp;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
	private static final Logger logger = Logger.getLogger(NoticeController.class);

	@Autowired
	private NoticeDao noticeDao;
	@Autowired 
	private LogDao logDao;
	@Autowired 
	private RoleMenuDao roleMenuDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;

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
	
	/**
	 * 获取新消息提醒（包括案件警情提醒）
	 * 轮询接口，返回JSON格式数据
	 */
	@RequestMapping("/getNewMessageRemind.do")
	@ResponseBody
	public Map<String,Object> getNewMessageRemind(@ModelAttribute("userSession")UserSession userSession, HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			// 检查用户会话是否有效
			if (userSession == null || userSession.getLoginUserDepartmentid() == 0) {
				logger.warn("用户会话无效或已过期，返回空消息列表");
				result.put("messageRemindList", new ArrayList<MessageRemind>());
				result.put("error", "会话已过期");
				return result;
			}

			// 查询当前消息表中有哪些未读消息（调试用）
			try {
				String debugSql = "SELECT id, department_id, message_type, xm, read_flag FROM p_case_police_message_t WHERE validflag > 0 AND read_flag = 0 ORDER BY id DESC LIMIT 5";
				List<java.util.Map<String, Object>> debugList = jdbcTemplate.queryForList(debugSql);
				//logger.info("【调试】消息表中未读消息: " + debugList.size() + " 条");
				for (java.util.Map<String, Object> row : debugList) {
					//logger.info("【调试】消息: id=" + row.get("id") + ", department_id=" + row.get("department_id") + ", type=" + row.get("message_type") + ", xm=" + row.get("xm"));
				}
			} catch (Exception e) {
				//logger.error("调试查询失败", e);
			}

			MessageRemind messageRemind = new MessageRemind();
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setRoleid(userSession.getLoginUserRoleid());
			roleMenu.setMenuid(173);
			roleMenu = roleMenuDao.findMenuButtons(roleMenu);
			if(roleMenu.getButtons().indexOf("审核")>-1){
				messageRemind.setIsCheck(1);
				//logger.info("用户具有审核权限");
			}

			messageRemind.setDepartmentid(userSession.getLoginUserDepartmentid());
			messageRemind.setAddoperatorid(userSession.getLoginUserID());

			//logger.info("【部门ID映射调试】传入SQL查询的departmentid: " + userSession.getLoginUserDepartmentid());
			//logger.info("开始执行getNewMessageRemind SQL查询...");
			List<MessageRemind> messageRemindList = noticeDao.getNewMessageRemind(messageRemind);
			//logger.info("查询完成，返回消息数量: " + (messageRemindList != null ? messageRemindList.size() : 0));

			if (messageRemindList != null && messageRemindList.size() > 0) {
				for (int i = 0; i < messageRemindList.size(); i++) {
					MessageRemind msg = messageRemindList.get(i);
					//logger.info("消息[" + (i+1) + "]: " + msg.getMessagecontent());
				}
			} else {
				//logger.info("未查询到任何消息");
			}

			result.put("messageRemindList", messageRemindList);
			//logger.info("========== 消息提醒查询结束 ==========");

		} catch (Exception e) {
			//logger.error("获取消息提醒失败", e);
			result.put("messageRemindList", new ArrayList<MessageRemind>());
			result.put("error", "查询失败: " + e.getMessage());
		}

		return result;
	}
	
	@RequestMapping("/showNotice.do")
	public String showNotice(int id,ModelMap model) throws Exception{
		Notice notice = noticeDao.getById(id);
		model.addAttribute("notice",notice);
		return "/jsp/sysapp/notice/showinfo";
	}

	/**
	 * 标记案件警情消息为已读
	 */
	@RequestMapping("/markCasePoliceMessageRead.do")
	@ResponseBody
	public Map<String, Object> markCasePoliceMessageRead(
			@ModelAttribute("userSession") UserSession userSession,
			Integer personnelid) {

		Map<String, Object> result = new HashMap<String, Object>();

		try {
			if (personnelid == null || personnelid <= 0) {
				result.put("success", false);
				result.put("error", "人员ID不能为空");
				return result;
			}

			// 更新 p_case_police_message_t 表，将该人员相关的未读消息标记为已读
			String sql = "UPDATE p_case_police_message_t " +
					"SET read_flag = 1 " +
					"WHERE personnelid = ? " +
					"AND read_flag = 0 " +
					"AND validflag > 0";

			int updateCount = jdbcTemplate.update(sql, personnelid);

			logger.info("User " + userSession.getLoginUserName() +
					" marked " + updateCount + " case/police messages as read for personnel " + personnelid);

			result.put("success", true);
			result.put("count", updateCount);
			result.put("personnelid", personnelid);

		} catch (Exception e) {
			logger.error("Failed to mark messages as read for personnel " + personnelid, e);
			result.put("success", false);
			result.put("error", e.getMessage());
		}

		return result;
	}

	/**
	 * 删除单条案件/警情消息（设置read_flag=1）
	 */
	@RequestMapping("/deleteCasePoliceMessage.do")
	@ResponseBody
	public Map<String, Object> deleteCasePoliceMessage(
			@ModelAttribute("userSession") UserSession userSession,
			Integer messageId) {

		Map<String, Object> result = new HashMap<String, Object>();

		try {
			if (messageId == null || messageId <= 0) {
				result.put("success", false);
				result.put("error", "消息ID不能为空");
				return result;
			}

			// 更新 p_case_police_message_t 表，将该条消息标记为已读
			String sql = "UPDATE p_case_police_message_t " +
					"SET read_flag = 1 " +
					"WHERE id = ? " +
					"AND validflag > 0";

			int updateCount = jdbcTemplate.update(sql, messageId);

			logger.info("User " + userSession.getLoginUserName() +
					" marked message " + messageId + " as read, affected rows: " + updateCount);

			result.put("success", true);
			result.put("count", updateCount);
			result.put("messageId", messageId);

		} catch (Exception e) {
			logger.error("Failed to mark message " + messageId + " as read", e);
			result.put("success", false);
			result.put("error", e.getMessage());
		}

		return result;
	}
}

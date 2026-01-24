package com.szrj.business.web.sysapp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.sysapp.SendMessageDao;
import com.szrj.business.dao.sysapp.SendMessageLogDao;
import com.szrj.business.model.User;
import com.szrj.business.model.sysapp.SendMessage;
import com.szrj.business.model.sysapp.SendMessageLog;
import com.szrj.business.dao.interfaces.ShortMessageDao;

@Controller
@SessionAttributes("userSession")
public class SendMessageController {
	@Autowired
	private SendMessageDao sendMessageDao;
	@Autowired
	private SendMessageLogDao sendMessageLogDao;
	@Autowired
	private UserDao userDao;
	@Autowired 
	private LogDao logDao;
	
	@RequestMapping("/searchSendMessage.do")
	@ResponseBody
	public Map<String,Object> searchSendMessage(SendMessage sendMessage,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = sendMessageDao.search(sendMessage, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/searchSendMessageLog.do")
	@ResponseBody
	public Map<String,Object> searchSendMessageLog(SendMessageLog sendMessageLog,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = sendMessageLogDao.search(sendMessageLog, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addSendMessage.do")
	@ResponseBody
	public String addSendMessage(SendMessage sendMessage,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			sendMessage.setSendtime(addtime);
			sendMessage.setSendoperator(userSession.getLoginUserName());
			sendMessage.setSendoperatorid(userSession.getLoginUserID());
			int id = sendMessageDao.add(sendMessage);
			if(sendMessage.getSmstype()==1){
				//模板发送
				//日志
				SendMessageLog sendMessageLog = new SendMessageLog();
				sendMessageLog.setSendmessageid(id);
				sendMessageLog.setSendtime(addtime);
				sendMessageLog.setSendperson(userSession.getLoginUserName());
				sendMessageLog.setSendflag(0);
				sendMessageLogDao.add(sendMessageLog);
			}else{
				//自定义发送
				//日志
				SendMessageLog sendMessageLog = new SendMessageLog();
				sendMessageLog.setSendmessageid(id);
				sendMessageLog.setSendtime(addtime);
				sendMessageLog.setSendperson(userSession.getLoginUserName());
				sendMessageLog.setSendflag(1);
				sendMessageLogDao.add(sendMessageLog);
				//发送短信接口
				if(sendMessage.getSendFlag()==1){
					//给单位发送
					String receiveids = sendMessage.getReceiveids().substring(0, sendMessage.getReceiveids().length()-1);
					List<User> userlist = userDao.getUsersByDepartids(receiveids);
					for(int i=0;i<userlist.size();i++){
						if(userlist.get(i).getContactnumber()!=null&&!"".equals(userlist.get(i).getContactnumber())){
							//调用短信接口发送管辖民警信息
							new ShortMessageDao().sendmessage(userlist.get(i).getContactnumber(),sendMessage.getSmstext());
						}
					}
				}else{
					//给个人发送
					String receiveids = sendMessage.getReceiveids().substring(0, sendMessage.getReceiveids().length()-1);
					List<User> userlist = userDao.getUserByIds(receiveids);
					for(int i=0;i<userlist.size();i++){
						if(userlist.get(i).getContactnumber()!=null&&!"".equals(userlist.get(i).getContactnumber())){
							//调用短信接口发送管辖民警信息
							new ShortMessageDao().sendmessage(userlist.get(i).getContactnumber(),sendMessage.getSmstext());
						}
					}
				}
			}
			message= new Message("true","发送短信成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "短信发送", userSession.getLoginUserName(), addtime, "短信发送成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","发送短信失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "短信发送", userSession.getLoginUserName(), addtime, "短信发送失败", "");
		}
		return JSONObject.fromObject(message).toString();
	}
}

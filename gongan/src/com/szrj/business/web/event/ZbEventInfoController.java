package com.szrj.business.web.event;

import java.util.HashMap;
import java.util.Map;

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
import com.aladdin.model.UserSession;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.EventsInfo;
import com.szrj.business.model.event.ZbEventInfo;

@Controller
@SessionAttributes("userSession")
public class ZbEventInfoController {
	@Autowired 
	private LogDao logDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	
	@RequestMapping("/searchZbEventInfo.do")
	@ResponseBody
	public Map<String,Object> searchZbEventInfo(ZbEventInfo zbEventInfo,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = contradictionInfoDao.search_ZbEventInfo(zbEventInfo, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addZbEventInfo.do")
	@ResponseBody
	public Map<String,Object> addZbEventInfo(ZbEventInfo zbEventInfo,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zbEventInfo.setAddtime(addtime);
			zbEventInfo.setAddoperator(userSession.getLoginUserName());
			zbEventInfo.setAddoperatorid(userSession.getLoginUserID());
			zbEventInfo.setValidflag(1);
			int id=contradictionInfoDao.add_ZbEventInfo(zbEventInfo);
			result.put("msg", "新增成功！");
			result.put("flag", 1);
			logDao.recordLog(menuid, "政保事件详细信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//更新时间
			ContradictionInfo contradictionInfo = new ContradictionInfo();
			contradictionInfo.setUpdatetime(addtime);
			contradictionInfo.setUpdateoperator(userSession.getLoginUserName());
			contradictionInfo.setId(zbEventInfo.getCdtid());
			contradictionInfoDao.updateTime(contradictionInfo);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "新增失败！");
			result.put("flag", -1);
			logDao.recordLog(menuid, "政保事件详细信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
		}
		return result;
	}
	
	@RequestMapping("/getZbEventInfo.do")
	public String getZbEventInfo(ZbEventInfo zbEventInfo,int menuid,ModelMap model,String page) throws Exception{
		model.addAttribute("menuid",menuid);
		ZbEventInfo zbEventInforesult = contradictionInfoDao.getById_ZbEventInfo(zbEventInfo);
		model.addAttribute("zbEventInfo",zbEventInforesult);
		model.addAttribute("page",page);
		String updatepage = "/jsp/event/zbEvent/"+page+"/update";
		return updatepage;
	}
	
	@RequestMapping("/updateZbEventInfo.do")
	@ResponseBody
	public Map<String,Object> updateZbEventInfo(ZbEventInfo zbEventInfo,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zbEventInfo.setUpdateoperator(userSession.getLoginUserName());
			zbEventInfo.setUpdatetime(addtime);
			contradictionInfoDao.update_ZbEventInfo(zbEventInfo);
			result.put("msg", "修改成功！");
			result.put("flag", 1);
			logDao.recordLog(menuid, "政保事件详细信息修改", userSession.getLoginUserName(), addtime, "政保事件详细信息修改成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "修改失败！");
			result.put("flag", -1);
			logDao.recordLog(menuid, "政保事件详细信息修改", userSession.getLoginUserName(), addtime, "政保事件详细信息修改失败", "");
		}
		return result;
	}
	
	@RequestMapping("/cancelZbEventInfo.do")
	@ResponseBody
	public String cancelZbEventInfo(ZbEventInfo zbEventInfo,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zbEventInfo.setUpdateoperator(userSession.getLoginUserName());
			zbEventInfo.setUpdatetime(addtime);
			contradictionInfoDao.cancel_ZbEventInfo(zbEventInfo);
			message= new Message("true","删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保事件详细信息删除", userSession.getLoginUserName(), addtime, "政保事件详细信息删除成功", "");
		} catch (Exception e) {
			message = new Message("false","删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保事件详细信息删除", userSession.getLoginUserName(), addtime, "政保事件详细信息删除失败", "");
		}
		return JSONObject.fromObject(message).toString();
	}
}

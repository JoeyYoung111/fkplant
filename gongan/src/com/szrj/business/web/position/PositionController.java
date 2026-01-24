package com.szrj.business.web.position;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.position.PositionDao;
import com.szrj.business.model.position.Position;
import com.szrj.business.model.position.PositionCard;
import com.szrj.business.model.position.PositionEvent;
import com.szrj.business.model.position.PositionPersonnel;
import com.szrj.business.model.position.PositionWorkRecord;

@Controller
@SessionAttributes("userSession")
public class PositionController {
	@Autowired
	private PositionDao	positionDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchPosition.do")
	@ResponseBody
	public Map<String,Object> searchPosition(Position position,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		//是否需要根据角色过滤
		if(userSession.getLoginRoleMsgFilter()==1){
			switch (userSession.getLoginRoleFieldFilter()) {
			case 1:
				position.setUnitFilter(userSession.getLoginUserDepartmentid());
				break;
			case 2:
				position.setPersonFilter(userSession.getLoginUserID());
				break;
			}	
		}
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=positionDao.searchPosition(position, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	@RequestMapping("/addPosition.do")
	public @ResponseBody String addPosition(Position position,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPosition.do.......................");
		try {
			position.setValidflag(1);
			position.setAddoperator(userSession.getLoginUserName());
			position.setAddtime(addtime);
			positionDao.add(position);
			message = new Message("true","政保阵地添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保阵地添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPosition.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保阵地添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保阵地添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPosition.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePosition.do")
	public @ResponseBody String updatePosition(Position position,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePosition.do.......................");
		try {
			position.setUpdateoperator(userSession.getLoginUserName());
			position.setUpdatetime(updatetime);
			positionDao.update(position);
			message = new Message("true","政保阵地修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保阵地修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePosition.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保阵地修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保阵地修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePosition.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getPositionUpdate.do")
	public String getPositionUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPositionUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		Position position=positionDao.getById(id);
		model.addAttribute("position",position);
		if (page.equals("update")){
			url="/jsp/position/update";
		}else if(page.equals("showinfo")){
			List<PositionCard> cardlist=positionDao.getPositionCardListByPositionid(id);
			model.addAttribute("cardnum",cardlist.size());
			model.addAttribute("cardlist",cardlist);
			//政保人员
			List<PositionPersonnel> personnellist=positionDao.getPositionPersonnelListByPositionid(id);
			model.addAttribute("personnelnum",personnellist.size());
			model.addAttribute("personnellist",personnellist);
			//政保活动情况
			List<PositionEvent> eventlist = positionDao.getPositionEventListByPositionid(id);
			model.addAttribute("eventnum", eventlist.size());
			model.addAttribute("eventlist", eventlist);
			//政保工作记录
			List<PositionWorkRecord> worklist = positionDao.getPositionWorkRecordListByPositionid(id);
			model.addAttribute("worknum", worklist.size());
			model.addAttribute("worklist", worklist);
			url="/jsp/position/showinfo";
		}else if(page.equals("card")){
			url="/jsp/position/card";
		}else if(page.equals("personnel")){
			url="/jsp/position/personnel";
		}
		return url;
	}
	
	@RequestMapping("/cancelPosition.do")
	public @ResponseBody String cancelPosition(Position position,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPosition.do.......................");
		try {
			position.setUpdateoperator(userSession.getLoginUserName());
			position.setUpdatetime(addtime);
			positionDao.cancel(position);
			message = new Message("true","政保阵地删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保阵地删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPosition.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保阵地删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保阵地删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPosition.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/******** 政保阵地——登记证书 *********/
	@RequestMapping("/searchPositionCard.do")
	@ResponseBody
	public Map<String,Object> searchPositionCard(PositionCard positionCard,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=positionDao.searchPositionCard(positionCard, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("/addPositionCard.do")
	public @ResponseBody String addPositionCard(PositionCard positionCard,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPositionCard.do.......................");
		try {
			positionCard.setValidflag(1);
			positionCard.setAddoperator(userSession.getLoginUserName());
			positionCard.setAddtime(addtime);
			positionDao.addPositionCard(positionCard);
			message = new Message("true","登记证书添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "登记证书添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPositionCard.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","登记证书添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "登记证书添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPositionCard.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePositionCard.do")
	public @ResponseBody String updatePositionCard(PositionCard positionCard,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionCard.do.......................");
		try {
			positionCard.setUpdateoperator(userSession.getLoginUserName());
			positionCard.setUpdatetime(updatetime);
			positionDao.updatePositionCard(positionCard);
			message = new Message("true","登记证书修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "登记证书修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionCard.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","登记证书修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "登记证书修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionCard.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getPositionCardUpdate.do")
	public String getPositionCardUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPositionCardUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		PositionCard positionCard=positionDao.getPositionCardById(id);
		model.addAttribute("positionCard",positionCard);
		if (page.equals("update")){
			url="/jsp/position/card/update";
		}
		return url;
	}
	
	@RequestMapping("/cancelPositionCard.do")
	public @ResponseBody String cancelPositionCard(PositionCard positionCard,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPositionCard.do.......................");
		try {
			positionCard.setUpdateoperator(userSession.getLoginUserName());
			positionCard.setUpdatetime(addtime);
			positionDao.cancelPositionCard(positionCard);
			message = new Message("true","登记证书删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "登记证书删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPositionCard.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","登记证书删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "登记证书删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPositionCard.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	/******** 政保阵地——人员情况 *********/
	@RequestMapping("/searchPositionPersonnel.do")
	@ResponseBody
	public Map<String,Object> searchPositionPersonnel(PositionPersonnel positionPersonnel,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=positionDao.searchPositionPersonnel(positionPersonnel, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("/addPositionPersonnel.do")
	public @ResponseBody String addPositionPersonnel(PositionPersonnel positionPersonnel,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPositionPersonnel.do.......................");
		try {
			positionPersonnel.setValidflag(1);
			positionPersonnel.setAddoperator(userSession.getLoginUserName());
			positionPersonnel.setAddtime(addtime);
			positionDao.addPositionPersonnel(positionPersonnel);
			message = new Message("true","人员情况添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员情况添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPositionPersonnel.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","人员情况添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员情况添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPositionPersonnel.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePositionPersonnel.do")
	public @ResponseBody String updatePositionPersonnel(PositionPersonnel positionPersonnel,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionPersonnel.do.......................");
		try {
			positionPersonnel.setUpdateoperator(userSession.getLoginUserName());
			positionPersonnel.setUpdatetime(updatetime);
			positionDao.updatePositionPersonnel(positionPersonnel);
			message = new Message("true","人员情况修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员情况修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionPersonnel.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","人员情况修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员情况修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionPersonnel.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getPositionPersonnelUpdate.do")
	public String getPositionPersonnelUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPositionPersonnelUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		PositionPersonnel positionPersonnel=positionDao.getPositionPersonnelById(id);
		model.addAttribute("positionPersonnel",positionPersonnel);
		if (page.equals("update")){
			url="/jsp/position/personnel/update";
		}
		return url;
	}
	
	@RequestMapping("/cancelPositionPersonnel.do")
	public @ResponseBody String cancelPositionPersonnel(PositionPersonnel positionPersonnel,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPositionPersonnel.do.......................");
		try {
			positionPersonnel.setUpdateoperator(userSession.getLoginUserName());
			positionPersonnel.setUpdatetime(addtime);
			positionDao.cancelPositionPersonnel(positionPersonnel);
			message = new Message("true","人员情况删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "人员情况删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPositionPersonnel.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","人员情况删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "人员情况删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPositionPersonnel.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/******** 政保阵地——主要活动情况 *********/
	@RequestMapping("/searchPositionEvent.do")
	@ResponseBody
	public Map<String,Object> searchPositionEvent(PositionEvent positionEvent,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=positionDao.searchPositionEvent(positionEvent, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("/addPositionEvent.do")
	public @ResponseBody String addPositionEvent(PositionEvent positionEvent,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPositionEvent.do.......................");
		try {
			positionEvent.setValidflag(1);
			positionEvent.setAddoperator(userSession.getLoginUserName());
			positionEvent.setAddtime(addtime);
			positionDao.addPositionEvent(positionEvent);
			message = new Message("true","主要活动情况添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "主要活动情况添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPositionEvent.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","主要活动情况添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "主要活动情况添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPositionEvent.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePositionEvent.do")
	public @ResponseBody String updatePositionEvent(PositionEvent positionEvent,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionEvent.do.......................");
		try {
			positionEvent.setUpdateoperator(userSession.getLoginUserName());
			positionEvent.setUpdatetime(updatetime);
			positionDao.updatePositionEvent(positionEvent);
			message = new Message("true","主要活动情况修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "主要活动情况修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionEvent.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","主要活动情况修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "主要活动情况修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionEvent.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getPositionEventUpdate.do")
	public String getPositionEventUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPositionEventUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		PositionEvent positionEvent=positionDao.getPositionEventById(id);
		model.addAttribute("positionEvent",positionEvent);
		if (page.equals("update")){
			url="/jsp/position/event/update";
		}
		return url;
	}
	
	@RequestMapping("/cancelPositionEvent.do")
	public @ResponseBody String cancelPositionEvent(PositionEvent positionEvent,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPositionEvent.do.......................");
		try {
			positionEvent.setUpdateoperator(userSession.getLoginUserName());
			positionEvent.setUpdatetime(addtime);
			positionDao.cancelPositionEvent(positionEvent);
			message = new Message("true","主要活动情况删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "主要活动情况删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPositionEvent.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","主要活动情况删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "主要活动情况删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPositionEvent.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/******** 政保阵地——工作记录 *********/
	@RequestMapping("/searchPositionWorkRecord.do")
	@ResponseBody
	public Map<String,Object> searchPositionWorkRecord(PositionWorkRecord positionWorkRecord,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=positionDao.searchPositionWorkRecord(positionWorkRecord, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("/addPositionWorkRecord.do")
	public @ResponseBody String addPositionWorkRecord(PositionWorkRecord positionWorkRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPositionWorkRecord.do.......................");
		try {
			positionWorkRecord.setValidflag(1);
			positionWorkRecord.setAddoperator(userSession.getLoginUserName());
			positionWorkRecord.setAddtime(addtime);
			positionDao.addPositionWorkRecord(positionWorkRecord);
			message = new Message("true","工作记录添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "工作记录添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPositionWorkRecord.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","工作记录添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "工作记录添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPositionWorkRecord.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePositionWorkRecord.do")
	public @ResponseBody String updatePositionWorkRecord(PositionWorkRecord positionWorkRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionWorkRecord.do.......................");
		try {
			positionWorkRecord.setUpdateoperator(userSession.getLoginUserName());
			positionWorkRecord.setUpdatetime(updatetime);
			positionDao.updatePositionWorkRecord(positionWorkRecord);
			message = new Message("true","工作记录修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "工作记录修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionWorkRecord.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","工作记录修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "工作记录修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionWorkRecord.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getPositionWorkRecordUpdate.do")
	public String getPositionWorkRecordUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPositionWorkRecordUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		PositionWorkRecord positionWorkRecord=positionDao.getPositionWorkRecordById(id);
		model.addAttribute("positionWorkRecord",positionWorkRecord);
		if (page.equals("update")){
			url="/jsp/position/work/update";
		}
		return url;
	}
	
	@RequestMapping("/cancelPositionWorkRecord.do")
	public @ResponseBody String cancelPositionWorkRecord(PositionWorkRecord positionWorkRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPositionWorkRecord.do.......................");
		try {
			positionWorkRecord.setUpdateoperator(userSession.getLoginUserName());
			positionWorkRecord.setUpdatetime(addtime);
			positionDao.cancelPositionWorkRecord(positionWorkRecord);
			message = new Message("true","工作记录删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "工作记录删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPositionWorkRecord.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","工作记录删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "工作记录删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPositionWorkRecord.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/dayinPosition.do")
	public void dayinPosition(Position position,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession) throws IOException{
		System.out.println(".....dayinPosition.do............");
		//模板位置
		String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\position\\template\\zdxx.xls";
		TemplateExportParams params = new TemplateExportParams(templateFileName,true);
		Map<String,Object> map = new HashMap<String,Object>();
		
		//获取阵地信息
		position = positionDao.getById(position.getId());
		if(position.getPositionname()!=null && !"".equals(position.getPositionname())){
			//名称
			map.put("positionname", position.getPositionname());
			
			//阵地级别	
			if(position.getPositiontype()!=null && !"".equals(position.getPositiontype())){
				map.put("positiontype",position.getPositiontype());
			}else{
				map.put("positiontype", " ");
			}
			//阵地类别	
			if(position.getPositioncharacter()!=null && !"".equals(position.getPositioncharacter())){
				map.put("positioncharacter",position.getPositioncharacter());
			}else{
				map.put("positioncharacter", " ");
			}
			//外文名称
			if(position.getForeignname()!=null && !"".equals(position.getForeignname())){
				map.put("foreignname",position.getForeignname());
			}else{
				map.put("foreignname", " ");
			}
			//成立时间
			if(position.getSetuptime()!=null && !"".equals(position.getSetuptime())){
				map.put("setuptime",position.getSetuptime());
			}else{
				map.put("setuptime", " ");
			}
			//成立地点
			if(position.getSetupplace()!=null && !"".equals(position.getSetupplace())){
				map.put("setupplace",position.getSetupplace());
			}else{
				map.put("setupplace", " ");
			}
			//详细地址
			if(position.getAddress()!=null && !"".equals(position.getAddress())){
				map.put("address",position.getAddress());
			}else{
				map.put("address", " ");
			}
			//占地面积
			if(position.getPlacearea()!=null && !"".equals(position.getPlacearea())){
				map.put("placearea",position.getPlacearea());
			}else{
				map.put("placearea", " ");
			}
			//涉及人数
			if(position.getPersonnum()!=null && !"".equals(position.getPersonnum())){
				map.put("personnum",position.getPersonnum());
			}else{
				map.put("personnum", " ");
			}
			//主管部门
			if(position.getChargeunit()!=null && !"".equals(position.getChargeunit())){
				map.put("chargeunit",position.getChargeunit());
			}else{
				map.put("chargeunit", " ");
			}
			//阵地概况
			if(position.getPositionsurvey()!=null && !"".equals(position.getPositionsurvey())){
				map.put("positionsurvey",position.getPositionsurvey());
			}else{
				map.put("positionsurvey", " ");
			}
			//管控单位
			if(position.getJdunit()!=null && !"".equals(position.getJdunit())){
				map.put("jdunit",position.getJdunit());
			}else{
				map.put("jdunit", " ");
			}
			//管控民警
			if(position.getJdpolice()!=null && !"".equals(position.getJdpolice())){
				map.put("jdpolice",position.getJdpolice());
			}else{
				map.put("jdpolice", " ");
			}
			//管控电话
			if(position.getJdphone()!=null && !"".equals(position.getJdphone())){
				map.put("jdphone",position.getJdphone());
			}else{
				map.put("jdphone", " ");
			}
			
			List<PositionCard> pclist = positionDao.getPositionCardListByPositionid(position.getId());
			List<Map<String,String>> cardList = new ArrayList<Map<String,String>>();
			if(pclist!=null && pclist.size()>0){
				for(int i=0;i<pclist.size();i++){
					if(i>=2){
						break;
					}
					Map<String,String> cd = new HashMap<String,String>();
					cd.put("cardname",pclist.get(i).getCardname());
					cd.put("cardno",pclist.get(i).getCardno());
					cd.put("validdate",pclist.get(i).getValiddate());
					cd.put("cardunit",pclist.get(i).getCardunit());
					cardList.add(cd);
				}
			}
			map.put("cardList",cardList);
			
			List<PositionPersonnel> ppList = positionDao.getPositionPersonnelListByPositionid(position.getId());
			List<Map<String,String>> personList = new ArrayList<Map<String,String>>();
			if(ppList!=null && ppList.size()>0){
				for(int i=0;i<ppList.size();i++){
					if(i>=6){
						break;
					}
					Map<String,String> p = new HashMap<String,String>();
					p.put("identity",ppList.get(i).getIdentity());
					p.put("personname",ppList.get(i).getPersonname());
					p.put("cardnumber",ppList.get(i).getCardnumber());
					p.put("homeplace",ppList.get(i).getHomeplace());
					p.put("telnumber",ppList.get(i).getTelnumber());
					personList.add(p);
				}
			}
			map.put("personList",personList);
			
			List<PositionEvent> peList = positionDao.getPositionEventListByPositionid(position.getId());
			List<Map<String,String>> eventList = new ArrayList<Map<String,String>>();
			if(peList!=null && peList.size()>0){
				for(int i=0;i<peList.size();i++){
					if(i>=6){
						break;
					}
					Map<String,String> p = new HashMap<String,String>();
					p.put("eventTime",peList.get(i).getEventTime());
					p.put("eventInfo",peList.get(i).getEventInfo());			
					eventList.add(p);
				}
			}
			map.put("eventList",eventList);
			
			List<PositionWorkRecord> pwrList = positionDao.getPositionWorkRecordListByPositionid(position.getId());
			List<Map<String,String>> workList = new ArrayList<Map<String,String>>();
			if(pwrList!=null && pwrList.size()>0){
				for(int i=0;i<pwrList.size();i++){
					if(i>=6){
						break;
					}
					Map<String,String> p = new HashMap<String,String>();
					p.put("workTime",pwrList.get(i).getWorkTime());
					p.put("workInfo",pwrList.get(i).getWorkInfo());
					workList.add(p);
				}
			}
			map.put("workList",workList);
			
			
			Workbook workbook = ExcelExportUtil.exportExcel(params, map);
			/*设置输出类型*/
			response.setContentType("application/vnd.ms-excel");
			response.setCharacterEncoding("utf-8");
			/*设置输出文件名称*/
			String title = "政保阵地_"+position.getPositionname()+"_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".xls", "UTF-8"));
			OutputStream outputStream=response.getOutputStream();
			workbook.write(outputStream);
			
		}
		
		
		
	}
	
	
}

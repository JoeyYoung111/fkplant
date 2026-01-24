package com.szrj.business.web.information;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.szrj.business.dao.FileDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.information.AssignSignforDao;
import com.szrj.business.dao.information.InfoAssignDao;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.model.File;
import com.szrj.business.model.information.AssignSignfor;
import com.szrj.business.model.information.InfoAssign;
import com.szrj.business.model.information.InfoTimeLine;

@Controller
@SessionAttributes("userSession")
public class InfoAssignController {

	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Picture;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private InfoAssignDao infoAssignDao;
	@Autowired
	private AssignSignforDao assignSignforDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	
	/**
	 * 查询对下交办的信息
	 * @param infoAssign
	 * @param pm
	 * @return
	 */
	@RequestMapping("/searchInfoAssign.do")
	@ResponseBody
	public Map<String, Object> search(InfoAssign infoAssign,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchInfoAssign.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			NewPageModel pagelist = infoAssignDao.search(infoAssign, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total",pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询情报交办信息");
			String operate_Condition = "";
			if(infoAssign.getDepartmentid() != null && !"".equals(infoAssign.getDepartmentid())&&!"0".equals(infoAssign.getDepartmentid())){
				operate_Condition += "承办人部门id = '" + infoAssign.getDepartmentid() + "'";
			}
			if(infoAssign.getInformationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "来源信息id = '" + infoAssign.getInformationid() + "'";
				}else{
					operate_Condition += " and 来源信息id = '" + infoAssign.getInformationid() + "'";
				}
			}
			if(infoAssign.getAssigntitle() != null && !"".equals(infoAssign.getAssigntitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + infoAssign.getAssigntitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + infoAssign.getAssigntitle() + "'";
				}
			}
			if(infoAssign.getUrgentflag() != null && !"".equals(infoAssign.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + infoAssign.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + infoAssign.getUrgentflag() + "'";
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
			log.setOperate_Name("查询情报交办信息");
			String operate_Condition = "";
			if(infoAssign.getDepartmentid() != null && !"".equals(infoAssign.getDepartmentid())&&!"0".equals(infoAssign.getDepartmentid())){
				operate_Condition += "承办人部门id = '" + infoAssign.getDepartmentid() + "'";
			}
			if(infoAssign.getInformationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "来源信息id = '" + infoAssign.getInformationid() + "'";
				}else{
					operate_Condition += " and 来源信息id = '" + infoAssign.getInformationid() + "'";
				}
			}
			if(infoAssign.getAssigntitle() != null && !"".equals(infoAssign.getAssigntitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + infoAssign.getAssigntitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + infoAssign.getAssigntitle() + "'";
				}
			}
			if(infoAssign.getUrgentflag() != null && !"".equals(infoAssign.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + infoAssign.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + infoAssign.getUrgentflag() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 根据id查询详情
	 * @return
	 */
	@RequestMapping("/getInfoAssignById.do")
	public String getInfoAssignById(Integer id, Integer menuid, ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		String url = "";
		InfoAssign infoAssign = infoAssignDao.getById(id);
		String signlimit1 = infoAssign.getSignlimit();
		String feedbacklimit1 = infoAssign.getFeedbacklimit();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String time = sdf.format(new Date());
		AssignSignfor assignSignfor = new AssignSignfor();
		assignSignfor.setAssignid(id);
		List<AssignSignfor> list = assignSignforDao.searchByassignid(assignSignfor);
		for(int i=0;i<list.size();i++){
			Integer compareTo1 = time.compareTo(signlimit1);
			Integer compareTo2 = time.compareTo(feedbacklimit1);
			if(list.get(i).getValidflag()==1){
				list.get(i).setSignflag(compareTo1>0?"未签收":"<span style='color:red'>超时未签收</span>");
				list.get(i).setFbackflag(compareTo2>0?"未反馈":"<span style='color:red'>超时未反馈</span>");
			}else if(list.get(i).getValidflag()==2){
				list.get(i).setSignflag("已签收");
				list.get(i).setFbackflag(compareTo2>0?"未反馈":"<span style='color:red'>超时未反馈</span>");
			}else{
				list.get(i).setSignflag("已签收");
				list.get(i).setFbackflag("已反馈");
			}
			
		}
		
		model.addAttribute("info", infoAssign);
		model.addAttribute("list", list);
		model.addAttribute("menuid",menuid);
		
		if("xiangqing".equals(page)){
			url = "/jsp/information/info_assign_show";
		}else if("update".equals(page)){
			url = "/jsp/information/update_assign";
			
			List<File> files = new ArrayList<File>();
			try {
				String attachments = infoAssign.getAttachments();
				if(attachments!=null && attachments.length()>0){
					attachments = "(" + attachments + ")";
					files = fileDao.getFileMsgByIdstr(attachments);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("files", files);
			
			String PU = uploadFile_Picture.replace("\\", "/");
			model.addAttribute("pictureurl", PU);
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询情报交办信息");
		String operate_Condition = "";
		operate_Condition += "情报交办id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 添加情报交办信息
	 * @param infoAssign
	 * @param menuid
	 * @param userSession
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/addInfoAssign.do")
	public @ResponseBody String addInfoAssign(InfoAssign infoAssign,Integer informationid,Integer informationsendid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Message message;
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		Date now = new Date();
		c1.setTime(now);
		c2.setTime(now);
		Integer sign = Integer.parseInt(infoAssign.getSignlimit());
		Integer feed = Integer.parseInt(infoAssign.getFeedbacklimit());
		c1.add(Calendar.MINUTE, sign);
		infoAssign.setSignlimit(sdf1.format(c1.getTime()));
		c2.add(Calendar.MINUTE, feed);
		infoAssign.setFeedbacklimit(sdf1.format(c2.getTime()));
		String addtime = sdf1.format(now);
		infoAssign.setAddtime(addtime);
		infoAssign.setAddoperator(userSession.getLoginUserName());
		infoAssign.setDepartmentid(userSession.getLoginUserDepartmentid()+"");
		infoAssign.setContactnumber(userDao.getById(userSession.getLoginUserID()).getContactnumber());
		AssignSignfor assignSignfor = new AssignSignfor();
		assignSignfor.setAddoperator(userSession.getLoginUserName());
		assignSignfor.setAddtime(addtime);
		try {
			int id = infoAssignDao.add(infoAssign);
			assignSignfor.setAssignid(id);
			String signdepartids = infoAssign.getSigndepartids();
			String[] receiveid = signdepartids.split(",");
			for(int i=0;i<receiveid.length;i++){
				assignSignfor.setReceiveid(Integer.parseInt(receiveid[i]));
				assignSignforDao.add(assignSignfor);
			}
			
			message = new Message("true","交办成功");
			message.setFlag(id);
			logDao.recordLog(menuid, "交办成功", userSession.getLoginUserName(), addtime, "交办成功", "");
		
			String content = userSession.getLoginUserDepartname()+ " " + userSession.getLoginUserName();
			String title = "【新增交办】";
			InfoTimeLine infoTimeLine = new InfoTimeLine(informationid,informationsendid+"","0",id,0,title,content,addtime,0);
			infoTimeLineDao.add(infoTimeLine);
			System.out.println("已录入时间轴");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加情报交办信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","交办失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "交办失败", userSession.getLoginUserName(), addtime, "交办失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加情报交办信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除交办情报
	 * @return
	 */
	@RequestMapping("/cancelInfoAssign.do")
	public @ResponseBody String cancel(Integer id,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		System.out.println("cancelInfoAssign.do ...");
		try {
			infoAssignDao.cancel(id);
			AssignSignfor assignSignfor = new AssignSignfor();
			assignSignfor.setAssignid(id);
			assignSignforDao.cancel(assignSignfor);
			message = new Message("true","删除交办情报成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "删除交办情报成功", userSession.getLoginUserName(), updatetime, "交办成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除情报交办信息");
			String operate_Condition = "";
			operate_Condition += "情报交办id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","删除交办情报失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "删除交办情报失败", userSession.getLoginUserName(), updatetime, "删除交办情报失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除情报交办信息");
			String operate_Condition = "";
			operate_Condition += "情报交办id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改交办
	 * @param infoAssign
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateInfoAssign.do")
	@ResponseBody
	public String updateInfoAssign(InfoAssign infoAssign,int menuid,String oldidlist,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		Date now = new Date();
		c1.setTime(now);
		c2.setTime(now);
		Integer sign = Integer.parseInt(infoAssign.getSignlimit());
		Integer feed = Integer.parseInt(infoAssign.getFeedbacklimit());
		c1.add(Calendar.MINUTE, sign);
		infoAssign.setSignlimit(sdf.format(c1.getTime()));
		c2.add(Calendar.MINUTE, feed);
		infoAssign.setFeedbacklimit(sdf.format(c2.getTime()));
		
		String updatetime = sdf.format(now);
		System.out.println("updateInfoAssign.do ...");
		AssignSignfor assignSignfor = new AssignSignfor();
		assignSignfor.setAssignid(infoAssign.getId());
		assignSignfor.setAddtime(updatetime);
		assignSignfor.setAddoperator(userSession.getLoginUserName());
		try {
			int id = infoAssignDao.update(infoAssign);
			
			if(!oldidlist.equals(infoAssign.getSigndepartids())){
				String[] oldlist = oldidlist.split(",");
				String[] newlist = infoAssign.getSigndepartids().split(",");
				List<String> oldTemp = Arrays.asList(oldlist);
				List<String> oldS = new ArrayList<String>(oldTemp);
				List<String> newS = new ArrayList<String>(Arrays.asList(newlist));
				for(String T : newlist){
					if(oldTemp.contains(T)){
						oldS.remove(T);
						newS.remove(T);
					}
				}
				
				if(oldS.size()>0){
					String idlist = "";
					for(int i=0;i<oldS.size();i++){
						idlist += oldS.get(i)+",";
					}
					idlist = "(" + idlist.substring(0, idlist.length()-1) + ")";
					assignSignfor.setIdlist(idlist);
					assignSignforDao.cancel(assignSignfor);
				}
				
				if(newS.size()>0){
					for(int i=0;i<newS.size();i++){
						assignSignfor.setReceiveid(Integer.parseInt(newS.get(i)));
						assignSignforDao.add(assignSignfor);
					}
				}
			}
			
			message = new Message("true","修改交办情报成功");
			message.setFlag(id);
			logDao.recordLog(menuid, "修改交办情报成功", userSession.getLoginUserName(), updatetime, "交办成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改情报交办信息");
			String operate_Condition = "";
			operate_Condition += "情报交办id = '" + infoAssign.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","修改交办情报失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "修改交办情报失败", userSession.getLoginUserName(), updatetime, "删除交办情报失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改情报交办信息");
			String operate_Condition = "";
			operate_Condition += "情报交办id = '" + infoAssign.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
}

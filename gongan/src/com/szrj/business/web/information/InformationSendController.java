package com.szrj.business.web.information;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.szrj.business.dao.information.InfoJointPersonDao;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.dao.information.InformationReceiveDao;
import com.szrj.business.dao.information.InformationSendDao;
import com.szrj.business.model.File;
import com.szrj.business.model.information.InfoAnnotation;
import com.szrj.business.model.information.InfoJointPerson;
import com.szrj.business.model.information.InfoTimeLine;
import com.szrj.business.model.information.InformationReceive;
import com.szrj.business.model.information.InformationSend;

@Controller
@SessionAttributes("userSession")
public class InformationSendController {

	private
	@Value("#{configProperties.uploadFile_Document}")
	String uploadFile_Document;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private InformationSendDao informationSendDao;
	@Autowired
	private InfoJointPersonDao infoJointPersonDao;
	@Autowired
	private InformationReceiveDao informationReceiveDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	
	
	@RequestMapping("/searchInformationSend.do")
	@ResponseBody
	public Map<String, Object> searchInformationSend(InformationSend informationSend, NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			NewPageModel pagelist = informationSendDao.searchInformation(informationSend, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total", pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询发布接收信息");
			String operate_Condition = "";
			if(informationSend.getReceiveid()!= 0){
				operate_Condition += "接收单位id = '" + informationSend.getReceiveid() + "'";
			}
			if(informationSend.getStarttime() != null && !"".equals(informationSend.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 >= '" + informationSend.getStarttime() + "'";
				}else{
					operate_Condition += " and 添加时间 >= '" + informationSend.getStarttime() + "'";
				}
			}
			if(informationSend.getEndtime() != null && !"".equals(informationSend.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 <= '" + informationSend.getEndtime() + "'";
				}else{
					operate_Condition += " and 添加时间 <= '" + informationSend.getEndtime() + "'";
				}
			}
			if(informationSend.getTuihuistarttime() != null && !"".equals(informationSend.getTuihuistarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "退回时间 >= '" + informationSend.getTuihuistarttime() + "'";
				}else{
					operate_Condition += " and 退回时间 >= '" + informationSend.getTuihuistarttime() + "'";
				}
			}
			if(informationSend.getTuihuiendtime() != null && !"".equals(informationSend.getTuihuiendtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "退回时间 <= '" + informationSend.getTuihuiendtime() + "'";
				}else{
					operate_Condition += " and 退回时间 <= '" + informationSend.getTuihuiendtime() + "'";
				}
			}
			if(informationSend.getInfotitle() != null && !"".equals(informationSend.getInfotitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + informationSend.getInfotitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + informationSend.getInfotitle() + "'";
				}
			}
			if(informationSend.getInfocontent() != null && !"".equals(informationSend.getInfocontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + informationSend.getInfocontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + informationSend.getInfocontent() + "'";
				}
			}
			if(informationSend.getDepartmentid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "上报人单位(发送方) = '" + informationSend.getDepartmentid() + "'";
				}else{
					operate_Condition += " and 上报人单位(发送方) = '" + informationSend.getDepartmentid() + "'";
				}
			}
			if(informationSend.getInfostate() != null && !"".equals(informationSend.getInfostate())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报状态 = '" + informationSend.getInfostate() + "'";
				}else{
					operate_Condition += " and 情报状态 = '" + informationSend.getInfostate() + "'";
				}
			}
			if(informationSend.getUrgentflag() != null && !"".equals(informationSend.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + informationSend.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + informationSend.getUrgentflag() + "'";
				}
			}
			if(informationSend.getInfosource() != null && !"".equals(informationSend.getInfosource())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报来源 = '" + informationSend.getInfosource() + "'";
				}else{
					operate_Condition += " and 情报来源 = '" + informationSend.getInfosource() + "'";
				}
			}
			if(informationSend.getInfotype() != null && !"".equals(informationSend.getInfotype())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报类型 = '" + informationSend.getInfotype() + "'";
				}else{
					operate_Condition += " and 情报类型 = '" + informationSend.getInfotype() + "'";
				}
			}
			if(informationSend.getSpecialid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "专项标签 = '" + informationSend.getSpecialid() + "'";
				}else{
					operate_Condition += " and 专项标签 = '" + informationSend.getSpecialid() + "'";
				}
			}
			if(informationSend.getGatherid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "采编标签 = '" + informationSend.getGatherid() + "'";
				}else{
					operate_Condition += " and 采编标签 = '" + informationSend.getGatherid() + "'";
				}
			}
			if(informationSend.getAnnotationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新批注id = '" + informationSend.getAnnotationid() + "'";
				}else{
					operate_Condition += " and 最新批注id = '" + informationSend.getAnnotationid() + "'";
				}
			}
			if(informationSend.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(0-作废 1-正常 2-退回 3-签收 4-已反馈) = '" + informationSend.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(0-作废 1-正常 2-退回 3-签收 4-已反馈) = '" + informationSend.getValidflag() + "'";
				}
			}
			if(informationSend.getFollowflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "关注标志(0-否 1-是) = '" + informationSend.getFollowflag() + "'";
				}else{
					operate_Condition += " and 关注标志(0-否 1-是) = '" + informationSend.getFollowflag() + "'";
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
			log.setOperate_Name("查询发布接收信息");
			String operate_Condition = "";
			if(informationSend.getReceiveid()!= 0){
				operate_Condition += "接收单位id = '" + informationSend.getReceiveid() + "'";
			}
			if(informationSend.getStarttime() != null && !"".equals(informationSend.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 >= '" + informationSend.getStarttime() + "'";
				}else{
					operate_Condition += " and 添加时间 >= '" + informationSend.getStarttime() + "'";
				}
			}
			if(informationSend.getEndtime() != null && !"".equals(informationSend.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 <= '" + informationSend.getEndtime() + "'";
				}else{
					operate_Condition += " and 添加时间 <= '" + informationSend.getEndtime() + "'";
				}
			}
			if(informationSend.getTuihuistarttime() != null && !"".equals(informationSend.getTuihuistarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "退回时间 >= '" + informationSend.getTuihuistarttime() + "'";
				}else{
					operate_Condition += " and 退回时间 >= '" + informationSend.getTuihuistarttime() + "'";
				}
			}
			if(informationSend.getTuihuiendtime() != null && !"".equals(informationSend.getTuihuiendtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "退回时间 <= '" + informationSend.getTuihuiendtime() + "'";
				}else{
					operate_Condition += " and 退回时间 <= '" + informationSend.getTuihuiendtime() + "'";
				}
			}
			if(informationSend.getInfotitle() != null && !"".equals(informationSend.getInfotitle())){
				if("".equals(operate_Condition)){
					operate_Condition += "标题 LIKE '" + informationSend.getInfotitle() + "'";
				}else{
					operate_Condition += " and 标题 LIKE '" + informationSend.getInfotitle() + "'";
				}
			}
			if(informationSend.getInfocontent() != null && !"".equals(informationSend.getInfocontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + informationSend.getInfocontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + informationSend.getInfocontent() + "'";
				}
			}
			if(informationSend.getDepartmentid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "上报人单位(发送方) = '" + informationSend.getDepartmentid() + "'";
				}else{
					operate_Condition += " and 上报人单位(发送方) = '" + informationSend.getDepartmentid() + "'";
				}
			}
			if(informationSend.getInfostate() != null && !"".equals(informationSend.getInfostate())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报状态 = '" + informationSend.getInfostate() + "'";
				}else{
					operate_Condition += " and 情报状态 = '" + informationSend.getInfostate() + "'";
				}
			}
			if(informationSend.getUrgentflag() != null && !"".equals(informationSend.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + informationSend.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + informationSend.getUrgentflag() + "'";
				}
			}
			if(informationSend.getInfosource() != null && !"".equals(informationSend.getInfosource())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报来源 = '" + informationSend.getInfosource() + "'";
				}else{
					operate_Condition += " and 情报来源 = '" + informationSend.getInfosource() + "'";
				}
			}
			if(informationSend.getInfotype() != null && !"".equals(informationSend.getInfotype())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报类型 = '" + informationSend.getInfotype() + "'";
				}else{
					operate_Condition += " and 情报类型 = '" + informationSend.getInfotype() + "'";
				}
			}
			if(informationSend.getSpecialid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "专项标签 = '" + informationSend.getSpecialid() + "'";
				}else{
					operate_Condition += " and 专项标签 = '" + informationSend.getSpecialid() + "'";
				}
			}
			if(informationSend.getGatherid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "采编标签 = '" + informationSend.getGatherid() + "'";
				}else{
					operate_Condition += " and 采编标签 = '" + informationSend.getGatherid() + "'";
				}
			}
			if(informationSend.getAnnotationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新批注id = '" + informationSend.getAnnotationid() + "'";
				}else{
					operate_Condition += " and 最新批注id = '" + informationSend.getAnnotationid() + "'";
				}
			}
			if(informationSend.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(0-作废 1-正常 2-退回 3-签收 4-已反馈) = '" + informationSend.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(0-作废 1-正常 2-退回 3-签收 4-已反馈) = '" + informationSend.getValidflag() + "'";
				}
			}
			if(informationSend.getFollowflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "关注标志(0-否 1-是) = '" + informationSend.getFollowflag() + "'";
				}else{
					operate_Condition += " and 关注标志(0-否 1-是) = '" + informationSend.getFollowflag() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 新增情报
	 * @param information
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addInformationSend.do")
	public @ResponseBody String addInformation(InformationSend informationSend,String receiveidList, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = sdf.format(new Date());
		System.out.println("addInformationsend.do ... ");
		informationSend.setAddtime(addtime);
		informationSend.setAddoperator(userSession.getLoginUserName());
		
		String content = userSession.getLoginUserDepartname() + " " + userSession.getLoginUserName();
		InfoTimeLine infoTimeLine = new InfoTimeLine();
		infoTimeLine.setInfoid(informationSend.getInformationid());
		infoTimeLine.setContent(content);
		infoTimeLine.setAddtime(addtime);
		infoTimeLine.setInfoAnnotationid(0);
		infoTimeLine.setInfoAssign(0);
		infoTimeLine.setAssignSignfor(0);
		
		String title = "";
		if("zhibao".equals(page)){
			title = "【直报】";
		}else{
			title = "【新增情报】";
		}
		infoTimeLine.setTitle(title);
		
		try {
			String[] receive = receiveidList.split(",");
			String sendid = "";
			for(int i=0;i<receive.length;i++){
				informationSend.setReceiveid(Integer.parseInt(receive[i]));
				int id = informationSendDao.add(informationSend);
				if(sendid.length()>0){
					sendid += ","+id;
				}else{
					sendid = ""+id;
				}
			}
			infoTimeLine.setInformationsendid(sendid);
			infoTimeLineDao.add(infoTimeLine);
			
			message = new Message("true","情报添加成功");
			message.setFlag(1);
			System.out.println("addInformationSend.do ... 情报添加成功");
			
			System.out.println("已录入时间轴");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加发布接收");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","情报添加失败");
			message.setFlag(-1);
			System.out.println("addInformationSend.do ... 情报添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加发布接收");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改
	 * @param company
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateinfosendflag.do")
	@ResponseBody
	public String updateinfosendflag(InformationSend informationSend, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String thistime = sdf.format(new Date());
		String note = "";
		try {
			if("topflag".equals(page)){
				informationSendDao.updatetopflag(informationSend);
				note = "置顶成功";
			}else if("hideflag".equals(page)){
				informationSendDao.updatehideflag(informationSend);
				note = "隐藏成功";
			}else if("followflag".equals(page)){
				informationSendDao.updatefollowflag(informationSend);
				note = "关注成功";
			}else if("tuihui".equals(page)){
				informationSend.setTuihuitime(thistime);
				informationSendDao.updateValidflag(informationSend);
				note = "退回成功";
				
				String content = userSession.getLoginUserDepartname()+ " " + userSession.getLoginUserName();
				InfoTimeLine infoTimeLine = new InfoTimeLine(informationSend.getInformationid(),informationSend.getId()+"","0",0,0,"【退回情报】",content,thistime,0);
				infoTimeLineDao.add(infoTimeLine);
				System.out.println("已录入时间轴");
				
			}else if("tuihuiqianshou".equals(page)){
				informationSend.setSignoperid(userSession.getLoginUserID());
				informationSend.setSignoper(userSession.getLoginUserName());
				informationSend.setSigntime(thistime);
				informationSendDao.updateValidflag(informationSend);
				note = "退回情报签收成功";
			}else if("tuihuifankui".equals(page)){
				informationSend.setFeedbackoperid(userSession.getLoginUserID());
				informationSend.setFeedbackoper(userSession.getLoginUserName());
				informationSend.setFeedbacktime(thistime);
				informationSendDao.updateValidflag(informationSend);
				note = "退回情报反馈成功";
			}
			message = new Message("true",note);
			message.setFlag(1);
			System.out.println("updateinfosendflag.do ... 修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改发布接收");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("fasle","单位信息修改失败");
			message.setFlag(-1);
			System.out.println("updateinfosendflag.do ... 修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改发布接收");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 根据id查询
	 * @return
	 */
	@RequestMapping("/getInformationSendById.do")
	public String getInformationById(Integer id, ModelMap model, int menuid, String page, @ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getInformationSendById.do ... id="+id+"page="+page);
		String url = "";
		List<File> files = new ArrayList<File>();
		String idlist = "";
		
		InformationSend informationSend = new InformationSend();
		try {
			informationSend = informationSendDao.getById(id);
			String attachements = informationSend.getAttachments();
			if(attachements!=null && attachements.length()>0){
				attachements = "(" + attachements + ")";
				files = fileDao.getFileMsgByIdstr(attachements);
			}
			/*
			 * idlist中为已接受到单位的id
			 * 包括information的主/其他报送单位(包含使用者当前部门)
			 * info_receive根据information-id查询到的单位id列表
			 * */
			idlist = informationSend.getSubmitunitid()+","+informationSend.getOtherunitids();
			InformationReceive info2 = new InformationReceive();
			info2.setInformationid(informationSend.getInformationid());
			info2.setInformationsendid(0);
			List<InformationReceive> receivelist = informationReceiveDao.searchByinformationid(info2);
			if(null!=receivelist && receivelist.size()>0){
				for(int i=0;i<receivelist.size();i++){
					idlist += ","+receivelist.get(i).getReceiveid();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("idlist", idlist);
		model.addAttribute("files", files);
		model.addAttribute("informationsend", informationSend);
		model.addAttribute("id", id);
		String PU = uploadFile_Document.replace("\\", "/");
		model.addAttribute("pictureurl", PU);
		
		Integer infoTId = informationSend.getInformationid();
		List<InfoJointPerson> infojointList = infoJointPersonDao.searchJointPerson(infoTId);
		model.addAttribute("infoJointList", infojointList);
//		Integer count = infoJointPersonDao.searchCount(infoTId);
		model.addAttribute("dataCount", infojointList.size());
		model.addAttribute("menuid",menuid);
		
		if("addReceive".equals(page)){
			url = "/jsp/information/info_add_receive";
		}else if("addzhibao".equals(page)){
			url = "/jsp/information/zhibao";
		}else if("addinfoAssign".equals(page)){
			url = "/jsp/information/info_add_assign";
		}
		
		return url;
	}
	
	/**
	 * 导出情报前查询信息
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/daochuinformation_send.do")
	public String daochuinformation_send(Integer id, Model model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		InformationSend informationSend = informationSendDao.getById(id);
		model.addAttribute("informationSend", informationSend);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询发布接收");
		String operate_Condition = "";
		operate_Condition += "发布接收id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/jsp/information/yulan";
	}
	
	/**
	 * 查询接报详情
	 * @param id
	 * @param informationid
	 * @param validflag
	 * @param specialid
	 * @param model
	 * @param page
	 * @param userSession
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/showinfoInformationSend.do")
	public String showinfoInformationSend(Integer id,Integer informationid,Integer validflag,Integer specialid, ModelMap model,int menuid,String page) throws Exception{
		List<File> files = new ArrayList<File>();
		model.addAttribute("id", id);
		model.addAttribute("informationid", informationid);
		model.addAttribute("specialid", specialid);
		model.addAttribute("validflag", validflag);
		model.addAttribute("menuid", menuid);
		
		List<InfoJointPerson> infojointList = new ArrayList<InfoJointPerson>();
		infojointList = infoJointPersonDao.searchJointPerson(informationid);
		model.addAttribute("infoJointList", infojointList);
		
		List<InfoTimeLine> infoTimeLineList = new ArrayList<InfoTimeLine>();
		InfoTimeLine infoTimeLine = new InfoTimeLine();
		infoTimeLine.setInfoid(informationid);
		infoTimeLine.setInformationsendid(id+"");
		infoTimeLine.setInformationreceiveid("0");
		infoTimeLine.setInfoAnnotationid(0);
		infoTimeLine.setInfoAssign(0);
		infoTimeLine.setAssignSignfor(0);
		infoTimeLineList = infoTimeLineDao.searchList(infoTimeLine);
		model.addAttribute("infoTimeLineList", infoTimeLineList);
		
		List<InformationReceive> receiveList = new ArrayList<InformationReceive>();
		model.addAttribute("infoReceiveList", receiveList);
		List<InfoAnnotation> infoAnnotationList = new ArrayList<InfoAnnotation>();
		model.addAttribute("infoAnnotationList", infoAnnotationList);
		
		try {
			InformationSend info = new InformationSend();
			info = informationSendDao.getById(id);
			model.addAttribute("info", info);
			String attachements = info.getAttachments();
			if(attachements!=null && attachements.length()>0){
				attachements = "(" + attachements + ")";
				files = fileDao.getFileMsgByIdstr(attachements);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("files", files);
		model.addAttribute("page", page);
		
		return "/jsp/information/info_show";
	}
	
	@RequestMapping("/rizhith.do")
	@ResponseBody
	public Map<String, Object> rizhith(Integer informationsendid){
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			InformationSend informationSend = informationSendDao.getById(informationsendid);
			result.put("data",informationSend.getTuihuireason());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/sgzxzqb.do")
	@ResponseBody
	public Map<String, Object> sgzxzqb(Integer infoid){
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			List<InformationSend> informationSend = informationSendDao.searchAdd(infoid);
			result.put("data",informationSend.toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}

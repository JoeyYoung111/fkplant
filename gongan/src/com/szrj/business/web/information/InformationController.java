package com.szrj.business.web.information;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONArray;
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
import com.aladdin.model.PieModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.FileDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.information.InfoJointPersonDao;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.dao.information.InformationDao;
import com.szrj.business.dao.information.InformationReceiveDao;
import com.szrj.business.dao.information.InformationSendDao;
import com.szrj.business.model.File;
import com.szrj.business.model.information.InfoAnnotation;
import com.szrj.business.model.information.InfoJointPerson;
import com.szrj.business.model.information.InfoTimeLine;
import com.szrj.business.model.information.Information;
import com.szrj.business.model.information.InformationReceive;
import com.szrj.business.model.information.InformationSend;
import com.szrj.business.model.personel.DuExtend;
import com.szrj.business.model.personel.Personnel;

@Controller
@SessionAttributes("userSession")
public class InformationController {

	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Picture;
	@Autowired
	private LogDao logDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private InformationDao informationDao;
	@Autowired
	private InformationSendDao informationSendDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	@Autowired
	private InfoJointPersonDao infoJointPersonDao;
	@Autowired
	private InformationReceiveDao informationReceiveDao;
	
	/**
	 * 查询所有
	 * @param information
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchInformation.do")
	@ResponseBody
	public Map<String, Object> searchInformaion(Information information, NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchInformation.do");
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			NewPageModel pagelist = informationDao.searchInformation(information, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total", pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询情报信息");
			String operate_Condition = "";
			if(information.getInfotitle() != null && !"".equals(information.getInfotitle())){
				operate_Condition += "标题 LIKE '" + information.getInfotitle() + "'";
			}
			if(information.getInfocontent() != null && !"".equals(information.getInfocontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + information.getInfocontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + information.getInfocontent() + "'";
				}
			}
			if(information.getDepartmentid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "上报人单位(发送方) = '" + information.getDepartmentid() + "'";
				}else{
					operate_Condition += " and 上报人单位(发送方) = '" + information.getDepartmentid() + "'";
				}
			}
			if(information.getInfostate() != null && !"".equals(information.getInfostate())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报状态 = '" + information.getInfostate() + "'";
				}else{
					operate_Condition += " and 情报状态 = '" + information.getInfostate() + "'";
				}
			}
			if(information.getUrgentflag() != null && !"".equals(information.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + information.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + information.getUrgentflag() + "'";
				}
			}
			if(information.getInfosource() != null && !"".equals(information.getInfosource())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报来源 = '" + information.getInfosource() + "'";
				}else{
					operate_Condition += " and 情报来源 = '" + information.getInfosource() + "'";
				}
			}
			if(information.getInfotype() != null && !"".equals(information.getInfotype())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报类型 = '" + information.getInfotype() + "'";
				}else{
					operate_Condition += " and 情报类型 = '" + information.getInfotype() + "'";
				}
			}
			if(information.getGatherid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "采编标签 = '" + information.getGatherid() + "'";
				}else{
					operate_Condition += " and 采编标签 = '" + information.getGatherid() + "'";
				}
			}
			if(information.getAnnotationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新批注id = '" + information.getAnnotationid() + "'";
				}else{
					operate_Condition += " and 最新批注id = '" + information.getAnnotationid() + "'";
				}
			}
			if(information.getStarttime() != null && !"".equals(information.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "上报时间(发送方) >= '" + information.getStarttime() + "'";
				}else{
					operate_Condition += " and 上报时间(发送方) >= '" + information.getStarttime() + "'";
				}
			}
			if(information.getEndtime() != null && !"".equals(information.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "上报时间(发送方) <= '" + information.getEndtime() + "'";
				}else{
					operate_Condition += " and 上报时间(发送方) <= '" + information.getEndtime() + "'";
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
			log.setOperate_Name("查询情报信息");
			String operate_Condition = "";
			if(information.getInfotitle() != null && !"".equals(information.getInfotitle())){
				operate_Condition += "标题 LIKE '" + information.getInfotitle() + "'";
			}
			if(information.getInfocontent() != null && !"".equals(information.getInfocontent())){
				if("".equals(operate_Condition)){
					operate_Condition += "内容 LIKE '" + information.getInfocontent() + "'";
				}else{
					operate_Condition += " and 内容 LIKE '" + information.getInfocontent() + "'";
				}
			}
			if(information.getDepartmentid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "上报人单位(发送方) = '" + information.getDepartmentid() + "'";
				}else{
					operate_Condition += " and 上报人单位(发送方) = '" + information.getDepartmentid() + "'";
				}
			}
			if(information.getInfostate() != null && !"".equals(information.getInfostate())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报状态 = '" + information.getInfostate() + "'";
				}else{
					operate_Condition += " and 情报状态 = '" + information.getInfostate() + "'";
				}
			}
			if(information.getUrgentflag() != null && !"".equals(information.getUrgentflag())){
				if("".equals(operate_Condition)){
					operate_Condition += "紧急程度 = '" + information.getUrgentflag() + "'";
				}else{
					operate_Condition += " and 紧急程度 = '" + information.getUrgentflag() + "'";
				}
			}
			if(information.getInfosource() != null && !"".equals(information.getInfosource())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报来源 = '" + information.getInfosource() + "'";
				}else{
					operate_Condition += " and 情报来源 = '" + information.getInfosource() + "'";
				}
			}
			if(information.getInfotype() != null && !"".equals(information.getInfotype())){
				if("".equals(operate_Condition)){
					operate_Condition += "情报类型 = '" + information.getInfotype() + "'";
				}else{
					operate_Condition += " and 情报类型 = '" + information.getInfotype() + "'";
				}
			}
			if(information.getGatherid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "采编标签 = '" + information.getGatherid() + "'";
				}else{
					operate_Condition += " and 采编标签 = '" + information.getGatherid() + "'";
				}
			}
			if(information.getAnnotationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "最新批注id = '" + information.getAnnotationid() + "'";
				}else{
					operate_Condition += " and 最新批注id = '" + information.getAnnotationid() + "'";
				}
			}
			if(information.getStarttime() != null && !"".equals(information.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "上报时间(发送方) >= '" + information.getStarttime() + "'";
				}else{
					operate_Condition += " and 上报时间(发送方) >= '" + information.getStarttime() + "'";
				}
			}
			if(information.getEndtime() != null && !"".equals(information.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "上报时间(发送方) <= '" + information.getEndtime() + "'";
				}else{
					operate_Condition += " and 上报时间(发送方) <= '" + information.getEndtime() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 根据id查询
	 * @return
	 */
	@RequestMapping("/getInformationById.do")
	public String getInformationById(int id, int menuid, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		String url = "/jsp/information/zhibao";
		List<File> files = new ArrayList<File>();
		String idlist = "";
		
		Information information = new Information();
		try {
			information = informationDao.getById(id);
			String attachements = information.getAttachments();
			if(attachements!=null && attachements.length()>0){
				attachements = "(" + attachements + ")";
				files = fileDao.getFileMsgByIdstr(attachements);
			}
			
			idlist = information.getSubmitunitid()+","+information.getOtherunitids();
			InformationReceive info = new InformationReceive();
			info.setInformationid(id);
			info.setInformationsendid(0);
			List<InformationReceive> receiveList = informationReceiveDao.searchByinformationid(info);
			if(null!=receiveList && receiveList.size()>0){
				for(int i=0;i<receiveList.size();i++){
					idlist += ","+receiveList.get(i).getReceiveid();
				}
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询情报信息");
			String operate_Condition = "";
			operate_Condition += "情报信息ID = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询情报信息");
			String operate_Condition = "";
			operate_Condition += "情报信息ID = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		
		model.addAttribute("idlist", idlist);
		model.addAttribute("files", files);
		model.addAttribute("informationsend", information);
		model.addAttribute("id", id);
		model.addAttribute("menuid",menuid);
		String PU = uploadFile_Picture.replace("\\", "/");
		model.addAttribute("pictureurl", PU);
		
		List<InfoJointPerson> infoJointList = infoJointPersonDao.searchJointPerson(id);
		model.addAttribute("infoJointList", infoJointList);
		model.addAttribute("dataCount", infoJointList.size());
		
		return url;
	}
	
	/**
	 * 新增情报
	 * @param information
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addInformation.do")
	public @ResponseBody String addInformation(Information information, String page, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = sdf.format(new Date());
		System.out.println("addInformation.do ... menuid = " + menuid);
		information.setAddtime(addtime);
		information.setAddoperator(userSession.getLoginUserName());
		information.setDepartmentid(userSession.getLoginUserDepartmentid());
		try {
			int id = informationDao.add(information);
			message = new Message("true","情报添加成功");
			message.setFlag(id);
			logDao.recordLog(menuid, "情报添加成功", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addInformation.do ... 情报添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("情报添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","情报添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "情报添加失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addInformation.do ... 情报添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("情报添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
	@RequestMapping("/showinfoInformation.do")
	public String showinfoInformation(Integer id,ModelMap model,int menuid)throws Exception{
		List<File> files = new ArrayList<File>();
		model.addAttribute("id", id);
		model.addAttribute("menuid", menuid);
		
		List<InfoJointPerson> infojointList = new ArrayList<InfoJointPerson>();
		infojointList = infoJointPersonDao.searchJointPerson(id);
		model.addAttribute("infoJointList", infojointList);
		
		List<InfoTimeLine> infoTimeLineList = new ArrayList<InfoTimeLine>();
		InfoTimeLine infoTimeLine = new InfoTimeLine();
		infoTimeLine.setInfoid(id);
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
			Information information = new Information();
			information = informationDao.getById(id);
			model.addAttribute("info", information);
			String attachments = information.getAttachments();
			if(attachments!=null && attachments.length()>0){
				attachments = "(" + attachments + ")";
				files = fileDao.getFileMsgByIdstr(attachments);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("files", files);
		
		return "/jsp/information/info_report_show";
	}
	
	@RequestMapping("/daochuinformation.do")
	public String daochuinformation_send(Integer id, Model model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Information information = informationDao.getById(id);
		model.addAttribute("informationSend", information);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID情报信息");
		String operate_Condition = "";
		operate_Condition += "情报信息ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/jsp/information/yulan";
	}
	
	@RequestMapping("/getInfoStatistics.do")
	public String getInfoStatistics(InformationSend informationSend,ModelMap model){
		try {
			//总计
			int zj = informationSendDao.searchInformationsend_count(informationSend);
			model.addAttribute("zj", zj);
			//退回数
			informationSend.setValidflag(2);
			int th = informationSendDao.searchInformationsend_count(informationSend);
			model.addAttribute("th", th);
			model.addAttribute("cy", zj-th);
			//查询各派出所报送数
			Information information = new Information();
			information.setDeparttype(4);
			List<Information> pcsList = informationDao.getSendcountByDepttype(information);
			List<String> sendpoliceList = new ArrayList<String>();
			List<Integer> sendpolicecountList = new ArrayList<Integer>();
			for(int i=0;i<pcsList.size();i++){
				sendpoliceList.add(pcsList.get(i).getDepartname());
				sendpolicecountList.add(pcsList.get(i).getValue());
			}
			model.addAttribute("sendpoliceList", JSONArray.fromObject(sendpoliceList).toString());
			model.addAttribute("sendpolicecountList", JSONArray.fromObject(sendpolicecountList).toString());
			//退回数
			information.setValidflag(2);
			List<Information> thpcsList = informationDao.getSendcountByDepttype(information);
			List<String> thsendpoliceList = new ArrayList<String>();
			List<Integer> thsendpolicecountList = new ArrayList<Integer>();
			for(int i=0;i<thpcsList.size();i++){
				thsendpoliceList.add(thpcsList.get(i).getDepartname());
				thsendpolicecountList.add(thpcsList.get(i).getValue());
			}
			model.addAttribute("thsendpoliceList", JSONArray.fromObject(thsendpoliceList).toString());
			model.addAttribute("thsendpolicecountList", JSONArray.fromObject(thsendpolicecountList).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/chart/exam/list";
	}
}

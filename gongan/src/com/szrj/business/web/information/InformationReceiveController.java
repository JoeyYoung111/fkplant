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
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.dao.information.InformationDao;
import com.szrj.business.dao.information.InformationReceiveDao;
import com.szrj.business.model.information.InfoTimeLine;
import com.szrj.business.model.information.Information;
import com.szrj.business.model.information.InformationReceive;

@Controller
@SessionAttributes("userSession")
public class InformationReceiveController {

	@Autowired
	private InformationReceiveDao informationReceiveDao;
	@Autowired
	private InformationDao informationDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	
	
	/**
	 * 查询所有
	 * @param information
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchInformationReceive.do")
	@ResponseBody
	public Map<String, Object> searchInformaionReceive(InformationReceive information, NewPageModel pm, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchInformationReceive.do");
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			NewPageModel pagelist = informationReceiveDao.searchInformation(information, pm, page);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total", pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询转阅接收信息");
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
			if(information.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否签收（1-未签收 2-已签收） = '" + information.getValidflag() + "'";
				}else{
					operate_Condition += " and 是否签收（1-未签收 2-已签收） = '" + information.getValidflag() + "'";
				}
			}
			if(information.getFeedbackflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否反馈(1-未反馈 2-已反馈) = '" + information.getFeedbackflag() + "'";
				}else{
					operate_Condition += " and 是否反馈(1-未反馈 2-已反馈) = '" + information.getFeedbackflag() + "'";
				}
			}
			if(information.getStarttime() != null && !"".equals(information.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "转阅时间 >= '" + information.getStarttime() + "'";
				}else{
					operate_Condition += " and 转阅时间 >= '" + information.getStarttime() + "'";
				}
			}
			if(information.getEndtime() != null && !"".equals(information.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "转阅时间 <= '" + information.getEndtime() + "'";
				}else{
					operate_Condition += " and 转阅时间 <= '" + information.getEndtime() + "'";
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
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询转阅接收信息");
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
			if(information.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否签收（1-未签收 2-已签收） = '" + information.getValidflag() + "'";
				}else{
					operate_Condition += " and 是否签收（1-未签收 2-已签收） = '" + information.getValidflag() + "'";
				}
			}
			if(information.getFeedbackflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否反馈(1-未反馈 2-已反馈) = '" + information.getFeedbackflag() + "'";
				}else{
					operate_Condition += " and 是否反馈(1-未反馈 2-已反馈) = '" + information.getFeedbackflag() + "'";
				}
			}
			if(information.getStarttime() != null && !"".equals(information.getStarttime())){
				if("".equals(operate_Condition)){
					operate_Condition += "转阅时间 >= '" + information.getStarttime() + "'";
				}else{
					operate_Condition += " and 转阅时间 >= '" + information.getStarttime() + "'";
				}
			}
			if(information.getEndtime() != null && !"".equals(information.getEndtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "转阅时间 <= '" + information.getEndtime() + "'";
				}else{
					operate_Condition += " and 转阅时间 <= '" + information.getEndtime() + "'";
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
	@RequestMapping("/addInformationReceive.do")
	public @ResponseBody String addInformation(InformationReceive informationReceive, String receiveidlist,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		System.out.println("addInformationReceive.do ... ");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String transfertime = sdf.format(new Date());
		informationReceive.setTransfertime(transfertime);
		informationReceive.setTransferoperid(userSession.getLoginUserID());
		informationReceive.setTransferoper(userSession.getLoginUserName());
		informationReceive.setTransferdepid(userSession.getLoginUserDepartmentid());
		informationReceive.setSignoperid(0);
		informationReceive.setFeedbackoperid(0);

		String content = userSession.getLoginUserDepartname()+ " " + userSession.getLoginUserName();
		InfoTimeLine infoTimeLine = new InfoTimeLine();
		infoTimeLine.setInfoid(informationReceive.getInformationid());
		infoTimeLine.setInformationsendid(informationReceive.getInformationsendid()+"");
		infoTimeLine.setContent(content);
		infoTimeLine.setAddtime(transfertime);
		infoTimeLine.setInfoAnnotationid(0);
		infoTimeLine.setInfoAssign(0);
		infoTimeLine.setAssignSignfor(0);
		infoTimeLine.setTitle("【转阅】");
		try {
			String[] receive = receiveidlist.split(",");
			String receiveid = "";
			for(int i=0;i<receive.length;i++){
				informationReceive.setReceiveid(Integer.parseInt(receive[i]));
				int id = informationReceiveDao.add(informationReceive);
				if(receiveid.length()>0){
					receiveid += "," + id;
				}else{
					receiveid = ""+id;
				}
			}
			infoTimeLine.setInformationreceiveid(receiveid);
			infoTimeLineDao.add(infoTimeLine);
			
			System.out.println("已录入时间轴");
			message = new Message("true","情报添加成功");
			message.setFlag(1);
			System.out.println("addInformationSend.do ... 情报添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("新增转阅接收信息");
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
			log.setOperate_Name("新增转阅接收信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改
	 * @param informationReceive
	 * @param page
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateinforeceiveflag.do")
	@ResponseBody
	public String updateinforeceiveflag(InformationReceive informationReceive, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String thistime = sdf.format(new Date());
		try {
			if("zhuanyueqianshou".equals(page)){
				informationReceive.setSigntime(thistime);
				informationReceive.setSignoperid(userSession.getLoginUserID());
				informationReceive.setSignoper(userSession.getLoginUserName());
				informationReceiveDao.qianshou(informationReceive);
			}else if("zhuanyuefankui".equals(page)){
				informationReceive.setFeedbacktime(thistime);
				informationReceive.setFeedbackoperid(userSession.getLoginUserID());
				informationReceive.setFeedbackoper(userSession.getLoginUserName());
				informationReceiveDao.fankui(informationReceive);
			}
			message = new Message("true","反馈成功");
			message.setFlag(1);
			System.out.println("updateinforeceiveflag.do ...");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("反馈转阅接收信息");
			String operate_Condition = "";
			operate_Condition += "转阅接收信息id = '" + informationReceive.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","处理失败");
			message.setFlag(-1);
			System.out.println("updateinforeceiveflag.do ...");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("反馈转阅接收信息");
			String operate_Condition = "";
			operate_Condition += "转阅接收信息id = '" + informationReceive.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 转阅详情
	 * @return
	 */
	@RequestMapping("/zhuanyuexiangqing.do")
	public String zhuanyuexiangqing(Integer id, ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		Information information = informationDao.getById(id);
		InformationReceive info = new InformationReceive();
		info.setInformationid(id);
		info.setInformationsendid(0);
		List<InformationReceive> receivelist = informationReceiveDao.searchByinformationid(info);
		model.addAttribute("info", information);
		model.addAttribute("infoReceiveList", receivelist);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询转阅接收信息");
		String operate_Condition = "";
		operate_Condition += "转阅接收信息id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/jsp/information/info_receive_show";
	}
	
	@RequestMapping("/rizhizhuanyue.do")
	@ResponseBody
	public Map<String, Object> rizhizhuanyue(String informationreceiveid, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		informationreceiveid = "("+informationreceiveid+")";
		try {
			List<InformationReceive> infoReceiveList = informationReceiveDao.rizhizhuanyue(informationreceiveid);
			result.put("data",infoReceiveList.toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}

package com.szrj.business.web.information;

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
import com.szrj.business.dao.information.InfoAnnotationDao;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.dao.information.InformationDao;
import com.szrj.business.dao.information.InformationSendDao;
import com.szrj.business.model.information.InfoAnnotation;
import com.szrj.business.model.information.InfoTimeLine;
import com.szrj.business.model.information.Information;
import com.szrj.business.model.information.InformationSend;

@Controller
@SessionAttributes("userSession")
public class InfoAnnotationController {
	
	@Autowired
	private InfoAnnotationDao infoAnnotationDao;
	@Autowired
	private InformationSendDao informationsendDao;
	@Autowired
	private InformationDao informationDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;

	
	/**
	 * 新增批注
	 * @param infoAnnotation
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addInfoAnnotation.do")
	public @ResponseBody String addInfoAnnotation(InfoAnnotation infoAnnotation,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = sdf.format(new Date());
		infoAnnotation.setAddtime(addtime);
		infoAnnotation.setAddoperator(userSession.getLoginUserName());
		System.out.println("addInfoAnnotation.do ...");
		
		InfoTimeLine infoTimeLine = new InfoTimeLine();
		infoTimeLine.setInfoid(infoAnnotation.getInformationid());
		infoTimeLine.setInformationsendid(infoAnnotation.getSendid()+"");
		infoTimeLine.setInformationreceiveid("0");
		infoTimeLine.setAddtime(addtime);
		infoTimeLine.setInfoAssign(0);
		infoTimeLine.setAssignSignfor(0);

		try {
			int id = infoAnnotationDao.add(infoAnnotation);
			infoTimeLine.setInfoAnnotationid(id);
			String content = userSession.getLoginUserDepartname()+ " " +  userSession.getLoginUserName();
			infoTimeLine.setContent(content);
			
			InformationSend informationsend = new InformationSend();
			informationsend.setId(infoAnnotation.getSendid());
			if(infoAnnotation.getAnnotationtype()==1){
				informationsend.setYtpizhuid(id);
				informationsendDao.ytpizhuid(informationsend);
				informationsend = informationsendDao.getById(infoAnnotation.getSendid());
				Information information = new Information();
				information.setId(informationsend.getInformationid());
				information.setAnnotationid(id);
				informationDao.updatePizhu(information);
				infoTimeLine.setTitle("【源头批注】");
			}else{
				informationsend.setPizhuid(id);
				informationsendDao.pizhuid(informationsend);
				infoTimeLine.setTitle("【工作批注】");
			}
			infoTimeLineDao.add(infoTimeLine);
			System.out.println("已录入时间轴");
			message = new Message("true","批注成功");
			message.setFlag(id);
			System.out.println("addInfoAnnotation.do ... 批注添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加情报批注");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","批注失败");
			message.setFlag(-1);
			System.out.println("addInfoAnnotation.do ... 批注添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加情报批注");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 签收批注
	 * @param infoAnnotation
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/qianshouInfoAnnotation.do")
	@ResponseBody
	public String qianshouInfoAnnotation(InfoAnnotation infoAnnotation,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signtime = sdf.format(new Date());
		infoAnnotation.setSigntime(signtime);
		infoAnnotation.setSignoper(userSession.getLoginUserName());
		System.out.println("qianshouInfoAnnotation.do ...");
		try {
			infoAnnotationDao.qianshou(infoAnnotation);
			
			message = new Message("true","批注签收成功");
			message.setFlag(1);
			System.out.println("qianshouInfoAnnotation.do ... 签收成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("批注签收");
			String operate_Condition = "";
			operate_Condition += "情报批注id = '" + infoAnnotation.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","签收批注失败");
			message.setFlag(-1);
			System.out.println("qianshouInfoAnnotation.do ... 签收失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("批注签收");
			String operate_Condition = "";
			operate_Condition += "情报批注id = '" + infoAnnotation.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
	@RequestMapping("/searchInfoAnnotation.do")
	public String searchlastinfo(Integer id, Integer informationid, Integer receiveid, ModelMap model) throws Exception{
		String url = "/jsp/information/pizhu";
		model.addAttribute("id", id);
		model.addAttribute("informationid", informationid);
		model.addAttribute("receiveid", receiveid);
		return url;
	}
	
	
	@RequestMapping("/searchAnnotation.do")
	@ResponseBody
	public Map<String, Object> searchAnnotation(InfoAnnotation infoAnnotation, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		infoAnnotation.setValidflag(0);
		infoAnnotation.setLimit(0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = infoAnnotationDao.searchAnnotation(infoAnnotation, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询情报批注表");
			String operate_Condition = "";
			if(infoAnnotation.getSendid()!= 0){
				operate_Condition += "发布接收id = '" + infoAnnotation.getSendid() + "'";
			}
			if(infoAnnotation.getAnnotationtype() != null && !"".equals(infoAnnotation.getAnnotationtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "批注类型(1-源头批注 2-工作批注) = '" + infoAnnotation.getAnnotationtype() + "'";
				}else{
					operate_Condition += " and 批注类型(1-源头批注 2-工作批注) = '" + infoAnnotation.getAnnotationtype() + "'";
				}
			}
			if(infoAnnotation.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(1-未签收 2-已签收) = '" + infoAnnotation.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(1-未签收 2-已签收) = '" + infoAnnotation.getValidflag() + "'";
				}
			}
			if(infoAnnotation.getInformationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "情报信息id = '" + infoAnnotation.getInformationid() + "'";
				}else{
					operate_Condition += " and 情报信息id = '" + infoAnnotation.getInformationid() + "'";
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
			log.setOperate_Name("查询情报批注表");
			String operate_Condition = "";
			if(infoAnnotation.getSendid()!= 0){
				operate_Condition += "发布接收id = '" + infoAnnotation.getSendid() + "'";
			}
			if(infoAnnotation.getAnnotationtype() != null && !"".equals(infoAnnotation.getAnnotationtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "批注类型(1-源头批注 2-工作批注) = '" + infoAnnotation.getAnnotationtype() + "'";
				}else{
					operate_Condition += " and 批注类型(1-源头批注 2-工作批注) = '" + infoAnnotation.getAnnotationtype() + "'";
				}
			}
			if(infoAnnotation.getValidflag() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "状态标识(1-未签收 2-已签收) = '" + infoAnnotation.getValidflag() + "'";
				}else{
					operate_Condition += " and 状态标识(1-未签收 2-已签收) = '" + infoAnnotation.getValidflag() + "'";
				}
			}
			if(infoAnnotation.getInformationid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "情报信息id = '" + infoAnnotation.getInformationid() + "'";
				}else{
					operate_Condition += " and 情报信息id = '" + infoAnnotation.getInformationid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}

	@RequestMapping("/getAnnotationById.do")
	@ResponseBody
	public Map<String, Object> getAnnotationById(Integer id,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		InfoAnnotation infoAnnotation = infoAnnotationDao.getById(id);
		result.put("data",infoAnnotation);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据id查询情报批注表");
		String operate_Condition = "";
		operate_Condition += "情报批注表id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return result;
		
	}
	
}

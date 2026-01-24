package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.dao.personel.ZaExtendDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.ZaDu;
import com.szrj.business.model.personel.ZaChang;
import com.szrj.business.model.personel.ZaPei;
import com.szrj.business.model.personel.ZaExtend;
import com.szrj.business.model.personel.ZaCaseAddress;
import com.szrj.business.model.personel.HomeplaceHistory;
import com.szrj.business.service.personel.ZaRelationService;


@Controller
@SessionAttributes("userSession")
public class CyPersonController {
	@Autowired
	private LogDao logDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private ZaExtendDao zaExtendDao;
	@Autowired
	private ZaRelationService zaRelationService;
	@RequestMapping("/searchCyPerson.do")
	@ResponseBody
	public Map<String,Object>  searchCyPerson(Personnel personnel,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
			Map<String, Object> result = new HashMap<String, Object>();
			try {
				pm.setPageNumber(page);
			    NewPageModel listTemp=personnelDao.searchCyPerson(personnel, pm);
		        result.put("code", 0);
		        result.put("count", listTemp.getTotal());
		        result.put("data", listTemp.getRows().toArray());
		        //生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("查询非风险人员信息");
				String operate_Condition = "";
				if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
				}
				if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
					}
				}
				if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
					if("".equals(operate_Condition)){
						operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
					}else{
						operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
					}
				}
				if(personnel.getNation() != null && !"".equals(personnel.getNation())){
					if("".equals(operate_Condition)){
						operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
					}else{
						operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
					}
				}
				if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
					}
				}
				if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
					}else{
						operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
					}
				}
				if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
					}else{
						operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
					}
				}
				if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
					}else{
						operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
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
				log.setOperate_Name("查询非风险人员信息");
				String operate_Condition = "";
				if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
				}
				if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
					}
				}
				if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
					if("".equals(operate_Condition)){
						operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
					}else{
						operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
					}
				}
				if(personnel.getNation() != null && !"".equals(personnel.getNation())){
					if("".equals(operate_Condition)){
						operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
					}else{
						operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
					}
				}
				if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
					}
				}
				if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
					}else{
						operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
					}
				}
				if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
					}else{
						operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
					}
				}
				if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
					}else{
						operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
	        return result;
	}
	
	@RequestMapping("/searchZaExtend.do")
	@ResponseBody
	public Map<String,Object>  searchZaExtend(ZaExtend zaExtend,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    pm.setPageNumber(page);
		    NewPageModel listTemp=zaExtendDao.search(zaExtend, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询治安扩展信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	
	@RequestMapping("/addCyPerson.do")
	public @ResponseBody String addCyPerson(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			User jurisdictpolice1=userDao.getById(Integer.parseInt(personnel.getJdpolice1()));
			personnel.setAddtime(addtime);
			personnel.setAddoperator(userSession.getLoginUserName());
			personnel.setAddoperatorid(userSession.getLoginUserID());
			personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
			personnel.setPphone1(jurisdictpolice1.getContactnumber());
			personnel.setPersontype("从业人员");
			int id = personnelDao.addCyPerson(personnel);
			//新增扩展表
			ZaExtend zaExtend = new ZaExtend();
			zaExtend.setPersonnelid(id);
			zaExtendDao.add(zaExtend);
			message= new Message("true","非风险人员添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加非风险人员", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加非风险人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","非风险人员添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "非风险人员添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加非风险人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getCyPerson.do")
	public String getCyPerson(Personnel personnel,int menuid,String buttons,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		personnel=personnelDao.getById(personnel.getId());
		model.addAttribute("personnel", personnel);
		model.addAttribute("menuid", menuid);
		model.addAttribute("buttons", buttons);
		int age=CardnumberInfo.getAge(personnel.getCardnumber());
		model.addAttribute("age",age);
		List<BasicMsg> marrystatus=basicMsgDao.getByType(16);//通用-婚姻状况
		model.addAttribute("marrystatus",marrystatus);
		
		List<BasicMsg> nation=basicMsgDao.getByType(15);//通用-民族
		model.addAttribute("nation",nation);
		
		List<BasicMsg> soldierstatus=basicMsgDao.getByType(21);//通用-兵役状况
		model.addAttribute("soldierstatus",soldierstatus);
		
		List<BasicMsg> heathstatus=basicMsgDao.getByType(54);//通用-健康状态
		model.addAttribute("heathstatus",heathstatus);
		
		List<BasicMsg> politicalposition=basicMsgDao.getByType(17);//通用-政治面貌
		model.addAttribute("politicalposition",politicalposition);
		
		List<BasicMsg> faith=basicMsgDao.getByType(18);//通用-宗教信仰
		model.addAttribute("faith",faith);
		
		List<BasicMsg> education=basicMsgDao.getByType(19);//通用-文化程度
		model.addAttribute("education",education);
		
		//派出所
		Department policeDepartment=new Department();
		policeDepartment.setDeparttype(String.valueOf(4));
		List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
		model.addAttribute("policeList",policeList);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询非风险人员");
		String operate_Condition = "";
		operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/jsp/personel/cy/update";
	}
	
	@RequestMapping("/getZaExtend.do")
	@ResponseBody
	public Map<String,Object> getZaExtend(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			ZaExtend zaExtend = zaExtendDao.getById(personnelid);
			result.put("zaExtend", zaExtend);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询非风险人员扩展信息");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询非风险人员扩展信息");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/updateZaExtend.do")
	public @ResponseBody String updateZaExtend(ZaExtend zaExtend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			zaExtend.setUpdateoperator(userSession.getLoginUserName());
			zaExtend.setUpdatetime(addtime);
			zaExtendDao.update(zaExtend);
			
			message = new Message("true","从业人员修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "从业人员修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改非风险人员扩展信息");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + zaExtend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","从业人员修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "从业人员修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改非风险人员扩展信息");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + zaExtend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateCyPerson.do")
	public @ResponseBody String updateCyPerson(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.updateSK(personnel);
			
			message = new Message("true","从业人员修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "从业人员修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改非风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","从业人员修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "从业人员修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改非风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelCyPerson.do")
	public @ResponseBody String cancelCyPerson(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.cancel(personnel);
			
			message = new Message("true","从业人员删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "从业人员删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除非风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","从业人员删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "从业人员删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除非风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateCyPersonRisk.do")
	public @ResponseBody String updateCyPersonRisk(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			//变为治安风险人员
			personnel.setIsrisk(1);
			personnel.setZslabel1("2046");
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.updateCyPersonRisk(personnel);
			message = new Message("true","升级风险人员成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "升级风险人员", userSession.getLoginUserName(), addtime, "升级成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("升级风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","升级风险人员失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "升级风险人员", userSession.getLoginUserName(), addtime, "升级失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("升级风险人员");
			String operate_Condition = "";
			operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 获取江阴派出所列表
	 * 从视图v_jiangyin_police_stations获取
	 * @return
	 */
	@RequestMapping("/getJiangyinPoliceStations.do")
	@ResponseBody
	public List<Map<String, Object>> getJiangyinPoliceStations(){
		return departmentDao.getJiangyinPoliceStations();
	}

	/*治安人员*/
	@RequestMapping("/searchZaPersonnel.do")
	@ResponseBody
	public Map<String,Object>  searchZaPersonnel(Personnel personnel,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
//		if(userSession.getLoginRoleMsgFilter()==1){
//			switch (userSession.getLoginRoleFieldFilter()) {
//			case 1:
//				personnel.setUnitFilter(userSession.getLoginUserDepartmentid());
//				break;
//			case 2:
//				personnel.setPersonFilter(userSession.getLoginUserID());
//				break;
//			}	
//		}
		String sqlall="";
		if (personnel.getAttributelabels()!=null&!"".equals(personnel.getAttributelabels())) {
			if (!personnel.getAttributelabels().contains(",")) {
				if (sqlall!="")sqlall +=" AND ";
				sqlall += "FIND_IN_SET("+personnel.getAttributelabels()+",p.zslabel2)";
			}else {
				String[] attributes=personnel.getAttributelabels().split(",");
				for (int i = 0; i < attributes.length; i++) {
					if(i>0)sqlall += " OR ";
					sqlall += "FIND_IN_SET("+attributes[i]+",p.zslabel2)";
				}
			}
		}
		if(!"".equals(sqlall))personnel.setSqlall(sqlall);
		pm.setPageNumber(page);
		   NewPageModel listTemp=personnelDao.searchZaPersonnel(personnel, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询治安人员信息");
			String operate_Condition = "";
			if(personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnel.getCardnumber() + "'";
			}
			if(personnel.getPersonname() != null && !"".equals(personnel.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnel.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnel.getPersonname() + "'";
				}
			}
			if(personnel.getSexes() != null && !"".equals(personnel.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + personnel.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + personnel.getSexes() + "'";
				}
			}
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 LIKE '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 LIKE '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getWorkplace() != null && !"".equals(personnel.getWorkplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}else{
					operate_Condition += " and 工作地详址 LIKE '" + personnel.getWorkplace() + "'";
				}
			}
			if(personnel.getHomepolice() != null && !"".equals(personnel.getHomepolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}else{
					operate_Condition += " and 现住地派出所 LIKE '" + personnel.getHomepolice() + "'";
				}
			}
			if(personnel.getWorkpolice() != null && !"".equals(personnel.getWorkpolice())){
				if("".equals(operate_Condition)){
					operate_Condition += "工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}else{
					operate_Condition += " and 工作地派出所 LIKE '" + personnel.getWorkpolice() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	
	@RequestMapping("/addZaPerson.do")
	public @ResponseBody String addZaPerson(Personnel personnel,String ybssid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			int findid=personnelDao.findPersonInPersonnel(personnel.getCardnumber());
			if (findid>0) {
				Personnel person=personnelDao.getById(findid);
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为治安风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
					//生成操作日志
					UserActionLog log = CreateLogXML.AssignUserLog(userSession);
					log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
					log.setOperate_Result("1");	//0：失败 1：成功
					log.setOperate_Name("升级风险人员");
					String operate_Condition = "";
					operate_Condition += "非风险人员ID = '" + personnel.getId() + "'";
					log.setOperate_Condition(operate_Condition);
					log.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(log);
				}
				User jurisdictpolice1=userDao.getById(Integer.parseInt(personnel.getJdpolice1()));
				/*****一标三识数据关联*****/
				if(ybssid!=null&&!"".equals(ybssid)){
					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
					person.setPersontype(ybssPersonnel.getPersontype());
					person.setNation(ybssPersonnel.getNation());
					person.setMarrystatus(ybssPersonnel.getMarrystatus());
					person.setEducation(ybssPersonnel.getEducation());
					person.setHouseplace(ybssPersonnel.getHouseplace());
					person.setHomeplace(ybssPersonnel.getHomeplace());
					person.setHomex(ybssPersonnel.getHomex());
					person.setHomey(ybssPersonnel.getHomey());
					person.setWorkplace(ybssPersonnel.getWorkplace());
					if(ybssPersonnel.getTelnumber()!=null&&!"".equals(ybssPersonnel.getTelnumber())){
						String[] telnumbers=ybssPersonnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(findid);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
				}
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1!="")zslabel1+=",";
				zslabel1+="2046";
				person.setZslabel1(zslabel1);
				person.setUpdatetime(addtime);
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setPphone1(jurisdictpolice1.getContactnumber());
				personnelDao.update(person);
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("一标三识数据关联");
				String operate_Condition = "";
				operate_Condition += "人员ID = '" + personnel.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else {
				User jurisdictpolice1=userDao.getById(Integer.parseInt(personnel.getJdpolice1()));
				/*****一标三识数据关联*****/
				if(ybssid!=null&&!"".equals(ybssid)){
					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
					personnel.setPersontype(ybssPersonnel.getPersontype());
					personnel.setNation(ybssPersonnel.getNation());
					personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
					personnel.setEducation(ybssPersonnel.getEducation());
					personnel.setHouseplace(ybssPersonnel.getHouseplace());
					personnel.setHomeplace(ybssPersonnel.getHomeplace());
					personnel.setHomex(ybssPersonnel.getHomex());
					personnel.setHomey(ybssPersonnel.getHomey());
					personnel.setWorkplace(ybssPersonnel.getWorkplace());
					personnel.setAddtime(addtime);
					personnel.setAddoperator(userSession.getLoginUserName());
					personnel.setAddoperatorid(userSession.getLoginUserID());
					personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
					personnel.setPphone1(jurisdictpolice1.getContactnumber());
					personnel.setValidflag(1);
					int id = personnelDao.add(personnel);
					/*****新增扩展表*****/
					ZaExtend zaExtend = new ZaExtend();
					zaExtend.setPersonnelid(id);
					zaExtendDao.add(zaExtend);
					if(ybssPersonnel.getTelnumber()!=null&&!"".equals(ybssPersonnel.getTelnumber())){
						String[] telnumbers=ybssPersonnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(id);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
				}else{
					personnel.setAddtime(addtime);
					personnel.setAddoperator(userSession.getLoginUserName());
					personnel.setAddoperatorid(userSession.getLoginUserID());
					personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
					personnel.setPphone1(jurisdictpolice1.getContactnumber());
					personnel.setValidflag(1);
					int id = personnelDao.add(personnel);
					/*****新增扩展表*****/
					ZaExtend zaExtend = new ZaExtend();
					zaExtend.setPersonnelid(id);
					zaExtendDao.add(zaExtend);
				}
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("治安人员新增");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
			message= new Message("true","治安风险人员添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加治安风险人员", userSession.getLoginUserName(), addtime, "添加成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","治安风险人员添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "治安风险人员添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("治安人员新增");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getZaPersonById.do")
    public String getZaPersonById(
            // 不要直接让 Spring 绑定 Personnel，或者手动处理 ID
            HttpServletRequest request,
            @RequestParam("menuid") String menuidStr,
            String buttons, ModelMap model,
            @ModelAttribute("userSession") UserSession userSession) throws Exception {

        // 1. 手动获取 ID 并处理重复（类似你处理 menuid 的逻辑）
        String idStr = request.getParameter("id");
        if (idStr == null) {
            // 处理错误情况
            return "error";
        }
        // 如果有多个 id，取第一个
        int id = Integer.parseInt(idStr.split(",")[0]);

        // 2. 手动查询 Personnel 对象
        Personnel personnel = personnelDao.getById(id);

        // 3. 处理 menuid
        int menuid = Integer.parseInt(menuidStr.split(",")[0]);

		model.addAttribute("personnel", personnel);
		model.addAttribute("menuid", menuid);
		model.addAttribute("buttons", buttons);
		int age=CardnumberInfo.getAge(personnel.getCardnumber());
		model.addAttribute("age",age);

		// ========== 涉赌/涉娼前科可编辑性判断 ==========
		// 判断是否存在涉赌记录
		boolean hasDuRecord = zaExtendDao.existsDuByPersonnelId(personnel.getId());
		// 如果存在涉赌记录，则不可编辑，值强制为1（有涉赌前科）
		model.addAttribute("duEditable", !hasDuRecord);
		if (hasDuRecord) {
			personnel.setHasSheduRecord(1);
		}

		// 判断是否存在涉娼记录
		boolean hasChangRecord = zaExtendDao.existsChangByPersonnelId(personnel.getId());
		// 如果存在涉娼记录，则不可编辑，值强制为1（有涉娼前科）
		model.addAttribute("changEditable", !hasChangRecord);
		if (hasChangRecord) {
			personnel.setHasSechangRecord(1);
		}

		// ========== 是否未成年动态计算（不落库） ==========
		// 根据身份证号动态计算年龄判断是否未成年
		int isMinorValue = (age < 18) ? 1 : 0;
		model.addAttribute("isMinorCalculated", isMinorValue);

		List<BasicMsg> marrystatus=basicMsgDao.getByType(16);//通用-婚姻状况
		model.addAttribute("marrystatus",marrystatus);
		
		List<BasicMsg> nation=basicMsgDao.getByType(15);//通用-民族
		model.addAttribute("nation",nation);
		
		List<BasicMsg> soldierstatus=basicMsgDao.getByType(21);//通用-兵役状况
		model.addAttribute("soldierstatus",soldierstatus);
		
		List<BasicMsg> heathstatus=basicMsgDao.getByType(54);//通用-健康状态
		model.addAttribute("heathstatus",heathstatus);
		
		List<BasicMsg> politicalposition=basicMsgDao.getByType(17);//通用-政治面貌
		model.addAttribute("politicalposition",politicalposition);
		
		List<BasicMsg> faith=basicMsgDao.getByType(18);//通用-宗教信仰
		model.addAttribute("faith",faith);
		
		List<BasicMsg> education=basicMsgDao.getByType(19);//通用-文化程度
		model.addAttribute("education",education);
		
		List<BasicMsg> persontype=basicMsgDao.getByType(20);//通用-人员类别
		model.addAttribute("persontype",persontype);

		//社会关系
		Relation relation=relationDao.searchrelation(personnel.getId());
		model.addAttribute("relation",relation);
		//派出所
		Department policeDepartment=new Department();
		policeDepartment.setDeparttype(String.valueOf(4));
		List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
		model.addAttribute("policeList",policeList);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID获取治安人员");
		String operate_Condition = "";
		operate_Condition += "人员ID = '" + personnel.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		//CreateLogXML.UserActionLog(log);
		return "/jsp/personel/za/update";
	}
	
	@RequestMapping("/updateZaPerson.do")
	public @ResponseBody String updateZaPerson(Personnel personnel, int menuid,
			@RequestParam(value="homePoliceStationId", required=false) Integer homePoliceStationId,
			@RequestParam(value="housePoliceStationId", required=false) Integer housePoliceStationId,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			// 调试日志：输出接收到的关键字段
			System.out.println("========== updateZaPerson 调试信息 ==========");
			System.out.println("人员ID: " + personnel.getId());
			System.out.println("姓名: " + personnel.getPersonname());
			System.out.println("户籍省: " + personnel.getHouseProvince());
			System.out.println("户籍市: " + personnel.getHouseCity());
			System.out.println("户籍县: " + personnel.getHouseCounty());
			System.out.println("户籍镇: " + personnel.getHouseTown());
			System.out.println("户籍派出所: " + personnel.getHousepolice());
			System.out.println("户籍派出所ID: " + housePoliceStationId);
			System.out.println("现住省: " + personnel.getHomeProvince());
			System.out.println("现住市: " + personnel.getHomeCity());
			System.out.println("现住县: " + personnel.getHomeCounty());
			System.out.println("现住镇: " + personnel.getHomeTown());
			System.out.println("现住派出所: " + personnel.getHomepolice());
			System.out.println("现住派出所ID: " + homePoliceStationId);
			System.out.println("打处单位: " + personnel.getHandleUnit());
			System.out.println("涉赌前科: " + personnel.getHasSheduRecord());
			System.out.println("涉娼前科: " + personnel.getHasSechangRecord());
			System.out.println("是否未成年: " + personnel.getIsMinor());
			System.out.println("==============================================");

			// 设置现住地派出所ID和户籍派出所ID
			personnel.setHomePoliceStationId(homePoliceStationId);
			personnel.setHousePoliceStationId(housePoliceStationId);

			// 检查现住地是否有修改，如有修改则保存历史记录
			Personnel oldPersonnel = personnelDao.getById(personnel.getId());
			if(oldPersonnel != null && isHomeAddressChanged(oldPersonnel, personnel)){
				// 保存旧地址到历史记录
				if(oldPersonnel.getHomeplace() != null && !"".equals(oldPersonnel.getHomeplace().trim())){
					HomeplaceHistory history = new HomeplaceHistory();
					history.setPersonnelid(personnel.getId());
					history.setProvince(oldPersonnel.getHomeProvince());
					history.setCity(oldPersonnel.getHomeCity());
					history.setCounty(oldPersonnel.getHomeCounty());
					history.setTown(oldPersonnel.getHomeTown());
					history.setPoliceStationId(oldPersonnel.getHomePoliceStationId());
					history.setDetailAddress(oldPersonnel.getHomeplace());
					history.setLongitude(oldPersonnel.getHomex());
					history.setLatitude(oldPersonnel.getHomey());
					history.setEndDate(addtime.substring(0,10));
					history.setAddoperator(userSession.getLoginUserName());
					history.setAddtime(addtime);
					history.setValidflag(1);
					zaExtendDao.addHomeplaceHistory(history);
					System.out.println("已保存现住地历史记录");
				}
			}

			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			int updateCount = personnelDao.updateSK(personnel);
			System.out.println("数据库更新影响行数: " + updateCount);

			message = new Message("true","治安人员修改成功！");
			message.setFlag(1);
			message.setFlag(1);
			logDao.recordLog(menuid, "治安人员修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("治安人员修改");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "治安人员修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("治安人员修改");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelZaPerson.do")
	public @ResponseBody String cancelZaPerson(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		int personlabelid=personnel.getPersonnelid();
		try {
			Personnel person=personnelDao.getById(personnel.getId());
			person.setUpdateoperator(userSession.getLoginUserName());
			person.setUpdatetime(addtime);
			String personlabel=person.getZslabel1();
			//String personlabel=person.getPersonlabel();
			String[] labelstr=personlabel.split(",");
			int[] labelint=new int[labelstr.length];
			for (int i = 0; i < labelstr.length; i++) {
				labelint[i]=Integer.parseInt(!"".equals(labelstr[i])?labelstr[i]:"0");
			}
			Arrays.sort(labelint);//数组排序
			int labelindex=Arrays.binarySearch(labelint,personlabelid);
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex&&labelint[i]!=0){
					if(newlabel!="")newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			person.setZslabel1(newlabel);
			
			String personlabel2=person.getZslabel2();
			if(personlabel2!=null&&!"".equals(personlabel2)){
				String[] labelstr2=personlabel2.split(",");
				int[] labelint2=new int[labelstr2.length];
				for (int i = 0; i < labelstr2.length; i++) {
					labelint2[i]=Integer.parseInt(!"".equals(labelstr2[i])?labelstr2[i]:"0");
				}
				Arrays.sort(labelint2);//数组排序
				String newlabel2="";
				List<AttributeLabel> aList=personnelDao.getAttributeLabelbyRootid(personlabelid);
				if(aList!=null){
					for (int j = 0; j < aList.size(); j++) {
						if(j>0){
							if(newlabel2!=""){
								labelstr2=newlabel2.split(",");
								labelint2=new int[labelstr2.length];
								for (int i = 0; i < labelstr2.length; i++) {
									labelint2[i]=Integer.parseInt(!"".equals(labelstr2[i])?labelstr2[i]:"0");
								}
								Arrays.sort(labelint2);//数组排序
								newlabel2="";
							}else{
								break;
							}
						}
						int labelindex2=Arrays.binarySearch(labelint2,aList.get(j).getId());
						for (int i = 0; i < labelint2.length; i++) {
							if(i!=labelindex2&&labelint2[i]!=0){
								if(newlabel2!="")newlabel2+=",";
								newlabel2+=String.valueOf(labelint2[i]);
							}
						}
					}
				}
				person.setZslabel2(newlabel2);
			}
			
			personnelDao.updateCheckedPersonLabel(person);
			System.out.println("治安删除风险人员标签!!!!");
			message = new Message("true","治安人员删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "治安人员删除删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("治安人员删除");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "治安人员删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("治安人员删除");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getCyPersonelInfo.do")
	public String getCyPersonelInfo(Personnel personnel,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		try {
		    //获取基本信息
			int id=personnel.getPersonnelid();
		    personnel=personnelDao.getById(id);
			model.addAttribute("personnel",personnel);
			int age=CardnumberInfo.getAge(personnel.getCardnumber());
			model.addAttribute("age",age);
			ZaExtend zaExtend = zaExtendDao.getById(id);
			model.addAttribute("zaExtend",zaExtend);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询从业人员");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询从业人员");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return "/jsp/personel/cy/showinfo";
	}
	
	@RequestMapping("/getZaPersonelInfo.do")
	public String getZaPersonelInfo(Personnel personnel,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		try {
		    //获取基本信息
			int id=personnel.getPersonnelid();
		    personnel=personnelDao.getById(id);
			model.addAttribute("personnel",personnel);
			int age=CardnumberInfo.getAge(personnel.getCardnumber());
			model.addAttribute("age",age);
			ZaExtend zaExtend = zaExtendDao.getById(id);
			model.addAttribute("zaExtend",zaExtend);
			//社会关系
			Relation relation=relationDao.searchrelation(personnel.getId());
			model.addAttribute("relation",relation);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询治安人员");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询治安人员");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return "/jsp/personel/za/showinfo";
	}
	
	@RequestMapping("/getZaDuByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getZaDuByPersonnelid(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			ZaDu zaDu=zaExtendDao.getZaDuByPersonnelid(personnelid);
			if(zaDu==null)result.put("firstDu",0);
			else result.put("firstDu",1);
			
			result.put("zaDu",zaDu);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询涉赌背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询涉赌背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	@RequestMapping("/getZaChangByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getZaChangByPersonnelid(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			ZaChang zaChang=zaExtendDao.getZaChangByPersonnelid(personnelid);
			if(zaChang==null)result.put("firstChang",0);
			else result.put("firstChang",1);
			
			result.put("zaChang",zaChang);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询涉娼背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询涉娼背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/searchZaDu.do")
	@ResponseBody
	public Map<String,Object> searchZaDu(ZaDu zaDu,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=zaExtendDao.searchZaDu(zaDu, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉赌背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaDu.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询涉赌背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaDu.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	@RequestMapping("/searchZaChang.do")
	@ResponseBody
	public Map<String,Object> searchZaChang(ZaChang zaChang,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=zaExtendDao.searchZaChang(zaChang, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉娼背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaChang.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询涉娼背景");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaChang.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/addZaDu.do")
	@ResponseBody
	public String addZaDu(ZaDu zaDu,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zaDu.setValidflag(2);
			zaDu.setAddoperator(userSession.getLoginUserName());
			zaDu.setAddtime(addtime);
			zaExtendDao.addZaDu(zaDu);

			// 同步更新人员表现住地址和手机号
			syncPersonnelAddressAndPhone(zaDu.getPersonnelid(), zaDu.getHomeProvince(), zaDu.getHomeCity(),
				zaDu.getHomeCounty(), zaDu.getHomeTown(), zaDu.getHomePoliceStationId(), zaDu.getHomeDetail(),
				zaDu.getHomePoliceStationName(), zaDu.getHomeLng(), zaDu.getHomeLat(), addtime, userSession.getLoginUserName());

			// 自动标记涉赌前科
			Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
			if(personnel != null && personnel.getHasSheduRecord() == 0){
				personnel.setHasSheduRecord(1);
				personnelDao.updateHasSheduRecord(personnel);
			}

			message= new Message("true","治安人员-涉赌背景添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加涉赌背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-涉赌背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉赌背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/addZaChang.do")
	@ResponseBody
	public String addZaChang(ZaChang zaChang,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zaChang.setValidflag(2);
			zaChang.setAddoperator(userSession.getLoginUserName());
			zaChang.setAddtime(addtime);

			// 计算是否未成年案件
			if(zaChang.getChang_chsj() != null && !"".equals(zaChang.getChang_chsj())){
				Personnel person = personnelDao.getById(zaChang.getPersonnelid());
				if(person != null && person.getCardnumber() != null && person.getCardnumber().length() >= 14){
					String birthDate = CardnumberInfo.getBirthDay(person.getCardnumber());
					int age = CardnumberInfo.getAgeByDate(birthDate, zaChang.getChang_chsj());
					if(age < 18){
						zaChang.setIsMinorCase(1);
					}
				}
			}

			zaExtendDao.addZaChang(zaChang);

			// 同步更新人员表现住地址和手机号
			syncPersonnelAddressAndPhone(zaChang.getPersonnelid(), zaChang.getHomeProvince(), zaChang.getHomeCity(),
				zaChang.getHomeCounty(), zaChang.getHomeTown(), zaChang.getHomePoliceStationId(), zaChang.getHomeDetail(),
				zaChang.getHomePoliceStationName(), zaChang.getHomeLng(), zaChang.getHomeLat(), addtime, userSession.getLoginUserName());

			// 自动标记涉黄前科
			Personnel personnel = personnelDao.getById(zaChang.getPersonnelid());
			if(personnel != null && personnel.getHasSechangRecord() == 0){
				personnel.setHasSechangRecord(1);
				personnelDao.updateHasSechangRecord(personnel);
			}

			message= new Message("true","治安人员-涉娼背景添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加涉娼背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-涉娼背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉娼背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateZaDu.do")
	public @ResponseBody String updateZaDu(ZaDu zaDu, int menuid,
			@RequestParam(value="homeProvince", required=false) String homeProvince,
			@RequestParam(value="homeCity", required=false) String homeCity,
			@RequestParam(value="homeCounty", required=false) String homeCounty,
			@RequestParam(value="homeTown", required=false) String homeTown,
			@RequestParam(value="homeplace", required=false) String homeplace,
			@RequestParam(value="homepolice", required=false) String homepolice,
			@RequestParam(value="homex", required=false) String homex,
			@RequestParam(value="homey", required=false) String homey,
			@RequestParam(value="homePoliceStationId", required=false) Integer homePoliceStationId,
			@RequestParam(value="phone", required=false) String phone,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateZaDu.do.......................");
		System.out.println("========== updateZaDu 参数调试 ==========");
		System.out.println("personnelid: " + zaDu.getPersonnelid());
		System.out.println("homeProvince: " + homeProvince);
		System.out.println("homeCity: " + homeCity);
		System.out.println("homeCounty: " + homeCounty);
		System.out.println("homeTown: " + homeTown);
		System.out.println("homeplace(详址): " + homeplace);
		System.out.println("homepolice(派出所): " + homepolice);
		System.out.println("homex(经度): " + homex);
		System.out.println("homey(纬度): " + homey);
		System.out.println("homePoliceStationId: " + homePoliceStationId);
		System.out.println("phone(表单): " + zaDu.getPhone());
		System.out.println("phone(@RequestParam): " + phone);
		System.out.println("==========================================");
		try {
			// 涉案地址二次校验
			if (zaDu.getCaseAddressList() != null && !zaDu.getCaseAddressList().trim().isEmpty()) {
				String[] addressArray = zaDu.getCaseAddressList().split("，");
				if (addressArray.length > 5) {
					message = new Message("false","涉案地址最多只能填写 5 个！");
					message.setFlag(-1);
					return JSONObject.fromObject(message).toString();
				}
			}

			if (zaDu.getId()>0) {
				zaDu.setUpdateoperator(userSession.getLoginUserName());
				zaDu.setUpdatetime(addtime);
				zaDu.setValidflag(1);//历史
				zaExtendDao.updateZaDu(zaDu);
			}

			// 将前端传来的现住地址字段设置到ZaDu对象中
			zaDu.setHomeProvince(homeProvince);
			zaDu.setHomeCity(homeCity);
			zaDu.setHomeCounty(homeCounty);
			zaDu.setHomeTown(homeTown);
			zaDu.setHomePoliceStationId(homePoliceStationId);
			zaDu.setHomeDetail(homeplace);
			zaDu.setHomeLng(homex);
			zaDu.setHomeLat(homey);

			zaDu.setAddoperator(userSession.getLoginUserName());
			zaDu.setAddtime(addtime);
			zaDu.setValidflag(2);//当前
			zaExtendDao.addZaDu(zaDu);



				syncPersonnelAddressAndPhone(zaDu.getPersonnelid(), homeProvince, homeCity,
					homeCounty, homeTown, homePoliceStationId, homeplace, homepolice,
					homex, homey, addtime, userSession.getLoginUserName());


			// 同步手机号码到关联信息表(p_relation_telnumber_t)
			if(phone != null && !"".equals(phone.trim())){
				syncPhoneToRelationTelnumber(zaDu.getPersonnelid(), phone, addtime, userSession.getLoginUserName());
			}

			message = new Message("true","治安人员-涉赌背景修改成功！");
			message.setFlag(zaDu.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateZaDu.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改涉赌背景");
			String operate_Condition = "";
			operate_Condition += "涉赌背景id = '" + zaDu.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-涉赌背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("updateZaDu.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改涉赌背景");
			String operate_Condition = "";
			operate_Condition += "涉赌背景id = '" + zaDu.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateZaChang.do")
	public @ResponseBody String updateZaChang(ZaChang zaChang, int menuid,
			@RequestParam(value="homeProvince", required=false) String homeProvince,
			@RequestParam(value="homeCity", required=false) String homeCity,
			@RequestParam(value="homeCounty", required=false) String homeCounty,
			@RequestParam(value="homeTown", required=false) String homeTown,
			@RequestParam(value="homeplace", required=false) String homeplace,
			@RequestParam(value="homepolice", required=false) String homepolice,
			@RequestParam(value="homex", required=false) String homex,
			@RequestParam(value="homey", required=false) String homey,
			@RequestParam(value="homePoliceStationId", required=false) Integer homePoliceStationId,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateZaChang.do.......................");
		System.out.println("========== updateZaChang 参数调试 ==========");
		System.out.println("personnelid: " + zaChang.getPersonnelid());
		System.out.println("homeProvince: " + homeProvince);
		System.out.println("homeCity: " + homeCity);
		System.out.println("homeCounty: " + homeCounty);
		System.out.println("homeTown: " + homeTown);
		System.out.println("homeplace(详址): " + homeplace);
		System.out.println("homepolice(派出所): " + homepolice);
		System.out.println("homex(经度): " + homex);
		System.out.println("homey(纬度): " + homey);
		System.out.println("homePoliceStationId: " + homePoliceStationId);
		System.out.println("==========================================");
		try {
			// 涉案地址二次校验
			if (zaChang.getCaseAddressList() != null && !zaChang.getCaseAddressList().trim().isEmpty()) {
				String[] addressArray = zaChang.getCaseAddressList().split("，");
				if (addressArray.length > 5) {
					message = new Message("false","涉案地址最多只能填写 5 个！");
					message.setFlag(-1);
					return JSONObject.fromObject(message).toString();
				}
			}

			if (zaChang.getId()>0) {
				zaChang.setUpdateoperator(userSession.getLoginUserName());
				zaChang.setUpdatetime(addtime);
				zaChang.setValidflag(1);//历史
				zaExtendDao.updateZaChang(zaChang);
			}

			// 将前端传来的现住地址字段设置到ZaChang对象中（保存到p_zaperson_chang_t）
			zaChang.setHomeProvince(homeProvince);
			zaChang.setHomeCity(homeCity);
			zaChang.setHomeCounty(homeCounty);
			zaChang.setHomeTown(homeTown);
			zaChang.setHomePoliceStationId(homePoliceStationId);
			zaChang.setHomeDetail(homeplace);
			zaChang.setHomeLng(homex);
			zaChang.setHomeLat(homey);

			zaChang.setAddoperator(userSession.getLoginUserName());
			zaChang.setAddtime(addtime);
			zaChang.setValidflag(2);//当前
			zaExtendDao.addZaChang(zaChang);

			// 同步更新p_personnel_t表现住地址（保存历史并更新）

				syncPersonnelAddressAndPhone(zaChang.getPersonnelid(), homeProvince, homeCity,
					homeCounty, homeTown, homePoliceStationId, homeplace, homepolice,
					homex, homey, addtime, userSession.getLoginUserName());


			message = new Message("true","治安人员-涉娼背景修改成功！");
			message.setFlag(zaChang.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateZaChang.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改涉娼背景");
			String operate_Condition = "";
			operate_Condition += "涉娼背景id = '" + zaChang.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-涉娼背景修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateZaChang.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改涉娼背景");
			String operate_Condition = "";
			operate_Condition += "涉娼背景id = '" + zaChang.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}

	// ========== 陪侍人员相关方法 ==========
	@RequestMapping("/addZaPei.do")
	@ResponseBody
	public String addZaPei(ZaPei zaPei,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			zaPei.setValidflag(2);
			zaPei.setAddoperator(userSession.getLoginUserName());
			zaPei.setAddtime(addtime);
			zaExtendDao.addZaPei(zaPei);

			// 同步更新人员表现住地址
			syncPersonnelAddressAndPhone(zaPei.getPersonnelid(), zaPei.getHomeProvince(), zaPei.getHomeCity(),
				zaPei.getHomeCounty(), zaPei.getHomeTown(), zaPei.getHomePoliceStationId(), zaPei.getHomeDetail(),
				zaPei.getHomePoliceStationName(), zaPei.getHomeLng(), zaPei.getHomeLat(), addtime, userSession.getLoginUserName());

			// 标记为陪侍人员
			Personnel personnel = personnelDao.getById(zaPei.getPersonnelid());
			if(personnel != null){
				// 这里可以添加人员表的陪侍标记字段更新逻辑
			}

			message= new Message("true","治安人员-陪侍背景添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加陪侍背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-陪侍背景添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加陪侍背景");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}

	@RequestMapping("/updateZaPei.do")
	public @ResponseBody String updateZaPei(ZaPei zaPei,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			if (zaPei.getId()>0) {
				zaPei.setUpdateoperator(userSession.getLoginUserName());
				zaPei.setUpdatetime(addtime);
				zaPei.setValidflag(1);//历史
				zaExtendDao.updateZaPei(zaPei);
			}
			zaPei.setAddoperator(userSession.getLoginUserName());
			zaPei.setAddtime(addtime);
			zaPei.setValidflag(2);//当前
			zaExtendDao.addZaPei(zaPei);

			message = new Message("true","治安人员-陪侍背景修改成功！");
			message.setFlag(zaPei.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改陪侍背景");
			String operate_Condition = "";
			operate_Condition += "陪侍背景id = '" + zaPei.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","治安人员-陪侍背景修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改陪侍背景");
		 String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}

	@RequestMapping("/getZaPeiByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getZaPeiByPersonnelid(int personnelid,ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		try {
			ZaPei zaPei = zaExtendDao.getZaPeiByPersonnelid(personnelid);
			if(zaPei!=null){
				result.put("zaPei", zaPei);
				result.put("firstPei", 1);
			}else{
				result.put("firstPei", 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("firstPei", 0);
		}
		return result;
	}

	/**
	 * 查询历史住址
	 */
	@RequestMapping("/getHomeplaceHistory.do")
	@ResponseBody
	public Map<String,Object> getHomeplaceHistory(int personnelid, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			List<HomeplaceHistory> list = zaExtendDao.getHomeplaceHistoryByPersonnelid(personnelid);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}


	/**
	 * 查询涉案地址
	 */
	@RequestMapping("/getCaseAddress.do")
	@ResponseBody
	public Map<String,Object> getCaseAddress(int recordId, int recordType, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			List<ZaCaseAddress> list = zaExtendDao.getCaseAddressByRecordId(recordId, recordType);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 保存涉案地址(批量)
	 */
	@RequestMapping("/saveCaseAddresses.do")
	@ResponseBody
	public String saveCaseAddresses(int recordId, int recordType, String addressesJson, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			// 先删除原有地址
			zaExtendDao.deleteCaseAddressByRecordId(recordId, recordType);
			// 解析并保存新地址
			if (addressesJson != null && !"".equals(addressesJson) && !"[]".equals(addressesJson)) {
				net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(addressesJson);
				for (int i = 0; i < jsonArray.size(); i++) {
					net.sf.json.JSONObject jsonObj = jsonArray.getJSONObject(i);
					ZaCaseAddress address = new ZaCaseAddress();
					address.setRecordId(recordId);
					address.setRecordType(recordType);
					address.setProvince(jsonObj.optString("province", ""));
					address.setCity(jsonObj.optString("city", ""));
					address.setCounty(jsonObj.optString("county", ""));
					address.setTown(jsonObj.optString("town", ""));
					address.setDetailAddress(jsonObj.optString("detailAddress", ""));
					address.setLongitude(jsonObj.optString("longitude", ""));
					address.setLatitude(jsonObj.optString("latitude", ""));
					address.setAddtime(addtime);
					zaExtendDao.addCaseAddress(address);
				}
			}
			message = new Message("true", "涉案地址保存成功！");
			message.setFlag(1);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false", "涉案地址保存失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}

	/**
	 * 添加历史住址记录
	 */
	@RequestMapping("/addHomeplaceHistory.do")
	@ResponseBody
	public String addHomeplaceHistory(HomeplaceHistory history, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			history.setAddoperator(userSession.getLoginUserName());
			history.setAddtime(addtime);
			history.setValidflag(1);
			zaExtendDao.addHomeplaceHistory(history);
			message = new Message("true", "历史住址添加成功！");
			message.setFlag(1);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false", "历史住址添加失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}


	/**
	 * 同步更新人员表地址，并保存历史记录
	 * @param personnelid 人员ID
	 * @param homeProvince 省
	 * @param homeCity 市
	 * @param homeCounty 县/区
	 * @param homeTown 镇/街道
	 * @param homePoliceStationId 派出所ID
	 * @param homeDetail 详细地址
	 * @param homepolice 派出所名称(可选，如果为空会通过ID查找)
	 * @param homeLng 经度
	 * @param homeLat 纬度
	 * @param addtime 添加时间
	 * @param operator 操作人
	 */
	private void syncPersonnelAddressAndPhone(int personnelid, String homeProvince, String homeCity,
			String homeCounty, String homeTown, Integer homePoliceStationId, String homeDetail,
			String homepolice, String homeLng, String homeLat, String addtime, String operator){
		try {
			Personnel personnel = personnelDao.getById(personnelid);
			if(personnel == null) return;

            // --- 关键修改：判断逻辑从“地址不为空”改为“数据是否有变化” ---

            // 1. 判断派出所 ID 是否改变
            boolean stationChanged = false;
            Integer oldStationId = personnel.getHomePoliceStationId();
            if (homePoliceStationId == null) {
                stationChanged = (oldStationId != null);
            } else {
                stationChanged = !homePoliceStationId.equals(oldStationId);
            }

            // 2. 判断详址是否改变
            String oldDetail = personnel.getHomeplace() == null ? "" : personnel.getHomeplace().trim();
            String newDetail = homeDetail == null ? "" : homeDetail.trim();
            boolean detailChanged = !newDetail.equals(oldDetail);

            // 3. 只要派出所变了，或者详址变了，就进入同步逻辑
            if(stationChanged || detailChanged){
				// 先保存旧地址到历史

					HomeplaceHistory history = new HomeplaceHistory();
					history.setPersonnelid(personnelid);
					history.setProvince(personnel.getHomeProvince());
					history.setCity(personnel.getHomeCity());
					history.setCounty(personnel.getHomeCounty());
					history.setTown(personnel.getHomeTown());
					history.setPoliceStationId(personnel.getHomePoliceStationId());
					history.setDetailAddress(personnel.getHomeplace());
					history.setLongitude(personnel.getHomex());
					history.setLatitude(personnel.getHomey());
					history.setEndDate(addtime.substring(0,10));
					history.setAddoperator(operator);
					history.setAddtime(addtime);
					history.setValidflag(1);
					zaExtendDao.addHomeplaceHistory(history);
					System.out.println("save success p_homeplace_history_t");


				// 如果派出所名称为空但有派出所ID，则通过ID查找派出所名称
				String policeStationName = homepolice;
				if((policeStationName == null || "".equals(policeStationName.trim())) && homePoliceStationId != null){
					try {
						Department dept = departmentDao.getById(homePoliceStationId);
						if(dept != null){
							policeStationName = dept.getDepartname();
							System.out.println("通过派出所ID(" + homePoliceStationId + ")查到派出所名称: " + policeStationName);
						}
					} catch (Exception e) {
						System.out.println("通过派出所ID查询名称失败: " + e.getMessage());
					}
				}

				// 更新人员表地址
				personnel.setHomeProvince(homeProvince);
				personnel.setHomeCity(homeCity);
				personnel.setHomeCounty(homeCounty);
				personnel.setHomeTown(homeTown);
				personnel.setHomePoliceStationId(homePoliceStationId);
				personnel.setHomeplace(homeDetail);
				personnel.setHomepolice(policeStationName);
				personnel.setHomex(homeLng);
				personnel.setHomey(homeLat);
				personnelDao.updateHomeAddress(personnel);
				System.out.println("已将新现住地址覆盖到 p_personnel_t 表");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 同步手机号码到关联信息表(p_relation_telnumber_t)
	 * 如果手机号已存在则不重复添加
	 * @param personnelid 人员ID
	 * @param phone 手机号码
	 * @param addtime 添加时间
	 * @param operator 操作人
	 */
	private void syncPhoneToRelationTelnumber(int personnelid, String phone, String addtime, String operator){
		try {
			if(phone == null || "".equals(phone.trim())){
				return;
			}
			// 检查手机号是否已存在
			boolean exists = relationDao.checkTelnumberExists(personnelid, phone.trim());
			if(!exists){
				// 不存在则添加新记录
				RelationTelnumber relationTelnumber = new RelationTelnumber();
				relationTelnumber.setPersonnelid(personnelid);
				relationTelnumber.setTelnumber(phone.trim());
				relationTelnumber.setGainorigin("涉赌背景采集");
				relationTelnumber.setValidflag(1);
				relationTelnumber.setAddoperator(operator);
				relationTelnumber.setAddtime(addtime);
				relationDao.addrelationtelnumber(relationTelnumber);
				System.out.println("已同步手机号码到关联信息表: " + phone);
			} else {
				System.out.println("手机号码已存在，跳过添加: " + phone);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("同步手机号码失败: " + e.getMessage());
		}
	}

	// ========== 涉赌-案件关联管理 ==========

	/**
	 * 根据涉赌记录ID查询关联的案件列表
	 */
	@RequestMapping("/getAjByDuId.do")
	@ResponseBody
	public Map<String,Object> getAjByDuId(int duId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getAjListByDuId(duId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据案件ID查询关联的涉赌记录列表
	 */
	@RequestMapping("/getDuByAjId.do")
	@ResponseBody
	public Map<String,Object> getDuByAjId(int ajId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaDu> list = zaRelationService.getDuListByAjId(ajId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	// ========== 涉赌-警情关联管理 ==========

	/**
	 * 根据涉赌记录ID查询关联的警情列表
	 */
	@RequestMapping("/getJqByDuId.do")
	@ResponseBody
	public Map<String,Object> getJqByDuId(int duId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getJqListByDuId(duId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据警情ID查询关联的涉赌记录列表
	 */
	@RequestMapping("/getDuByJqId.do")
	@ResponseBody
	public Map<String,Object> getDuByJqId(int jqId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaDu> list = zaRelationService.getDuListByJqId(jqId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据人员ID查询涉赌关联的案件列表
	 */
	@RequestMapping("/getDuAjByPersonnelId.do")
	@ResponseBody
	public Map<String,Object> getDuAjByPersonnelId(int personnelId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getAjListByPersonnelId(personnelId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据人员ID查询涉赌关联的警情列表
	 */
	@RequestMapping("/getDuJqByPersonnelId.do")
	@ResponseBody
	public Map<String,Object> getDuJqByPersonnelId(int personnelId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getJqListByPersonnelId(personnelId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	// ========== 涉娼-案件关联管理 ==========

	/**
	 * 根据涉娼记录ID查询关联的案件列表
	 */
	@RequestMapping("/getAjByChangId.do")
	@ResponseBody
	public Map<String,Object> getAjByChangId(int changId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getAjListByChangId(changId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据案件ID查询关联的涉娼记录列表
	 */
	@RequestMapping("/getChangByAjId.do")
	@ResponseBody
	public Map<String,Object> getChangByAjId(int ajId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaChang> list = zaRelationService.getChangListByAjId(ajId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	// ========== 涉娼-警情关联管理 ==========

	/**
	 * ��据涉娼记录ID查询关联的警情列表
	 */
	@RequestMapping("/getJqByChangId.do")
	@ResponseBody
	public Map<String,Object> getJqByChangId(int changId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getJqListByChangId(changId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据警情ID查询关联的涉娼记录列表
	 */
	@RequestMapping("/getChangByJqId.do")
	@ResponseBody
	public Map<String,Object> getChangByJqId(int jqId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaChang> list = zaRelationService.getChangListByJqId(jqId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	// ========== 陪侍-案件关联管理 ==========

	/**
	 * 根据陪侍记录ID查询关联的案件列表
	 */
	@RequestMapping("/getAjByPeiId.do")
	@ResponseBody
	public Map<String,Object> getAjByPeiId(int peiId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getAjListByPeiId(peiId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据案件ID查询关联的陪侍记录列表
	 */
	@RequestMapping("/getPeiByAjId.do")
	@ResponseBody
	public Map<String,Object> getPeiByAjId(int ajId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaPei> list = zaRelationService.getPeiListByAjId(ajId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	// ========== 陪侍-警情关联管理 ==========

	/**
	 * 根据陪侍记录ID查询关联的警情列表
	 */
	@RequestMapping("/getJqByPeiId.do")
	@ResponseBody
	public Map<String,Object> getJqByPeiId(int peiId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<Object> list = zaRelationService.getJqListByPeiId(peiId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 根据警情ID查询关联的陪侍记录列表
	 */
	@RequestMapping("/getPeiByJqId.do")
	@ResponseBody
	public Map<String,Object> getPeiByJqId(int jqId, ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			List<ZaPei> list = zaRelationService.getPeiListByJqId(jqId);
			result.put("count", list.size());
			result.put("data", list.toArray());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 判断现住地址是否发生变化
	 * @param oldPersonnel 原人员信息
	 * @param newPersonnel 新人员信息
	 * @return true-有变化 false-无变化
	 */
	private boolean isHomeAddressChanged(Personnel oldPersonnel, Personnel newPersonnel){
		// 比较现住地详址
		String oldHomeplace = oldPersonnel.getHomeplace() != null ? oldPersonnel.getHomeplace().trim() : "";
		String newHomeplace = newPersonnel.getHomeplace() != null ? newPersonnel.getHomeplace().trim() : "";
		if(!oldHomeplace.equals(newHomeplace) && !"".equals(newHomeplace)){
			return true;
		}
		// 比较省
		String oldProvince = oldPersonnel.getHomeProvince() != null ? oldPersonnel.getHomeProvince().trim() : "";
		String newProvince = newPersonnel.getHomeProvince() != null ? newPersonnel.getHomeProvince().trim() : "";
		if(!oldProvince.equals(newProvince) && !"".equals(newProvince)){
			return true;
		}
		// 比较市
		String oldCity = oldPersonnel.getHomeCity() != null ? oldPersonnel.getHomeCity().trim() : "";
		String newCity = newPersonnel.getHomeCity() != null ? newPersonnel.getHomeCity().trim() : "";
		if(!oldCity.equals(newCity) && !"".equals(newCity)){
			return true;
		}
		// 比较县
		String oldCounty = oldPersonnel.getHomeCounty() != null ? oldPersonnel.getHomeCounty().trim() : "";
		String newCounty = newPersonnel.getHomeCounty() != null ? newPersonnel.getHomeCounty().trim() : "";
		if(!oldCounty.equals(newCounty) && !"".equals(newCounty)){
			return true;
		}
		// 比较镇
		String oldTown = oldPersonnel.getHomeTown() != null ? oldPersonnel.getHomeTown().trim() : "";
		String newTown = newPersonnel.getHomeTown() != null ? newPersonnel.getHomeTown().trim() : "";
		if(!oldTown.equals(newTown) && !"".equals(newTown)){
			return true;
		}
		return false;
	}
}

package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import com.szrj.business.util.ZaPersonnelPermissionUtil;
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
	@Autowired
	private PersonnelController personnelController;
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
		// 处理"治安大队或其他"搜索（哨兵值 NOT_PCT）：
		// 搜索 handle_unit_code 中包含至少一个不在 240-263 范围内的代码的记录
		// 判断逻辑：handle_unit_code 非空，且不完全由 240-263 的数字（逗号分隔）构成
		if ("NOT_PCT".equals(personnel.getHandleUnitCode())) {
			personnel.setHandleUnitCode(""); // 清除哨兵，避免走 FIND_IN_SET 子句
			// 使用 REGEXP 直接在外层 WHERE 中判断：
			// 若 handle_unit_code 全部由 240-263 的数字组成，则 REGEXP 匹配；取反即为含非派出所代码
			String notPctSql =
				"(p.handle_unit_code IS NOT NULL AND p.handle_unit_code != '' AND " +
				"NOT p.handle_unit_code REGEXP " +
				"'^(2[4-5][0-9]|26[0-3])(,(2[4-5][0-9]|26[0-3]))*$')";
			if (!"".equals(sqlall)) sqlall += " AND ";
			sqlall += notPctSql;
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
			// 新增：涉赌查询条件日志
			if(personnel.getDuPersonAttribute() != null && !"".equals(personnel.getDuPersonAttribute())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉赌人员属性 = '" + personnel.getDuPersonAttribute() + "'";
				}else{
					operate_Condition += " and 涉赌人员属性 = '" + personnel.getDuPersonAttribute() + "'";
				}
			}
			if(personnel.getDuMethod() != null && !"".equals(personnel.getDuMethod())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉赌方式 = '" + personnel.getDuMethod() + "'";
				}else{
					operate_Condition += " and 涉赌方式 = '" + personnel.getDuMethod() + "'";
				}
			}
			if(personnel.getDuPart() != null && !"".equals(personnel.getDuPart())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉赌部位 = '" + personnel.getDuPart() + "'";
				}else{
					operate_Condition += " and 涉赌部位 = '" + personnel.getDuPart() + "'";
				}
			}
			// 新增：涉娼查询条件日志
			if(personnel.getChangPersonAttribute() != null && !"".equals(personnel.getChangPersonAttribute())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉娼人员属性 = '" + personnel.getChangPersonAttribute() + "'";
				}else{
					operate_Condition += " and 涉娼人员属性 = '" + personnel.getChangPersonAttribute() + "'";
				}
			}
			if(personnel.getChangMethod() != null && !"".equals(personnel.getChangMethod())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉娼方式 = '" + personnel.getChangMethod() + "'";
				}else{
					operate_Condition += " and 涉娼方式 = '" + personnel.getChangMethod() + "'";
				}
			}
			if(personnel.getChangType() != null && !"".equals(personnel.getChangType())){
				if("".equals(operate_Condition)){
					operate_Condition += "涉娼类型 = '" + personnel.getChangType() + "'";
				}else{
					operate_Condition += " and 涉娼类型 = '" + personnel.getChangType() + "'";
				}
			}
			// 新增：处罚时间区间日志
			if(personnel.getPunishDateStart() != null && !"".equals(personnel.getPunishDateStart())){
				if("".equals(operate_Condition)){
					operate_Condition += "处罚日期起 >= '" + personnel.getPunishDateStart() + "'";
				}else{
					operate_Condition += " and 处罚日期起 >= '" + personnel.getPunishDateStart() + "'";
				}
			}
			if(personnel.getPunishDateEnd() != null && !"".equals(personnel.getPunishDateEnd())){
				if("".equals(operate_Condition)){
					operate_Condition += "处罚日期止 <= '" + personnel.getPunishDateEnd() + "'";
				}else{
					operate_Condition += " and 处罚日期止 <= '" + personnel.getPunishDateEnd() + "'";
				}
			}
			// 新增：未成年案件标识日志
			if(personnel.getIsMinorCase() != null && !"".equals(personnel.getIsMinorCase())){
				if("".equals(operate_Condition)){
					operate_Condition += "未成年案件 = '" + personnel.getIsMinorCase() + "'";
				}else{
					operate_Condition += " and 未成年案件 = '" + personnel.getIsMinorCase() + "'";
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
			boolean isExistPerson = (findid > 0); // 标记是否为已存在人员
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
				/*****风险人员主表标签修改（防止重复添加）*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1 == null) zslabel1 = "";
				if(!(","+zslabel1+",").contains(",2046,")){
					if(!zslabel1.isEmpty()) zslabel1 += ",";
					zslabel1 += "2046";
					person.setZslabel1(zslabel1);
				}

				// 如果是未成年人，添加未成年标签（zslabel2：5002）
				if(person.getCardnumber() != null && person.getCardnumber().length() >= 14){
					int age = CardnumberInfo.getAge(person.getCardnumber());
					if(age < 18){
						String zslabel2 = person.getZslabel2();
						if(zslabel2 == null || zslabel2.trim().isEmpty()){
							zslabel2 = "5002";
						}else if(!zslabel2.contains("5002")){
							zslabel2 += ",5002";
						}
						person.setZslabel2(zslabel2);
					}
				}

				person.setUpdatetime(addtime);
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setPphone1(jurisdictpolice1.getContactnumber());
				personnelDao.update(person);

				// ===== 追加打处单位到 handleUnitCode（去重） =====
				String newHandleUnitCode = personnel.getHandleUnitCode();
				if (newHandleUnitCode != null && !newHandleUnitCode.trim().isEmpty()) {
					String currentCode = person.getHandleUnitCode();
					java.util.LinkedHashSet<String> codeSet = new java.util.LinkedHashSet<String>();
					if (currentCode != null && !currentCode.trim().isEmpty()) {
						for (String c : currentCode.split(",")) {
							if (!c.trim().isEmpty()) codeSet.add(c.trim());
						}
					}
					for (String c : newHandleUnitCode.split(",")) {
						if (!c.trim().isEmpty()) codeSet.add(c.trim());
					}
					StringBuilder sb = new StringBuilder();
					for (String c : codeSet) {
						if (sb.length() > 0) sb.append(",");
						sb.append(c);
					}
					personnelDao.updateHandleUnitCode(findid, sb.toString());
				}
				// ===== 追加结束 =====

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

					// 确保handleUnitCode被正确保存
					// handleUnitCode已通过表单参数绑定到personnel对象

					// 如果是未成年人，添加未成年标签（zslabel2：5002）
					if(personnel.getCardnumber() != null && personnel.getCardnumber().length() >= 14){
						int age = CardnumberInfo.getAge(personnel.getCardnumber());
						if(age < 18){
							String zslabel2 = personnel.getZslabel2();
							if(zslabel2 == null || zslabel2.trim().isEmpty()){
								zslabel2 = "5002";
							}else if(!zslabel2.contains("5002")){
								zslabel2 += ",5002";
							}
							personnel.setZslabel2(zslabel2);
						}
					}

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

					// 如果是未成年人，添加未成年标签（zslabel2：5002）
					if(personnel.getCardnumber() != null && personnel.getCardnumber().length() >= 14){
						int age = CardnumberInfo.getAge(personnel.getCardnumber());
						if(age < 18){
							String zslabel2 = personnel.getZslabel2();
							if(zslabel2 == null || zslabel2.trim().isEmpty()){
								zslabel2 = "5002";
							}else if(!zslabel2.contains("5002")){
								zslabel2 += ",5002";
							}
							personnel.setZslabel2(zslabel2);
						}
					}

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
			if(isExistPerson){
				message= new Message("true","打处单位新增成功！");
			} else {
				message= new Message("true","治安风险人员添加成功！");
			}
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

		// ========== 涉赌/涉娼/陪侍前科可编辑性判断 ==========
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

		// 判断是否存在陪侍记录
		boolean hasPeiRecord = zaExtendDao.existsPeiByPersonnelId(personnel.getId());
		// 如果存在陪侍记录，则不可编辑，值强制为1（是陪侍人员）
		model.addAttribute("peiEditable", !hasPeiRecord);
		if (hasPeiRecord) {
			personnel.setIsPeishi(1);
		}

		// ========== 是否未成年动态计算（不落库） ==========
		// 根据身份证号动态计算年龄判断是否未成年
		int isMinorValue = (age < 18) ? 1 : 0;
		model.addAttribute("isMinorCalculated", isMinorValue);

		// ========== 查询时维护标签（特别是未成年人标签） ==========
		personnel.setIsMinor(isMinorValue);
		maintainPersonnelLabels(personnel);

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
			@RequestParam(value="dealUnitHandled", required=false) String dealUnitHandled,
			@RequestParam(value="removeDealUnit", required=false) String removeDealUnit,
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
			System.out.println("打处单位是否已处理: " + dealUnitHandled);
			System.out.println("是否移除打处单位: " + removeDealUnit);
			System.out.println("==============================================");

			// ========== 打处单位处理确认逻辑 ==========
			if ("1".equals(removeDealUnit) && "1".equals(dealUnitHandled)) {
				// 获取当前登录用户的单位编码
				String currentUserDepartCode = userSession.getLoginDepartcode();
				int currentUserDepartmentId = userSession.getLoginUserDepartmentid();

				System.out.println("当前用户单位编码: " + currentUserDepartCode);
				System.out.println("当前用户单位ID: " + currentUserDepartmentId);

				// 获取人员原有的打处单位编码列表
				String handleUnitCodeStr = personnel.getHandleUnitCode();
				if (handleUnitCodeStr != null && !handleUnitCodeStr.trim().isEmpty()) {
					String[] handleUnitCodes = handleUnitCodeStr.split(",");

					// 权限校验：确保当前单位确实在打处单位列表中
					boolean isInList = false;
					for (String code : handleUnitCodes) {
						if (code.trim().equals(currentUserDepartCode) ||
							code.trim().equals(String.valueOf(currentUserDepartmentId))) {
							isInList = true;
							break;
						}
					}

					if (!isInList) {
						System.out.println("权限校验失败：当前单位不在人员打处单位列表中");
						message = new Message("false","当前单位不在该人员的打处单位列表中，无权移除！");
						message.setFlag(-1);
						return JSONObject.fromObject(message).toString();
					}

					System.out.println("权限校验通过，执行打处单位移除操作");
					// 前端已经处理好了，这里的 handleUnit 和 handleUnitCode 已经是移除后的值
					// 直接使用 personnel 对象中的值即可
				}
			}

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

			// ========== 保护zslabel2不被updateSK覆盖 ==========
			// updateSK会将zslabel2原样写入数据库，而前端提交的personnel.zslabel2为null/空
			// 直接使用DB中已有的完整zslabel2，保留所有子标签（包括10、2178、2219等）
			// 5001/5002的增删由后续maintainPersonnelLabels统一处理
			if (oldPersonnel != null) {
				String oldZslabel2 = oldPersonnel.getZslabel2();
				personnel.setZslabel2(oldZslabel2 != null ? oldZslabel2 : "");
				System.out.println("保护zslabel2，使用DB原值: " + personnel.getZslabel2());
			}
			// ========== 保护标签结束 ==========

			int updateCount = personnelDao.updateSK(personnel);
			System.out.println("数据库更新影响行数: " + updateCount);

			// ========== 人员标签统一维护 ==========
			maintainPersonnelLabels(personnel);

			String successMsg = "治安人员修改成功！";
			if ("1".equals(removeDealUnit) && "1".equals(dealUnitHandled)) {
				successMsg = "治安人员修改成功！当前单位已从打处单位列表中移除。";
				System.out.println("打处单位移除成功");
			}

			message = new Message("true", successMsg);
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
        ////标签处理相关代码
//        try {
//            // a. 计算该人员当前年龄是否成年（当前日期-出生日期）
//            Personnel currentPersonnel = personnelDao.getById(personnel.getId());
//            if (currentPersonnel != null && currentPersonnel.getCardnumber() != null && !"".equals(currentPersonnel.getCardnumber())) {
//                int age = CardnumberInfo.getAge(currentPersonnel.getCardnumber());
//                int minorflag = (age < 18) ? 1 : 0; // 1表示未成年，0表示成年
//
//                System.out.println("========== updateZaPerson 标签处理 ==========");
//                System.out.println("人员ID: " + personnel.getId() + ", 年龄: " + age + ", 是否未成年: " + minorflag);
//                System.out.println("涉赌前科(hasSheduRecord): " + currentPersonnel.getHasSheduRecord());
//                System.out.println("涉娼前科(hasSechangRecord): " + currentPersonnel.getHasSechangRecord());
//                System.out.println("是否陪侍(isPeishi): " + currentPersonnel.getIsPeishi());
//
//                // b. 获取该人员当前子标签（zslabel2）
//                String currentLabels = currentPersonnel.getZslabel2();
//                System.out.println("当前子标签: " + currentLabels);

                // c. 根据hasSheduRecord、hasSechangRecord、isPeishi更新子标签

                // 处理涉赌标签(2178)
//                boolean hasDuLabel = (currentLabels != null && currentLabels.contains("2178"));
//                if (currentPersonnel.getHasSheduRecord() != null && currentPersonnel.getHasSheduRecord() == 1) {
//                    // 有涉赌前科，需要添加2178标签
//                    if (!hasDuLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), "2178", null);
//                        System.out.println("添加涉赌标签 2178");
//                    } else {
//                        System.out.println("已包含涉赌标签 2178，无需重复添加");
//                    }
//                } else {
//                    // 无涉赌前科，如果存在2178标签则移除
//                    if (hasDuLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), null, "2178");
//                        System.out.println("移除涉赌标签 2178");
//                    }
//                }
//
//                // 处理涉娼标签(2219)
//                boolean hasChangLabel = (currentLabels != null && currentLabels.contains("2219"));
//                if (currentPersonnel.getHasSechangRecord() != null && currentPersonnel.getHasSechangRecord() == 1) {
//                    // 有涉娼前科，需要添加2219标签
//                    if (!hasChangLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), "2219", null);
//                        System.out.println("添加涉娼标签 2219");
//                    } else {
//                        System.out.println("已包含涉娼标签 2219，无需重复添加");
//                    }
//                } else {
//                    // 无涉娼前科，如果存在2219标签则移除
//                    if (hasChangLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), null, "2219");
//                        System.out.println("移除涉娼标签 2219");
//                    }
//                }

//                // 处理陪侍标签(5001)
//                boolean hasPeiLabel = (currentLabels != null && currentLabels.contains("5001"));
//                if (currentPersonnel.getIsPeishi() != null && currentPersonnel.getIsPeishi() == 1) {
//                    // 是陪侍人员，需要添加5001标签
//                    if (!hasPeiLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), "5001", null);
//                        System.out.println("添加陪侍标签 5001");
//                    } else {
//                        System.out.println("已包含陪侍标签 5001，无需重复添加");
//                    }
//                } else {
//                    // 不是陪侍人员，如果存在5001标签则移除
//                    if (hasPeiLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), null, "5001");
//                        System.out.println("移除陪侍标签 5001");
//                    }
//                }
//
//                // 处理未成年标签(5002) - 根据年龄自动判定
//                boolean hasMinorLabel = (currentLabels != null && currentLabels.contains("5002"));
//                if (minorflag == 1) {
//                    // 未成年，添加5002标签
//                    if (!hasMinorLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), "5002", null);
//                        System.out.println("年龄" + age + "岁，添加未成年标签 5002");
//                    }
//                } else {
//                    // 成年，如果存在5002标签则移除
//                    if (hasMinorLabel) {
//                        personnelController.updateChildrenLabelOnZhian(personnel.getId(), null, "5002");
//                        System.out.println("年龄" + age + "岁，移除未成年标签 5002");
//                    }
//                }
//
//                System.out.println("========== 标签处理完成 ==========");
//            }
//        } catch (Exception e) {
//            System.err.println("updateZaPerson标签处理时发生错误: " + e.getMessage());
//            e.printStackTrace();
//        }

        ////////////////
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
	
	@RequestMapping("/searchZaPei.do")
	@ResponseBody
	public Map<String,Object> searchZaPei(ZaPei zaPei,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist=zaExtendDao.searchZaPei(zaPei, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询陪侍记录");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaPei.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询陪侍记录");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + zaPei.getPersonnelid() + "'";
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
        Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
		try {
			// 治安人员权限检查
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"新增"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景添加", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			zaDu.setValidflag(1);
			zaDu.setAddoperator(userSession.getLoginUserName());
			zaDu.setAddtime(addtime);
			zaExtendDao.addZaDu(zaDu);

			// 同步更新人员表现住地址和手机号
			syncPersonnelAddressAndPhone(zaDu.getPersonnelid(), zaDu.getHomeProvince(), zaDu.getHomeCity(),
				zaDu.getHomeCounty(), zaDu.getHomeTown(), zaDu.getHomePoliceStationId(), zaDu.getHomeDetail(),
				zaDu.getHomePoliceStationName(), zaDu.getHomeLng(), zaDu.getHomeLat(), addtime, userSession.getLoginUserName());

			// 自动标记涉赌前科
//			Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
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
		Personnel personnel = personnelDao.getById(zaChang.getPersonnelid());
		try {
			// 治安人员权限检查
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"新增"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景添加", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			zaChang.setValidflag(1);
			zaChang.setAddoperator(userSession.getLoginUserName());
			zaChang.setAddtime(addtime);

			// 计算是否未成年案件
			if(zaChang.getChang_chsj() != null && !"".equals(zaChang.getChang_chsj())){
				if(personnel != null && personnel.getCardnumber() != null && personnel.getCardnumber().length() >= 14){
					String birthDate = CardnumberInfo.getBirthDay(personnel.getCardnumber());
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
			@RequestParam(value="relJqIds", required=false) String relJqIds,
			@RequestParam(value="relAjIds", required=false) String relAjIds,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateZaDu.do.......................");
		System.out.println("========== updateZaDu  ==========");
		System.out.println("zaDu ID: " + zaDu.getId());
		System.out.println("personnelid: " + zaDu.getPersonnelid());
		System.out.println("---  ---");
		System.out.println("homeProvince: " + homeProvince);
		System.out.println("homeCity: " + homeCity);
		System.out.println("homeCounty: " + homeCounty);
		System.out.println("homeTown: " + homeTown);
		System.out.println("homeplace(): " + homeplace);
		System.out.println("homepolice(): " + homepolice);
		System.out.println("homex(): " + homex);
		System.out.println("homey(): " + homey);
		System.out.println("homePoliceStationId: " + homePoliceStationId);
		System.out.println("lssdqk: " + zaDu.getLssdqk());
		System.out.println("collectSource: " + zaDu.getCollectSource());
		System.out.println("collectDate: " + zaDu.getCollectDate());
		System.out.println("personAttribute: " + zaDu.getPersonAttribute());
		System.out.println("dbfs: " + zaDu.getDbfs());
		System.out.println("dbbw: " + zaDu.getDbbw());
		System.out.println("chjg: " + zaDu.getChjg());
		System.out.println("cfjg: " + zaDu.getCfjg());
		System.out.println("clxq: " + zaDu.getClxq());
		System.out.println("chsj: " + zaDu.getChsj());
		System.out.println("caseAddressList: " + zaDu.getCaseAddressList());
		System.out.println("phone: " + zaDu.getPhone());
		System.out.println("phone(@RequestParam): " + phone);
		System.out.println("relJqIds: " + relJqIds);
		System.out.println("relAjIds: " + relAjIds);
		System.out.println("==========================================");

		int duId = zaDu.getId(); // 保存涉赌记录ID，用于后续关联
		boolean isUpdate = duId > 0; // 判断是新增还是修改

		try {
			// 治安人员权限检查
			Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"修改"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-涉赌背景修改", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			// 涉案地址二次校验
			if (zaDu.getCaseAddressList() != null && !zaDu.getCaseAddressList().trim().isEmpty()) {
				String[] addressArray = zaDu.getCaseAddressList().split("，");
				if (addressArray.length > 5) {
					message = new Message("false","涉案地址最多只能填写 5 个！");
					message.setFlag(-1);
					return JSONObject.fromObject(message).toString();
				}
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

			// ✅ 核心修改：直接修改原记录，不再"废弃旧行+产生新行"
			if (isUpdate) {
				// 修改逻辑：直接更新原记录
				zaDu.setUpdateoperator(userSession.getLoginUserName());
				zaDu.setUpdatetime(addtime);
				// 不修改validflag，保持原有状态
				zaExtendDao.updateZaDu(zaDu);

				// 清除该记录旧的关联关系（先删后插）
				zaExtendDao.deleteDuRelByDuId(duId);
			} else {
				// 新增逻辑
				zaDu.setAddoperator(userSession.getLoginUserName());
				zaDu.setAddtime(addtime);
				zaDu.setValidflag(1); // 当前有效
				zaExtendDao.addZaDu(zaDu);
				duId = zaDu.getId(); // 获取新增后的自增ID

				// ✅ 自动标记涉赌前科（新增涉赌记录时更新）
				if(personnel != null && (personnel.getHasSheduRecord() == null || personnel.getHasSheduRecord() == 0)){
					personnel.setHasSheduRecord(1);
					personnelDao.updateHasSheduRecord(personnel);
					System.out.println("updateZaDu.do 新增模式：自动标记涉赌前科 hasSheduRecord = 1");
				}
			}

			// 处理关联关系（新增和修改都走这套逻辑）
			if (duId > 0) {
				// 保存警情关联
				if (relJqIds != null && !relJqIds.trim().isEmpty()) {
					String[] jqIdArray = relJqIds.split(",");
					for (String jqIdStr : jqIdArray) {
						if (jqIdStr != null && !jqIdStr.trim().isEmpty()) {
							try {
								int jqId = Integer.parseInt(jqIdStr.trim());
								zaExtendDao.insertDuJqRel(duId, zaDu.getPersonnelid(), jqId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("警情ID格式错误: " + jqIdStr);
							}
						}
					}
				}

				// 保存案件关联
				if (relAjIds != null && !relAjIds.trim().isEmpty()) {
					String[] ajIdArray = relAjIds.split(",");
					for (String ajIdStr : ajIdArray) {
						if (ajIdStr != null && !ajIdStr.trim().isEmpty()) {
							try {
								int ajId = Integer.parseInt(ajIdStr.trim());
								zaExtendDao.insertDuAjRel(duId, zaDu.getPersonnelid(), ajId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("案件ID格式错误: " + ajIdStr);
							}
						}
					}
				}
			}

			// 同步人员基础信息
			syncPersonnelAddressAndPhone(zaDu.getPersonnelid(), homeProvince, homeCity,
				homeCounty, homeTown, homePoliceStationId, homeplace, homepolice,
				homex, homey, addtime, userSession.getLoginUserName());


			// 同步手机号码到关联信息表(p_relation_telnumber_t)
			if(phone != null && !"".equals(phone.trim())){
				syncPhoneToRelationTelnumber(zaDu.getPersonnelid(), phone, addtime, userSession.getLoginUserName(), "涉赌背景采集");
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

        /////标签处理相关代码
        try {
            // a. 计算该人员当前年龄是否成年（当前日期-出生日期）
            Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
            if (personnel != null && personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())) {
                int age = CardnumberInfo.getAge(personnel.getCardnumber());
                int minorflag = (age < 18) ? 1 : 0; // 1表示未成年，0表示成年

                System.out.println("========== 涉赌背景标签处理 ==========");
                System.out.println("人员ID: " + zaDu.getPersonnelid() + ", 年龄: " + age + ", 是否未成年: " + minorflag);

                // b. 查看该人员子标签是否包含2178（涉赌人员）
                String currentLabels = personnel.getZslabel2();
                boolean hasDuLabel = (currentLabels != null && currentLabels.contains("2178"));

                // 如果未包含2178，则添加
                if (!hasDuLabel) {
                    personnelController.updateChildrenLabelOnZhian(zaDu.getPersonnelid(), "2178", null);
                    System.out.println("添加涉赌标签 2178");
                } else {
                    System.out.println("已包含涉赌标签 2178，无需重复添加");
                }

                // c. 根据minorflag更新5002（未成年）标签
                if (minorflag == 1) {
                    // 未成年，添加5002标签
                    personnelController.updateChildrenLabelOnZhian(zaDu.getPersonnelid(), "5002", null);
                    System.out.println("添加未成年标签 5002");
                } else {
                    // 成年，如果存在5002标签则移除
                    boolean hasMinorLabel = (currentLabels != null && currentLabels.contains("5002"));
                    if (hasMinorLabel) {
                        personnelController.updateChildrenLabelOnZhian(zaDu.getPersonnelid(), null, "5002");
                        System.out.println("移除未成年标签 5002");
                    }
                }
                System.out.println("========== 标签处理完成 ==========");
            }
        } catch (Exception e) {
            System.err.println("涉赌背景标签处理时发生错误: " + e.getMessage());
            e.printStackTrace();
        }
        ///////////////////////////////
		return JSONObject.fromObject(message).toString();
	}

	/**
	 * 查询涉赌记录的关联警情/案件详情
	 */
	@RequestMapping("/queryDuRelations.do")
	@ResponseBody
	public Map<String, Object> queryDuRelations(@RequestParam("duId") int duId) {
		Map<String, Object> result = new HashMap<>();
		try {
			// 查询关联的警情详情
			List<Object> jqList = zaExtendDao.findJqByDuId(duId);

			// 查询关联的案件详情
			List<Object> ajList = zaExtendDao.findAjByDuId(duId);

			result.put("code", 0);
			result.put("jqList", jqList);
			result.put("ajList", ajList);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 1);
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 查询涉娼记录的关联警情/案件详情
	 */
	@RequestMapping("/queryChangRelations.do")
	@ResponseBody
	public Map<String, Object> queryChangRelations(@RequestParam("changId") int changId) {
		Map<String, Object> result = new HashMap<>();
		try {
			// 查询关联的警情详情
			List<Object> jqList = zaExtendDao.findJqByChangId(changId);

			// 查询关联的案件详情
			List<Object> ajList = zaExtendDao.findAjByChangId(changId);

			result.put("code", 0);
			result.put("jqList", jqList);
			result.put("ajList", ajList);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 1);
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 查询陪侍记录的关联警情/案件详情
	 */
	@RequestMapping("/queryPeiRelations.do")
	@ResponseBody
	public Map<String, Object> queryPeiRelations(@RequestParam("peiId") int peiId) {
		Map<String, Object> result = new HashMap<>();
		try {
			// 查询关联的警情详情
			List<Object> jqList = zaExtendDao.findJqByPeiId(peiId);

			// 查询关联的案件详情
			List<Object> ajList = zaExtendDao.findAjByPeiId(peiId);

			result.put("code", 0);
			result.put("jqList", jqList);
			result.put("ajList", ajList);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 1);
			result.put("msg", "查询失败");
		}
		return result;
	}

	/**
	 * 删除涉赌记录（级联删除关联关系）
	 */
	@RequestMapping("/deleteZaDu.do")
	@ResponseBody
	public String deleteZaDu(@RequestParam("duId") int duId, int menuid,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			// 治安人员权限检查
			ZaDu zaDu = zaExtendDao.getZaDuById(duId);
			if (zaDu != null) {
				Personnel personnel = personnelDao.getById(zaDu.getPersonnelid());
				if (personnel != null) {
					String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
						userSession.getLoginUserDepartmentid(),
						personnel.getZslabel1(),
						personnel.getHandleUnitCode(),
						"删除"
					);
					if (permissionMsg != null) {
						message = new Message("false", permissionMsg);
						message.setFlag(-1);
						logDao.recordLog(menuid, "涉赌记录删除", userSession.getLoginUserName(), addtime, "权限不足", "");
						return JSONObject.fromObject(message).toString();
					}
				}
			}

			// ✅ 逻辑删除：设置validflag=0（作废）
			if (zaDu != null) {
				zaDu.setValidflag(0);
				zaDu.setUpdateoperator(userSession.getLoginUserName());
				zaDu.setUpdatetime(addtime);
				zaExtendDao.updateZaDu(zaDu);

				// ✅ 同步更新关联表的validflag为0
				zaExtendDao.updateDuAjRelValidflag(duId, 0);  // 涉赌-案件关联
				zaExtendDao.updateDuJqRelValidflag(duId, 0);  // 涉赌-警情关联
			}

			message = new Message("true","涉赌记录删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "涉赌记录删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉赌记录删除失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}

	/**
	 * 删除涉娼记录
	 * @param changId 涉娼记录ID
	 * @param menuid 菜单ID
	 * @param request 请求对象
	 * @param userSession 用户会话
	 * @return JSON格式的操作结果
	 */
	@RequestMapping("/deleteZaChang.do")
	@ResponseBody
	public String deleteZaChang(@RequestParam("changId") int changId, int menuid,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			// 治安人员权限检查
			ZaChang zaChang = zaExtendDao.getZaChangById(changId);
			if (zaChang != null) {
				Personnel personnel = personnelDao.getById(zaChang.getPersonnelid());
				if (personnel != null) {
					String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
						userSession.getLoginUserDepartmentid(),
						personnel.getZslabel1(),
						personnel.getHandleUnitCode(),
						"删除"
					);
					if (permissionMsg != null) {
						message = new Message("false", permissionMsg);
						message.setFlag(-1);
						logDao.recordLog(menuid, "涉娼记录删除", userSession.getLoginUserName(), addtime, "权限不足", "");
						return JSONObject.fromObject(message).toString();
					}
				}
			}

			// ✅ 逻辑删除：设置validflag=0（作废）
			if (zaChang != null) {
				zaChang.setValidflag(0);
				zaChang.setUpdateoperator(userSession.getLoginUserName());
				zaChang.setUpdatetime(addtime);
				zaExtendDao.updateZaChang(zaChang);

				// ✅ 同步更新关联表的validflag为0
				zaExtendDao.updateChangAjRelValidflag(changId, 0);  // 涉娼-案件关联
				zaExtendDao.updateChangJqRelValidflag(changId, 0);  // 涉娼-警情关联
			}

			message = new Message("true","涉娼记录删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "涉娼记录删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉娼记录删除失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}

	/**
	 * 删除陪侍记录
	 * @param peiId 陪侍记录ID
	 * @param menuid 菜单ID
	 * @param request 请求对象
	 * @param userSession 用户会话
	 * @return JSON格式的操作结果
	 */
	@RequestMapping("/deleteZaPei.do")
	@ResponseBody
	public String deleteZaPei(@RequestParam("peiId") int peiId, int menuid,
			ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			// 治安人员权限检查
			ZaPei zaPei = zaExtendDao.getZaPeiById(peiId);
			if (zaPei != null) {
				Personnel personnel = personnelDao.getById(zaPei.getPersonnelid());
				if (personnel != null) {
					String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
						userSession.getLoginUserDepartmentid(),
						personnel.getZslabel1(),
						personnel.getHandleUnitCode(),
						"删除"
					);
					if (permissionMsg != null) {
						message = new Message("false", permissionMsg);
						message.setFlag(-1);
						logDao.recordLog(menuid, "陪侍记录删除", userSession.getLoginUserName(), addtime, "权限不足", "");
						return JSONObject.fromObject(message).toString();
					}
				}
			}

			// ✅ 逻辑删除：设置validflag=0（作废）
			if (zaPei != null) {
				zaPei.setValidflag(0);
				zaPei.setUpdateoperator(userSession.getLoginUserName());
				zaPei.setUpdatetime(addtime);
				zaExtendDao.updateZaPei(zaPei);

				// ✅ 同步更新关联表的validflag为0
				zaExtendDao.updatePeiAjRelValidflag(peiId, 0);  // 陪侍-案件关联
				zaExtendDao.updatePeiJqRelValidflag(peiId, 0);  // 陪侍-警情关联
			}

			message = new Message("true","陪侍记录删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "陪侍记录删除", userSession.getLoginUserName(), addtime, "删除成功", "");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","陪侍记录删除失败！");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}

	/**
	 * 根据ID查询涉赌记录详情（用于关联详情查看）
	 */
	@RequestMapping("/getZaDuById.do")
	@ResponseBody
	public ZaDu getZaDuById(@RequestParam("id") int id){
		try {
			return zaExtendDao.getZaDuById(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 根据ID查询涉娼记录详情（用于关联详情查看）
	 */
	@RequestMapping("/getZaChangById.do")
	@ResponseBody
	public ZaChang getZaChangById(@RequestParam("id") int id){
		try {
			return zaExtendDao.getZaChangById(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 根据ID查询陪侍记录详情（用于关联详情查看）
	 */
	@RequestMapping("/getZaPeiById.do")
	@ResponseBody
	public ZaPei getZaPeiById(@RequestParam("id") int id){
		try {
			return zaExtendDao.getZaPeiById(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
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
		System.out.println("zaChang对象ID: " + zaChang.getId());
		System.out.println("personnelid: " + zaChang.getPersonnelid());
		System.out.println("--- 现住地址 ---");
		System.out.println("homeProvince: " + homeProvince);
		System.out.println("homeCity: " + homeCity);
		System.out.println("homeCounty: " + homeCounty);
		System.out.println("homeTown: " + homeTown);
		System.out.println("homeplace(详址): " + homeplace);
		System.out.println("homepolice(派出所): " + homepolice);
		System.out.println("homex(经度): " + homex);
		System.out.println("homey(纬度): " + homey);
		System.out.println("homePoliceStationId: " + homePoliceStationId);
		System.out.println("--- 涉娼业务字段 ---");
		System.out.println("chang_lsscqk(情况综述): " + zaChang.getChang_lsscqk());
		System.out.println("collectSource(采集来源): " + zaChang.getCollectSource());
		System.out.println("collectDate(采集日期): " + zaChang.getCollectDate());
		System.out.println("chang_scjs(人员属性): " + zaChang.getChang_scjs());
		System.out.println("chang_myfs(涉娼方式): " + zaChang.getChang_myfs());
		System.out.println("changType(涉娼类型): " + zaChang.getChangType());
		System.out.println("chang_chjg(查获经过): " + zaChang.getChang_chjg());
		System.out.println("chang_cfjg(处罚结果): " + zaChang.getChang_cfjg());
		System.out.println("chang_clxq(处理详情): " + zaChang.getChang_clxq());
		System.out.println("chang_chsj(处罚时间): " + zaChang.getChang_chsj());
		System.out.println("caseAddressList(涉案地址): " + zaChang.getCaseAddressList());
		System.out.println("phone(联系电话): " + zaChang.getPhone());
		System.out.println("isMinorCase(前端传来的值): " + zaChang.getIsMinorCase());
		System.out.println("==========================================");

		int changId = zaChang.getId(); // 保存涉娼记录ID
		boolean isUpdate = changId > 0; // 判断是新增还是修改

		try {
			// 治安人员权限检查
			Personnel personnel = personnelDao.getById(zaChang.getPersonnelid());
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"修改"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-涉娼背景修改", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			// 涉案地址二次校验
			if (zaChang.getCaseAddressList() != null && !zaChang.getCaseAddressList().trim().isEmpty()) {
				String[] addressArray = zaChang.getCaseAddressList().split("，");
				if (addressArray.length > 5) {
					message = new Message("false","涉案地址最多只能填写 5 个！");
					message.setFlag(-1);
					return JSONObject.fromObject(message).toString();
				}
			}

			// ✅ 核心修改：先设置现住地址字段，再进行更新或新增
			zaChang.setHomeProvince(homeProvince);
			zaChang.setHomeCity(homeCity);
			zaChang.setHomeCounty(homeCounty);
			zaChang.setHomeTown(homeTown);
			zaChang.setHomePoliceStationId(homePoliceStationId);
			zaChang.setHomeDetail(homeplace);
			zaChang.setHomeLng(homex);
			zaChang.setHomeLat(homey);

			// ✅ 未成年案件判断：完全由前端负责，后端只做日志记录和验证
			// 注意：前端已经根据处罚时间和生日计算过isMinorCase，后端不再重新计算和设置
			// 后端只输出日志用于对比验证，确保前端计算的正确性
			System.out.println("========== 未成年案件判断（仅验证，不覆盖） ==========");
			System.out.println("前端传来的isMinorCase值: " + zaChang.getIsMinorCase());

			// 后端计算年龄仅用于验证对比，不会修改zaChang对象的isMinorCase值
			if(zaChang.getChang_chsj() != null && !"".equals(zaChang.getChang_chsj())){
				if(personnel != null && personnel.getCardnumber() != null && personnel.getCardnumber().length() >= 14){
					String birthDate = CardnumberInfo.getBirthDay(personnel.getCardnumber());
					int age = CardnumberInfo.getAgeByDate(birthDate, zaChang.getChang_chsj());
					System.out.println("身份证号: " + personnel.getCardnumber());
					System.out.println("出生日期: " + birthDate);
					System.out.println("处罚时间: " + zaChang.getChang_chsj());
					System.out.println("后端验证年龄: " + age);

					// 计算后端结果仅用于对比，不会设置到zaChang对象
					int backendResult = (age < 18) ? 1 : 0;
					System.out.println("后端验证结果: " + backendResult);
					System.out.println("前端传来结果: " + zaChang.getIsMinorCase());

					// 如果前后端计算不一致，输出警告，但仍以前端为准
					if(backendResult != zaChang.getIsMinorCase()) {
						System.out.println("⚠️ 警告：前后端计算结果不一致！");
						System.out.println("    前端值=" + zaChang.getIsMinorCase() + ", 后端计算=" + backendResult);
						System.out.println("    以前端传来的值为准，不会被后端覆盖");
					} else {
						System.out.println("✓ 前后端计算结果一致");
					}
					System.out.println("最终存储值: " + zaChang.getIsMinorCase() + " (来自前端)");
				}
			}
			System.out.println("====================================================");

			if (isUpdate) {
				// 修改逻辑：直接更新原记录
				zaChang.setUpdateoperator(userSession.getLoginUserName());
				zaChang.setUpdatetime(addtime);
				// 不修改validflag，保持原有状态
				zaExtendDao.updateZaChang(zaChang);

				// 清除该记录旧的关联关系（先删后插）
				zaExtendDao.deleteChangRelByChangId(changId);
			} else {
				// 新增逻辑
				zaChang.setAddoperator(userSession.getLoginUserName());
				zaChang.setAddtime(addtime);
				zaChang.setValidflag(1); // 当前有效
				zaExtendDao.addZaChang(zaChang);
				changId = zaChang.getId(); // 获取新增后的自增ID

				// ✅ 自动标记涉黄前科（新增涉娼记录时更新）
				if(personnel != null && (personnel.getHasSechangRecord() == null || personnel.getHasSechangRecord() == 0)){
					personnel.setHasSechangRecord(1);
					personnelDao.updateHasSechangRecord(personnel);
					System.out.println("updateZaChang.do 新增模式：自动标记涉黄前科 hasSechangRecord = 1");
				}
			}

			// 处理关联关系（新增和修改都走这套逻辑）
			if (changId > 0) {
				String relJqIds = zaChang.getRelJqIds();
				String relAjIds = zaChang.getRelAjIds();

				// 保存警情关联
				if (relJqIds != null && !relJqIds.trim().isEmpty()) {
					String[] jqIdArray = relJqIds.split(",");
					for (String jqIdStr : jqIdArray) {
						if (jqIdStr != null && !jqIdStr.trim().isEmpty()) {
							try {
								int jqId = Integer.parseInt(jqIdStr.trim());
								zaExtendDao.insertChangJqRel(changId, zaChang.getPersonnelid(), jqId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("警情ID格式错误: " + jqIdStr);
							}
						}
					}
				}

				// 保存案件关联
				if (relAjIds != null && !relAjIds.trim().isEmpty()) {
					String[] ajIdArray = relAjIds.split(",");
					for (String ajIdStr : ajIdArray) {
						if (ajIdStr != null && !ajIdStr.trim().isEmpty()) {
							try {
								int ajId = Integer.parseInt(ajIdStr.trim());
								zaExtendDao.insertChangAjRel(changId, zaChang.getPersonnelid(), ajId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("案件ID格式错误: " + ajIdStr);
							}
						}
					}
				}
			}

			// 同步人员基础信息
			syncPersonnelAddressAndPhone(zaChang.getPersonnelid(), homeProvince, homeCity,
				homeCounty, homeTown, homePoliceStationId, homeplace, homepolice,
				homex, homey, addtime, userSession.getLoginUserName());

			// 同步手机号码到关联信息表
			String phone = zaChang.getPhone();
			if(phone != null && !"".equals(phone.trim())){
				syncPhoneToRelationTelnumber(zaChang.getPersonnelid(), phone, addtime, userSession.getLoginUserName(), "涉娼背景采集");
			}


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
        /////标签处理相关代码
        try {
            // a. 计算该人员当前年龄是否成年（当前日期-出生日期）
            Personnel personnel = personnelDao.getById(zaChang.getPersonnelid());
            if (personnel != null && personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())) {
                int age = CardnumberInfo.getAge(personnel.getCardnumber());
                int minorflag = (age < 18) ? 1 : 0; // 1表示未成年，0表示成年

                System.out.println("========== 涉娼背景标签处理 ==========");
                System.out.println("人员ID: " + zaChang.getPersonnelid() + ", 年龄: " + age + ", 是否未成年: " + minorflag);

                // b. 查看该人员子标签是否包含2219（涉娼人员）
                String currentLabels = personnel.getZslabel2();
                boolean hasChangLabel = (currentLabels != null && currentLabels.contains("2219"));

                // 如果未包含2219，则添加
                if (!hasChangLabel) {
                    personnelController.updateChildrenLabelOnZhian(zaChang.getPersonnelid(), "2219", null);
                    System.out.println("添加涉娼标签 2219");
                } else {
                    System.out.println("已包含涉娼标签 2219，无需重复添加");
                }

                // c. 根据minorflag更新5002（未成年）标签
                if (minorflag == 1) {
                    // 未成年，添加5002标签
                    personnelController.updateChildrenLabelOnZhian(zaChang.getPersonnelid(), "5002", null);
                    System.out.println("添加未成年标签 5002");
                } else {
                    // 成年，如果存在5002标签则移除
                    boolean hasMinorLabel = (currentLabels != null && currentLabels.contains("5002"));
                    if (hasMinorLabel) {
                        personnelController.updateChildrenLabelOnZhian(zaChang.getPersonnelid(), null, "5002");
                        System.out.println("移除未成年标签 5002");
                    }
                }
                System.out.println("========== 标签处理完成 ==========");
            }
        } catch (Exception e) {
            System.err.println("涉娼背景标签处理时发生错误: " + e.getMessage());
            e.printStackTrace();
        }


        ///////////////////////////////
		return JSONObject.fromObject(message).toString();
	}

	// ========== 陪侍人员相关方法 ==========
	@RequestMapping("/addZaPei.do")
	@ResponseBody
	public String addZaPei(ZaPei zaPei,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		Personnel personnel = personnelDao.getById(zaPei.getPersonnelid());
		try {
			// 治安人员权限检查
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"新增"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景添加", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			zaPei.setValidflag(1);
			zaPei.setAddoperator(userSession.getLoginUserName());
			zaPei.setAddtime(addtime);
			zaExtendDao.addZaPei(zaPei);

			// 同步更新人员表现住地址
			syncPersonnelAddressAndPhone(zaPei.getPersonnelid(), zaPei.getHomeProvince(), zaPei.getHomeCity(),
				zaPei.getHomeCounty(), zaPei.getHomeTown(), zaPei.getHomePoliceStationId(), zaPei.getHomeDetail(),
				zaPei.getHomePoliceStationName(), zaPei.getHomeLng(), zaPei.getHomeLat(), addtime, userSession.getLoginUserName());

			// 标记为陪侍人员
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
	public @ResponseBody String updateZaPei(ZaPei zaPei,int menuid,
			@RequestParam(value="relJqIds", required=false) String relJqIds,
			@RequestParam(value="relAjIds", required=false) String relAjIds,
			ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());

		int peiId = zaPei.getId(); // 保存陪侍记录ID
		boolean isUpdate = peiId > 0; // 判断是新增还是修改

		try {
			// 治安人员权限检查
			Personnel personnel = personnelDao.getById(zaPei.getPersonnelid());
			if (personnel != null) {
				String permissionMsg = ZaPersonnelPermissionUtil.checkPermissionWithMessage(
					userSession.getLoginUserDepartmentid(),
					personnel.getZslabel1(),
					personnel.getHandleUnitCode(),
					"修改"
				);
				if (permissionMsg != null) {
					message = new Message("false", permissionMsg);
					message.setFlag(-1);
					logDao.recordLog(menuid, "风险人员-治安人员-陪侍背景修改", userSession.getLoginUserName(), addtime, "权限不足", "");
					return JSONObject.fromObject(message).toString();
				}
			}

			// ✅ 核心修改：直接修改原记录，不再"废弃旧行+产生新行"
			if (isUpdate) {
				// 修改逻辑：直接更新原记录
				zaPei.setUpdateoperator(userSession.getLoginUserName());
				zaPei.setUpdatetime(addtime);
				// 不修改validflag，保持原有状态
				zaExtendDao.updateZaPei(zaPei);

				// 清除该记录旧的关联关系（先删后插）
				zaExtendDao.deletePeiRelByPeiId(peiId);
			} else {
				// 新增逻辑
				zaPei.setAddoperator(userSession.getLoginUserName());
				zaPei.setAddtime(addtime);
				zaPei.setValidflag(1); // 当前有效
				zaExtendDao.addZaPei(zaPei);
				peiId = zaPei.getId(); // 获取新增后的自增ID

				// ✅ 自动标记陪侍人员（新增陪侍记录时更新）
				if(personnel != null && (personnel.getIsPeishi() == null || personnel.getIsPeishi() == 0)){
					personnel.setIsPeishi(1);
					personnelDao.updateIsPeishi(personnel);
					System.out.println("updateZaPei.do 新增模式：自动标记陪侍人员 isPeishi = 1");
				}
			}

			// 处理关联关系（新增和修改都走这套逻辑）
			if (peiId > 0) {
				// 保存警情关联
				if (relJqIds != null && !relJqIds.trim().isEmpty()) {
					String[] jqIdArray = relJqIds.split(",");
					for (String jqIdStr : jqIdArray) {
						if (jqIdStr != null && !jqIdStr.trim().isEmpty()) {
							try {
								int jqId = Integer.parseInt(jqIdStr.trim());
								zaExtendDao.insertPeiJqRel(peiId, zaPei.getPersonnelid(), jqId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("警情ID格式错误: " + jqIdStr);
							}
						}
					}
				}

				// 保存案件关联
				if (relAjIds != null && !relAjIds.trim().isEmpty()) {
					String[] ajIdArray = relAjIds.split(",");
					for (String ajIdStr : ajIdArray) {
						if (ajIdStr != null && !ajIdStr.trim().isEmpty()) {
							try {
								int ajId = Integer.parseInt(ajIdStr.trim());
								zaExtendDao.insertPeiAjRel(peiId, zaPei.getPersonnelid(), ajId, addtime);
							} catch (NumberFormatException e) {
								System.err.println("案件ID格式错误: " + ajIdStr);
							}
						}
					}
				}
			}

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
        /////标签处理相关代码
        try {
            // a. 计算该人员当前年龄是否成年（当前日期-出生日期）
            Personnel personnel = personnelDao.getById(zaPei.getPersonnelid());
            if (personnel != null && personnel.getCardnumber() != null && !"".equals(personnel.getCardnumber())) {
                int age = CardnumberInfo.getAge(personnel.getCardnumber());
                int minorflag = (age < 18) ? 1 : 0; // 1表示未成年，0表示成年

                System.out.println("========== 陪侍背景标签处理 ==========");
                System.out.println("人员ID: " + zaPei.getPersonnelid() + ", 年龄: " + age + ", 是否未成年: " + minorflag);

                // b. 查看该人员子标签是否包含5001（陪侍人员）
                String currentLabels = personnel.getZslabel2();
                boolean hasPeiLabel = (currentLabels != null && currentLabels.contains("5001"));

                // 如果未包含5001，则添加
                if (!hasPeiLabel) {
                    personnelController.updateChildrenLabelOnZhian(zaPei.getPersonnelid(), "5001", null);
                    System.out.println("添加陪侍标签 5001");
                } else {
                    System.out.println("已包含陪侍标签 5001，无需重复添加");
                }

                // c. 根据minorflag更新5002（未成年）标签
                if (minorflag == 1) {
                    // 未成年，添加5002标签
                    personnelController.updateChildrenLabelOnZhian(zaPei.getPersonnelid(), "5002", null);
                    System.out.println("添加未成年标签 5002");
                } else {
                    // 成年，如果存在5002标签则移除
                    boolean hasMinorLabel = (currentLabels != null && currentLabels.contains("5002"));
                    if (hasMinorLabel) {
                        personnelController.updateChildrenLabelOnZhian(zaPei.getPersonnelid(), null, "5002");
                        System.out.println("移除未成年标签 5002");
                    }
                }
                System.out.println("========== 标签处理完成 ==========");
            }
        } catch (Exception e) {
            System.err.println("陪侍背景标签处理时发生错误: " + e.getMessage());
            e.printStackTrace();
        }


        ///////////////////////////////
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
	 * @param gainorigin 获取来源（如：涉赌背景采集、涉娼背景采集）
	 */
	private void syncPhoneToRelationTelnumber(int personnelid, String phone, String addtime, String operator, String gainorigin){
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
				relationTelnumber.setGainorigin(gainorigin);
				relationTelnumber.setValidflag(1);
				relationTelnumber.setAddoperator(operator);
				relationTelnumber.setAddtime(addtime);
				relationDao.addrelationtelnumber(relationTelnumber);
				System.out.println("已同步手机号码到关联信息表: " + phone + ", 来源: " + gainorigin);
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

	/**
	 * 人员标签统一维护方法
	 * 根据人员的hasSheduRecord、hasSechangRecord、isPeishi字段及年龄
	 * 自动维护zslabel2中的标签(2178涉赌、2219涉娼、5001陪侍、5002未成年)
	 *
	 * @param personnel 人员对象
	 */
	private void maintainPersonnelLabels(Personnel personnel) {
		try {
			System.out.println("========== 开始维护人员标签 ==========");

			// 1. 从数据库获取最新的人员信息（包含 isPeishi/hasSheduRecord/hasSechangRecord 等字段）
			Personnel currentPersonnel = personnelDao.getById(personnel.getId());
			if (currentPersonnel == null) {
				System.err.println("维护标签失败：人员不存在 id=" + personnel.getId());
				return;
			}
			String currentLabels = currentPersonnel.getZslabel2();
			if (currentLabels == null) {
				currentLabels = "";
			}

			// 使用 LinkedHashSet 保留原始标签顺序，避免每次写库顺序不同导致误判"有变化"
			Set<String> labelSet = new LinkedHashSet<>();
			if (!"".equals(currentLabels.trim())) {
				String[] labelArray = currentLabels.split(",");
				for (String label : labelArray) {
					if (label != null && !"".equals(label.trim())) {
						labelSet.add(label.trim());
					}
				}
			}

			System.out.println("当前标签: " + currentLabels);
			System.out.println("涉赌前科(DB): " + currentPersonnel.getHasSheduRecord());
			System.out.println("涉娼前科(DB): " + currentPersonnel.getHasSechangRecord());
			System.out.println("是否陪侍(DB): " + currentPersonnel.getIsPeishi());

			// 2. 处理涉赌标签(2178)
			// 若已存在2178则不操作；否则查询 p_zaperson_du_t，有记录则添加
			if (!labelSet.contains("2178")) {
				try {
					boolean hasDuRecord = zaExtendDao.existsDuByPersonnelId(personnel.getId());
					if (hasDuRecord) {
						labelSet.add("2178");
						System.out.println("查询到涉赌记录，补充添加涉赌标签 2178");
					}
				} catch (Exception ex) {
					System.err.println("查询涉赌记录失败: " + ex.getMessage());
				}
			} else {
				System.out.println("已包含涉赌标签 2178，跳过检查");
			}

			// 3. 处理涉娼标签(2219)
			// 若已存在2219则不操作；否则查询 p_zaperson_chang_t，有记录则添加
			if (!labelSet.contains("2219")) {
				try {
					boolean hasChangRecord = zaExtendDao.existsChangByPersonnelId(personnel.getId());
					if (hasChangRecord) {
						labelSet.add("2219");
						System.out.println("查询到涉娼记录，补充添加涉娼标签 2219");
					}
				} catch (Exception ex) {
					System.err.println("查询涉娼记录失败: " + ex.getMessage());
				}
			} else {
				System.out.println("已包含涉娼标签 2219，跳过检查");
			}

			// 4. 处理陪侍标签(5001) —— 以数据库中 isPeishi 字段为准
			if (currentPersonnel.getIsPeishi() != null && currentPersonnel.getIsPeishi() == 1) {
				if (labelSet.add("5001")) {
					System.out.println("添加陪侍标签 5001");
				} else {
					System.out.println("已包含陪侍标签 5001，无需重复添加");
				}
			} else {
				if (labelSet.remove("5001")) {
					System.out.println("移除陪侍标签 5001");
				}
			}

			// 5. 处理未成年标签(5002) —— 根据身份证号动态计算年龄
			String cardnumber = currentPersonnel.getCardnumber();
			if (cardnumber != null && !"".equals(cardnumber.trim())) {
				int age = CardnumberInfo.getAge(cardnumber);
				if (age < 18) {
					if (labelSet.add("5002")) {
						System.out.println("年龄" + age + "岁，添加未成年标签 5002");
					}
				} else {
					if (labelSet.remove("5002")) {
						System.out.println("年龄" + age + "岁，移除未成年标签 5002");
					}
				}
			}

			// 6. 将 Set 转回字符串
			StringBuilder sb = new StringBuilder();
			for (String label : labelSet) {
				if (sb.length() > 0) {
					sb.append(",");
				}
				sb.append(label);
			}
			String newLabels = sb.toString();

			// 7. 仅在内容真正变化时才更新数据库
			if (!newLabels.equals(currentLabels)) {
				currentPersonnel.setZslabel2(newLabels);
				personnelDao.updateSK(currentPersonnel);
				System.out.println("标签已更新: " + currentLabels + " -> " + newLabels);
			} else {
				System.out.println("标签无变化，无需更新");
			}

			System.out.println("========== 标签维护完成 ==========");

		} catch (Exception e) {
			System.err.println("维护人员标签时发生错误: " + e.getMessage());
			e.printStackTrace();
		}
	}
}

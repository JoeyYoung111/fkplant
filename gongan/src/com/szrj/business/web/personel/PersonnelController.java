package com.szrj.business.web.personel;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.szrj.business.dao.personel.*;
import com.szrj.business.model.personel.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.DuModel;
import com.aladdin.model.MapModel;
import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.aladdin.util.TreeSelect;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.dao.company.VehicleDao;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.dao.goods.DangerousItemDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.dao.interfaces.ShortMessageDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.Role;
import com.szrj.business.model.User;
import com.szrj.business.model.goods.DangerousItem;

@Controller
@SessionAttributes("userSession")
public class PersonnelController {
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private ApplylabelDao applylabelDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private MaintainrateDao maintainrateDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private WenGradeDao wenGradeDao;
	@Autowired
	private KongExtendDao kongExtendDao;
	@Autowired
	private HeiEditorDao heiEditorDao;
	@Autowired
	private DuExtendDao duextendDao;
	@Autowired
	private PersonnelExtendDao extendDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	@Autowired
	private CompanyDao companyDao;
	@Autowired
	private DangerousItemDao dangerousItemDao;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private ControlPowerDao controlPowerDao;
	@Autowired
	private ControlFilesDao controlFilesDao;


	/**  *********************************************************************管控力量信息***************************************************************  **/

	@RequestMapping("/getcontrolfilesbyid.do")
	public String getcontrolfilesbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		ControlFiles controlfiles=controlFilesDao.getById(id);
		model.addAttribute("controlfiles", controlfiles);
		String  urlString="/jsp/personel/controlfiles/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询管控文件");
		String operate_Condition = "";
		operate_Condition += "管控文件id = '" + controlfiles.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}

	@RequestMapping("/addcontrolfiles.do")
	public @ResponseBody String addcontrolfiles(ControlFiles controlFiles,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			controlFiles.setAddtime(addtime);
			controlFiles.setAddoperator(userSession.getLoginUserName());
			controlFiles.setValidflag(1);
			controlFilesDao.add(controlFiles);
			message= new Message("true","管控文件添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控文件添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控文件添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控文件信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控文件信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控文件信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}

	@RequestMapping("/updatecontrolfiles.do")
	public @ResponseBody String updatecontrolfiles(ControlFiles controlfiles,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		try {
			controlfiles.setUpdatetime(updatetime);
			controlfiles.setUpdateoperator(userSession.getLoginUserName());
			controlFilesDao.update(controlfiles);
			message= new Message("true","管控文件信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控文件修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控文件修改");
			String operate_Condition = "";
			operate_Condition += "管控文件id = '" + controlfiles.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控文件修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控文件修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控文件修改");
			String operate_Condition = "";
			operate_Condition += "管控文件id = '" + controlfiles.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}

	@RequestMapping("/cancelcontrolfiles.do")
	public @ResponseBody String cancelcontrolfiles(ControlFiles controlfiles,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		try {
			controlfiles.setUpdatetime(updatetime);
			controlfiles.setUpdateoperator(userSession.getLoginUserName());
			controlfiles.setValidflag(0);
			controlFilesDao.cancel(controlfiles);
			message= new Message("true","管控文件删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控文件删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控文件删除");
			String operate_Condition = "";
			operate_Condition += "管控文件id = '" + controlfiles.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控文件删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控文件删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控文件删除");
			String operate_Condition = "";
			operate_Condition += "管控文件id = '" + controlfiles.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/searchcontrolfiles.do")
	@ResponseBody
	public Map<String,Object>  searchcontrolfiles(int personnelid,int type,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/searchcontrolfiles.do..............="+personnelid);
		pm.setPageNumber(page);


		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功

		//type   类型   1:管控方案,2:应急预案
		NewPageModel listTemp = null;
		if(1 == type){
			listTemp=controlFilesDao.searchcontrolplan(personnelid, pm);
			log.setOperate_Name("查询管控方案");
		}else if(2 == type){
			listTemp=controlFilesDao.searchcontrolemergency(personnelid, pm);
			log.setOperate_Name("查询应急预案");
		}


		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		String operate_Condition = "";
		operate_Condition += "人员ID = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return result;
	}

	@RequestMapping("/searchcontrolpower.do")
	@ResponseBody
	public Map<String,Object>  searchcontrolpower(int personnelid,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/searchcontrolpower.do..............="+personnelid);
		pm.setPageNumber(page);
		NewPageModel listTemp=controlPowerDao.searchcontrolpower(personnelid, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询管控力量信息");
		String operate_Condition = "";
		operate_Condition += "人员ID = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return result;
	}
	@RequestMapping("/addcontrolpower.do")
	public @ResponseBody String addcontrolpower(ControlPower controlpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			controlpower.setAddtime(addtime);
			controlpower.setAddoperator(userSession.getLoginUserName());
			controlpower.setValidflag(1);
			controlpower.setSexes(CardnumberInfo.getSex(controlpower.getCardnumber()));
			controlPowerDao.add(controlpower);
			message= new Message("true","管控力量信息添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控力量信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控力量信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控力量信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updatecontrolpower.do")
	public @ResponseBody String updatecontrolpower(ControlPower controlpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		try {
			controlpower.setUpdatetime(updatetime);
			controlpower.setUpdateoperator(userSession.getLoginUserName());
			controlPowerDao.update(controlpower);
			message= new Message("true","管控力量信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控力量信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息修改");
			String operate_Condition = "";
			operate_Condition += "管控力量信息id = '" + controlpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控力量信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控力量信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息修改");
			String operate_Condition = "";
			operate_Condition += "管控力量信息id = '" + controlpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/cancelcontrolpower.do")
	public @ResponseBody String cancelcontrolpower(ControlPower controlpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		try {
			controlpower.setUpdatetime(updatetime);
			controlpower.setUpdateoperator(userSession.getLoginUserName());
			controlpower.setValidflag(0);
			controlPowerDao.cancel(controlpower);
			message= new Message("true","管控力量信息删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "管控力量信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息删除");
			String operate_Condition = "";
			operate_Condition += "管控力量信息id = '" + controlpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","管控力量信息删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "管控力量信息删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("管控力量信息删除");
			String operate_Condition = "";
			operate_Condition += "管控力量信息id = '" + controlpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getcontrolpowerbyid.do")
	public String getcontrolpowerbyid(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		ControlPower controlpower=controlPowerDao.getById(id);
		model.addAttribute("controlpower", controlpower);
		String  urlString="/jsp/personel/controlpower/update";
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询管控力量信息");
		String operate_Condition = "";
		operate_Condition += "管控力量信息id = '" + controlpower.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	
	@RequestMapping("/getAllPersonnel.do")
	@ResponseBody
	public Map<String, Object> getAllPersonnel(Personnel personnel, NewPageModel pm,
												String ages,String personneltype1,String personneltype4
												,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			String sqlall="";
			if(ages!=null&&!"".equals(ages)){
				if (!ages.contains(",")) {
					switch (Integer.parseInt(ages)) {
						case 1:
							sqlall += "getAge(pt.cardnumber)<18";
							break;
						case 2:
							sqlall += "(getAge(pt.cardnumber)>=18 AND getAge(pt.cardnumber)<=30)";
							break;
						case 3:
							sqlall += "(getAge(pt.cardnumber)>=31 AND getAge(pt.cardnumber)<=40)";
							break;
						case 4:
							sqlall += "(getAge(pt.cardnumber)>=41 AND getAge(pt.cardnumber)<=50)";
							break;
						case 5:
							sqlall += "getAge(pt.cardnumber)>50";
							break;
					}
				}else {
					String[] agesStrings=ages.split(",");
					for(int i=0;i<agesStrings.length;i++){
						if(i!=0)sqlall+=" OR ";
						switch (Integer.parseInt(agesStrings[i])) {
							case 1:
								sqlall += "getAge(pt.cardnumber)<18";
								break;
							case 2:
								sqlall += "(getAge(pt.cardnumber)>=18 AND getAge(pt.cardnumber)<=30)";
								break;
							case 3:
								sqlall += "(getAge(pt.cardnumber)>=31 AND getAge(pt.cardnumber)<=40)";
								break;
							case 4:
								sqlall += "(getAge(pt.cardnumber)>=41 AND getAge(pt.cardnumber)<=50)";
								break;
							case 5:
								sqlall += "getAge(pt.cardnumber)>50";
								break;
						} 
					}
				}
			}
			if (personnel.getAttributelabels()!=null&!"".equals(personnel.getAttributelabels())) {
				if (!personnel.getAttributelabels().contains(",")) {
					if (sqlall!="")sqlall +=" AND ";
					sqlall += "FIND_IN_SET("+personnel.getAttributelabels()+",pt.attributelabels)";
				}else {
					String[] attributes=personnel.getAttributelabels().split(",");
					for (int i = 0; i < attributes.length; i++) {
						if(i>0)sqlall += " OR ";
						sqlall += "FIND_IN_SET("+attributes[i]+",pt.attributelabels)";
					}
				}
			}
			if (personnel.getPersonlabel()!=null&&!"".equals(personnel.getPersonlabel())) {
				if (!personnel.getPersonlabel().contains(",")) {
					if (sqlall!="")sqlall +=" AND ";
					sqlall += "(FIND_IN_SET("+personnel.getPersonlabel()+",pt.zslabel1) OR FIND_IN_SET("+personnel.getPersonlabel()+",pt.lslabel1))";
				}else {
					String[] attributes=personnel.getPersonlabel().split(",");
					for (int i = 0; i < attributes.length; i++) {
						if(i>0)sqlall += " OR ";
						sqlall += "(FIND_IN_SET("+attributes[i]+",pt.zslabel1) OR FIND_IN_SET("+attributes[i]+",pt.lslabel1))";
					}
				}
			}
			if(personneltype1!=null&&!"".equals(personneltype1)){
				if(!personneltype1.contains(",")){
					if (sqlall!="")sqlall +=" AND ";
					//sqlall += "FIND_IN_SET("+personneltype1+",wgt.personneltype)";
					sqlall += "FIND_IN_SET("+personneltype1+",IFNULL((SELECT wgt.personneltype FROM p_wen_grade_t wgt WHERE wgt.personnelid=pt.id AND wgt.validflag>0 LIMIT 1),0))";
				}else {
					String[] typeStrings=personneltype1.split(",");
					if (sqlall!="")sqlall +=" AND ";
					for(int i=0;i<typeStrings.length;i++){
						if(i!=0)sqlall+=" OR ";
						//sqlall +="FIND_IN_SET("+typeStrings[i]+",wgt.personneltype)"; 
						sqlall +="FIND_IN_SET("+typeStrings[i]+",IFNULL((SELECT wgt.personneltype FROM p_wen_grade_t wgt WHERE wgt.personnelid=pt.id AND wgt.validflag>0 LIMIT 1),0))"; 
					}
				}
			}
			if(personneltype4!=null&&!"".equals(personneltype4)){
				if(!personneltype4.contains(",")){
					if (sqlall!="")sqlall +=" AND ";
					//sqlall += "FIND_IN_SET("+personneltype4+",det.personneltype)";
					sqlall += "FIND_IN_SET("+personneltype4+",IFNULL((SELECT det.personneltype FROM p_du_extend_t det WHERE det.personnelid=pt.id AND det.validflag>0 LIMIT 1),0))";
				}else {
					String[] typeStrings=personneltype4.split(",");
					if (sqlall!="")sqlall +=" AND ";
					for(int i=0;i<typeStrings.length;i++){
						if(i!=0)sqlall+=" OR ";
						//sqlall +="FIND_IN_SET("+typeStrings[i]+",det.personneltype)"; 
						sqlall +="FIND_IN_SET("+typeStrings[i]+",IFNULL((SELECT det.personneltype FROM p_du_extend_t det WHERE det.personnelid=pt.id AND det.validflag>0 LIMIT 1),0))"; 
					}
				}
			}
			System.out.println("===sql===="+sqlall);
			personnel.setSqlall(sqlall);
			NewPageModel pagelist = personnelDao.getAllPersonnel(personnel, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total", pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询人员信息");
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
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 包含 '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 包含 '" + personnel.getPersontype() + "'";
				}
			}
			if(personnel.getMarrystatus() != null && !"".equals(personnel.getMarrystatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "婚姻状态 包含 '" + personnel.getMarrystatus() + "'";
				}else{
					operate_Condition += " and 婚姻状态 包含 '" + personnel.getMarrystatus() + "'";
				}
			}
			if(personnel.getEducation() != null && !"".equals(personnel.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 包含 '" + personnel.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 包含 '" + personnel.getEducation() + "'";
				}
			}
			if(personnel.getSoldierstatus() != null && !"".equals(personnel.getSoldierstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "兵役情况 = '" + personnel.getSoldierstatus() + "'";
				}else{
					operate_Condition += " and 兵役情况 = '" + personnel.getSoldierstatus() + "'";
				}
			}
			if(personnel.getHeathstatus() != null && !"".equals(personnel.getHeathstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "健康状态 = '" + personnel.getHeathstatus() + "'";
				}else{
					operate_Condition += " and 健康状态 = '" + personnel.getHeathstatus() + "'";
				}
			}
			if(personnel.getPoliticalposition() != null && !"".equals(personnel.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + personnel.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + personnel.getPoliticalposition() + "'";
				}
			}
			if(personnel.getFaith() != null && !"".equals(personnel.getFaith())){
				if("".equals(operate_Condition)){
					operate_Condition += "宗教信仰 = '" + personnel.getFaith() + "'";
				}else{
					operate_Condition += " and 宗教信仰 = '" + personnel.getFaith() + "'";
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
			log.setOperate_Name("查询人员信息");
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
			if(personnel.getNation() != null && !"".equals(personnel.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + personnel.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + personnel.getNation() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 包含 '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 包含 '" + personnel.getPersontype() + "'";
				}
			}
			if(personnel.getMarrystatus() != null && !"".equals(personnel.getMarrystatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "婚姻状态 包含 '" + personnel.getMarrystatus() + "'";
				}else{
					operate_Condition += " and 婚姻状态 包含 '" + personnel.getMarrystatus() + "'";
				}
			}
			if(personnel.getEducation() != null && !"".equals(personnel.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 包含 '" + personnel.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 包含 '" + personnel.getEducation() + "'";
				}
			}
			if(personnel.getSoldierstatus() != null && !"".equals(personnel.getSoldierstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "兵役情况 = '" + personnel.getSoldierstatus() + "'";
				}else{
					operate_Condition += " and 兵役情况 = '" + personnel.getSoldierstatus() + "'";
				}
			}
			if(personnel.getHeathstatus() != null && !"".equals(personnel.getHeathstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "健康状态 = '" + personnel.getHeathstatus() + "'";
				}else{
					operate_Condition += " and 健康状态 = '" + personnel.getHeathstatus() + "'";
				}
			}
			if(personnel.getPoliticalposition() != null && !"".equals(personnel.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + personnel.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + personnel.getPoliticalposition() + "'";
				}
			}
			if(personnel.getFaith() != null && !"".equals(personnel.getFaith())){
				if("".equals(operate_Condition)){
					operate_Condition += "宗教信仰 = '" + personnel.getFaith() + "'";
				}else{
					operate_Condition += " and 宗教信仰 = '" + personnel.getFaith() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/allpersonshowinfo.do")
	public String allpersonshowinfo(int personnelid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Personnel personnel=personnelDao.getById(personnelid);
		model.addAttribute("personnel",personnel);
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询人员信息");
		String operate_Condition = "";
		operate_Condition += "人员id = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return "/allpersonshowinfo";
	}
	
	@RequestMapping("/getPersonnelByCardnumber.do")
	@ResponseBody
	public Personnel getPersonnelByCardnumber(Personnel personnel,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		try {
			int id=personnelDao.findPersonInPersonnel(personnel.getCardnumber());
			personnel=personnelDao.getById(id);
			if(personnel==null)personnel=new Personnel();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据身份证查询人员信息");
			String operate_Condition = "";
			operate_Condition += "人员身份证 = '" + personnel.getCardnumber() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据身份证查询人员信息");
			String operate_Condition = "";
			operate_Condition += "人员身份证 = '" + personnel.getCardnumber() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return personnel;
	}
	
	@RequestMapping("/checkPersonnelCardnumber.do")
	@ResponseBody
	public Map<String, Object> checkPersonnelCardnumber(String cardnumber){
		boolean flag = false;
		Map<String,Object> map = new HashMap<String, Object>();
		int num = personnelDao.findPersonInPersonnel(cardnumber);
		if(num>0){
			flag = true;
			map.put("personnel",personnelDao.getById(num));
		}
		map.put("flag", flag);
		return map;
	}
	@RequestMapping("/searchWholePersonnel.do")
	@ResponseBody
	public Map<String, Object> searchWholePersonnel(Personnel personnel, NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			if(userSession.getLoginRoleMsgFilter()==1){
				switch (userSession.getLoginRoleFieldFilter()) {
				case 1:
					personnel.setUnitFilter(userSession.getLoginUserDepartmentid());
					break;
				case 2:
					personnel.setPersonFilter(userSession.getLoginUserID());
					break;
				}	
			}
			String sqlall="";
			if (personnel.getAttributelabels()!=null&!"".equals(personnel.getAttributelabels())) {
				if (!personnel.getAttributelabels().contains(",")) {
					if (sqlall!="")sqlall +=" AND ";
					sqlall += "(FIND_IN_SET("+personnel.getAttributelabels()+",pt.zslabel1) OR FIND_IN_SET("+personnel.getAttributelabels()+",pt.zslabel2))";
				}else {
					String[] attributes=personnel.getAttributelabels().split(",");
					for (int i = 0; i < attributes.length; i++) {
						if(i>0)sqlall += " OR ";
						sqlall += "(FIND_IN_SET("+attributes[i]+",pt.zslabel1) OR FIND_IN_SET("+attributes[i]+",pt.zslabel2))";
					}
				}
			}
			personnel.setSqlall(sqlall);
			personnel.setAddoperatorid(userSession.getLoginUserID());
			NewPageModel pagelist = personnelDao.getWholePersonnel(personnel, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			result.put("allpagenum", pagelist.getAllpagenum());
			result.put("total", pagelist.getTotal());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询所有人员信息");
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
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 包含 '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 包含 '" + personnel.getPersontype() + "'";
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
			log.setOperate_Name("查询所有人员信息");
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
			if(personnel.getHomeplace() != null && !"".equals(personnel.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnel.getHomeplace() + "'";
				}
			}
			if(personnel.getPersontype() != null && !"".equals(personnel.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 包含 '" + personnel.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 包含 '" + personnel.getPersontype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	@RequestMapping("/addWholePersonel.do")
	public @ResponseBody String addWholePersonel(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addWholePersonel.do.......................");
		try {
			/*****风险人员主表添加*****/
			User jurisdictpolice1=userDao.getById(Integer.parseInt(personnel.getJdpolice1()));
			personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
			personnel.setPphone1(jurisdictpolice1.getContactnumber());
			personnel.setValidflag(1);
			personnel.setAddoperator(userSession.getLoginUserName());
			personnel.setAddoperatorid(userSession.getLoginUserID());
			personnel.setAddtime(addtime);
			int typeflag=Integer.parseInt(personnel.getZslabel1());
			if(typeflag==2){
				personnel.setZslabel1("");
				personnel.setLslabel1("2");
			}else if (typeflag==9&&userSession.getLoginRoleMsgFilter()==1) {
//				personnel.setZslabel1("");
//				personnel.setLslabel1("9");
			}else {
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
			}
			int personid=personnelDao.add(personnel);
			/*****默认添加空关联信息*****/
			Relation relation=new Relation();
		    relation.setPersonnelid(personid);
		    relationDao.addrelation(relation);
			
		    switch (typeflag) {
			case 1:
				/*****涉稳人员子表添加*****/
				WenGrade wenGrade=new WenGrade();
				wenGrade.setPersonnelid(personid);
				wenGrade.setValidflag(1);
				wenGrade.setJurisdictpolice1(0);
				wenGrade.setJurisdictunit1(0);
				wenGrade.setResponsiblepolice("0");
				wenGrade.setAddoperator(userSession.getLoginUserName());
				wenGrade.setAddtime(addtime);
				wenGradeDao.add(wenGrade);
				
				/*****涉稳人员维护率表添加*****/
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(1);//添加标签 涉稳-1
				maintainrate.setPersonnelid(personid);
				maintainrateDao.add(maintainrate);
				
				HashMap<String,Object> map=new HashMap<String,Object>();
	    		map.put("in_personnelid", personid);
	    		maintainrateDao.updateMaintainrateByPersonnelid(map);
				break;
			case 2:
				System.out.println("-----新增涉恐人员");
				/*****提交标签审核*****/
				Applylabel applylabel = new Applylabel();
				applylabel.setPersonnelid(personnel.getId());
				applylabel.setApplytype(1);
				applylabel.setValidflag(1);
				applylabel.setAdddepartmentid(userSession.getLoginUserDepartmentid());
				applylabel.setAddoperatorid(userSession.getLoginUserID());
				applylabel.setAddoperator(userSession.getLoginUserName());
				applylabel.setAddtime(TimeFormate.getISOTimeToNow());
				applylabel.setApplylabel1("2");
				applylabel.setApplylabel1name("涉恐标签");
				applylabel.setApplyreason("风险人员新增");
				applylabelDao.add(applylabel);
				//给领悟消息中心推送
				HashMap<String,Object> map1=new HashMap<String,Object>();
				String toIds = personnelDao.getUserCodeForSendChat(2);
				String content = "【风控平台-涉恐人员-新增】"+userSession.getLoginUserName()+"申请增加涉恐人员:"+personnel.getPersonname()+
				",待审核";
				map1.put("event", content);
				content = new String(URLEncoder.encode(content, "UTF-8").getBytes());
				//System.out.println(content);
				String param="fromId="+userSession.getLoginUserCode()+"&toIds="+toIds+"&content="+content;
				String url = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param;
			    SendChat sendchat=new SendChat();
				String result=sendchat.doHttpGet(url);
                System.out.println("领悟消息中心接口发送========"+result);
                
//                map1.put("user_tag", userSession.getLoginUserCode());//发送人
//				map1.put("jsf_tag", toIds);//接受人
//				String parame=JSONObject.fromObject(map1).toString();
//				System.out.println("方正消息中心接口参数========parame="+parame);
//				//String fzresult=sendchat.doHttpPost("http://50.66.189.145:9014/api/szsh/saveSzshSjNotFj", parame);//测试
//				String fzresult=sendchat.doHttpPost("http://50.64.128.56:9004/api/szsh/saveSzshSjNotFj", parame);
//				System.out.println("方正消息中心接口发送========fzresult="+fzresult);
				
//				KongExtend  kongextend=new KongExtend();
//				kongextend.setPersonnelid(personid);
//				kongextend.setJointtype(0);
//				kongextend.setControltime(3);
//				kongextend.setIncontrollevel("在控");
//				kongextend.setJurisdictpolice1("0");
//				kongextend.setJurisdictpolice2("0");
//				kongextend.setJurisdictunit1("0");
//				kongextend.setJurisdictunit2("0");
//				kongextend.setAddoperator(userSession.getLoginUserName());
//				kongextend.setAddtime(addtime);
//				kongextend.setValidflag(1);
//				if(kongextend.getJurisdictunit1().equals("0")&&kongextend.getJurisdictunit2().equals("0")){
//					kongextend.setIsassign(1);
//				}else{
//					 kongextend.setIsassign(2);
//				}
//				kongExtendDao.add(kongextend);
				break;
			case 3:
				/*****涉黑人员子表添加*****/
				HeiEditor heieditor=new HeiEditor();
				heieditor.setPersonnelid(personid);
				heieditor.setIncontrolleve(0);//默认插入关注中......
				heieditor.setValidflag(1);
				heieditor.setAddoperator(userSession.getLoginUserName());
				heieditor.setAddoperatorid(userSession.getLoginUserID());
				heieditor.setAddtime(addtime);
				heiEditorDao.add(heieditor);
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				break;
			case 4:
				/*****涉毒人员子表添加*****/
				DuExtend duextend=new DuExtend();
				duextend.setPersonneltype(Integer.parseInt(personnel.getPersonneltype()));
				duextend.setCaredperson(1);
				duextend.setValidflag(1);
				duextend.setPersonnelid(personid);
				duextend.setAddoperator(userSession.getLoginUserName());
				duextend.setAddtime(addtime);
			    duextendDao.addduextend(duextend);
				break;
			default:
				if(1==2&&typeflag==9&&userSession.getLoginRoleMsgFilter()==1){//暂时不用
					System.out.println("-----新增政保人员");
					/*****提交标签审核*****/
					Applylabel applylabel9 = new Applylabel();
					applylabel9.setPersonnelid(personnel.getId());
					applylabel9.setApplytype(1);
					applylabel9.setValidflag(1);
					applylabel9.setAdddepartmentid(userSession.getLoginUserDepartmentid());
					applylabel9.setAddoperatorid(userSession.getLoginUserID());
					applylabel9.setAddoperator(userSession.getLoginUserName());
					applylabel9.setAddtime(TimeFormate.getISOTimeToNow());
					applylabel9.setApplylabel1("9");
					applylabel9.setApplylabel1name("政保人员");
					applylabel9.setApplyreason("风险人员-政保人员-新增");
					applylabelDao.add(applylabel9);
					//给领悟消息中心推送
					HashMap<String,Object> map9=new HashMap<String,Object>();
					String toIds9 = personnelDao.getUserCodeForSendChat(9);
					String content9 = "【风控平台-政保人员-新增】"+userSession.getLoginUserName()+"申请增加政保人员:"+personnel.getPersonname()+
					",待审核";
					map9.put("event", content9);
					content9 = new String(URLEncoder.encode(content9, "UTF-8").getBytes());
					//System.out.println(content);
					String param9="fromId="+userSession.getLoginUserCode()+"&toIds="+toIds9+"&content="+content9;
					String url9 = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param9;
					SendChat sendchat9=new SendChat();
					String result9=sendchat9.doHttpGet(url9);
					System.out.println("领悟消息中心接口发送========"+result9);
				}else{
					PersonnelExtend personnelExtend=new PersonnelExtend();
					personnelExtend.setPersonlabelid(typeflag);
					personnelExtend.setPersonnelid(personid);
					personnelExtend.setJurisdictpolice1(0);
					personnelExtend.setJurisdictunit1(0);
					personnelExtend.setValidflag(1);
					personnelExtend.setAddoperator(userSession.getLoginUserName());
					personnelExtend.setAddtime(addtime);
					extendDao.add(personnelExtend);
				}
				break;
			}
		    
			message= new Message("true","风险人员-添加成功！");
			message.setFlag(personid);
			logDao.recordLog(menuid, "风险人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addWholePersonel.do.......................添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加风险人员信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","风险人员-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addWholePersonel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加风险人员信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateWholePersonnel.do")
	public @ResponseBody String updateWholePersonnel(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatePersonnelExtend.do.......................");
		try {
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.update(personnel);
			
			message = new Message("true","风险人员-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid,"风险人员-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatePersonnelExtend.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改风险人员信息");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","风险人员-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatePersonnelExtend.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改风险人员信息");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getRootAttributeLabel.do")
	public void  getRootAttributeLabel(HttpServletResponse response){
		try{
			List<AttributeLabel> attributeLabelList = personnelDao.getAttributeLabelByParentid(0);
			JSONArray json=JSONArray.fromObject(attributeLabelList);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}   
	}
	
	@RequestMapping("/getChildrenLabelByParentid.do")
	public void  getChildrenLabelByParentid(int parentid,HttpServletResponse response){
		try{
			List<AttributeLabel> attributeLabelList = personnelDao.getChildrenLabelByParentid(parentid);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON_New(attributeLabelList, "attributelabel","", "parentid", true,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}   
	}
	
	@RequestMapping("/applyAttribbuteLabel.do")
	public @ResponseBody String applyAttribbuteLabel(String addjson,Personnel personnel,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		try {
			Personnel tempPersonnel = personnelDao.getById(personnel.getId());
			if(((tempPersonnel.getLslabel1()!=null&&!"".equals(tempPersonnel.getLslabel1()))||(tempPersonnel.getLslabel2()!=null&&!"".equals(tempPersonnel.getLslabel2())))&&!"[]".equals(addjson)){
				message = new Message("true","还有标签正在审核中,不能添加！");
				message.setFlag(-1);
			}else{
				JSONArray jsonArray = JSONArray.fromObject(addjson);
				String temp1="";
				String temp2="";
				for(int i=0;i<jsonArray.size();i++){
					if("".equals(temp1)){
						temp1=String.valueOf(jsonArray.getJSONObject(i).getInt("attribute1"));
					}else{
						temp1=temp1+","+jsonArray.getJSONObject(i).getInt("attribute1");
					}
					if("".equals(temp2)){
						temp2=jsonArray.getJSONObject(i).getString("attribute2");
					}else{
						String attribute2 = jsonArray.getJSONObject(i).getString("attribute2");
						if(!"".equals(attribute2)){
							temp2 = temp2+","+attribute2;
						}
					}
				}
				personnel.setLslabel1(temp1);
				personnel.setLslabel2(temp2);
				personnelDao.updateAllPersonLabel(personnel);
				//提交审核
				if(!"".equals(temp1)){
					Applylabel applylabel = new Applylabel();
					applylabel.setPersonnelid(personnel.getId());
					applylabel.setApplytype(1);
					applylabel.setValidflag(1);
					applylabel.setAdddepartmentid(userSession.getLoginUserDepartmentid());
					applylabel.setAddoperatorid(userSession.getLoginUserID());
					applylabel.setAddoperator(userSession.getLoginUserName());
					applylabel.setAddtime(TimeFormate.getISOTimeToNow());
					for(int i=0;i<jsonArray.size();i++){
						applylabel.setApplylabel1(String.valueOf(jsonArray.getJSONObject(i).getInt("attribute1")));
						applylabel.setApplylabel2(jsonArray.getJSONObject(i).getString("attribute2"));
						applylabel.setApplylabel1name(jsonArray.getJSONObject(i).getString("applylabel1name"));
						applylabel.setApplylabel2name(jsonArray.getJSONObject(i).getString("applylabel2name"));
						applylabel.setApplyreason(jsonArray.getJSONObject(i).getString("reason"));
						applylabelDao.add(applylabel);
						HashMap<String,Object> map1=new HashMap<String,Object>();
						//给领悟消息中心推送
						String toIds = personnelDao.getUserCodeForSendChat(jsonArray.getJSONObject(i).getInt("attribute1"));
						Personnel personnelname = personnelDao.getById(personnel.getId());
						String content = "【风控平台-人员标签-新增】"+userSession.getLoginUserName()+"申请给风险人员:"+personnelname.getPersonname()+
						",增加一级标签-"+jsonArray.getJSONObject(i).getString("applylabel1name")+",待审核";
						map1.put("event", content);
						content = new String(URLEncoder.encode(content, "UTF-8").getBytes());
						//System.out.println(content);
						String param="fromId="+userSession.getLoginUserCode()+"&toIds="+toIds+"&content="+content;
						String url = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param;
					    SendChat sendchat=new SendChat();
						String result=sendchat.doHttpGet(url);
                        System.out.println("领悟消息中心接口发送========"+result);
                        
//                        map1.put("user_tag", userSession.getLoginUserCode());//发送人
//        				map1.put("jsf_tag", toIds);//接受人
//        				String parame=JSONObject.fromObject(map1).toString();
//        				System.out.println("方正消息中心接口参数========parame="+parame);
//        				//String fzresult=sendchat.doHttpPost("http://50.66.189.145:9014/api/szsh/saveSzshSjNotFj", parame);//测试
//        				String fzresult=sendchat.doHttpPost("http://50.64.128.56:9004/api/szsh/saveSzshSjNotFj", parame);
//        				System.out.println("方正消息中心接口发送========fzresult="+fzresult);
                        
                        
					}
					message = new Message("true","标签已提交审核！");
					message.setFlag(1);
					//生成操作日志
					UserActionLog log = CreateLogXML.AssignUserLog(userSession);
					log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
					log.setOperate_Result("1");	//0：失败 1：成功
					log.setOperate_Name("标签提交审核");
					String operate_Condition = "";
					operate_Condition += "人员id = '" + personnel.getId() + "'";
					log.setOperate_Condition(operate_Condition);
					log.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(log);
				}else{
					message = new Message("true","标签修改成功！");
					message.setFlag(1);
					//生成操作日志
					UserActionLog log = CreateLogXML.AssignUserLog(userSession);
					log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
					log.setOperate_Result("1");	//0：失败 1：成功
					log.setOperate_Name("标签修改");
					String operate_Condition = "";
					operate_Condition += "人员id = '" + personnel.getId() + "'";
					log.setOperate_Condition(operate_Condition);
					log.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(log);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("true","标签修改失败！");
			message.setFlag(-1);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("标签修改");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getApplylabelByPersonnel.do")
	@ResponseBody
	public Applylabel getApplylabelByPersonnel(Applylabel applylabel,ModelMap model) throws Exception{
		applylabel=applylabelDao.getByPerson(applylabel);
		return applylabel;
	}
	
	@RequestMapping("/searchApplylabel.do")
	@ResponseBody
	public Map<String,Object> searchApplylabel(Applylabel applylabel,NewPageModel pm,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = applylabelDao.search(applylabel, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/checkApplylabel.do")
	@ResponseBody
	public String checkApplylabel(Applylabel applylabel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			applylabel.setExamineman(userSession.getLoginUserName());
			applylabel.setExaminemanid(userSession.getLoginUserID());
			applylabel.setExaminetime(addtime);
			applylabelDao.check(applylabel);
			Personnel person=personnelDao.getById(applylabel.getPersonnelid());
			if(person.getZslabel1()==null){
				person.setZslabel1("");
			}
			if(person.getZslabel2()==null){
				person.setZslabel2("");
			}
			if(person.getLslabel1()==null){
				person.setLslabel1("");
			}
			if(person.getLslabel2()==null){
				person.setLslabel2("");
			}
			if(applylabel.getExamineflag()==1){
				//审核通过
				String zslabel1 = person.getZslabel1();
				String zslabel2 = person.getZslabel2();
				String lslabel1 = ","+person.getLslabel1()+",";
				String lslabel2 = ","+person.getLslabel2()+",";
				String applylabel1 = applylabel.getApplylabel1();
				String applylabel2 = applylabel.getApplylabel2();
				if(zslabel1!=null&&!"".equals(zslabel1)){
					person.setZslabel1(zslabel1+","+applylabel1);
				}else{
					person.setZslabel1(applylabel1);
				}
				if(zslabel2!=null&&!"".equals(zslabel2)){
					person.setZslabel2(zslabel2+","+applylabel2);
				}else{
					person.setZslabel2(applylabel2);
				}
				String lslabel1temp = lslabel1.replace(","+applylabel1+",", ",");
				if(lslabel1temp.length()>1){
					person.setLslabel1((lslabel1temp.substring(1, lslabel1temp.length()-1)));
				}else{
					person.setLslabel1("");
				}
				String[] lslabel2sz = applylabel2.split(",");
				for(int i=0;i<lslabel2sz.length;i++){
					lslabel2=lslabel2.replace(","+lslabel2sz[i]+",", ",");
				}
				if(lslabel2.length()>1){
					person.setLslabel2(lslabel2.substring(1, lslabel2.length()-1));
				}else{
					person.setLslabel2("");
				}
				personnelDao.updateCheckedPersonLabel(person);
				
				//人员子表更新
				switch (Integer.parseInt(applylabel1)) {
				case 1:
					/*****涉稳人员子表添加*****/
					WenGrade wenGrade=new WenGrade();
					wenGrade.setPersonnelid(applylabel.getPersonnelid());
					wenGrade.setValidflag(1);
					wenGrade.setJurisdictpolice1(0);
					wenGrade.setJurisdictunit1(0);
					wenGrade.setResponsiblepolice("0");
					wenGrade.setAddoperator(userSession.getLoginUserName());
					wenGrade.setAddtime(addtime);
					wenGradeDao.add(wenGrade);
					
					/*****涉稳人员维护率表添加*****/
					Maintainrate maintainrate=new Maintainrate();
					maintainrate.setPersonlabel(1);//添加标签 涉稳-1
					maintainrate.setPersonnelid(applylabel.getPersonnelid());
					maintainrateDao.add(maintainrate);
					
					HashMap<String,Object> map=new HashMap<String,Object>();
		    		map.put("in_personnelid", applylabel.getPersonnelid());
		    		maintainrateDao.updateMaintainrateByPersonnelid(map);
					break;
				case 2:
					/*****涉恐人员子表添加*****/
					KongExtend  kongextend=new KongExtend();
					kongextend.setPersonnelid(applylabel.getPersonnelid());
					kongextend.setIncontrollevel("在控");
					kongextend.setJointtype(0);
					kongextend.setControltime(3);
					kongextend.setJurisdictpolice1("0");
					kongextend.setJurisdictpolice2("0");
					kongextend.setJurisdictunit1("0");
					kongextend.setJurisdictunit2("0");
					kongextend.setAddoperator(userSession.getLoginUserName());
					kongextend.setAddtime(addtime);
					kongextend.setValidflag(1);
					if(kongextend.getJurisdictunit1().equals("0")&&kongextend.getJurisdictunit2().equals("0")){
						kongextend.setIsassign(1);
					}else{
						 kongextend.setIsassign(2);
					}
					kongExtendDao.add(kongextend);
					break;
				case 3:
					/*****涉黑人员子表添加*****/
					HeiEditor heieditor=new HeiEditor();
					heieditor.setPersonnelid(applylabel.getPersonnelid());
					heieditor.setIncontrolleve(0);//默认插入关注中......
					heieditor.setValidflag(1);
					heieditor.setAddoperator(userSession.getLoginUserName());
					heieditor.setAddoperatorid(userSession.getLoginUserID());
					heieditor.setAddtime(addtime);
					heiEditorDao.add(heieditor);
					/*****修改社会关系中人员风险类别*****/
					SocialRelations socialrelations=new SocialRelations();
					socialrelations.setUpdateoperator(userSession.getLoginUserName());
					socialrelations.setUpdatetime(addtime);
					socialrelations.setCardnumber(applylabel.getCardnumber());
					relationDao.updateriskpersonnel(socialrelations);
					break;
				case 4:
					/*****涉毒人员子表添加*****/
					DuExtend duextend=new DuExtend();
					duextend.setPersonneltype(Integer.parseInt(applylabel.getPersonneltype()));
					duextend.setCaredperson(1);
					duextend.setValidflag(1);
					duextend.setPersonnelid(applylabel.getPersonnelid());
					duextend.setAddoperator(userSession.getLoginUserName());
					duextend.setAddtime(addtime);
				    duextendDao.addduextend(duextend);
					break;
				default:
					PersonnelExtend personnelExtend=new PersonnelExtend();
					personnelExtend.setPersonlabelid(Integer.parseInt(applylabel1));
					personnelExtend.setPersonnelid(applylabel.getPersonnelid());
					personnelExtend.setJurisdictpolice1(0);
					personnelExtend.setJurisdictunit1(0);
					personnelExtend.setValidflag(1);
					personnelExtend.setAddoperator(userSession.getLoginUserName());
					personnelExtend.setAddtime(addtime);
					extendDao.add(personnelExtend);
					break;
				}
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
			}else if(applylabel.getExamineflag()==2){
				//审核不通过,删除临时标志位
				String lslabel1 = ","+person.getLslabel1()+",";
				String lslabel2 = ","+person.getLslabel2()+",";
				String applylabel1 = applylabel.getApplylabel1();
				String applylabel2 = applylabel.getApplylabel2();
				String lslabel1temp = lslabel1.replace(","+applylabel1+",", ",");
				if(lslabel1temp.length()>1){
					person.setLslabel1((lslabel1temp.substring(1, lslabel1temp.length()-1)));
				}else{
					person.setLslabel1("");
				}
				String[] lslabel2sz = applylabel2.split(",");
				for(int i=0;i<lslabel2sz.length;i++){
					lslabel2=lslabel2.replace(","+lslabel2sz[i]+",", ",");
				}
				if(lslabel2.length()>1){
					person.setLslabel2(lslabel2.substring(1, lslabel2.length()-1));
				}else{
					person.setLslabel2("");
				}
				personnelDao.updateCheckedPersonLabel(person);
			}
			message= new Message("true","审核成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "审核成功", userSession.getLoginUserName(), addtime, "审核成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("审核人员标签");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + person.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","审核失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "审核失败", userSession.getLoginUserName(), addtime, "审核失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("审核人员标签");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + applylabel.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getFengxianSecurityDist.post")
	public String getFengxianSecurityDist(ModelMap model,int menuid){
		try {
			model.addAttribute("menuid", menuid);
			//按人员标签统计
			List<SelectModel> attributelabels=personnelDao.getAllCountByAttributelabel("非访人员,涉军人员,利益受损,极端风险,电诈风险,精神障碍,问题青少年");
			model.addAttribute("attributelabels", JSONArray.fromObject(attributelabels).toString());
			//选出最大值
			int max = 0;
			for(int i=0;i<attributelabels.size();i++){
				int value = Integer.parseInt(attributelabels.get(i).getValue());
				if(value>max){
					max = value;
				}
			}
			ArrayList<SelectModel> indicator = new ArrayList<SelectModel>();
			for(int i=0;i<attributelabels.size();i++){
				SelectModel tempModel = new SelectModel();
				tempModel.setName(attributelabels.get(i).getName());
				tempModel.setMax(max);
				indicator.add(tempModel);
			}
			model.addAttribute("indicator", JSONArray.fromObject(indicator).toString());
			int allcount=personnelDao.countAllPersonnel(new Personnel());
			model.addAttribute("allcount", allcount);
			List<MapModel> mapdatas=personnelDao.countAllMapPersonnel();
			model.addAttribute("mapdatas", JSONArray.fromObject(mapdatas).toString());
			List<MapModel> trenddatas=personnelDao.countAllTrendPersonnel();
			model.addAttribute("trenddatas", JSONArray.fromObject(trenddatas).toString());
			int wencount=wenGradeDao.countWenGrade(new WenGrade());
			model.addAttribute("wencount", wencount);
			//按涉稳状态统计
			List<SelectModel> incontrollevels=personnelDao.getAllCountByIncontrollevel("在控,临控,在京,在宁,下落不明,不在控");
			model.addAttribute("incontrollevels", JSONArray.fromObject(incontrollevels).toString());
			//按涉稳级别统计
			List<SelectModel> jointcontrollevels=personnelDao.getAllCountByJointcontrollevel("一级,二级,三级");
			model.addAttribute("jointcontrollevels", JSONArray.fromObject(jointcontrollevels).toString());
			String controllevelone="";
			String controlleveltwo="";
			String controllevelthree="";
			for(int i=0;i<jointcontrollevels.size();i++){
				if("一级".equals(jointcontrollevels.get(i).getText())){
					controllevelone = jointcontrollevels.get(i).getValue();
				}else if("二级".equals(jointcontrollevels.get(i).getText())){
					controlleveltwo = jointcontrollevels.get(i).getValue();
				}else if("三级".equals(jointcontrollevels.get(i).getText())){
					controllevelthree  = jointcontrollevels.get(i).getValue();
				}
			}
			model.addAttribute("controllevelone", controllevelone);
			model.addAttribute("controlleveltwo", controlleveltwo);
			model.addAttribute("controllevelthree", controllevelthree);
			//级别调整统计
			int todayLevelAdjustCount = wenGradeDao.countTodayLevelAdjust();
			model.addAttribute("todayLevelAdjustCount", todayLevelAdjustCount);
			int todayLevelUpCount = wenGradeDao.countTodayLevelUp();
			model.addAttribute("todayLevelUpCount", todayLevelUpCount);
			int todayLevelDownCount = todayLevelAdjustCount-todayLevelUpCount;
			model.addAttribute("todayLevelDownCount", todayLevelDownCount);
			//按涉恐级别统计
			List<SelectModel> jointtypes=kongExtendDao.countDistpersonByJointtype();
			int kongcount=0;
			for (int i = 0; i < jointtypes.size(); i++) {
				kongcount+=Integer.parseInt(jointtypes.get(i).getValue());
				model.addAttribute("jointtype"+i, jointtypes.get(i).getValue());
			}
			model.addAttribute("kongcount", kongcount);
			model.addAttribute("jointtypes", JSONArray.fromObject(jointtypes).toString());
			//按籍贯统计
			List<SelectModel> nativeplaces=kongExtendDao.countDistpersonByNativeplace();
			model.addAttribute("nativeplaces", JSONArray.fromObject(nativeplaces).toString());
			//按涉黑联控级别统计
			List<SelectModel> incontrolleves=heiEditorDao.countDistpersonByIncontrolleve();
			int heicount=0;
			for (int i = 0; i < incontrolleves.size(); i++) {
				heicount+=Integer.parseInt(incontrolleves.get(i).getValue());
			}
			model.addAttribute("heicount", heicount);
			model.addAttribute("incontrolleves", JSONArray.fromObject(incontrolleves).toString());
			//按涉毒联控级别统计
			List<DuModel> dujointcontrollevels=duextendDao.countDistDuPersonByJointcontrollevel();
			model.addAttribute("dujointcontrollevels", JSONArray.fromObject(dujointcontrollevels).toString());
			int ducount=duextendDao.countDuPersonnel(new DuExtend());
			model.addAttribute("ducount", ducount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/security-dist/fengxian";
	}
	@RequestMapping("/getQuanjingSecurityDist.post")
	public String getQuanjingSecurityDist(ModelMap model,int menuid){
		try {
			model.addAttribute("menuid", menuid);
			DecimalFormat df=new DecimalFormat("0.0");
			int allcount=personnelDao.countAllPersonnel(new Personnel());
			model.addAttribute("allpersoncount", allcount);
			int wencount=wenGradeDao.countWenGrade(new WenGrade());
			model.addAttribute("wencount", wencount);
			model.addAttribute("wenpercent", df.format((float)wencount/allcount*100));
			//按涉恐级别统计
			List<SelectModel> jointtypes=kongExtendDao.countDistpersonByJointtype();
			int kongcount=0;
			for (int i = 0; i < jointtypes.size(); i++) {
				kongcount+=Integer.parseInt(jointtypes.get(i).getValue());
			}
			model.addAttribute("kongcount", kongcount);
			model.addAttribute("kongpercent", df.format((float)kongcount/allcount*100));
			List<SelectModel> incontrolleves=heiEditorDao.countDistpersonByIncontrolleve();
			int heicount=0;
			for (int i = 0; i < incontrolleves.size(); i++) {
				heicount+=Integer.parseInt(incontrolleves.get(i).getValue());
			}
			model.addAttribute("heicount", heicount);
			model.addAttribute("heipercent", df.format((float)heicount/allcount*100));
			int ducount=duextendDao.countDuPersonnel(new DuExtend());
			model.addAttribute("ducount", ducount);
			model.addAttribute("dupercent", df.format((float)ducount/allcount*100));
			model.addAttribute("otherpersoncount", allcount-wencount-kongcount-heicount-ducount);
			model.addAttribute("otherpersonpercent", df.format((float)(allcount-wencount-kongcount-heicount-ducount)/allcount*100));
			
			List<MapModel> mapdatas=personnelDao.countAllpersonAndAllevent();
			model.addAttribute("mapdatas", JSONArray.fromObject(mapdatas).toString());
			List<MapModel> adddatas=personnelDao.countAllAddByAddtime();
			model.addAttribute("adddatas", adddatas);
			
			List<SelectModel> cdttypes=contradictionInfoDao.countByCdttype();
			model.addAttribute("cdttypes", JSONArray.fromObject(cdttypes).toString());
			//选出最大值
			int max = 0;
			for(int i=0;i<cdttypes.size();i++){
				int value = Integer.parseInt(cdttypes.get(i).getValue());
				if(value>max){
					max = value;
				}
			}
			ArrayList<SelectModel> indicator = new ArrayList<SelectModel>();
			for(int i=0;i<cdttypes.size();i++){
				SelectModel tempModel = new SelectModel();
				tempModel.setName(cdttypes.get(i).getName());
				tempModel.setMax(max);
				indicator.add(tempModel);
			}
			model.addAttribute("indicator", JSONArray.fromObject(indicator).toString());
			List<SelectModel> departments=contradictionInfoDao.countPersonAndEventByDepartment();
			model.addAttribute("departments", JSONArray.fromObject(departments).toString());
			List<SelectModel> cdtresults=contradictionInfoDao.countByCdtresult();
			int eventcount=0;
			for (int i = 0; i < cdtresults.size(); i++) {
				eventcount+=Integer.parseInt(cdtresults.get(i).getValue());
			}
			model.addAttribute("eventcount", eventcount);
			model.addAttribute("cdtresults", cdtresults);
			List<SelectModel> affecttypes=companyDao.countByAffecttype();
			int companycount=0;
			for (int i = 0; i < affecttypes.size(); i++) {
				companycount+=Integer.parseInt(affecttypes.get(i).getValue());
			}
			model.addAttribute("companycount", companycount);
			model.addAttribute("affecttypes", JSONArray.fromObject(affecttypes).toString());
			NewPageModel goods = dangerousItemDao.search(new DangerousItem(), new NewPageModel());
			int goodcount=dangerousItemDao.search_count(new DangerousItem());
			model.addAttribute("goodcount", goodcount);
			model.addAttribute("goods", goods.getRows().toArray());
			
			List<SelectModel> vehicletypes=vehicleDao.countByVehicletype();
			int vehiclecount=0;
			for (int i = 0; i < vehicletypes.size(); i++) {
				vehiclecount+=Integer.parseInt(vehicletypes.get(i).getValue());
			}
			model.addAttribute("vehiclecount", vehiclecount);
			model.addAttribute("vehicletypes", JSONArray.fromObject(vehicletypes).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/security-dist/quanjing";
	}
}

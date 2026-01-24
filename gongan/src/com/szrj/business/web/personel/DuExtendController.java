package com.szrj.business.web.personel;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import cn.afterturn.easypoi.entity.ImageEntity;
import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberCheck;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.DuExtendDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.PersonnelPhotoDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.DuCheckRecord;
import com.szrj.business.model.personel.DuExtend;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelPhoto;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationDriver;
import com.szrj.business.model.personel.RelationIdentity;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.SocialRelations;

@Controller
@SessionAttributes("userSession")
public class DuExtendController {
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private DuExtendDao duextendDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private PersonnelPhotoDao photoDao;
	@Autowired
	private KaKouDao kaKouDao;
	private
    @Value("#{configProperties.uploadFile_Pricture}")
    String uploadFile_Pricture;	//读配置文件中的文件上传路径
	
	
	@RequestMapping("/searchDuPersonnel.do")
	@ResponseBody
	public Map<String,Object>  searchDuPersonnel(DuExtend duextend,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    System.out.println("/searchDuPersonnel.do..............="+duextend.getCardnumber());
		  //是否需要根据角色过滤
			if(userSession.getLoginRoleMsgFilter()==1){
				switch (userSession.getLoginRoleFieldFilter()) {
				case 1:
					duextend.setUnitFilter(userSession.getLoginUserDepartmentid());
					break;
				case 2:
					duextend.setPersonFilter(userSession.getLoginUserID());
					break;
				}	
			}
			pm.setPageNumber(page);
		    NewPageModel listTemp=duextendDao.searchDuPersonnel(duextend, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉毒人员");
			String operate_Condition = "";
			if(duextend.getCardnumber() != null && !"".equals(duextend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + duextend.getCardnumber() + "'";
			}
			if(duextend.getPersonname() != null && !"".equals(duextend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + duextend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + duextend.getPersonname() + "'";
				}
			}
			if(duextend.getSexes() != null && !"".equals(duextend.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + duextend.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + duextend.getSexes() + "'";
				}
			}
			if(duextend.getNation() != null && !"".equals(duextend.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + duextend.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + duextend.getNation() + "'";
				}
			}
			if(duextend.getPtype() != null && !"".equals(duextend.getPtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 = '" + duextend.getPtype() + "'";
				}else{
					operate_Condition += " and 人员类别 = '" + duextend.getPtype() + "'";
				}
			}
			if(duextend.getHomeplace() != null && !"".equals(duextend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}
			}
			if(duextend.getIncontrollevel() != null && !"".equals(duextend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getJointcontrollevel() != null && !"".equals(duextend.getJointcontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}else{
					operate_Condition += " and 联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}
			}
			if(duextend.getNarcoticstype() != null && !"".equals(duextend.getNarcoticstype())){
				if("".equals(operate_Condition)){
					operate_Condition += "毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}else{
					operate_Condition += " and 毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}
			}
			if(duextend.getUnitname1() != null && !"".equals(duextend.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}
			}
			if(duextend.getControlstatus() != null && !"".equals(duextend.getControlstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}else{
					operate_Condition += " and 管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}
			}
			if(duextend.getAddtime() != null && !"".equals(duextend.getAddtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 LIKE '" + duextend.getAddtime() + "'";
				}else{
					operate_Condition += " and 添加时间 LIKE '" + duextend.getAddtime() + "'";
				}
			}
			if(duextend.getCaredperson() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getCasename() != null && !"".equals(duextend.getCasename())){
				if("".equals(operate_Condition)){
					operate_Condition += "案件名称 LIKE '" + duextend.getCasename() + "'";
				}else{
					operate_Condition += " and 案件名称 LIKE '" + duextend.getCasename() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	
	@RequestMapping("/addDuPersonel.do")
	public @ResponseBody String addDuPersonel(Personnel personnel,DuExtend duextend,String ybssid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addDuPersonel.do.......................");
		try {
			int findid=personnelDao.findPersonInPersonnel(personnel.getCardnumber());
			if(findid>0){
				Personnel person=personnelDao.getById(findid);//根据身份证号查询人员基本信息
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
				}
				User jurisdictpolice1=userDao.getById(duextend.getJurisdictpolice1());
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1!="")zslabel1+=",";
				zslabel1+="4";
				person.setJdunit1(duextend.getJurisdictunit1()+"");
				person.setJdpolice1(duextend.getJurisdictpolice1()+"");
				person.setPphone1(jurisdictpolice1.getContactnumber());
				person.setJdunit2(duextend.getJurisdictunit2()+"");
				person.setJdpolice2(null==duextend.getJurisdictpolice2()?"0":duextend.getJurisdictpolice2()+"");
				if(duextend.getJurisdictpolice2()!=null){
					User jurisdictpolice2=userDao.getById(Integer.parseInt(duextend.getJurisdictpolice2()));
					person.setPphone2(jurisdictpolice2.getContactnumber());
					duextend.setPolicephone2(jurisdictpolice2.getContactnumber());
				}
				person.setZslabel1(zslabel1);
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setUpdatetime(addtime);
				/*****一标三识数据关联*****/
				if(ybssid!=null&&!"".equals(ybssid)){
					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
					person.setNation(ybssPersonnel.getNation());
					person.setMarrystatus(ybssPersonnel.getMarrystatus());
					person.setEducation(ybssPersonnel.getEducation());
					person.setHouseplace(ybssPersonnel.getHouseplace());
					person.setHomeplace(ybssPersonnel.getHomeplace());
					person.setHomex(ybssPersonnel.getHomex());
					person.setHomey(ybssPersonnel.getHomey());
					person.setWorkplace(ybssPersonnel.getWorkplace());
					if(null!=ybssPersonnel.getTelnumber()&&!"".equals(ybssPersonnel.getTelnumber())){
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
				personnelDao.update(person);
				/*****添加涉毒子表信息*****/
				duextend.setPersonnelid(findid);
				duextend.setCaredperson(1);
				duextend.setPolicephone1(jurisdictpolice1.getContactnumber());
				duextend.setAddoperator(userSession.getLoginUserName());
				duextend.setAddtime(addtime);
			    duextendDao.addduextend(duextend);
			    
			    /*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
			    
				message= new Message("true","涉毒人员添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addDuPersonel.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("非风险人提升为涉毒人员");
				String operate_Condition = "";
				operate_Condition += "非风险人id = '" + personnel.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else{
				User jurisdictpolice1=userDao.getById(duextend.getJurisdictpolice1());
				/*****风险人员主表添加*****/
				personnel.setZslabel1("4");//标签 涉毒-4
				personnel.setJdunit1(duextend.getJurisdictunit1()+"");
		        personnel.setJdpolice1(duextend.getJurisdictpolice1()+"");
		        personnel.setPphone1(jurisdictpolice1.getContactnumber());
		        personnel.setJdunit2(duextend.getJurisdictunit2()+"");
		        personnel.setJdpolice2(null==duextend.getJurisdictpolice2()?"0":duextend.getJurisdictpolice2()+"");
		        if(duextend.getJurisdictpolice2()!=null){
					User jurisdictpolice2=userDao.getById(Integer.parseInt(duextend.getJurisdictpolice2()));
					personnel.setPphone2(jurisdictpolice2.getContactnumber());
					duextend.setPolicephone2(jurisdictpolice2.getContactnumber());
				}
		        personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
		        personnel.setValidflag(1);
		        personnel.setAddoperator(userSession.getLoginUserName());
		        personnel.setAddoperatorid(userSession.getLoginUserID());
		        personnel.setAddtime(addtime);
		        /*****一标三识数据关联*****/
				if(ybssid!=null&&!"".equals(ybssid)){
					Personnel ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
					personnel.setNation(ybssPersonnel.getNation());
					personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
					personnel.setEducation(ybssPersonnel.getEducation());
					personnel.setHouseplace(ybssPersonnel.getHouseplace());
					personnel.setHomeplace(ybssPersonnel.getHomeplace());
					personnel.setHomex(ybssPersonnel.getHomex());
					personnel.setHomey(ybssPersonnel.getHomey());
					personnel.setWorkplace(ybssPersonnel.getWorkplace());
					if(null!=ybssPersonnel.getTelnumber()&&!"".equals(ybssPersonnel.getTelnumber())){
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
				int personid=personnelDao.add(personnel);
				/*****默认添加空关联信息*****/
				Relation relation=new Relation();
			    relation.setPersonnelid(personid);
			    relationDao.addrelation(relation);
				/*****涉毒人员子表添加*****/
				duextend.setPersonnelid(personid);
				duextend.setPolicephone1(jurisdictpolice1.getContactnumber());
				duextend.setAddoperator(userSession.getLoginUserName());
				duextend.setAddtime(addtime);
				duextend.setCaredperson(1);
			    duextendDao.addduextend(duextend);
			    
			    /*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
			    
				logDao.recordLog(menuid, "风险人员-涉毒人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				message= new Message("true","涉毒人员添加成功！");
				message.setFlag(1);
				System.out.println("addDuPersonel.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("添加涉毒人员");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addDuPersonel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉毒人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getDuPersonelUpdate.do")
	public String getDuPersonelUpdate(DuExtend duextend,int menuid,String buttons,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getDuPersonelUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		model.addAttribute("buttons",buttons);
		try {
		    //获取基本信息
		     Personnel personnel=personnelDao.getById(duextend.getPersonnelid());
			 model.addAttribute("personnel",personnel);
			 int age=CardnumberInfo.getAge(personnel.getCardnumber());
			 model.addAttribute("age",age);
			 duextend=duextendDao.getDuExtendBypersonnelid(duextend.getPersonnelid());	//关联信息
			 model.addAttribute("duextend",duextend);
			 Relation relation=relationDao.searchrelation(duextend.getPersonnelid());	//关联信息
		     model.addAttribute("relation",relation);
			 if(page.equals("xidu_update")){
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
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				
				List<BasicMsg> actualstate=basicMsgDao.getByType(83);//现实表现
				model.addAttribute("actualstate",actualstate);
				List<BasicMsg> controlstatus=basicMsgDao.getByType(85);//管控状态
				model.addAttribute("controlstatus",controlstatus);
				
				url="/jsp/personel/du/xidu/update";
			}else  if(page.equals("xidu_showinfo")){
				url="/jsp/personel/du/xidu/showinfo";
			}else  if(page.equals("zhidu_update")){
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
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				
				List<BasicMsg> actualstate=basicMsgDao.getByType(86);//现实表现
				model.addAttribute("actualstate",actualstate);
				url="/jsp/personel/du/zhidu/update";
			}else  if(page.equals("all_update")){
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
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				
				List<BasicMsg> actualstate=basicMsgDao.getByType(86);//现实表现
				model.addAttribute("actualstate",actualstate);
				if(duextend.getPersonneltype()==1||duextend.getPersonneltype()==3){//风险人员类别  1-吸毒人员 2-制贩毒前科
					List<BasicMsg> actualstate1=basicMsgDao.getByType(83);//现实表现
					model.addAttribute("actualstate",actualstate1);
					List<BasicMsg> controlstatus=basicMsgDao.getByType(85);//管控状态
					model.addAttribute("controlstatus",controlstatus);
					url="/jsp/personel/du/xidu/update";
				}else if(duextend.getPersonneltype()==0){
					url="/jsp/personel/du/update";
				}else if(duextend.getPersonneltype()==2){
					List<BasicMsg> actualstate2=basicMsgDao.getByType(86);//现实表现
					model.addAttribute("actualstate",actualstate2);
				   url="/jsp/personel/du/zhidu/update";
				}
			} else{
				
				url="/jsp/personel/du/zhidu/showinfo";
			}    
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}	

	@RequestMapping("/updateDuPersonel.do")
	public @ResponseBody String updateDuPersonel(DuExtend duextend,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateDuPersonel.do.......................");
		try {
			duextend.setId(Integer.parseInt(duextend.getDuextendid()));
			duextend.setUpdateoperator(userSession.getLoginUserName());
			duextend.setUpdatetime(addtime);
			duextendDao.updatedupersonel(duextend);
			
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
//			personnelDao.update(personnel);
			personnelDao.updateSK(personnel);
			
			message = new Message("true","涉毒人员-基本信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-基本信息修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateDuPersonel.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改涉毒人员");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员-基本信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-基本信息修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateDuPersonel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改涉毒人员");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateduextend.do")
	public @ResponseBody String updateduextend(DuExtend duextend,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateduextend.do.......................");
		try {
			duextend.setUpdateoperator(userSession.getLoginUserName());
			duextend.setUpdatetime(addtime);
			duextendDao.updateduextend(duextend);
			
			personnel = personnelDao.getById(duextend.getPersonnelid());
			personnel.setJdpolice1(duextend.getJurisdictpolice1()+"");
			personnel.setJdunit1(duextend.getJurisdictunit1()+"");
			personnel.setPphone1(duextend.getPolicephone1());
			personnel.setJdpolice2(null==duextend.getJurisdictpolice2()?"0":duextend.getJurisdictpolice2()+"");
			personnel.setJdunit2(duextend.getJurisdictunit2()+"");
			personnel.setPphone2(duextend.getPolicephone2());
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.update(personnel);
			
			message = new Message("true","涉毒人员-分级分类信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "涉毒人员-分级分类信息修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateduextend.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员分级分类信息修改");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员-分级分类信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-分级分类信息修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateduextend.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员分级分类信息修改");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updateduextendXSBX.do")
	public @ResponseBody String updateduextendXSBX(DuExtend duextend,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateduextendXSBX.do.......................");
		try {
			duextend.setUpdateoperator(userSession.getLoginUserName());
			duextend.setUpdatetime(addtime);
			duextendDao.updateduextendXSBX(duextend);
			
			message = new Message("true","涉毒人员-现实表现修改成功！");
			message.setFlag(duextend.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-涉毒人员-现实表现修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateduextendXSBX.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员-现实表现修改");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员-现实表现修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-现实表现修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateduextendXSBX.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员-现实表现修改");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelDuPersonel.do")
	public @ResponseBody String cancelDuPersonel(DuExtend duextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelDuPersonel.do.......................");
		try {
			duextend.setUpdateoperator(userSession.getLoginUserName());
			duextend.setUpdatetime(addtime);
			duextendDao.cancelduextend(duextend);
			
			Personnel person=personnelDao.getById(duextend.getPersonnelid());
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
			int labelindex=Arrays.binarySearch(labelint,4);//涉毒-4
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex&&labelint[i]!=0){
					if(newlabel!="")newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			person.setZslabel1(newlabel);
			personnelDao.update(person);
			System.out.println("cancelDuPersonel.do.......................更新风险人员标签!!!!");
			/*if(newlabel.equals("")){
				if(person.getAttributelabels().equals("")){//人员属性标签为空 且 人员类型标签为空 即可彻底删除人员
					personnelDao.cancel(person);
					System.out.println("cancelWenGrade.do.......................同时删除风险人员!!!!");
				}else{//人员类型为空 但存在其他人员属性标签 不可删除
					person.setPersonlabel("");
					personnelDao.update(person);
				}
				
			}else {
				person.setPersonlabel(newlabel);
				personnelDao.update(person);
				System.out.println("cancelDuPersonel.do.......................更新风险人员标签!!!!");
			}*/
			
			message = new Message("true","涉毒人员-删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelDuPersonel.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员删除");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + duextend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员-删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelDuPersonel.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员删除");
			String operate_Condition = "";
			operate_Condition += "涉毒人员id = '" + duextend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/exportDuPersonnel.do")
	public void exportDuPersonnel(HttpServletResponse response,DuExtend duextend,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,
											String personnelfield,String personneltext,
											String gradefield,String gradetext,
											String relationfield,String relationtext,
										    String showfield,String showtext,
											int menuid){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportDuPersonnel.do.......................gradefield="+gradefield+"  gradetext"+gradetext+"  relationfield"+relationfield+"  relationtext"+relationtext+"  showfield"+showfield+"  showtext"+showtext);
		
		try {
			
			if(userSession.getLoginRoleMsgFilter()==1){
				switch (userSession.getLoginRoleFieldFilter()){
				case 1: 
					duextend.setUnitFilter(userSession.getLoginUserDepartmentid());
					break;
				case 2:
					duextend.setPersonFilter(userSession.getLoginUserID());
					break;
				}
			}
			
			List<DuExtend> list=duextendDao.searchDuPersonnelList(duextend);
			
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("风险人员(涉毒)信息.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet("涉毒人员");
				
				/*excel表单内容样式*/
				HSSFCellStyle border = wb.createCellStyle();
				border.setWrapText(true);
				border.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				border.setBorderRight(HSSFCellStyle.BORDER_THIN);
				border.setBorderTop(HSSFCellStyle.BORDER_THIN);
				border.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				border .setAlignment(HSSFCellStyle.ALIGN_CENTER);
				border.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				HSSFFont font3 = wb.createFont();
				font3.setFontName("宋体");
				font3.setFontHeightInPoints((short)10);
				border.setFont(font3);
				
				/*excel标题样式*/
				HSSFCellStyle style = wb.createCellStyle();
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				HSSFFont font = wb.createFont();
				font.setFontName("宋体");
				font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
				font.setFontHeightInPoints((short)14);
				style.setFont(font);
				
				/*excel表单内容的小标题样式*/
				HSSFCellStyle style2 = wb.createCellStyle();
				style2 .setAlignment(HSSFCellStyle.ALIGN_CENTER);
				style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				HSSFFont font2 = wb.createFont();
				font2.setFontName("宋体");
				font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
				font2.setFontHeightInPoints((short)10);
				style2.setFont(font2);
				
				/*勾选字段解析*/
				String[] personnelfieldStrings=personnelfield.split(",");
				String[] personneltextStrings=personneltext.split(",");
				int personnellength=personnelfieldStrings.length;
				
				String[] gradefieldStrings=gradefield.split(",");
				String[] gradetextStrings=gradetext.split(",");
				int gradelength=(gradefield!=""?gradefieldStrings.length:0);
				
				String[] relationfieldStrings=relationfield.split(",");
				String[] relationtextStrings=relationtext.split(",");
				int relationlength=(relationfield!=""?relationfieldStrings.length:0);
				
			    String[] showfieldStrings=showfield.split(",");
				String[] showtextStrings=showtext.split(",");
				int showlength=(showfield!=""?showfieldStrings.length:0);
				
				/*定义标题*/
				HSSFRow rowtitle = sheet.createRow(0);
				rowtitle.setHeightInPoints(40);
				CellRangeAddress r = new CellRangeAddress(0,0,0,personnellength+gradelength+relationlength+showlength);
				sheet.addMergedRegion(r);
				HSSFCell cellhead = rowtitle.createCell(0);
				HSSFRichTextString valuehead = new HSSFRichTextString("涉毒人员信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*定义副标题*/
				rowtitle=sheet.createRow(1);
				rowtitle.setHeightInPoints(30);
				/*基本信息*/
				int titlelength=personnellength;
				int personneltype=duextend.getPersonneltype();
				r=new CellRangeAddress(1,1,0,titlelength);
				sheet.addMergedRegion(r);
				cellhead = rowtitle.createCell(0);
				valuehead=new HSSFRichTextString("基本信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*可编辑人员信息*/
				if(gradelength>0){
					if(gradelength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+gradelength);						
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString(personneltype==1?"风险评估":"分类分级");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=gradelength;
				}
				/*现实表现*/
				if(showlength>0){
					if(showlength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+showlength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString(personneltype==1?"管控现状":"现实表现");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=showlength;
				}
				/*关联信息*/
				if(relationlength>0){
					if(relationlength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+relationlength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("关联信息");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=relationlength;
				}
			
				/*数据*/
				HSSFRow row;
				HSSFCell cell;
				HSSFRichTextString value;
				
				/*标题行*/
				row = sheet.createRow(2);
				row.setHeightInPoints(25);
				cell = row.createCell(0);
				value = new HSSFRichTextString("编号");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				for(int i=0;i<personnellength;i++){
					cell = row.createCell(i+1);
					value = new HSSFRichTextString(personneltextStrings[i]);
					cell.setCellValue(value);
					cell.setCellStyle(style2);
				}
				int cell2length=personnellength;
				if(gradelength>0){
					for(int i=0;i<gradelength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(gradetextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=gradelength;
				}
				if(showlength>0){
					for(int i=0;i<showlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(showtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=showlength;
				}
				if(relationlength>0){
					for(int i=0;i<relationlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(relationtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=relationlength;
				}
				
				/*数据行*/
				/*创建行*/
				for (int i = 0; i < list.size(); i++) {
					row = sheet.createRow(i+3);
					row.setHeightInPoints(60);
					cell = row.createCell(0);
					value = new HSSFRichTextString(String.valueOf(i+1));
					cell.setCellValue(value);
					cell.setCellStyle(border);
					int cellindex=0;
					JSONObject node=JSONObject.fromObject(list.get(i).getExportPersonnel());
				
					for (int j = 0; j < personnellength; j++) {
						if(j==1){
							sheet.setColumnWidth(cellindex+j+1, 5000);
						}else{
							sheet.setColumnWidth(cellindex+j+1, 3000);
						}
						
						cell = row.createCell(cellindex+j+1);
						String celltext=node.get(personnelfieldStrings[j]).toString();
						//System.out.println("j="+j+"   celltext= "+celltext );
					    value = new HSSFRichTextString(celltext);
						cell.setCellValue(value);
						cell.setCellStyle(border);
						if(personnelfieldStrings[j].equals("cardnumber")){
							String ageString=String.valueOf(CardnumberInfo.getAge(node.get(personnelfieldStrings[j]).toString()));
							j++;
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(ageString);
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
					}
					cellindex+=personnellength;
					
					if(gradelength>0){
						node=JSONObject.fromObject(list.get(i));
						for (int j = 0; j < gradelength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 5000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(gradefieldStrings[j]).toString());
							if(gradefieldStrings[j].equals("caredperson")){
								if (Integer.parseInt(node.get(gradefieldStrings[j]).toString())==1)value = new HSSFRichTextString("否");
								if (Integer.parseInt(node.get(gradefieldStrings[j]).toString())==2)value = new HSSFRichTextString("是");
								if (Integer.parseInt(node.get(gradefieldStrings[j]).toString())==0)value = new HSSFRichTextString("");
							}
							if(gradefieldStrings[j].equals("controlstatus")){
								value = new HSSFRichTextString(node.get(gradefieldStrings[j]).toString().replace(",", "\r\n"));
							}
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=gradelength;
					}
					if(showlength>0){
						node=JSONObject.fromObject(list.get(i));
						for (int j = 0; j < showlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 6000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(showfieldStrings[j]).toString());
							if(showfieldStrings[j].equals("actualstate")){
								value = new HSSFRichTextString(node.get(showfieldStrings[j]).toString().replace(",", "\r\n"));
							}
							if(showfieldStrings[j].equals("yesorno")){
								String yesornoString=","+node.get(showfieldStrings[j]).toString()+",";
								value = new HSSFRichTextString((yesornoString.indexOf(",1,")>=0?"是":"否"));
							}
							cell.setCellValue(value);
							cell.setCellStyle(border);
							if(showfieldStrings[j].equals("yesorno")){
								String yesornoString=","+node.get(showfieldStrings[j]).toString()+",";
								for (int j2 = 2; j2 < 6; j2++) {
									value = new HSSFRichTextString((yesornoString.indexOf(","+j2+",")>=0?"是":"否"));
									j++;
									sheet.setColumnWidth(cellindex+j+1, 6000);
									cell = row.createCell(cellindex+j+1);
									cell.setCellValue(value);
									cell.setCellStyle(border);
								}
							}
						}
						cellindex+=showlength;
					}
					if(relationlength>0){
						if(list.get(i).getExportRelation()!=null)node=JSONObject.fromObject(list.get(i).getExportRelation());
						else node=JSONObject.fromObject(new Relation());
						for (int j = 0; j < relationlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 4000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(relationfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=relationlength;
					}
					
				}
				
				message = new Message("true","涉毒人员导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
			}else {
				message = new Message("false","无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员导出");
			String operate_Condition = "";
			if(duextend.getCardnumber() != null && !"".equals(duextend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + duextend.getCardnumber() + "'";
			}
			if(duextend.getPersonname() != null && !"".equals(duextend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + duextend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + duextend.getPersonname() + "'";
				}
			}
			if(duextend.getSexes() != null && !"".equals(duextend.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + duextend.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + duextend.getSexes() + "'";
				}
			}
			if(duextend.getNation() != null && !"".equals(duextend.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + duextend.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + duextend.getNation() + "'";
				}
			}
			if(duextend.getPtype() != null && !"".equals(duextend.getPtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 = '" + duextend.getPtype() + "'";
				}else{
					operate_Condition += " and 人员类别 = '" + duextend.getPtype() + "'";
				}
			}
			if(duextend.getHomeplace() != null && !"".equals(duextend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}
			}
			if(duextend.getIncontrollevel() != null && !"".equals(duextend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getJointcontrollevel() != null && !"".equals(duextend.getJointcontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}else{
					operate_Condition += " and 联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}
			}
			if(duextend.getNarcoticstype() != null && !"".equals(duextend.getNarcoticstype())){
				if("".equals(operate_Condition)){
					operate_Condition += "毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}else{
					operate_Condition += " and 毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}
			}
			if(duextend.getUnitname1() != null && !"".equals(duextend.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}
			}
			if(duextend.getControlstatus() != null && !"".equals(duextend.getControlstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}else{
					operate_Condition += " and 管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}
			}
			if(duextend.getAddtime() != null && !"".equals(duextend.getAddtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 LIKE '" + duextend.getAddtime() + "'";
				}else{
					operate_Condition += " and 添加时间 LIKE '" + duextend.getAddtime() + "'";
				}
			}
			if(duextend.getCaredperson() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getCasename() != null && !"".equals(duextend.getCasename())){
				if("".equals(operate_Condition)){
					operate_Condition += "案件名称 LIKE '" + duextend.getCasename() + "'";
				}else{
					operate_Condition += " and 案件名称 LIKE '" + duextend.getCasename() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉毒人员导出失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-导出", userSession.getLoginUserName(), addtime, "导出失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员导出");
			String operate_Condition = "";
			if(duextend.getCardnumber() != null && !"".equals(duextend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + duextend.getCardnumber() + "'";
			}
			if(duextend.getPersonname() != null && !"".equals(duextend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + duextend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + duextend.getPersonname() + "'";
				}
			}
			if(duextend.getSexes() != null && !"".equals(duextend.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + duextend.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + duextend.getSexes() + "'";
				}
			}
			if(duextend.getNation() != null && !"".equals(duextend.getNation())){
				if("".equals(operate_Condition)){
					operate_Condition += "民族 = '" + duextend.getNation() + "'";
				}else{
					operate_Condition += " and 民族 = '" + duextend.getNation() + "'";
				}
			}
			if(duextend.getPtype() != null && !"".equals(duextend.getPtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 = '" + duextend.getPtype() + "'";
				}else{
					operate_Condition += " and 人员类别 = '" + duextend.getPtype() + "'";
				}
			}
			if(duextend.getHomeplace() != null && !"".equals(duextend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + duextend.getHomeplace() + "'";
				}
			}
			if(duextend.getIncontrollevel() != null && !"".equals(duextend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getJointcontrollevel() != null && !"".equals(duextend.getJointcontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}else{
					operate_Condition += " and 联控级别 = '" + duextend.getJointcontrollevel() + "'";
				}
			}
			if(duextend.getNarcoticstype() != null && !"".equals(duextend.getNarcoticstype())){
				if("".equals(operate_Condition)){
					operate_Condition += "毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}else{
					operate_Condition += " and 毒品种类 LIKE '" + duextend.getNarcoticstype() + "'";
				}
			}
			if(duextend.getUnitname1() != null && !"".equals(duextend.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位名称 LIKE '" + duextend.getUnitname1() + "'";
				}
			}
			if(duextend.getControlstatus() != null && !"".equals(duextend.getControlstatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}else{
					operate_Condition += " and 管控现状 LIKE '" + duextend.getControlstatus() + "'";
				}
			}
			if(duextend.getAddtime() != null && !"".equals(duextend.getAddtime())){
				if("".equals(operate_Condition)){
					operate_Condition += "添加时间 LIKE '" + duextend.getAddtime() + "'";
				}else{
					operate_Condition += " and 添加时间 LIKE '" + duextend.getAddtime() + "'";
				}
			}
			if(duextend.getCaredperson() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 是否平安关爱对象 = '" + duextend.getIncontrollevel() + "'";
				}
			}
			if(duextend.getCasename() != null && !"".equals(duextend.getCasename())){
				if("".equals(operate_Condition)){
					operate_Condition += "案件名称 LIKE '" + duextend.getCasename() + "'";
				}else{
					operate_Condition += " and 案件名称 LIKE '" + duextend.getCasename() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		//return JSONObject.fromObject(message).toString();
	}
	
	
	
	
	@RequestMapping("/getDuExtendByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getDuExtendByPersonnelid(int personnelid){
		System.out.println("getDuExtendByPersonnelid.do.......................查询");
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			 DuExtend duextend=duextendDao.getDuExtendBypersonnelid(personnelid);
			if(duextend==null)result.put("firstRisk",0);
			else result.put("firstRisk",1);
			result.put("duextend",duextend);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping("/searchducheckrecord.do")
	@ResponseBody
	public Map<String,Object>  searchducheckrecord(DuCheckRecord ducheckrecord,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		    System.out.println("/searchducheckrecord.do..............");
		    pm.setPageNumber(page);
		    NewPageModel listTemp=duextendDao.searchducheckrecord(ducheckrecord, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询涉毒人员联控记录信息");
			String operate_Condition = "";
			operate_Condition += "人员ID = '" + ducheckrecord.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	
	@RequestMapping("/addducheckrecord.do")
	public @ResponseBody String addducheckrecord(DuCheckRecord ducheckrecord,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    ducheckrecord.setAddtime(addtime);
			    ducheckrecord.setAddoperator(userSession.getLoginUserName());
			    duextendDao.addducheckrecord(ducheckrecord);
				message= new Message("true","涉毒人员-联控记录添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addducheckrecord.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉毒人员-联控记录添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉毒人员-联控记录添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addducheckrecord.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员-联控记录添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
	@RequestMapping("/updateducheckrecord.do")
	public @ResponseBody String updateducheckrecord(DuCheckRecord ducheckrecord,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    ducheckrecord.setUpdatetime(addtime);
			    ducheckrecord.setUpdateoperator(userSession.getLoginUserName());
			    duextendDao.updateducheckrecord(ducheckrecord);
				message= new Message("true","涉毒人员-联控记录修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录修改", userSession.getLoginUserName(), addtime, "修改成功", "");
				System.out.println("updateducheckrecord.do......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉毒人员-联控记录修改");
				String operate_Condition = "";
				operate_Condition += "联控记录id = '" + ducheckrecord.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉毒人员-联控记录修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateducheckrecord.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员-联控记录修改");
			String operate_Condition = "";
			operate_Condition += "联控记录id = '" + ducheckrecord.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	

	@RequestMapping("/cancelducheckrecord.do")
	public @ResponseBody String cancelducheckrecord(DuCheckRecord ducheckrecord,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			    ducheckrecord.setUpdatetime(addtime);
			    ducheckrecord.setUpdateoperator(userSession.getLoginUserName());
			    duextendDao.cancelducheckrecord(ducheckrecord);
				message= new Message("true","涉毒人员-联控记录删除成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录删除", userSession.getLoginUserName(), addtime, "删除成功", "");
				System.out.println("cancelducheckrecord.do......................删除成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉毒人员-联控记录删除");
				String operate_Condition = "";
				operate_Condition += "联控记录id = '" + ducheckrecord.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉毒人员-联控记录删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉毒人员-联控记录删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelducheckrecord.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉毒人员-联控记录删除");
			String operate_Condition = "";
			operate_Condition += "联控记录id = '" + ducheckrecord.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getDuCheckRecordByid.do")
	public String getDuCheckRecordByid(int id,String page,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getDuCheckRecordByid.do.................");
		DuCheckRecord ducheckrecord=duextendDao.getDuCheckRecordByid(id);
		model.addAttribute("ducheckrecord", ducheckrecord);
		String  urlString="";
		if(page.equals("update")){
			urlString="/jsp/personel/du/checkrecord/update";
		}else{
			urlString="/jsp/personel/du/checkrecord/showinfo";
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询涉毒人员联控记录");
		String operate_Condition = "";
		operate_Condition += "联控记录id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}	
	

	@RequestMapping("/importDuPersonel.do")
	@ResponseBody
    public   Map<String, Object>  importDuPersonel(HttpServletRequest request,HttpServletResponse response,int personneltype,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	Map<String, Object> json = new HashMap<String, Object>();  
    	String msg = "";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	System.out.println("importDuPersonel.do.......................");
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String addtime=dateFormat.format(new Date());
    	try{
    	  String fileName = myFile.getOriginalFilename();
          String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
          Sheet sheet;
          int totalRows=0;
            Workbook workbook=WorkbookFactory.create(myFile.getInputStream());
            sheet=workbook.getSheetAt(0);
            totalRows=sheet.getPhysicalNumberOfRows();//返回索引
            Row rowdata;
            System.out.println("importDuPersonel.do.......................fileName="+fileName+"   totalRows="+totalRows);
            for (int i =1; i < totalRows; i++) {
            	rowdata=sheet.getRow(i);
            	 int rownum=i+1;
            	 rowmsg=" 第2行 至 第"+totalRows+"行<br/>"; 
            	//System.out.println("开始读取.......................读取行号="+rownum+"   身份证号码="+rowdata.getCell(0).getStringCellValue());
            	 if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
              	   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){
              		   if(rownum>2)rowmsg=" 第2行 至 第"+i+"行<br/>"; 
              		   else rowmsg="<font color='red'>无数据导入</font><br/>";
              		   break;
              	   }
              	   btmsg+="第"+rownum+"行，第一列(身份证号)为必填项；"+"<br/>"; 
                 }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
              	   btmsg+="第"+rownum+"行，第二列(姓名)为必填项；"+"<br/>";
                 }else{  
              	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
              	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
              	   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
              		   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
                  	   if(findid>0){
                  		   btmsg+="第"+rownum+"行，第一列(身份证号)已存在；"+"<br/>";   //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
                  	   }else {
                  		   /*****风险人员主表添加*****/
                  		   Personnel person=new Personnel();
                  		   person.setCardnumber(rowdata.getCell(0).getStringCellValue().trim());
                  		   person.setPersonname(rowdata.getCell(1).getStringCellValue());
                  		   person.setZslabel1("4");//标签 涉毒-3
                  		   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
                  		   person.setValidflag(1);
                  		   person.setAddoperator(userSession.getLoginUserName());
                  		   person.setAddoperatorid(userSession.getLoginUserID());
                  		   person.setAddtime(addtime);
	                  		 if(userSession.getLoginRoleMsgFilter()==1){
	              			   person.setJdunit1(userSession.getLoginUserDepartmentid()+"");
	              			   person.setJdpolice1(userSession.getLoginUserID()+"");
	              			   person.setPphone1(userSession.getLoginContactnumber());
	              		   }
                  		   int personid=personnelDao.add(person);
                  		   person=personnelDao.getById(personid);
                  		   boolean personUpdate=false;
                  		   DuExtend duextend=new DuExtend();
                  		   if(rowdata.getCell(2)!=null){//曾用名
                  			   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setUsedname(rowdata.getCell(2).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(3)!=null){//绰号
                  			   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setNickname(rowdata.getCell(3).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(4)!=null){//身高
                  			   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setPersonheight(rowdata.getCell(4).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(5)!=null){//婚姻状况
                  			   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setMarrystatus(rowdata.getCell(5).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(6)!=null){//民族
                  			   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setNation(rowdata.getCell(6).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		
                  		   if(rowdata.getCell(7)!=null){//人员类别
                  			   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                  			   duextend.setPtype(rowdata.getCell(7).getStringCellValue());
//                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(8)!=null){//兵役状况
                  			   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setSoldierstatus(rowdata.getCell(8).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(9)!=null){//健康状态
                  			   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHeathstatus(rowdata.getCell(9).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(10)!=null){//政治面貌
                  			   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setPoliticalposition(rowdata.getCell(10).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(11)!=null){//宗教信仰
                  			   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setFaith(rowdata.getCell(11).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(12)!=null){//文化程度
                  			   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setEducation(rowdata.getCell(12).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(13)!=null){//网络社交技能习惯
                  			   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setNetskillhabit(rowdata.getCell(13).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(14)!=null){//户籍地详址
                  			   rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHouseplace(rowdata.getCell(14).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(15)!=null){//户籍地派出所
                  			   rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHousepolice(rowdata.getCell(15).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		  if(rowdata.getCell(16)!=null){//现住地详址
                 			   rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
                 			   person.setHomeplace(rowdata.getCell(16).getStringCellValue());
                 			   personUpdate=true;
                 		   }
                  		  if(rowdata.getCell(17)!=null){//现住地派出所
                			   rowdata.getCell(17).setCellType(Cell.CELL_TYPE_STRING);
                			   person.setHomepolice(rowdata.getCell(17).getStringCellValue());
                			   personUpdate=true;
                		   }
                  		 if(rowdata.getCell(18)!=null){//工作地详址
	              			   rowdata.getCell(18).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setWorkplace(rowdata.getCell(18).getStringCellValue());
	              			   personUpdate=true;
              		      }
                  		 if(rowdata.getCell(19)!=null){//工作地派出所
	              			   rowdata.getCell(19).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setWorkpolice(rowdata.getCell(19).getStringCellValue());
	              			   personUpdate=true;
            		      }
                  		 if(rowdata.getCell(20)!=null){//特殊特征
	              			   rowdata.getCell(20).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setFeature(rowdata.getCell(20).getStringCellValue());
	              			   personUpdate=true;
          		           }
                  		 if(rowdata.getCell(21)!=null){//技能专长
	              			   rowdata.getCell(21).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setSpeciality(rowdata.getCell(21).getStringCellValue());
	              			   personUpdate=true;
          		          }
                  		 if(rowdata.getCell(22)!=null){//前科劣迹
	              			   rowdata.getCell(22).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setRecords(rowdata.getCell(22).getStringCellValue());
	              			   personUpdate=true;
          		          }
                  		   if(personUpdate)personnelDao.update(person);
                  		   
                  		   /*****默认添加空关联信息*****/
                  		   Relation relation=new Relation();
                  		   relation.setPersonnelid(personid);
                  		   relationDao.addrelation(relation);
	                  	    /*****添加涉毒子表信息*****/
                  		    duextend.setPersonnelid(personid);
                  		    duextend.setAddoperator(userSession.getLoginUserName());
                  		    duextend.setAddtime(addtime);
                  		    duextend.setPersonneltype(personneltype);
                  		    duextend.setCaredperson(1);
                  		    duextend.setJurisdictunit1(userSession.getLoginUserDepartmentid());
                  		    duextend.setJurisdictpolice1(userSession.getLoginUserID());
                  		    duextend.setPolicephone1(userSession.getLoginContactnumber());
                  		    duextendDao.addduextend(duextend);
							/*****修改社会关系中人员风险类别*****/
							SocialRelations socialrelations=new SocialRelations();
							socialrelations.setUpdateoperator(userSession.getLoginUserName());
							socialrelations.setUpdatetime(addtime);
							socialrelations.setCardnumber(person.getCardnumber());
							relationDao.updateriskpersonnel(socialrelations);
   					    pCount++;
                  	   }
              	   }else {
              		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
              	   }
                 } 
            }
        	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
        	msg+="<tr><td>成功导入：</td><td>风险人员（涉毒）<font color='red'>"+pCount+"</font> 名</td></tr>";
        	if(btmsg!=""){
        		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
        		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
        	}
        	msg+="</table>";
            json.put("success",msg);
            logDao.recordLog(0, "风险人员-涉毒人员-信息导入", userSession.getLoginUserName(), addtime, "导出成功", "");
    } catch (Exception e) {
        e.printStackTrace();
        logDao.recordLog(0, "风险人员-涉毒人员-信息导入", userSession.getLoginUserName(), addtime, "导出失败", "");
    }   
       return json;  
    }
	
	@RequestMapping("/getDuStatistics.do")
	public String getDuStatistics(ModelMap model){
		try {
			//社会吸毒人员
			DuExtend duExtend = new DuExtend();
			duExtend.setPersonneltype(1);
			List<Personnel> personnelList = duextendDao.countDuPersonByPersontype(duExtend);
			for(int i=0;i<personnelList.size();i++){
				model.addAttribute(""+personnelList.get(i).getPersontype(), personnelList.get(i).getPersoncount());
			}
			//按派出所统计
			List<PieModel> unitList = duextendDao.countDuPersonByUnit(duExtend);
			List<String> policeList = new ArrayList<String>();
			List<Integer> policecountList = new ArrayList<Integer>();
			for(int i=0;i<unitList.size();i++){
				policeList.add(unitList.get(i).getName());
				policecountList.add(unitList.get(i).getValue());
			}
			model.addAttribute("policeList", JSONArray.fromObject(policeList).toString());
			model.addAttribute("policecountList", JSONArray.fromObject(policecountList).toString());
			//按联控级别统计
			List<PieModel> levelList = duextendDao.countDuPersonByJointcontrollevel(duExtend);
			model.addAttribute("levelList", JSONArray.fromObject(levelList).toString());
			//社会制贩毒人员
			duExtend.setPersonneltype(2);
			List<Personnel> zfdpersonnelList = duextendDao.countDuPersonByPersontype(duExtend);
			for(int i=0;i<zfdpersonnelList.size();i++){
				model.addAttribute("zfd"+zfdpersonnelList.get(i).getPersontype(), zfdpersonnelList.get(i).getPersoncount());
			}
			//按派出所统计
			List<PieModel> zfdunitList = duextendDao.countDuPersonByUnit(duExtend);
			List<String> zfdpoliceList = new ArrayList<String>();
			List<Integer> zfdpolicecountList = new ArrayList<Integer>();
			for(int i=0;i<zfdunitList.size();i++){
				zfdpoliceList.add(zfdunitList.get(i).getName());
				zfdpolicecountList.add(zfdunitList.get(i).getValue());
			}
			model.addAttribute("zfdpoliceList", JSONArray.fromObject(zfdpoliceList).toString());
			model.addAttribute("zfdpolicecountList", JSONArray.fromObject(zfdpolicecountList).toString());
			List<PieModel> zfdlevelList = duextendDao.countDuPersonByJointcontrollevel(duExtend);
			model.addAttribute("zfdlevelList", JSONArray.fromObject(zfdlevelList).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/chart/du/list";
	}
	
	@RequestMapping("/exportxidurenyuan.do")
	public void exportxidurenyuan(DuExtend duExtend,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession){
		try {
			System.out.println("exportxidurenyuan.do.......................");
			//模板位置
			String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\personel\\template\\xidu_new.xls";
			TemplateExportParams params = new TemplateExportParams(templateFileName,true);
			String nowtime = TimeFormate.getYMD();
			String[] time = nowtime.split("-");
			String year = time[0];
			String month = time[1];
			String day = time[2];
			Map<String,Object> map = new HashMap<String,Object>();
		
			//获取人员信息
			DuExtend exportDuExtend = duextendDao.exportxidurenyuan(duExtend);
			List<DuCheckRecord> lkList = duextendDao.exportxiduLiankong(exportDuExtend.getPersonnelid());
			
			if(exportDuExtend.getCardnumber()!= null){
				map.put("danwei", userSession.getLoginUserDepartname());
				map.put("year", year);
				map.put("month", month);
				map.put("day", day);
				map.put("checktime1", "_");
				map.put("checktime2", "_");
				map.put("checktime3", "_");
				map.put("checkmemo1", "_");
				map.put("checkmemo2", "_");
				map.put("checkmemo3", "_");
				map.put("checkman3", "_");
				map.put("checkunit3", "_");
				for(int i=0;i<lkList.size();i++){
					if("尿检".equals(lkList.get(i).getChecktype())){
						if(lkList.get(i).getChecktime()!=null && !"".equals(lkList.get(i).getChecktime())){
							map.put("checktime1", lkList.get(i).getChecktime());
						}
						if(lkList.get(i).getCheckcontent()!=null && !"".equals(lkList.get(i).getCheckcontent())){
							map.put("checkmemo1", lkList.get(i).getCheckcontent());
						}
					}else if("发检".equals(lkList.get(i).getChecktype())){
						if(lkList.get(i).getChecktime()!=null && !"".equals(lkList.get(i).getChecktime())){
							map.put("checktime2", lkList.get(i).getChecktime());
						}
						if(lkList.get(i).getCheckcontent()!=null && !"".equals(lkList.get(i).getCheckcontent())){
							map.put("checkmemo2", lkList.get(i).getCheckcontent());
						}
					}else if("走访".equals(lkList.get(i).getChecktype())){
						if(lkList.get(i).getChecktime()!=null && !"".equals(lkList.get(i).getChecktime())){
							map.put("checktime3", lkList.get(i).getChecktime());
						}
						if(lkList.get(i).getCheckcontent()!=null && !"".equals(lkList.get(i).getCheckcontent())){
							map.put("checkmemo3", lkList.get(i).getCheckcontent());
						}
						if(lkList.get(i).getCheckunit()!=null && !"".equals(lkList.get(i).getCheckunit())){
							map.put("checkunit3", lkList.get(i).getCheckunit());
						}
						if(lkList.get(i).getCheckman()!=null && !"".equals(lkList.get(i).getCheckman())){
							map.put("checkman3", lkList.get(i).getCheckman());
						}
					}
				}
				
				int personnelid = exportDuExtend.getPersonnelid();
				PersonnelPhoto pp = photoDao.exportByPersonnelid(personnelid);
				if(pp!=null && !"".equals(pp.getFileallName())){
					File file = new File(uploadFile_Pricture+"\\"+pp.getFileallName());
					if(file.exists()){
						ImageEntity image = new ImageEntity();
						image.setUrl(uploadFile_Pricture+"\\"+pp.getFileallName());
						map.put("image",image);
					}else{
						String imageUrlStr = request.getSession().getServletContext().getRealPath("")+"\\images\\nophoto.png";
						ImageEntity image = new ImageEntity();
						image.setUrl(imageUrlStr);
						map.put("image", image);
					}
				}
				map.put("image", " ");
				
				Relation relation=relationDao.searchrelation(personnelid);
				//手机号码
				if (relation.getTelnumber()!=null&&!"".equals(relation.getTelnumber())) {
					map.put("telnumber", relation.getTelnumber());
				}else {
					map.put("telnumber", " ");
				}
				//虚拟身份
				if (relation.getNetidentity()!=null&&!"".equals(relation.getNetidentity())) {
					List<RelationIdentity> list=relationDao.getrelationidentitybypersonnelid(personnelid);
					if(list.size()>0){
						String qq="";
						String wechat="";
						for (int j = 0; j < list.size(); j++) {
							RelationIdentity ri=list.get(j);
							if (ri.getIdentitytype().equals("QQ")) {
								if(ri.getAccountid()!=null&&!"".equals(ri.getAccountid())){
									if(!"".equals(qq))qq+=",";
									qq+=ri.getAccountid();
								}
							}
							if (ri.getIdentitytype().equals("微信")) {
								if(ri.getWechat()!=null&&!"".equals(ri.getWechat())){
									if(!"".equals(wechat))wechat+=",";
									wechat+=ri.getWechat();
								}
							}
						}
						if (!"".equals(qq))map.put("qq",qq);
						else map.put("qq", " ");
						if (!"".equals(wechat))map.put("wechat",wechat);
						else map.put("wechat", " ");
					}else {
						map.put("qq", " ");
						map.put("wechat", " ");
					}
				}else {
					map.put("qq", " ");
					map.put("wechat", " ");
				}
				//驾驶证件
				if (relation.getRelateddriver()!=null&&!"".equals(relation.getRelateddriver())) {
					List<RelationDriver> list=relationDao.getdriverbypersonnelid(personnelid);
					if (list.size()>0) {
						String drivertype="";
						for (int i = 0; i < list.size(); i++) {
							RelationDriver rd=list.get(i);
							if(!"".equals(drivertype))drivertype+=",";
							drivertype+=rd.getDrivertype();
							if (rd.getIsactivate()>0)drivertype+="(停用)";
							else drivertype+="(在用)";
						}
						map.put("driverflag", "是");
						map.put("drivertype", drivertype);
					}else {
						map.put("driverflag", "否");
						map.put("drivertype", " ");
					}
				}else {
					map.put("driverflag", "否");
					map.put("drivertype", " ");
				}
				//交通工具
				if (relation.getRelatedvehicle()!=null&&!"".equals(relation.getRelatedvehicle())) {
					List<RelationVehicle> list=relationDao.getNewRelationvehicle(personnelid);
					if (list.size()>0) {
						String vehiclebrand="";
						String vehiclenum="";
						for (int i = 0; i < list.size(); i++) {
							RelationVehicle rv=list.get(i);
							if(rv.getVehicletype().equals("小客车")){
								if(!"".equals(vehiclebrand))vehiclebrand+=",";
								if(rv.getVehiclebrand()!=null&&!"".equals(rv.getVehiclebrand()))vehiclebrand+=rv.getVehiclebrand();
								else vehiclebrand+="未填写";
								if(!"".equals(vehiclenum))vehiclenum+=",";
								if(rv.getVehiclenum()!=null&&!"".equals(rv.getVehiclenum()))vehiclenum+=rv.getVehiclenum();
								else vehiclenum+="未填写";
							}
						}
						map.put("carflag", "是");
						map.put("vehiclebrand", vehiclebrand);
						map.put("vehiclenum", vehiclenum);
					}else {
						map.put("carflag", "否");
						map.put("vehiclebrand", " ");
						map.put("vehiclenum", " ");
					}
				}else {
					map.put("carflag", "否");
					map.put("vehiclebrand", " ");
					map.put("vehiclenum", " ");
				}
				
				List<SocialRelations> srList=relationDao.getSocialrelationsByPersonnelid(personnelid);
				if(srList.size()>0){
					String socialrelations="";
					for (int i = 0; i < srList.size(); i++) {
						SocialRelations sr=srList.get(i);
						socialrelations+=sr.getRelationtype();
						socialrelations+="-";
						socialrelations+=sr.getAppellation();
						if (sr.getAppellation().equals("其他")&&sr.getMemo()!=null&&!"".equals(sr.getMemo())) {
							socialrelations+="(";
							socialrelations+=sr.getMemo();
							socialrelations+=")";
						}
						socialrelations+="-";
						socialrelations+=sr.getPersonname();
						socialrelations+="(";
						socialrelations+=sr.getCardnumber();
						socialrelations+=")\r\n";
					}
					map.put("socialrelations", socialrelations);
				}else {
					map.put("socialrelations", " ");
				}
				
				//人员类别
				if(exportDuExtend.getPtype()!=null && !"".equals(exportDuExtend.getPtype()) ){
					map.put("ptype", exportDuExtend.getPtype());
				}else{
					map.put("ptype", " ");
				}
				//姓名
				if(exportDuExtend.getPersonname()!=null && !"".equals(exportDuExtend.getPersonname()) ){
					map.put("personname", exportDuExtend.getPersonname());
				}else{
					map.put("personname", " ");
				}
				//性别
				if(exportDuExtend.getSexes()!=null && !"".equals(exportDuExtend.getSexes()) ){
					map.put("sexes", exportDuExtend.getSexes());
				}else{
					map.put("sexes", " ");
				}
				//绰号
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getNickname()!=null && !"".equals(exportDuExtend.getExportPersonnel().getNickname())){
					map.put("nickname", exportDuExtend.getExportPersonnel().getNickname());
				}else{
					map.put("nickname", " ");
				}
				//身份证号码+出生日期
				if(exportDuExtend.getCardnumber()!=null && !"".equals(exportDuExtend.getCardnumber()) ){
					map.put("cardnumber", exportDuExtend.getCardnumber());
					map.put("birthday", CardnumberInfo.getBirthDay(exportDuExtend.getCardnumber()));
				}else{
					map.put("cardnumber", " ");
					map.put("birthday", " ");
				}
				//民族
				if(exportDuExtend.getNation()!=null && !"".equals(exportDuExtend.getNation()!=null) ){
					map.put("nation", exportDuExtend.getNation());
				}else{
					map.put("nation", " ");
				}
				//文化程度
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getEducation()!=null && !"".equals(exportDuExtend.getExportPersonnel().getEducation()) ){
					map.put("education", exportDuExtend.getExportPersonnel().getEducation());
				}else{
					map.put("education", " ");
				}
				//婚姻状况
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getMarrystatus()!=null && !"".equals(exportDuExtend.getExportPersonnel().getMarrystatus()) ){
					map.put("marrystatus", exportDuExtend.getExportPersonnel().getMarrystatus());
				}else{
					map.put("marrystatus", " ");
				}
				//健康状态
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getHeathstatus()!=null && !"".equals(exportDuExtend.getExportPersonnel().getHeathstatus()) ){
					map.put("heathstatus", exportDuExtend.getExportPersonnel().getHeathstatus());
				}else{
					map.put("heathstatus", " ");
				}
				//身高
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getPersonheight() !=null && !"".equals(exportDuExtend.getExportPersonnel().getPersonheight()) ){
					map.put("personheight", exportDuExtend.getExportPersonnel().getPersonheight()+"cm");
				}else{
					map.put("personheight", " ");
				}
				//政治面貌
				if(exportDuExtend.getExportPersonnel()!=null &&exportDuExtend.getExportPersonnel().getPoliticalposition() !=null && !"".equals(exportDuExtend.getExportPersonnel().getPoliticalposition()) ){
					map.put("politicalposition", exportDuExtend.getExportPersonnel().getPoliticalposition());
				}else{
					map.put("politicalposition", " ");
				}
				//宗教信仰
				if(exportDuExtend.getExportPersonnel()!=null &&exportDuExtend.getExportPersonnel().getFaith() !=null && !"".equals(exportDuExtend.getExportPersonnel().getFaith()) ){
					map.put("faith", exportDuExtend.getExportPersonnel().getFaith());
				}else{
					map.put("faith", " ");
				}
				//兵役状况
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getSoldierstatus()!=null && !"".equals(exportDuExtend.getExportPersonnel().getSoldierstatus()) ){
					map.put("soldierstatus", exportDuExtend.getExportPersonnel().getSoldierstatus());
				}else{
					map.put("soldierstatus", " ");
				}
				//滥用毒品种类
				if(exportDuExtend.getNarcoticstype() !=null && !"".equals(exportDuExtend.getNarcoticstype()) ){
					map.put("narcoticstype", exportDuExtend.getNarcoticstype());
				}else{
					map.put("narcoticstype", " ");
				}
				//初次吸毒时间
				if(exportDuExtend.getFirsttime()!=null && !"".equals(exportDuExtend.getFirsttime()) ){
					map.put("firsttime", exportDuExtend.getFirsttime());
				}else{
					map.put("firsttime", " ");
				}
				//末次处罚时间
				if(exportDuExtend.getLasttime()!=null && !"".equals(exportDuExtend.getLasttime()) ){
					map.put("lasttime", exportDuExtend.getLasttime());
				}else{
					map.put("lasttime", " ");
				}
				//户籍地详细地址
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getHouseplace()!=null && !"".equals(exportDuExtend.getExportPersonnel().getHouseplace()) ){
					map.put("houseplace", exportDuExtend.getExportPersonnel().getHouseplace());
				}else{
					map.put("houseplace", " ");
				}
				//户籍地派出所
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getHousepolice() !=null && !"".equals(exportDuExtend.getExportPersonnel().getHousepolice()) ){
					map.put("housepolice", exportDuExtend.getExportPersonnel().getHousepolice());
				}else{
					map.put("housepolice", " ");
				}
				//现住地详细地址
				if(exportDuExtend.getExportPersonnel()!=null &&exportDuExtend.getExportPersonnel().getHomeplace() !=null && !"".equals(exportDuExtend.getExportPersonnel().getHomeplace()) ){
					map.put("homeplace", exportDuExtend.getExportPersonnel().getHomeplace());
				}else{
					map.put("homeplace", " ");
				}
				//现住地派出所
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getHomepolice() !=null && !"".equals(exportDuExtend.getExportPersonnel().getHomepolice()) ){
					map.put("homepolice", exportDuExtend.getExportPersonnel().getHomepolice());
				}else{
					map.put("homepolice", " ");
				}
				//工作地址
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getWorkplace()!=null && !"".equals(exportDuExtend.getExportPersonnel().getWorkplace()) ){
					map.put("workplace", exportDuExtend.getExportPersonnel().getWorkplace());
				}else{
					map.put("workplace", " ");
				}
				//工作地派出所
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getWorkpolice()!=null && !"".equals(exportDuExtend.getExportPersonnel().getWorkpolice()) ){
					map.put("workpolice", exportDuExtend.getExportPersonnel().getWorkpolice());
				}else{
					map.put("workpolice", " ");
				}
				//特征
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getFeature() !=null && !"".equals(exportDuExtend.getExportPersonnel().getFeature()) ){
					map.put("feature", exportDuExtend.getExportPersonnel().getFeature());
				}else{
					map.put("feature", " ");
				}
				//技能特长
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getSpeciality() !=null && !"".equals(exportDuExtend.getExportPersonnel().getSpeciality()) ){
					map.put("speciality", exportDuExtend.getExportPersonnel().getSpeciality());
				}else{
					map.put("speciality", " ");
				}
				//信息核查方式
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getCheckmethod() !=null && !"".equals(exportDuExtend.getExportPersonnel().getCheckmethod()) ){
					map.put("checkmethod", exportDuExtend.getExportPersonnel().getCheckmethod());
				}else{
					map.put("checkmethod", "无");
				}
				//前科
				if(exportDuExtend.getExportPersonnel()!=null && exportDuExtend.getExportPersonnel().getRecords()!=null && !"".equals(exportDuExtend.getExportPersonnel().getRecords()) ){
					map.put("records", exportDuExtend.getExportPersonnel().getRecords());
				}else{
					map.put("records", "无");
				}
				//管控类别
				if(exportDuExtend.getJointcontrollevel()!=null && !"".equals(exportDuExtend.getJointcontrollevel()) ){
					map.put("jointcontrollevel", exportDuExtend.getJointcontrollevel());
				}else{
					map.put("jointcontrollevel", " ");
				}
				//在控状态
				if(exportDuExtend.getIncontrollevel()!=null && !"".equals(exportDuExtend.getIncontrollevel()) ){
					map.put("incontrollevel", exportDuExtend.getIncontrollevel());
				}else{
					map.put("incontrollevel", " ");
				}
				//管控现状
				if(exportDuExtend.getControlstatus()!=null && !"".equals(exportDuExtend.getControlstatus()) ){
					map.put("controlstatus", exportDuExtend.getControlstatus().replace(",", "\r\n"));
				}else{
					map.put("controlstatus", "无");
				}
				//其他特殊状态
				if(exportDuExtend.getControlstatusmemo()!=null && !"".equals(exportDuExtend.getControlstatusmemo())){
					map.put("controlstatusmemo", exportDuExtend.getControlstatusmemo());
				}else{
					map.put("controlstatusmemo", " ");
				}
				map.put("controlstatusmemo", " ");
				//关爱对象
				if(exportDuExtend.getCaredperson()==1){
					map.put("caredperson", "否");
				}else{
					map.put("caredperson", "是");
				}
				//平安关爱措施
				if(exportDuExtend.getSafetyaction()!=null && !"".equals(exportDuExtend.getSafetyaction()) ){
					map.put("safetyaction", exportDuExtend.getSafetyaction());
				}else{
					map.put("safetyaction", " ");
				}
				//管控责任单位
				if(exportDuExtend.getUnitname1()!=null && !"".equals(exportDuExtend.getUnitname1()) ){
					map.put("unitname1", exportDuExtend.getUnitname1());
				}else{
					map.put("unitname1", " ");
				}
				//辖区民警
				if(exportDuExtend.getPolicename1()!=null && !"".equals(exportDuExtend.getPolicename1()) ){
					map.put("policename1", exportDuExtend.getPolicename1());
				}else{
					map.put("policename1", " ");
				}
				//手机号码
				if(exportDuExtend.getPolicephone1() !=null && !"".equals(exportDuExtend.getPolicephone1()) ){
					map.put("policephone1", exportDuExtend.getPolicephone1());
				}else{
					map.put("policephone1", " ");
				}
				//双管控单位
				if(exportDuExtend.getUnitname2() !=null && !"".equals(exportDuExtend.getUnitname2()) ){
					map.put("unitname2", exportDuExtend.getUnitname2());
				}else{
					map.put("unitname2", " ");
				}
				//双辖区民警
				if(exportDuExtend.getPolicename2()!=null && !"".equals(exportDuExtend.getPolicename2()) ){
					map.put("policename2", exportDuExtend.getPolicename2());
				}else{
					map.put("policename2", " ");
				}
				//手机号码
				if(exportDuExtend.getPolicephone2()!=null && !"".equals(exportDuExtend.getPolicephone2()) ){
					map.put("policephone2", exportDuExtend.getPolicephone1());
				}else{
					map.put("policephone2", " ");
				}
				//现实表现
				if(exportDuExtend.getActualstate()!=null && !"".equals(exportDuExtend.getActualstate()) ){
					map.put("actualstate", exportDuExtend.getActualstate().replace(",", "\r\n"));
				}else{
					map.put("actualstate", "无");
				}
				//现实情况具体说明
				if(exportDuExtend.getMemo() !=null && !"".equals(exportDuExtend.getMemo()) ){
					map.put("memo", exportDuExtend.getMemo());
				}else{
					map.put("memo", " ");
				}
				
				Workbook workbook = ExcelExportUtil.exportExcel(params, map);
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel");
				response.setCharacterEncoding("utf-8");
				/*设置输出文件名称*/
				String title = "涉毒_"+exportDuExtend.getPersonname()+"_"+TimeFormate.getISOTimeToNow2();
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".xls", "UTF-8"));
				OutputStream outputStream=response.getOutputStream();
				workbook.write(outputStream);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}

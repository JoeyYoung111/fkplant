package com.szrj.business.web.personel;

import java.io.IOException;
import java.io.InputStream;
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
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberCheck;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.aladdin.util.TreeSelect;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.dao.personel.ApplylabelDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.PersonnelExtendDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.Applylabel;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.CustomLabel;
import com.szrj.business.model.personel.CustomText;
import com.szrj.business.model.personel.Labelinfo;
import com.szrj.business.model.personel.PersonLabel;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelExtend;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.SocialRelations;

@Controller
@SessionAttributes("userSession")
public class PersonnelExtendController {
	@Autowired
	private PersonnelExtendDao extendDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private ApplylabelDao applylabelDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchPersonnelExtend.do")
	@ResponseBody
	public Map<String,Object> searchPersonnelExtend(PersonnelExtend personnelExtend,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		System.out.println("searchPersonnelExtend.do.................Attributelabels="+personnelExtend.getAttributelabels());
		//是否需要根据角色过滤
		if(userSession.getLoginRoleMsgFilter()==1){
			switch (userSession.getLoginRoleFieldFilter()) {
			case 1:
				personnelExtend.setUnitFilter(userSession.getLoginUserDepartmentid());//部门过滤
				break;
			case 2:
				personnelExtend.setPersonFilter(userSession.getLoginUserID());//民警过滤
				break;
			}	
		}
		String labelsql="";
		if (personnelExtend.getAttributelabels()!=null&!"".equals(personnelExtend.getAttributelabels())) {
			if (!personnelExtend.getAttributelabels().contains(",")) {
				if (labelsql!="")labelsql +=" AND ";
				labelsql += "FIND_IN_SET("+personnelExtend.getAttributelabels()+",pt.zslabel2)";
			}else {
				String[] attributes=personnelExtend.getAttributelabels().split(",");
				for (int i = 0; i < attributes.length; i++) {
					if(i>0)labelsql += " OR ";
					labelsql += "FIND_IN_SET("+attributes[i]+",pt.zslabel2)";
				}
			}
		}
		if(!"".equals(labelsql))personnelExtend.setLabelsql(labelsql);
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=extendDao.searchPersonnelExtend(personnelExtend, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询风险人员通用扩展信息");
			String operate_Condition = "";
			if(personnelExtend.getCardnumber() != null && !"".equals(personnelExtend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnelExtend.getCardnumber() + "'";
			}
			if(personnelExtend.getPersonname() != null && !"".equals(personnelExtend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}
			}
			if(personnelExtend.getTelnumber() != null && !"".equals(personnelExtend.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}
			}
			if(personnelExtend.getHomeplace() != null && !"".equals(personnelExtend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}
			}
			if(personnelExtend.getUnitname1() != null && !"".equals(personnelExtend.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位 包含 '" + personnelExtend.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位 包含 '" + personnelExtend.getUnitname1() + "'";
				}
			}
			if(personnelExtend.getPolicename1() != null && !"".equals(personnelExtend.getPolicename1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任民警名称 LIKE '" + personnelExtend.getPolicename1() + "'";
				}else{
					operate_Condition += " and 管辖责任民警名称 LIKE '" + personnelExtend.getPolicename1() + "'";
				}
			}
			if(personnelExtend.getIncontrollevel() != null && !"".equals(personnelExtend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}
			}
			if(personnelExtend.getPersontype() != null && !"".equals(personnelExtend.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}
			}
			if(personnelExtend.getPersonlabelid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类型表id LIKE '" + personnelExtend.getPersonlabelid() + "'";
				}else{
					operate_Condition += " and 人员类型表id LIKE '" + personnelExtend.getPersonlabelid() + "'";
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
			log.setOperate_Name("查询风险人员通用扩展信息");
			String operate_Condition = "";
			if(personnelExtend.getCardnumber() != null && !"".equals(personnelExtend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnelExtend.getCardnumber() + "'";
			}
			if(personnelExtend.getPersonname() != null && !"".equals(personnelExtend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}
			}
			if(personnelExtend.getTelnumber() != null && !"".equals(personnelExtend.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}
			}
			if(personnelExtend.getHomeplace() != null && !"".equals(personnelExtend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}
			}
			if(personnelExtend.getUnitname1() != null && !"".equals(personnelExtend.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位 包含 '" + personnelExtend.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位 包含 '" + personnelExtend.getUnitname1() + "'";
				}
			}
			if(personnelExtend.getPolicename1() != null && !"".equals(personnelExtend.getPolicename1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任民警名称 LIKE '" + personnelExtend.getPolicename1() + "'";
				}else{
					operate_Condition += " and 管辖责任民警名称 LIKE '" + personnelExtend.getPolicename1() + "'";
				}
			}
			if(personnelExtend.getIncontrollevel() != null && !"".equals(personnelExtend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}
			}
			if(personnelExtend.getPersontype() != null && !"".equals(personnelExtend.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}
			}
			if(personnelExtend.getPersonlabelid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类型表id LIKE '" + personnelExtend.getPersonlabelid() + "'";
				}else{
					operate_Condition += " and 人员类型表id LIKE '" + personnelExtend.getPersonlabelid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	@RequestMapping("/getPersonnelExtendUpdate.do")
	public String getPersonnelExtendUpdate(PersonnelExtend extend,int menuid,String buttons,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getPersonnelExtendUpdate.do.................page="+page);
		String url="";
		model.addAttribute("menuid",menuid);
		model.addAttribute("buttons",buttons);
		try {
			if(page.equals("add")){
				url="/jsp/personel/custom/add";
				
				model.addAttribute("jurisdictunit1",userSession.getLoginUserDepartmentid());
				model.addAttribute("jurisdictppolice1",userSession.getLoginUserID());
				
				model.addAttribute("personnelExtend",extend);
			}else if (page.equals("addothers")) {
				url="/jsp/personel/others/add";
				
				model.addAttribute("jurisdictunit1",userSession.getLoginUserDepartmentid());
				model.addAttribute("jurisdictppolice1",userSession.getLoginUserID());
				
				model.addAttribute("personnelExtend",extend);
			}else if (page.equals("update")) {
				url="/jsp/personel/custom/update";
				
				PersonnelExtend personnelExtend=new PersonnelExtend();
				if(extend.getId()>0)personnelExtend=extendDao.getById(extend.getId());//获取分类分级信息
				else if(extend.getPersonnelid()>0)personnelExtend=extendDao.getByPersonnelid(extend);
				personnelExtend.setPersonlabelid(extend.getPersonlabelid());
//				if(extend.getPersonlabelid()==0){
//					String attributesql="";
//					String[] attributelabelString=personnelExtend.getAttributelabels().split(",");
//					for (int i = 0; i < attributelabelString.length; i++) {
//						if(!attributesql.equals(""))attributesql+=" OR ";
//						attributesql+="FIND_IN_SET("+attributelabelString[i]+",attributelabels)";
//					}
//					PersonLabel sqlLabel=personnelDao.getPersonLabelsByAttributesql(attributesql);
//					personnelExtend.setLabelsql(sqlLabel.getAttributelabels());
//					personnelExtend.setMemo(sqlLabel.getMemo());
//				}
				model.addAttribute("personnelExtend",personnelExtend);
				Personnel personnel=personnelDao.getById(personnelExtend.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
				int age=CardnumberInfo.getAge(personnel.getCardnumber());
				if(age==0)age=CardnumberInfo.getAgeByBirthday(personnelExtend.getBirthday());
				model.addAttribute("age",age);
				
				CustomText customText=new CustomText();
				int customTextid=personnelDao.getCustomtextidBypersonnelid(personnel.getId());
				if(customTextid>0)customText=personnelDao.getCustomtextByid(customTextid);
				model.addAttribute("customTextid",customTextid);
				model.addAttribute("customText",customText);
				
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
				
				List<BasicMsg> jointcontrollevel=basicMsgDao.getByType(47);//涉稳-联控级别
				model.addAttribute("jointcontrollevel",jointcontrollevel);
				
				List<BasicMsg> incontrollevel=basicMsgDao.getByType(22);//通用-在控状态
				model.addAttribute("incontrollevel",incontrollevel);
				
				//社会关系
				Relation relation=relationDao.searchrelation(personnelExtend.getPersonnelid());
				model.addAttribute("relation",relation);
			}else if (page.equals("update_zhengbao")) {//政保专题
				url="/jsp/personel/zhengbao/update";
				
				PersonnelExtend personnelExtend=new PersonnelExtend();
				if(extend.getId()>0)personnelExtend=extendDao.getById(extend.getId());//获取分类分级信息
				else if(extend.getPersonnelid()>0)personnelExtend=extendDao.getByPersonnelid(extend);
				personnelExtend.setPersonlabelid(extend.getPersonlabelid());
//				if(extend.getPersonlabelid()==0){
//					String attributesql="";
//					String[] attributelabelString=personnelExtend.getAttributelabels().split(",");
//					for (int i = 0; i < attributelabelString.length; i++) {
//						if(!attributesql.equals(""))attributesql+=" OR ";
//						attributesql+="FIND_IN_SET("+attributelabelString[i]+",attributelabels)";
//					}
//					PersonLabel sqlLabel=personnelDao.getPersonLabelsByAttributesql(attributesql);
//					personnelExtend.setLabelsql(sqlLabel.getAttributelabels());
//					personnelExtend.setMemo(sqlLabel.getMemo());
//				}
				model.addAttribute("personnelExtend",personnelExtend);
				Personnel personnel=personnelDao.getById(personnelExtend.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
				int age=CardnumberInfo.getAge(personnel.getCardnumber());
				if(age==0)age=CardnumberInfo.getAgeByBirthday(personnelExtend.getBirthday()!=null?personnelExtend.getBirthday():"");
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
				
				List<BasicMsg> persontype=basicMsgDao.getByType(20);//通用-人员类别
				model.addAttribute("persontype",persontype);
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				
				List<BasicMsg> jointcontrollevel=basicMsgDao.getByType(96);//政保-联控级别
				model.addAttribute("jointcontrollevel",jointcontrollevel);
				
				List<BasicMsg> incontrollevel=basicMsgDao.getByType(97);//政保-在控状态
				model.addAttribute("incontrollevel",incontrollevel);
				
				//社会关系
				Relation relation=relationDao.searchrelation(personnelExtend.getPersonnelid());
				model.addAttribute("relation",relation);
			}else if(page.equals("showinfo")){
               url="/jsp/personel/custom/showinfo";
				
               	PersonnelExtend personnelExtend=new PersonnelExtend();
				if(extend.getId()>0)personnelExtend=extendDao.getById(extend.getId());//获取分类分级信息
				else if(extend.getPersonnelid()>0)personnelExtend=extendDao.getByPersonnelid(extend);
				personnelExtend.setPersonlabelid(extend.getPersonlabelid());
				if(extend.getPersonlabelid()==0){
					String attributesql="";
					String[] attributelabelString=personnelExtend.getAttributelabels().split(",");
					for (int i = 0; i < attributelabelString.length; i++) {
						if(!attributesql.equals(""))attributesql+=" OR ";
						attributesql+="FIND_IN_SET("+attributelabelString[i]+",attributelabels)";
					}
					PersonLabel sqlLabel=personnelDao.getPersonLabelsByAttributesql(attributesql);
					personnelExtend.setLabelsql(sqlLabel.getAttributelabels());
					personnelExtend.setMemo(sqlLabel.getMemo());
				}
				model.addAttribute("personnelExtend",personnelExtend);
				model.addAttribute("extendTitle",extend.getMemo());
				Personnel personnel=personnelDao.getById(personnelExtend.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
				int age=CardnumberInfo.getAge(personnel.getCardnumber());
				if(age==0)age=CardnumberInfo.getAgeByBirthday(personnelExtend.getBirthday());
				model.addAttribute("age",age);
				
				CustomText customText=new CustomText();
				int customTextid=personnelDao.getCustomtextidBypersonnelid(personnel.getId());
				if(customTextid>0)customText=personnelDao.getCustomtextByid(customTextid);
				model.addAttribute("customTextid",customTextid);
				model.addAttribute("customText",customText);
				
			    Relation relation=relationDao.searchrelation(personnelExtend.getPersonnelid());	//社会关系
				model.addAttribute("relation",relation);
			}else if(page.equals("showinfo_zhengbao")){
	               url="/jsp/personel/zhengbao/showinfo";
					
	               	PersonnelExtend personnelExtend=new PersonnelExtend();
					if(extend.getId()>0)personnelExtend=extendDao.getById(extend.getId());//获取分类分级信息
					else if(extend.getPersonnelid()>0)personnelExtend=extendDao.getByPersonnelid(extend);
					personnelExtend.setPersonlabelid(extend.getPersonlabelid());
					if(extend.getPersonlabelid()==0){
						String attributesql="";
						String[] attributelabelString=personnelExtend.getAttributelabels().split(",");
						for (int i = 0; i < attributelabelString.length; i++) {
							if(!attributesql.equals(""))attributesql+=" OR ";
							attributesql+="FIND_IN_SET("+attributelabelString[i]+",attributelabels)";
						}
						PersonLabel sqlLabel=personnelDao.getPersonLabelsByAttributesql(attributesql);
						personnelExtend.setLabelsql(sqlLabel.getAttributelabels());
						personnelExtend.setMemo(sqlLabel.getMemo());
					}
					model.addAttribute("personnelExtend",personnelExtend);
					model.addAttribute("extendTitle",extend.getMemo());
					Personnel personnel=personnelDao.getById(personnelExtend.getPersonnelid());//获取基本信息
					model.addAttribute("personnel",personnel);
					int age=CardnumberInfo.getAge(personnel.getCardnumber());
					if(age==0)age=CardnumberInfo.getAgeByBirthday(personnelExtend.getBirthday());
					model.addAttribute("age",age);
				    Relation relation=relationDao.searchrelation(personnelExtend.getPersonnelid());	//社会关系
					model.addAttribute("relation",relation);
				}else if (page.equals("updateWhole")){
				url="/jsp/personel/whole/update";
				Personnel personnel=personnelDao.getById(extend.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
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
				
				List<BasicMsg> persontype=basicMsgDao.getByType(20);//通用-人员类别
				model.addAttribute("persontype",persontype);
				
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				
				List<BasicMsg> jointcontrollevel=basicMsgDao.getByType(47);//涉稳-联控级别
				model.addAttribute("jointcontrollevel",jointcontrollevel);
				
				List<BasicMsg> incontrollevel=basicMsgDao.getByType(22);//通用-在控状态
				model.addAttribute("incontrollevel",incontrollevel);
				
				//社会关系
				Relation relation=relationDao.searchrelation(extend.getPersonnelid());
				model.addAttribute("relation",relation);
			}else if(page.equals("showinfoWhole")){
	               url="/jsp/personel/whole/showinfo";
					
					Personnel personnel=personnelDao.getById(extend.getPersonnelid());//获取基本信息
					model.addAttribute("personnel",personnel);
					int age=CardnumberInfo.getAge(personnel.getCardnumber());
					if(age==0){
						if(extend.getId()>0){
							PersonnelExtend personnelExtend=new PersonnelExtend();
							personnelExtend=extendDao.getById(extend.getId());//获取分类分级信息
							age=CardnumberInfo.getAgeByBirthday(personnelExtend.getBirthday());
						}
					}
					model.addAttribute("age",age);
				    Relation relation=relationDao.searchrelation(extend.getPersonnelid());	//社会关系
					model.addAttribute("relation",relation);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	
	@RequestMapping("/addPersonnelExtend.do")
	public @ResponseBody String addPersonnelExtend(PersonnelExtend personnelExtend,String ybssid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addPersonnelExtend.do.......................");
		try {
			int findid=personnelDao.findPersonInPersonnel(personnelExtend.getCardnumber());
			int typeflag=personnelExtend.getPersonlabelid();
			User jurisdictpolice1=userDao.getById(personnelExtend.getJurisdictpolice1());
			if (findid>0) {
				Personnel person=personnelDao.getById(findid);
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
				}
				if(1==2&&typeflag==9&&userSession.getLoginRoleMsgFilter()==1){//暂时不用
					System.out.println("-----新增政保人员");
					/*****提交标签审核*****/
					Applylabel applylabel9 = new Applylabel();
					applylabel9.setPersonnelid(person.getId());
					applylabel9.setApplytype(1);
					applylabel9.setValidflag(1);
					applylabel9.setAdddepartmentid(userSession.getLoginUserDepartmentid());
					applylabel9.setAddoperatorid(userSession.getLoginUserID());
					applylabel9.setAddoperator(userSession.getLoginUserName());
					applylabel9.setAddtime(TimeFormate.getISOTimeToNow());
					applylabel9.setApplylabel1("9");
					applylabel9.setApplylabel1name("政保人员");
					applylabel9.setApplyreason("政保专题-政保人员-新增");
					applylabelDao.add(applylabel9);
					//给领悟消息中心推送
					HashMap<String,Object> map9=new HashMap<String,Object>();
					String toIds9 = personnelDao.getUserCodeForSendChat(9);
					String content9 = "【风控平台-政保人员-新增】"+userSession.getLoginUserName()+"申请增加政保人员:"+person.getPersonname()+
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
					/*****通用扩展子表添加*****/
					personnelExtend.setPersonnelid(findid);
					if(jurisdictpolice1!=null){
						personnelExtend.setPolicephone1(jurisdictpolice1.getContactnumber());
					}
					personnelExtend.setValidflag(1);
					personnelExtend.setAddoperator(userSession.getLoginUserName());
					personnelExtend.setAddtime(addtime);
					extendDao.add(personnelExtend);
				}
				
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(1==2&&typeflag==9&&userSession.getLoginRoleMsgFilter()==1){//暂时不用
					person.setLslabel1("9");
					personnelDao.updateCheckedPersonLabel(person);
				}else{
					if(zslabel1!="")zslabel1+=",";
					zslabel1+=personnelExtend.getPersonlabelid();
					person.setZslabel1(zslabel1);
					person.setJdunit1(personnelExtend.getJurisdictunit1()+"");
					person.setJdpolice1(personnelExtend.getJurisdictpolice1()+"");
					if(jurisdictpolice1!=null){
						person.setPphone1(jurisdictpolice1.getContactnumber());
					}
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.update(person);
				}
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				message= new Message("true",personnelExtend.getPersonlabelname()+"添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addPersonnelExtend.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("非风险人提升为风险人");
				String operate_Condition = "";
				operate_Condition += "人员id = '" + findid + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else {
				/*****风险人员主表添加*****/
				Personnel person=new Personnel();
				person.setCardnumber(personnelExtend.getCardnumber());
				person.setPersonname(personnelExtend.getPersonname());
				person.setSexes(CardnumberInfo.getSex(personnelExtend.getCardnumber()));
				person.setZslabel1(personnelExtend.getPersonlabelid()+"");
				person.setJdunit1(personnelExtend.getJurisdictunit1()+"");
				person.setJdpolice1(personnelExtend.getJurisdictpolice1()+"");
				if(jurisdictpolice1!=null){
					person.setPphone1(jurisdictpolice1.getContactnumber());
				}
				person.setValidflag(1);
				person.setAddoperator(userSession.getLoginUserName());
				person.setAddoperatorid(userSession.getLoginUserID());
				person.setAddtime(addtime);
				int personid=personnelDao.add(person);
				/*****默认添加空关联信息*****/
				Relation relation=new Relation();
			    relation.setPersonnelid(personid);
			    relationDao.addrelation(relation);
				/*****一标三识数据关联*****/
			    if(ybssid!=null&&!"".equals(ybssid)){
			    	person=personnelDao.getById(personid);
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
					if(!"".equals(ybssPersonnel.getTelnumber())){
						String[] telnumbers=ybssPersonnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(personid);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
					personnelDao.update(person);
					
				}
			    
			    if(1==2&&typeflag==9&&userSession.getLoginRoleMsgFilter()==1){//暂时不用
			    	person.setLslabel1("9");
			    	person.setZslabel1("");
					personnelDao.updateCheckedPersonLabel(person);
					System.out.println("-----新增政保人员");
					/*****提交标签审核*****/
					Applylabel applylabel9 = new Applylabel();
					applylabel9.setPersonnelid(person.getId());
					applylabel9.setApplytype(1);
					applylabel9.setValidflag(1);
					applylabel9.setAdddepartmentid(userSession.getLoginUserDepartmentid());
					applylabel9.setAddoperatorid(userSession.getLoginUserID());
					applylabel9.setAddoperator(userSession.getLoginUserName());
					applylabel9.setAddtime(TimeFormate.getISOTimeToNow());
					applylabel9.setApplylabel1("9");
					applylabel9.setApplylabel1name("政保人员");
					applylabel9.setApplyreason("政保专题-政保人员-新增");
					applylabelDao.add(applylabel9);
					//给领悟消息中心推送
					HashMap<String,Object> map9=new HashMap<String,Object>();
					String toIds9 = personnelDao.getUserCodeForSendChat(9);
					String content9 = "【风控平台-政保人员-新增】"+userSession.getLoginUserName()+"申请增加政保人员:"+person.getPersonname()+
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
					/*****子表添加*****/
					personnelExtend.setPersonnelid(personid);
					if(jurisdictpolice1!=null){
						personnelExtend.setPolicephone1(jurisdictpolice1.getContactnumber());
					}
					personnelExtend.setValidflag(1);
					personnelExtend.setAddoperator(userSession.getLoginUserName());
					personnelExtend.setAddtime(addtime);
					extendDao.add(personnelExtend);
				}
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				if(1==2&&typeflag==9&&userSession.getLoginRoleMsgFilter()==1){//暂时不用
					message= new Message("true",personnelExtend.getPersonlabelname()+"已提交审核！");
				}else{
					message= new Message("true",personnelExtend.getPersonlabelname()+"添加成功！");
				}
				message.setFlag(personid);
				logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addPersonnelExtend.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("添加风险人");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",personnelExtend.getPersonlabelname()+"添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPersonnelExtend.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePersonnelExtend.do")
	public @ResponseBody String updatePersonnelExtend(PersonnelExtend personnelExtend,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatePersonnelExtend.do.......................");
		try {
			personnelExtend.setId(personnelExtend.getPersonFilter());
			personnelExtend.setUpdateoperator(userSession.getLoginUserName());
			personnelExtend.setUpdatetime(addtime);
			extendDao.update(personnelExtend);
			
			personnel.setId(personnelExtend.getPersonnelid());
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
//			personnelDao.update(personnel);
			personnelDao.updateSX(personnel);
			
			message = new Message("true",personnelExtend.getPersonlabelname()+"修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatePersonnelExtend.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改人员基本信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",personnelExtend.getPersonlabelname()+"修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatePersonnelExtend.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改人员基本信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatePersonnelWorkExtend.do")
	public @ResponseBody String updatePersonnelWorkExtend(PersonnelExtend personnelExtend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatePersonnelExtend.do.......................");
		try {
			personnelExtend.setId(personnelExtend.getPersonFilter());
			personnelExtend.setUpdateoperator(userSession.getLoginUserName());
			personnelExtend.setUpdatetime(addtime);
			extendDao.updateWorkExtend(personnelExtend);
			
			message = new Message("true",personnelExtend.getPersonlabelname()+"工作情况修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"工作情况修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatePersonnelExtend.do.......................工作情况修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("工作情况修改");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",personnelExtend.getPersonlabelname()+"工作情况修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"工作情况修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatePersonnelExtend.do.......................工作情况修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("工作情况修改");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelPersonnelExtend.do")
	public @ResponseBody String cancelPersonnelExtend(PersonnelExtend personnelExtend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelPersonnelExtend.do.......................");
		int personlabelid=personnelExtend.getPersonlabelid();
		personnelExtend=extendDao.getById(personnelExtend.getId());
		try {
			personnelExtend.setUpdateoperator(userSession.getLoginUserName());
			personnelExtend.setUpdatetime(addtime);
			extendDao.cancel(personnelExtend);
			
			Personnel person=personnelDao.getById(personnelExtend.getPersonnelid());
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
					if(!"".equals(newlabel))newlabel+=",";
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
			System.out.println("cancelPersonnelExtend.do.......................更新风险人员标签!!!!");
			/*if(personlabel.equals("")){
				personnelDao.cancel(person);
				System.out.println("cancelPersonnelExtend.do.......................同时删除风险人员!!!!");
			}else {
				person.setAttributelabels("");
				personnelDao.update(person);
				System.out.println("cancelPersonnelExtend.do.......................更新风险人员标签!!!!");
			}*/
			
			message = new Message("true",personnelExtend.getPersonlabelname()+"删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelPersonnelExtend.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除风险人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",personnelExtend.getPersonlabelname()+"删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, personnelExtend.getPersonlabelname()+"删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelPersonnelExtend.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除风险人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/importPersonnelExtend.do")
    @ResponseBody
    public Map<String, Object> importPersonnelExtend(HttpServletRequest request,HttpServletResponse response,@RequestParam("personlabelid")int personlabelid,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	Map<String, Object> json = new HashMap<String, Object>();  
    	String msg = "";
    	try{
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          //原文件名
          String fileName = myFile.getOriginalFilename();
          // 文件扩展名
          String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
              InputStream fis = (InputStream) myFile.getInputStream();
              if(fileType.equals("xls")){ 
                  HSSFWorkbook workbook = new HSSFWorkbook(fis);
                  HSSFSheet sheet=workbook.getSheetAt(0);
                  HSSFRow rowdata=null;
                  msg=importPersonnelExtendXLS(sheet,rowdata,personlabelid,userSession);                 
              }else if(fileType.equals("xlsx")){   
            	  XSSFWorkbook workbook = new XSSFWorkbook(fis);
                  XSSFSheet sheet=workbook.getSheetAt(0);
                  XSSFRow rowdata=null;
                  msg=importPersonnelExtendXLSX(sheet,rowdata,personlabelid,userSession);
              }        
              json.put("success",msg);
    } catch (Exception e) {
        e.printStackTrace();
    }   
    return json;  
    }
	
	private String importPersonnelExtendXLSX(XSSFSheet sheet,XSSFRow rowdata,int personlabelid,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
    	String msg="";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	for (int i =1; i < sheet.getLastRowNum()+1; i++) {
               rowdata = sheet.getRow(i);
               int rownum=i+1;
               if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
            	   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){
            		   if(rownum>2)rowmsg=" 第2行 至 第"+i+"行<br/>"; 
            		   else rowmsg="<font color='red'>无数据导入</font><br/>";
            		   break;
            	   }else{
              		    rowmsg=" 第2行 至 第"+sheet.getLastRowNum()+1+"行<br/>"; 
              	   }
            	   btmsg+="第"+rownum+"行，第一列(身份证号)为必填项；"+"<br/>"; 
               }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
            	   btmsg+="第"+rownum+"行，第二列(姓名)为必填项；"+"<br/>";
               }else{  
            	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
            	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
            	   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
            	   if(findid>0){
            		   if(personlabelid==2046){
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入治安人员！！！！"+"<br/>";
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2046");
            			   personnelDao.update(oldPersonnel);
            		   }else if(personlabelid==2297){
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入刑嫌专题！！！！"+"<br/>";
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2297");
            			   personnelDao.update(oldPersonnel);
            			   if(!oldPersonnel.getZslabel1().equals("2297")){
            				   /*****子表添加*****/
            				   PersonnelExtend personnelExtend=new PersonnelExtend();
            				   personnelExtend.setPersonnelid(findid);
            				   personnelExtend.setPersonlabelid(personlabelid);
            				   personnelExtend.setValidflag(1);
            				   personnelExtend.setAddoperator(userSession.getLoginUserName());
            				   personnelExtend.setAddtime(addtime);
            				   extendDao.add(personnelExtend);
            			   }
            		   }else if(personlabelid==2314){
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入民意诉求人员！！！！"+"<br/>";
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2314");
            			   personnelDao.update(oldPersonnel);
            			   if(!oldPersonnel.getZslabel1().equals("2314")){
            				   /*****子表添加*****/
            				   PersonnelExtend personnelExtend=new PersonnelExtend();
            				   personnelExtend.setPersonnelid(findid);
            				   personnelExtend.setPersonlabelid(personlabelid);
            				   personnelExtend.setValidflag(1);
            				   personnelExtend.setAddoperator(userSession.getLoginUserName());
            				   personnelExtend.setAddtime(addtime);
            				   extendDao.add(personnelExtend);
            			   }
            		   }else btmsg+="第"+rownum+"行，身份证号已存在；"+"<br/>";  //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
            	   }else {
            		   boolean numflag=false;
            		   if(rowdata.getCell(0).getStringCellValue().length()>14){
            			   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
            				   numflag=true;
            			   }else {
            				   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            			   }
            		   }else{
            			   numflag=true;
            		   }
            		   if(numflag){
            			   /*****风险人员主表添加*****/
            			   Personnel person=new Personnel();
            			   person.setCardnumber(rowdata.getCell(0).getStringCellValue());
            			   person.setPersonname(rowdata.getCell(1).getStringCellValue());
            			   person.setZslabel1(String.valueOf(personlabelid));//标签 personlabelid
            			   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
            			   person.setValidflag(1);
            			   person.setAddoperator(userSession.getLoginUserName());
            			   person.setAddoperatorid(userSession.getLoginUserID());
            			   person.setAddtime(addtime);
            			   int personid=personnelDao.add(person);
            			   person=personnelDao.getById(personid);
            			   boolean personUpdate=false;
            			   if(rowdata.getCell(2)!=null){
            				   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setUsedname(rowdata.getCell(2).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(3)!=null){
            				   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setNickname(rowdata.getCell(3).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(4)!=null){
            				   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPersonheight(rowdata.getCell(4).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(5)!=null){
            				   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setMarrystatus(rowdata.getCell(5).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(6)!=null){
            				   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setNation(rowdata.getCell(6).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(7)!=null){
            				   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPersontype(rowdata.getCell(7).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(8)!=null){
            				   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setSoldierstatus(rowdata.getCell(8).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(9)!=null){
            				   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setHeathstatus(rowdata.getCell(9).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(10)!=null){
            				   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPoliticalposition(rowdata.getCell(10).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(11)!=null){
            				   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setFaith(rowdata.getCell(11).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(12)!=null){
            				   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setEducation(rowdata.getCell(12).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(13)!=null){
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
            			   /*****一标三识数据关联*****/
            			   if(personlabelid==2297){
            				   String ybssid=kaKouDao.findYbssRkByCardnumber(person.getCardnumber());
            				   if(ybssid!=null&&!"0".equals(ybssid)){
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
            					   personUpdate=true;
            				   }
            			   }
            			   if(personUpdate)personnelDao.update(person);
            			   
            			   /*****默认添加空关联信息*****/
            			   Relation relation=new Relation();
            			   relation.setPersonnelid(personid);
            			   relationDao.addrelation(relation);
            			   /*****涉稳人员子表添加*****/
            			   PersonnelExtend personnelExtend=new PersonnelExtend();
            			   personnelExtend.setPersonnelid(personid);
            			   personnelExtend.setPersonlabelid(personlabelid);
            			   personnelExtend.setValidflag(1);
            			   personnelExtend.setAddoperator(userSession.getLoginUserName());
            			   personnelExtend.setAddtime(addtime);
            			   extendDao.add(personnelExtend);
            			   /*****修改社会关系中人员风险类别*****/
            			   SocialRelations socialrelations=new SocialRelations();
            			   socialrelations.setUpdateoperator(userSession.getLoginUserName());
            			   socialrelations.setUpdatetime(addtime);
            			   socialrelations.setCardnumber(person.getCardnumber());
            			   relationDao.updateriskpersonnel(socialrelations);
            			   pCount++;
            		   }
            	   }
               }  
    	}
//    	PersonLabel personLabel=personnelDao.getPersonLabelByid(personlabelid);
    	AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(personlabelid);
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
//    	msg+="<tr><td>成功导入:</td><td>风险人员（"+personLabel.getPersonlabel()+"）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险人员（"+attributeLabel.getAttributelabel()+"）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
    }
	private String importPersonnelExtendXLS(HSSFSheet sheet,HSSFRow rowdata,int personlabelid,@ModelAttribute("userSession")UserSession userSession) throws IOException {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
    	String msg="";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	for (int i =1; i < sheet.getLastRowNum()+1; i++) {
               rowdata = sheet.getRow(i);
               int rownum=i+1;
               if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
            	   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){
            		   if(rownum>2)rowmsg=" 第2行 至 第"+i+"行<br/>"; 
            		   else rowmsg="<font color='red'>无数据导入</font><br/>";
            		   break;
            	   }else{
              		    rowmsg=" 第2行 至 第"+sheet.getLastRowNum()+1+"行<br/>"; 
              	   }
            	   btmsg+="第"+rownum+"行，第一列(身份证号)为必填项；"+"<br/>"; 
               }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
            	   btmsg+="第"+rownum+"行，第二列(姓名)为必填项；"+"<br/>";
               }else{  
            	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
            	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
            	   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
            	   if(findid>0){
            		   if(personlabelid==2046){
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入治安人员！！！！"+"<br/>";
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2046");
            			   personnelDao.update(oldPersonnel);
            		   }else if(personlabelid==2297){
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入刑嫌专题！！！！"+"<br/>";
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2297");
            			   personnelDao.update(oldPersonnel);
            			   if(!oldPersonnel.getZslabel1().equals("2297")){
            				   /*****子表添加*****/
            				   PersonnelExtend personnelExtend=new PersonnelExtend();
            				   personnelExtend.setPersonnelid(findid);
            				   personnelExtend.setPersonlabelid(personlabelid);
            				   personnelExtend.setValidflag(1);
            				   personnelExtend.setAddoperator(userSession.getLoginUserName());
            				   personnelExtend.setAddtime(addtime);
            				   extendDao.add(personnelExtend);
            			   }
            		   }else if(personlabelid==2314){
            			   Personnel oldPersonnel=personnelDao.getById(findid);
            			   btmsg+="第"+rownum+"行，身份证号已存在；临时插入民意诉求人员！！！！"+"<br/>";
            			   oldPersonnel.setZslabel1(oldPersonnel.getZslabel1()+"\\,2314");
            			   personnelDao.update(oldPersonnel);
            			   if(!oldPersonnel.getZslabel1().equals("2314")){
            				   /*****子表添加*****/
            				   PersonnelExtend personnelExtend=new PersonnelExtend();
            				   personnelExtend.setPersonnelid(findid);
            				   personnelExtend.setPersonlabelid(personlabelid);
            				   personnelExtend.setValidflag(1);
            				   personnelExtend.setAddoperator(userSession.getLoginUserName());
            				   personnelExtend.setAddtime(addtime);
            				   extendDao.add(personnelExtend);
            			   }
            		   }else btmsg+="第"+rownum+"行，身份证号已存在；"+"<br/>";  //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
            	   }else {
            		   boolean numflag=false;
            		   if(rowdata.getCell(0).getStringCellValue().length()>14){
            			   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
            				   numflag=true;
            			   }else {
            				   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            			   }
            		   }else{
            			   numflag=true;
            		   }
            		   if(numflag){
            			   /*****风险人员主表添加*****/
            			   Personnel person=new Personnel();
            			   person.setCardnumber(rowdata.getCell(0).getStringCellValue());
            			   person.setPersonname(rowdata.getCell(1).getStringCellValue());
            			   person.setZslabel1(String.valueOf(personlabelid));//标签 personlabelid
            			   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
            			   person.setValidflag(1);
            			   person.setAddoperator(userSession.getLoginUserName());
            			   person.setAddoperatorid(userSession.getLoginUserID());
            			   person.setAddtime(addtime);
            			   int personid=personnelDao.add(person);
            			   person=personnelDao.getById(personid);
            			   boolean personUpdate=false;
            			   if(rowdata.getCell(2)!=null){
            				   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setUsedname(rowdata.getCell(2).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(3)!=null){
            				   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setNickname(rowdata.getCell(3).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(4)!=null){
            				   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPersonheight(rowdata.getCell(4).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(5)!=null){
            				   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setMarrystatus(rowdata.getCell(5).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(6)!=null){
            				   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setNation(rowdata.getCell(6).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(7)!=null){
            				   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPersontype(rowdata.getCell(7).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(8)!=null){
            				   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setSoldierstatus(rowdata.getCell(8).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(9)!=null){
            				   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setHeathstatus(rowdata.getCell(9).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(10)!=null){
            				   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setPoliticalposition(rowdata.getCell(10).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(11)!=null){
            				   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setFaith(rowdata.getCell(11).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(12)!=null){
            				   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
            				   person.setEducation(rowdata.getCell(12).getStringCellValue());
            				   personUpdate=true;
            			   }
            			   if(rowdata.getCell(13)!=null){
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
            			   /*****一标三识数据关联*****/
            			   if(personlabelid==2297){
            				   String ybssid=kaKouDao.findYbssRkByCardnumber(person.getCardnumber());
            				   if(ybssid!=null&&!"0".equals(ybssid)){
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
            					   personUpdate=true;
            				   }
            			   }
            			   if(personUpdate)personnelDao.update(person);
            			   
            			   /*****默认添加空关联信息*****/
            			   Relation relation=new Relation();
            			   relation.setPersonnelid(personid);
            			   relationDao.addrelation(relation);
            			   /*****涉稳人员子表添加*****/
            			   PersonnelExtend personnelExtend=new PersonnelExtend();
            			   personnelExtend.setPersonnelid(personid);
            			   personnelExtend.setPersonlabelid(personlabelid);
            			   personnelExtend.setValidflag(1);
            			   personnelExtend.setAddoperator(userSession.getLoginUserName());
            			   personnelExtend.setAddtime(addtime);
            			   extendDao.add(personnelExtend);
            			   /*****修改社会关系中人员风险类别*****/
            			   SocialRelations socialrelations=new SocialRelations();
            			   socialrelations.setUpdateoperator(userSession.getLoginUserName());
            			   socialrelations.setUpdatetime(addtime);
            			   socialrelations.setCardnumber(person.getCardnumber());
            			   relationDao.updateriskpersonnel(socialrelations);
            			   pCount++;
            		   }
            	   }
               }  
    	}
//    	PersonLabel personLabel=personnelDao.getPersonLabelByid(personlabelid);
    	AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(personlabelid);
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
//    	msg+="<tr><td>成功导入:</td><td>风险人员（"+personLabel.getPersonlabel()+"）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险人员（"+attributeLabel.getAttributelabel()+"）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
	}
	@RequestMapping("/exportPersonnelExtend.do")
	public void exportPersonnelExtend(HttpServletResponse response,PersonnelExtend personnelExtend,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,
											String personnelfield,String personneltext,
											String extendfield,String extendtext,
											String relationfield,String relationtext,
											int menuid){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportPersonnelExtend.do.......................");
		//PersonLabel personLabel=personnelDao.getPersonLabelByid(personnelExtend.getPersonlabelid());
		AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(personnelExtend.getPersonlabelid());
		try {
			String labelsql="";
			if (personnelExtend.getAttributelabels()!=null&!"".equals(personnelExtend.getAttributelabels())) {
				if (!personnelExtend.getAttributelabels().contains(",")) {
					if (labelsql!="")labelsql +=" AND ";
					labelsql += "FIND_IN_SET("+personnelExtend.getAttributelabels()+",pt.zslabel2)";
				}else {
					String[] attributes=personnelExtend.getAttributelabels().split(",");
					for (int i = 0; i < attributes.length; i++) {
						if(i>0)labelsql += " OR ";
						labelsql += "FIND_IN_SET("+attributes[i]+",pt.zslabel2)";
					}
				}
			}
			if(!"".equals(labelsql))personnelExtend.setLabelsql(labelsql);
			List<PersonnelExtend> list=extendDao.exportPersonnelExtend(personnelExtend);
			
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("风险人员("+attributeLabel.getAttributelabel()+")信息.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet(attributeLabel.getAttributelabel());
				
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
				
				String[] extendfieldStrings=extendfield.split(",");
				String[] extendtextStrings=extendtext.split(",");
				int extendlength=(extendfield!=""?extendfieldStrings.length:0);
				
				String[] relationfieldStrings=relationfield.split(",");
				String[] relationtextStrings=relationtext.split(",");
				int relationlength=(relationfield!=""?relationfieldStrings.length:0);
				
				/*定义标题*/
				HSSFRow rowtitle = sheet.createRow(0);
				rowtitle.setHeightInPoints(40);
				CellRangeAddress r = new CellRangeAddress(0,0,0,personnellength+extendlength+relationlength);
				sheet.addMergedRegion(r);
				HSSFCell cellhead = rowtitle.createCell(0);
				HSSFRichTextString valuehead = new HSSFRichTextString("风险人员("+attributeLabel.getAttributelabel()+")信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*定义副标题*/
				rowtitle=sheet.createRow(1);
				rowtitle.setHeightInPoints(30);
				/*基本信息*/
				int titlelength=personnellength;
				r=new CellRangeAddress(1,1,0,titlelength);
				sheet.addMergedRegion(r);
				cellhead = rowtitle.createCell(0);
				valuehead=new HSSFRichTextString("基本信息");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				/*分级分类信息*/
				if(extendlength>0){
					if(extendlength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+extendlength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("分级分类信息");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=extendlength;
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
				if(extendlength>0){
					for(int i=0;i<extendlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(extendtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=extendlength;
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
						if(personnelfieldStrings[j].equals("maintainrate1"))celltext+="%";
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
					
					if(extendlength>0){
						node=JSONObject.fromObject(list.get(i));
						for (int j = 0; j < extendlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 5000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(extendfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=extendlength;
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
				
				message = new Message("true",attributeLabel.getAttributelabel()+"导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, attributeLabel.getAttributelabel()+"导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("导出人员信息");
				String operate_Condition = "";
				if(personnelExtend.getCardnumber() != null && !"".equals(personnelExtend.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + personnelExtend.getCardnumber() + "'";
				}
				if(personnelExtend.getPersonname() != null && !"".equals(personnelExtend.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + personnelExtend.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + personnelExtend.getPersonname() + "'";
					}
				}
				if(personnelExtend.getTelnumber() != null && !"".equals(personnelExtend.getTelnumber())){
					if("".equals(operate_Condition)){
						operate_Condition += "名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
					}else{
						operate_Condition += " and 名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
					}
				}
				if(personnelExtend.getHomeplace() != null && !"".equals(personnelExtend.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
					}
				}
				if(personnelExtend.getJointcontrollevel() != null && !"".equals(personnelExtend.getJointcontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
					}else{
						operate_Condition += " and 联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
					}
				}
				if(personnelExtend.getCountry() != null && !"".equals(personnelExtend.getCountry())){
					if("".equals(operate_Condition)){
						operate_Condition += "国籍 LIKE '" + personnelExtend.getCountry() + "'";
					}else{
						operate_Condition += " and 国籍 LIKE '" + personnelExtend.getCountry() + "'";
					}
				}
				if(personnelExtend.getIncontrollevel() != null && !"".equals(personnelExtend.getIncontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
					}else{
						operate_Condition += " and 在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
					}
				}
				if(personnelExtend.getPersontype() != null && !"".equals(personnelExtend.getPersontype())){
					if("".equals(operate_Condition)){
						operate_Condition += "人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
					}else{
						operate_Condition += " and 人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else {
				message = new Message("false","无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, attributeLabel.getAttributelabel()+"导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("0");	//0：失败 1：成功
				log.setOperate_Name("导出人员信息");
				String operate_Condition = "";
				if(personnelExtend.getCardnumber() != null && !"".equals(personnelExtend.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + personnelExtend.getCardnumber() + "'";
				}
				if(personnelExtend.getPersonname() != null && !"".equals(personnelExtend.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + personnelExtend.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + personnelExtend.getPersonname() + "'";
					}
				}
				if(personnelExtend.getTelnumber() != null && !"".equals(personnelExtend.getTelnumber())){
					if("".equals(operate_Condition)){
						operate_Condition += "名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
					}else{
						operate_Condition += " and 名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
					}
				}
				if(personnelExtend.getHomeplace() != null && !"".equals(personnelExtend.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
					}
				}
				if(personnelExtend.getJointcontrollevel() != null && !"".equals(personnelExtend.getJointcontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
					}else{
						operate_Condition += " and 联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
					}
				}
				if(personnelExtend.getCountry() != null && !"".equals(personnelExtend.getCountry())){
					if("".equals(operate_Condition)){
						operate_Condition += "国籍 LIKE '" + personnelExtend.getCountry() + "'";
					}else{
						operate_Condition += " and 国籍 LIKE '" + personnelExtend.getCountry() + "'";
					}
				}
				if(personnelExtend.getIncontrollevel() != null && !"".equals(personnelExtend.getIncontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
					}else{
						operate_Condition += " and 在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
					}
				}
				if(personnelExtend.getPersontype() != null && !"".equals(personnelExtend.getPersontype())){
					if("".equals(operate_Condition)){
						operate_Condition += "人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
					}else{
						operate_Condition += " and 人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",attributeLabel.getAttributelabel()+"导出失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, attributeLabel.getAttributelabel()+"导出", userSession.getLoginUserName(), addtime, "导出失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("导出人员信息");
			String operate_Condition = "";
			if(personnelExtend.getCardnumber() != null && !"".equals(personnelExtend.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + personnelExtend.getCardnumber() + "'";
			}
			if(personnelExtend.getPersonname() != null && !"".equals(personnelExtend.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + personnelExtend.getPersonname() + "'";
				}
			}
			if(personnelExtend.getTelnumber() != null && !"".equals(personnelExtend.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + personnelExtend.getTelnumber() + "'";
				}
			}
			if(personnelExtend.getHomeplace() != null && !"".equals(personnelExtend.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + personnelExtend.getHomeplace() + "'";
				}
			}
			if(personnelExtend.getJointcontrollevel() != null && !"".equals(personnelExtend.getJointcontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
				}else{
					operate_Condition += " and 联控级别 = '" + personnelExtend.getJointcontrollevel() + "'";
				}
			}
			if(personnelExtend.getCountry() != null && !"".equals(personnelExtend.getCountry())){
				if("".equals(operate_Condition)){
					operate_Condition += "国籍 LIKE '" + personnelExtend.getCountry() + "'";
				}else{
					operate_Condition += " and 国籍 LIKE '" + personnelExtend.getCountry() + "'";
				}
			}
			if(personnelExtend.getIncontrollevel() != null && !"".equals(personnelExtend.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + personnelExtend.getIncontrollevel() + "'";
				}
			}
			if(personnelExtend.getPersontype() != null && !"".equals(personnelExtend.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}else{
					operate_Condition += " and 人员类别 LIKE '" + personnelExtend.getPersontype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		//return JSONObject.fromObject(message).toString();
	}
	/***************************人员标签信息******************************************/
	@RequestMapping("/getLabelinfo.do")
	@ResponseBody
	public Map<String,Object> getLabelinfo(Labelinfo labelinfo,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        try {
        	CustomLabel customLabel=personnelDao.getCustomLabelByid(labelinfo.getCustomlabelid());
        	labelinfo=extendDao.getLabelinfo(labelinfo);
        	result.put("customLabel", customLabel);
        	if(labelinfo==null){
        		result.put("firstLabel",0);
        		result.put("labelinfo",new Labelinfo());
        	}
			else{
				result.put("firstLabel",1);
				result.put("labelinfo",labelinfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	@RequestMapping("/updateLabelinfo.do")
	public @ResponseBody String updateLabelinfo(Labelinfo labelinfo,String infotitle,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateLabelinfo.do.......................");
		try {
			if (labelinfo.getId()>0) {
				labelinfo.setUpdateoperator(userSession.getLoginUserName());
				labelinfo.setUpdatetime(addtime);
				labelinfo.setValidflag(1);//历史
				extendDao.updateLabelinfoValidflag(labelinfo);
			}
			
			labelinfo.setAddoperator(userSession.getLoginUserName());
			labelinfo.setAddtime(addtime);
			labelinfo.setValidflag(2);//当前
			extendDao.addLabelinfo(labelinfo);
			
			message = new Message("true",infotitle+"提交成功！");
			message.setFlag(labelinfo.getCustomlabelid());
			logDao.recordLog(menuid, infotitle+"提交", userSession.getLoginUserName(), addtime, "提交成功", "");
			System.out.println("updateLabelinfo.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("新增标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false",infotitle+"提交失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, infotitle+"提交", userSession.getLoginUserName(), addtime, "提交失败", "");
			System.out.println("updateLabelinfo.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("新增标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/searchLabelinfo.do")
	@ResponseBody
	public Map<String,Object> searchLabelinfo(Labelinfo labelinfo,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=extendDao.searchLabelinfo(labelinfo, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/getCustomTextById.do")
	@ResponseBody
	public CustomText getCustomTextById(int id,ModelMap model) throws Exception{
		CustomText customText=personnelDao.getCustomtextByid(id);
		if(customText==null)customText=new CustomText();
		return customText;
	}
	
	@RequestMapping("/updateCustomText.do")
	public @ResponseBody String updateCustomText(CustomText customText,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateCustomText.do.......................");
		try {
			int customTextid=0;
			if (customText.getId()>0) {
				customTextid=customText.getId();
				customText.setUpdateoperator(userSession.getLoginUserName());
				customText.setUpdatetime(addtime);
				personnelDao.updatecustomtext(customText);
			}else{
				customText.setAddoperator(userSession.getLoginUserName());
				customText.setAddtime(addtime);
				customText.setValidflag(1);
				customTextid=personnelDao.addcustomtext(customText);
			}
			
			message = new Message("true","自定义档案提交成功！");
			message.setFlag(customTextid);
			logDao.recordLog(menuid, "自定义档案提交", userSession.getLoginUserName(), addtime, "提交成功", "");
			System.out.println("updateCustomText.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("自定义档案提交");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","自定义档案提交失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "自定义档案提交", userSession.getLoginUserName(), addtime, "提交失败", "");
			System.out.println("updateCustomText.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("自定义档案提交");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getAttributeLabelzTreeSelectM.do")
	public void getAttributeLabelTreeSelect(HttpServletResponse response){
		try {
			System.out.println("getCustomLabelTree=====");
			List<AttributeLabel> list1=new ArrayList<AttributeLabel>();
			list1=  personnelDao.searchAttributeLabel();
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON(list1, "attributelabel","","parentid", false,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/getAttributeLabelzTreeSelectMBySearch.do")
	public void getAttributeLabelzTreeSelectMBySearch(String searchtext,HttpServletResponse response){
		try {
			System.out.println("getAttributeLabelzTreeSelectMBySearch=====");
			List<AttributeLabel> list1=new ArrayList<AttributeLabel>();
			list1=  personnelDao.searchAttributeLabelBySearch(searchtext);
			JSONArray json=new JSONArray();
			json=TreeSelect.listToTreeSelectJSON_New(list1, "attributelabel","","parentid", false,false);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

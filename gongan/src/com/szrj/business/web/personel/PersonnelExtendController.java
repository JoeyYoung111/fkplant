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
import com.szrj.business.model.personel.ZaDu;
import com.szrj.business.model.personel.ZaChang;
import com.szrj.business.model.personel.ZaPei;

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
	@Autowired
	private com.szrj.business.dao.personel.ZaExtendDao zaExtendDao;

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
    /**
     * 将 Integer 列表转为逗号分隔字符串
     */
    private String listToString(List<Integer> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(list.get(i));
        }
        return sb.toString();
    }
    /**
     * 将 String 列表转为逗号分隔字符串（用于 SQL IN 查询）
     */
    private String listToStringWithQuotes(List<String> list) {
        if (list == null || list.isEmpty()) {
            return "''"; // 返回空字符串防止SQL报错
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append("'").append(list.get(i)).append("'"); // 关键：添加单引号
        }
        return sb.toString();
    }

    /**
     * 按人员ID分组涉赌记录
     */
    private Map<Integer, List<ZaDu>> groupDuByPersonnelId(List<ZaDu> duList) {
        Map<Integer, List<ZaDu>> map = new HashMap<>();
        if (duList != null) {
            for (ZaDu du : duList) {
                int pid = du.getPersonnelid();
                if (!map.containsKey(pid)) {
                    map.put(pid, new ArrayList<ZaDu>());
                }
                map.get(pid).add(du);
            }
        }
        return map;
    }

    /**
     * 按人员ID分组涉娼记录
     */
    private Map<Integer, List<ZaChang>> groupChangByPersonnelId(List<ZaChang> changList) {
        Map<Integer, List<ZaChang>> map = new HashMap<>();
        if (changList != null) {
            for (ZaChang chang : changList) {
                int pid = chang.getPersonnelid();
                if (!map.containsKey(pid)) {
                    map.put(pid, new ArrayList<ZaChang>());
                }
                map.get(pid).add(chang);
            }
        }
        return map;
    }

    /**
     * 按人员ID分组陪侍记录
     */
    private Map<Integer, List<ZaPei>> groupPeiByPersonnelId(List<ZaPei> peiList) {
        Map<Integer, List<ZaPei>> map = new HashMap<>();
        if (peiList != null) {
            for (ZaPei pei : peiList) {
                int pid = pei.getPersonnelid();
                if (!map.containsKey(pid)) {
                    map.put(pid, new ArrayList<ZaPei>());
                }
                map.get(pid).add(pei);
            }
        }
        return map;
    }

    /**
     * 按身份证号分组案件信息
     */
    @SuppressWarnings("unchecked")
    private Map<String, List<Map<String, Object>>> groupAjxxMapByCardnumber(List<Object> ajxxList) {
        Map<String, List<Map<String, Object>>> map = new HashMap<>();
        if (ajxxList != null) {
            for (Object obj : ajxxList) {
                Map<String, Object> aj = (Map<String, Object>) obj;
                String cardnumber = aj.get("sfzh") != null ? aj.get("sfzh").toString() : "";
                if (!map.containsKey(cardnumber)) {
                    map.put(cardnumber, new ArrayList<Map<String, Object>>());
                }
                map.get(cardnumber).add(aj);
            }
        }
        return map;
    }

    /**
     * 按身份证号分组警情信息
     */
    @SuppressWarnings("unchecked")
    private Map<String, List<Map<String, Object>>> groupJqxxMapByCardnumber(List<Object> jqxxList) {
        Map<String, List<Map<String, Object>>> map = new HashMap<>();
        if (jqxxList != null) {
            for (Object obj : jqxxList) {
                Map<String, Object> jq = (Map<String, Object>) obj;
                String cardnumber = jq.get("sfzh") != null ? jq.get("sfzh").toString() : "";
                if (!map.containsKey(cardnumber)) {
                    map.put(cardnumber, new ArrayList<Map<String, Object>>());
                }
                map.get(cardnumber).add(jq);
            }
        }
        return map;
    }

    /**
     * 涉赌人员导出表头
     */
    private List<String> getSheduExportHeaders() {
        List<String> headers = new ArrayList<String>();
        headers.add("序号");
        headers.add("姓名");
        headers.add("身份证号码");
        headers.add("户籍地址");
        headers.add("现住址");
        headers.add("现住址所属辖区");
        headers.add("现住址地市");
        headers.add("涉赌前科");
        headers.add("手机号码");
        headers.add("人员类型");
        headers.add("涉赌方式");
        headers.add("涉赌部位");
        headers.add("案件信息（id | 案件编号 | 案件名称）");
        headers.add("涉案地址");
        headers.add("处罚结果");
        headers.add("处罚日期");
        return headers;
    }

    /**
     * 涉娼人员导出表头
     */
    private List<String> getShechangExportHeaders() {
        List<String> headers = new ArrayList<String>();
        headers.add("序号");
        headers.add("姓名");
        headers.add("身份证号码");
        headers.add("户籍地址");
        headers.add("现住址");
        headers.add("现住址所属辖区");
        headers.add("现住址地市");
        headers.add("是否未成年");
        headers.add("涉黄前科");
        headers.add("手机号码");
        headers.add("人员类型");
        headers.add("涉黄方式");
        headers.add("涉黄类型");
        headers.add("案件信息（id | 案件编号 | 案件名称）");
        headers.add("涉案地址");
        headers.add("处罚结果");
        headers.add("处罚日期");
        return headers;
    }

    /**
     * 陪侍人员导出表头
     * todo：标签字段未添加
     */
    private List<String> getPeishiExportHeaders() {
        List<String> headers = new ArrayList<String>();
        headers.add("序号");
        headers.add("姓名");
        headers.add("身份证号码");
        headers.add("户籍地址");
        headers.add("现住址");
        headers.add("现住址所属辖区");
        headers.add("现住址地市");
        headers.add("手机号码");
        headers.add("活动场所");
        headers.add("角色标签");
        headers.add("案件信息（id | 案件编号 | 案件名称）");
        headers.add("采集来源");
        headers.add("采集时间");
        return headers;
    }

    /**
     * 未成年人基础信息导出表头
     */
    private List<String> getMinorExportHeaders() {
        List<String> headers = new ArrayList<String>();
        headers.add("序号");
        headers.add("姓名");
        headers.add("性别");//新增
        headers.add("身份证号码");
        headers.add("户籍地址");
        headers.add("现住址");
//        headers.add("现住址所属辖区");
//        headers.add("现住址地市");
        headers.add("手机号码");
//        headers.add("采集来源");
//        headers.add("采集时间");
        return headers;
    }

    /**
     * 涉娼未成年案件人员导出表头
     */
    private List<String> getMinorCaseExportHeaders() {
        List<String> headers = new ArrayList<String>();
        headers.add("序号");
        headers.add("姓名");
        headers.add("身份证号码");
        headers.add("户籍地址");
        headers.add("现住址");
        headers.add("现住址所属辖区");
        headers.add("现住址地市");
        headers.add("手机号码");
        headers.add("涉赌记录（id | 人员类型 | 涉赌方式 | 涉赌部位 | 处罚结果 | 涉案地址 | 处罚时间）");
        headers.add("涉娼记录（id | 人员类型 | 涉娼方式 | 涉娼类型 | 处罚结果 | 涉案地址 | 处罚时间）");
        headers.add("案件信息（id | 案件编号 | 案件名称）");
        return headers;
    }

    /**
     * 根据导出类型获取对应表头
     */
    private List<String> getExportHeadersByType(String exportType) {
        if ("shedu".equals(exportType)) {
            return getSheduExportHeaders();
        } else if ("shechang".equals(exportType)) {
            return getShechangExportHeaders();
        } else if ("peishi".equals(exportType)) {
            return getPeishiExportHeaders();
        } else if ("minor".equals(exportType)) {
            return getMinorExportHeaders();
        } else if ("minorCase".equals(exportType)) {
            return getMinorCaseExportHeaders();
        }
        return new ArrayList<String>();
    }

    /**
     * 构建涉赌人员导出行数据（每条涉赌记录生成一行）
     * @param rowIndex 行号（从1开始）
     * @param person 人员基础信息
     * @param duList 涉赌记录列表
     * @param ajxxList 案件信息列表
     * @return 行数据列表（可能包含多行）
     */
    private List<List<String>> buildSheduRowsData(int rowIndex, Personnel person,
                                           List<ZaDu> duList,
                                           List<Map<String, Object>> ajxxList) {
        List<List<String>> rows = new ArrayList<List<String>>();

        // 如果没有涉赌记录，生成一行基础数据
        if (duList == null || duList.isEmpty()) {
            List<String> row = new ArrayList<String>();
            row.add(String.valueOf(rowIndex));
            row.add(nullToEmpty(person.getPersonname()));
            row.add(nullToEmpty(person.getCardnumber()));
            row.add(buildFullHouseAddress(person));
            row.add(buildFullHomeAddress(person));
            row.add(nullToEmpty(person.getHomePoliceStationName()));  // 现住址所属辖区
            row.add(nullToEmpty(person.getHomeCity()));  // 现住址地市
            row.add(person.getHasSheduRecord() != null && person.getHasSheduRecord() == 1 ? "是" : "否");
            row.add(nullToEmpty(person.getTelnumber()));
            row.add("");  // 人员类型
            row.add("");  // 涉赌方式
            row.add("");  // 涉赌部位
            row.add(joinAjxxSimple(ajxxList));  // 案件信息
            row.add("");  // 涉案地址
            row.add("");  // 处罚结果
            row.add("");  // 处罚日期
            rows.add(row);
            return rows;
        }

        // 每条涉赌记录生成一行
        int currentRowIndex = rowIndex;
        for (ZaDu du : duList) {
            List<String> row = new ArrayList<String>();

            // 序号
            row.add(String.valueOf(currentRowIndex++));

            // 姓名
            row.add(nullToEmpty(person.getPersonname()));

            // 身份证号码
            row.add(nullToEmpty(person.getCardnumber()));

            // 户籍地址（完整）
            row.add(buildFullHouseAddress(person));

            // 现住址（完整+派出所）
            row.add(buildFullHomeAddress(person));

            // 现住址所属辖区
            row.add(nullToEmpty(person.getHomePoliceStationName()));

            // 现住址地市
            row.add(nullToEmpty(person.getHomeCity()));

            // 涉赌前科
            row.add(person.getHasSheduRecord() != null && person.getHasSheduRecord() == 1 ? "是" : "否");

            // 手机号码
            row.add(nullToEmpty(person.getTelnumber()));

            // 人员类型（当前涉赌记录的人员属性）
            row.add(nullToEmpty(du.getPersonAttribute()));

            // 涉赌方式
            row.add(nullToEmpty(du.getDbfs()));

            // 涉赌部位
            row.add(nullToEmpty(du.getDbbw()));

            // 案件信息（显示与该涉赌记录关联的所有案件）
            row.add(buildRelatedAjxxInfo(du.getRelAjIds(), ajxxList));

            // 涉案地址
            row.add(nullToEmpty(du.getCaseAddressList()));

            // 处罚结果
            row.add(nullToEmpty(du.getCfjg()));

            // 处罚日期
            row.add(nullToEmpty(du.getChsj()));

            rows.add(row);
        }

        return rows;
    }

    /**
     * 构建涉娼人员导出行数据（每条涉娼记录生成一行）
     * @param rowIndex 行号（从1开始）
     * @param person 人员基础信息
     * @param changList 涉娼记录列表
     * @param ajxxList 案件信息列表
     * @return 行数据列表（可能包含多行）
     */
    private List<List<String>> buildShechangRowsData(int rowIndex, Personnel person,
                                              List<ZaChang> changList,
                                              List<Map<String, Object>> ajxxList) {
        List<List<String>> rows = new ArrayList<List<String>>();

        // 如果没有涉娼记录，生成一行基础数据
        if (changList == null || changList.isEmpty()) {
            List<String> row = new ArrayList<String>();
            row.add(String.valueOf(rowIndex));
            row.add(nullToEmpty(person.getPersonname()));
            row.add(nullToEmpty(person.getCardnumber()));
            row.add(buildFullHouseAddress(person));
            row.add(buildFullHomeAddress(person));
            // 现住址所属辖区
            row.add(nullToEmpty(person.getHomePoliceStationName()));

            // 现住址地市
            row.add(nullToEmpty(person.getHomeCity()));
            row.add(checkIsMinor(person.getCardnumber()));
            row.add(person.getHasSechangRecord() != null && person.getHasSechangRecord() == 1 ? "是" : "否");
            row.add(nullToEmpty(person.getTelnumber()));
            row.add("");  // 人员类型
            row.add("");  // 涉黄方式
            row.add("");  // 涉黄类型
            row.add(joinAjxxSimple(ajxxList));  // 案件信息
            row.add("");  // 涉案地址
            row.add("");  // 处罚结果
            row.add("");  // 处罚日期
            rows.add(row);
            return rows;
        }

        // 每条涉娼记录生成一行
        int currentRowIndex = rowIndex;
        for (ZaChang chang : changList) {
            List<String> row = new ArrayList<String>();

            // 序号
            row.add(String.valueOf(currentRowIndex++));

            // 姓名
            row.add(nullToEmpty(person.getPersonname()));

            // 身份证号码
            row.add(nullToEmpty(person.getCardnumber()));

            // 户籍地址（完整）
            row.add(buildFullHouseAddress(person));

            // 现住址（完整+派出所）
            row.add(buildFullHomeAddress(person));

            // 现住址所属辖区
            row.add(nullToEmpty(person.getHomePoliceStationName()));

            // 现住址地市
            row.add(nullToEmpty(person.getHomeCity()));

            // 是否未成年（根据当前时间）
            row.add(checkIsMinor(person.getCardnumber()));

            // 涉黄前科
            row.add(person.getHasSechangRecord() != null && person.getHasSechangRecord() == 1 ? "是" : "否");

            // 手机号码
            row.add(nullToEmpty(person.getTelnumber()));

            // 人员类型（当前涉娼记录的人员属性）
            row.add(nullToEmpty(chang.getChang_scjs()));

            // 涉黄方式
            row.add(nullToEmpty(chang.getChang_myfs()));

            // 涉黄类型
            row.add(nullToEmpty(chang.getChangType()));

            // 案件信息（显示与该涉娼记录关联的所有案件）
            row.add(buildRelatedAjxxInfo(chang.getRelAjIds(), ajxxList));

            // 涉案地址
            row.add(nullToEmpty(chang.getCaseAddressList()));

            // 处罚结果
            row.add(nullToEmpty(chang.getChang_cfjg()));

            // 处罚日期
            row.add(nullToEmpty(chang.getChang_chsj()));

            rows.add(row);
        }

        return rows;
    }

    /**
     * 构建陪侍人员导出行数据（每条陪侍记录生成一行）
     * @param rowIndex 行号（从1开始）
     * @param person 人员基础信息
     * @param peiList 陪侍记录列表
     * @param ajxxList 案件信息列表
     * @return 行数据列表（可能包含多行）
     */
    private List<List<String>> buildPeishiRowsData(int rowIndex, Personnel person,
                                            List<ZaPei> peiList,
                                            List<Map<String, Object>> ajxxList) {
        List<List<String>> rows = new ArrayList<List<String>>();

        // 如果没有陪侍记录，生成一行基础数据
        if (peiList == null || peiList.isEmpty()) {
            List<String> row = new ArrayList<String>();
            row.add(String.valueOf(rowIndex));
            row.add(nullToEmpty(person.getPersonname()));
            row.add(nullToEmpty(person.getCardnumber()));
            row.add(buildFullHouseAddress(person));
            row.add(buildFullHomeAddress(person));
            row.add(nullToEmpty(person.getHomePoliceStationName()));
            row.add(nullToEmpty(person.getHomeCity()));
            row.add(nullToEmpty(person.getTelnumber()));
            row.add("");  // 活动场所
            row.add("");  // 角色标签
            row.add(joinAjxxSimple(ajxxList));  // 案件信息
            row.add("");  // 采集来源
            row.add("");  // 采集时间
            rows.add(row);
            return rows;
        }

        // 每条陪侍记录生成一行
        int currentRowIndex = rowIndex;
        for (ZaPei pei : peiList) {
            List<String> row = new ArrayList<String>();

            // 序号
            row.add(String.valueOf(currentRowIndex++));

            // 姓名
            row.add(nullToEmpty(person.getPersonname()));

            // 身份证号码
            row.add(nullToEmpty(person.getCardnumber()));

            // 户籍地址（完整）
            row.add(buildFullHouseAddress(person));

            // 现住址（完整+派出所）
            row.add(buildFullHomeAddress(person));

            // 现住址所属辖区
            row.add(nullToEmpty(person.getHomePoliceStationName()));

            // 现住址地市
            row.add(nullToEmpty(person.getHomeCity()));

            // 手机号码
            row.add(nullToEmpty(person.getTelnumber()));

            // 活动场所（当前陪侍记录）
            row.add(nullToEmpty(pei.getActivityVenue()));

            // 角色标签（从ZaPei的memo字段获取）
            row.add(nullToEmpty(pei.getMemo()));

            // 案件信息（显示与该陪侍记录关联的所有案件）
            row.add(buildRelatedAjxxInfo(pei.getRelAjIds(), ajxxList));

            // 采集来源
            row.add(nullToEmpty(pei.getCollectSource()));

            // 采集时间
            row.add(nullToEmpty(pei.getCollectDate()));

            rows.add(row);
        }

        return rows;
    }

    /**
     * 构建未成年人基础信息导出行数据
     * @param rowIndex 行号（从1开始）
     * @param person 人员基础信息
     */
    private List<String> buildMinorRowData(int rowIndex, Personnel person) {
        List<String> row = new ArrayList<String>();

        // 序号
        row.add(String.valueOf(rowIndex));

        // 姓名
        row.add(nullToEmpty(person.getPersonname()));

        // 性别
        row.add(nullToEmpty(person.getSexes()));

        // 身份证号码
        row.add(nullToEmpty(person.getCardnumber()));

        // 户籍地址（完整）
        row.add(buildFullHouseAddress(person));

        // 现住址（完整+派出所）
        row.add(buildFullHomeAddress(person));

        // 现住址所属辖区
//        row.add(nullToEmpty(person.getHomePoliceStationName()));

        // 现住址地市
//        row.add(nullToEmpty(person.getHomeCity()));

        // 手机号码
        row.add(nullToEmpty(person.getTelnumber()));

        // 采集来源
//        row.add(nullToEmpty(person.getAddoperator()));

        // 采集时间
//        row.add(nullToEmpty(person.getAddtime()));

        return row;
    }

    /**
     * 构建涉娼未成年案件人员导出行数据
     * @param rowIndex 行号（从1开始）
     * @param person 人员基础信息
     * @param duList 涉赌记录列表
     * @param changList 涉娼记录列表
     * @param ajxxList 案件信息列表
     */
    private List<String> buildMinorCaseRowData(int rowIndex, Personnel person,
                                               List<ZaDu> duList,
                                               List<ZaChang> changList,
                                               List<Map<String, Object>> ajxxList) {
        List<String> row = new ArrayList<String>();

        // 序号
        row.add(String.valueOf(rowIndex));

        // 姓名
        row.add(nullToEmpty(person.getPersonname()));

        // 身份证号码
        row.add(nullToEmpty(person.getCardnumber()));

        // 户籍地址（完整）
        row.add(buildFullHouseAddress(person));

        // 现住址（完整+派出所）
        row.add(buildFullHomeAddress(person));

        // 现住址所属辖区
        row.add(nullToEmpty(person.getHomePoliceStationName()));

        // 现住址地市
        row.add(nullToEmpty(person.getHomeCity()));

        // 手机号码
        row.add(nullToEmpty(person.getTelnumber()));

        // 涉赌记录（id | 人员类型 | 涉赌方式 | 涉赌部位 | 处罚结果 | 涉案地址 | 处罚时间）
        row.add(joinDuRecordsForMinorCase(duList));

        // 涉娼记录（id | 人员类型 | 涉娼方式 | 涉娼类型 | 处罚结果 | 涉案地址 | 处罚时间）
        row.add(joinChangRecordsForMinorCase(changList));

        // 案件信息（id | 案件编号 | 案件名称）
        row.add(joinAjxxSimple(ajxxList));

        return row;
    }

    /**
     * 根据身份证号计算年龄
     */
    private String calculateAge(String cardnumber) {
        if (cardnumber == null || cardnumber.length() < 14) {
            return "";
        }
        try {
            String birthYear = cardnumber.substring(6, 10);
            int year = Integer.parseInt(birthYear);
            int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
            return String.valueOf(currentYear - year);
        } catch (Exception e) {
            return "";
        }
    }

    /**
     * 空值转空字符串
     */
    private String nullToEmpty(Object value) {
        return value == null ? "" : value.toString();
    }

    /**
     * 获取打处单位显示名称
     * 优先使用handleUnit字段，如果为空则根据handleUnitCode查询部门名称
     */
    private String getHandleUnitDisplayName(Personnel person) {
        // 优先使用handleUnit
        String handleUnit = person.getHandleUnit();
        if (handleUnit != null && !handleUnit.trim().isEmpty()) {
            return handleUnit;
        }

        // 如果handleUnit为空，尝试根据handleUnitCode查询部门名称
        String handleUnitCode = person.getHandleUnitCode();
        if (handleUnitCode == null || handleUnitCode.trim().isEmpty()) {
            return "";
        }

        StringBuilder names = new StringBuilder();
        String[] codes = handleUnitCode.split(",");
        for (String code : codes) {
            if (code != null && !code.trim().isEmpty()) {
                try {
                    int deptId = Integer.parseInt(code.trim());
                    Department dept = departmentDao.getById(deptId);
                    if (dept != null && dept.getDepartname() != null) {
                        if (names.length() > 0) {
                            names.append(",");
                        }
                        names.append(dept.getDepartname());
                    }
                } catch (Exception e) {
                    // 忽略无效的部门ID
                }
            }
        }
        return names.toString();
    }

    /**
     * 获取人员类型标签名称（zslabel1+zslabel2）
     * @param zslabel1 一级标签ID（逗号分隔）
     * @param zslabel2 二级标签ID（逗号分隔）
     * @return 标签名称字符串
     */
    private String getPersonTypeLabel(String zslabel1, String zslabel2) {
        StringBuilder labelNames = new StringBuilder();

        // 处理一级标签
        if (zslabel1 != null && !zslabel1.trim().isEmpty()) {
            String[] label1Array = zslabel1.split(",");
            for (String labelId : label1Array) {
                if (labelId != null && !labelId.trim().isEmpty()) {
                    try {
                        AttributeLabel label = personnelDao.getAttributeLabelByid(Integer.parseInt(labelId.trim()));
                        if (label != null && label.getAttributelabel() != null) {
                            if (labelNames.length() > 0) {
                                labelNames.append(",");
                            }
                            labelNames.append(label.getAttributelabel());
                        }
                    } catch (Exception e) {
                        // 忽略无效的标签ID
                    }
                }
            }
        }

        // 处理二级标签
        if (zslabel2 != null && !zslabel2.trim().isEmpty()) {
            String[] label2Array = zslabel2.split(",");
            for (String labelId : label2Array) {
                if (labelId != null && !labelId.trim().isEmpty()) {
                    try {
                        AttributeLabel label = personnelDao.getAttributeLabelByid(Integer.parseInt(labelId.trim()));
                        if (label != null && label.getAttributelabel() != null) {
                            if (labelNames.length() > 0) {
                                labelNames.append(",");
                            }
                            labelNames.append(label.getAttributelabel());
                        }
                    } catch (Exception e) {
                        // 忽略无效的标签ID
                    }
                }
            }
        }

        return labelNames.toString();
    }

    /**
     * 拼接涉赌记录，多条记录用换行符分隔
     * 单条格式：详细地址 | 派出所 | 联系电话 | 涉赌情况综述 | 采集来源 | 采集日期 | 人员属性 | 赌博方式 | 赌博部位 | 查获经过 | 处罚结果 | 处理详情 | 涉案地址 | 处罚时间
     */
    private String joinDuRecords(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            ZaDu du = list.get(i);
            sb.append( i+1 );  // id
            sb.append(" | ");
            sb.append(nullToEmpty(du.getHomeDetail()));  // 详细地址
            sb.append(" | ");
            sb.append(nullToEmpty(du.getHomePoliceStationName()));  // 派出所
            sb.append(" | ");
            sb.append(nullToEmpty(du.getPhone()));  // 联系电话
            sb.append(" | ");
            sb.append(nullToEmpty(du.getLssdqk()));  // 涉赌情况综述
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCollectSource()));  // 采集来源
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCollectDate()));  // 采集日期
            sb.append(" | ");
            sb.append(nullToEmpty(du.getPersonAttribute()));  // 人员属性
            sb.append(" | ");
            sb.append(nullToEmpty(du.getDbfs()));  // 赌博方式
            sb.append(" | ");
            sb.append(nullToEmpty(du.getDbbw()));  // 赌博部位
            sb.append(" | ");
            sb.append(nullToEmpty(du.getChjg()));  // 查获经过
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCfjg()));  // 处罚结果
            sb.append(" | ");
            sb.append(nullToEmpty(du.getClxq()));  // 处理详情
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCaseAddressList()));  // 涉案地址
            sb.append(" | ");
            sb.append(nullToEmpty(du.getChsj()));  // 处罚时间
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼记录，多条记录用换行符分隔
     * 单条格式：详细地址 | 派出所 | 联系电话 | 涉娼情况综述 | 采集来源 | 采集日期 | 人员属性 | 涉娼方式 | 涉娼类型 | 是否未成年案件 | 查获经过 | 处罚结果 | 处理详情 | 涉案地址 | 处罚时间
     */
    private String joinChangRecords(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            ZaChang chang = list.get(i);
            sb.append( i+1 );  // id
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getHomeDetail()));  // 详细地址
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getHomePoliceStationName()));  // 派出所
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getPhone()));  // 联系电话
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_lsscqk()));  // 涉娼情况综述
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getCollectSource()));  // 采集来源
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getCollectDate()));  // 采集日期
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_scjs()));  // 人员属性（涉黄角色）
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_myfs()));  // 涉娼方式（卖淫方式）
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChangType()));  // 涉娼类型
            sb.append(" | ");
            sb.append(chang.getIsMinorCase() == 1 ? "是" : "否");  // 是否未成年案件
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_chjg()));  // 查获经过
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_cfjg()));  // 处罚结果
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_clxq()));  // 处理详情
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getCaseAddressList()));  // 涉案地址
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_chsj()));  // 处罚时间
        }
        return sb.toString();
    }

    /**
     * 拼接陪侍记录，多条记录用换行符分隔
     * 单条格式：陪侍情况综述 | 采集来源 | 采集日期 | 活动场所
     */
    private String joinPeiRecords(List<ZaPei> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            ZaPei pei = list.get(i);
            sb.append( i+1 );  // id
            sb.append(" | ");
            sb.append(nullToEmpty(pei.getOtherMemo()));  // 陪侍情况综述（其他备注）
            sb.append(" | ");
            sb.append(nullToEmpty(pei.getCollectSource()));  // 采集来源
            sb.append(" | ");
            sb.append(nullToEmpty(pei.getCollectDate()));  // 采集日期
            sb.append(" | ");
            sb.append(nullToEmpty(pei.getActivityVenue()));  // 活动场所
        }
        return sb.toString();
    }

    /**
     * 拼接案件信息，多条记录用换行符分隔
     * 单条格式：案件编号 | 受理时间 | 案件类别 | 案件名称 | 受理单位 | 简要案情
     */
    private String joinAjxxRecords(List<Map<String, Object>> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            Map<String, Object> aj = list.get(i);
            sb.append( i+1 );  // id
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "jjbh")));  // 案件编号
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "slsj")));  // 受理时间
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "ajlb")));  // 案件类别
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "ajmc")));  // 案件名称
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "sldwmc")));  // 受理单位名称
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "jyaq")));  // 简要案情
        }
        return sb.toString();
    }

    /**
     * 拼接警情信息，多条记录用换行符分隔
     * 单条格式：接警时间 | 报警内容 | 报警类型 | 事发地点 | 处理结果内容 | 处警单位名称
     */
    private String joinJqxxRecords(List<Map<String, Object>> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            Map<String, Object> jq = list.get(i);
            sb.append( i+1 );  // id
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "jjrqsj")));  // 接警时间
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "bjnr")));  // 报警内容
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "bjlx")));  // 报警类型
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "sfdd")));  // 事发地点
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "cljgnr")));  // 处理结果内容
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(jq, "cjdwmc")));  // 处警单位名称
        }
        return sb.toString();
    }

    /**
     * 构建完整的户籍地址（省+市+县+镇街+详细地址）
     */
    private String buildFullHouseAddress(Personnel person) {
        StringBuilder addr = new StringBuilder();
        if (person.getHouseProvince() != null && !person.getHouseProvince().trim().isEmpty()) {
            addr.append(person.getHouseProvince());
        }
        if (person.getHouseCity() != null && !person.getHouseCity().trim().isEmpty()) {
            addr.append(person.getHouseCity());
        }
        if (person.getHouseCounty() != null && !person.getHouseCounty().trim().isEmpty()) {
            addr.append(person.getHouseCounty());
        }
        if (person.getHouseTown() != null && !person.getHouseTown().trim().isEmpty()) {
            addr.append(person.getHouseTown());
        }
        if (person.getHouseplace() != null && !person.getHouseplace().trim().isEmpty()) {
            addr.append(person.getHouseplace());
        }
        return addr.toString();
    }

    /**
     * 构建完整的现住址（省+市+县+镇街+详细地址+现住地派出所）
     */
    private String buildFullHomeAddress(Personnel person) {
        StringBuilder addr = new StringBuilder();
        if (person.getHomeProvince() != null && !person.getHomeProvince().trim().isEmpty()) {
            addr.append(person.getHomeProvince());
        }
        if (person.getHomeCity() != null && !person.getHomeCity().trim().isEmpty()) {
            addr.append(person.getHomeCity());
        }
        if (person.getHomeCounty() != null && !person.getHomeCounty().trim().isEmpty()) {
            addr.append(person.getHomeCounty());
        }
        if (person.getHomeTown() != null && !person.getHomeTown().trim().isEmpty()) {
            addr.append(person.getHomeTown());
        }
        if (person.getHomeplace() != null && !person.getHomeplace().trim().isEmpty()) {
            addr.append(person.getHomeplace());
        }
        if (person.getHomePoliceStationName() != null && !person.getHomePoliceStationName().trim().isEmpty()) {
            addr.append("（").append(person.getHomePoliceStationName()).append("）");
        }
        return addr.toString();
    }

    /**
     * 判断是否未成年（根据当前时间和身份证号计算）
     */
    private String checkIsMinor(String cardnumber) {
        if (cardnumber == null || cardnumber.length() < 14) {
            return "";
        }
        try {
            String birthYear = cardnumber.substring(6, 10);
            String birthMonth = cardnumber.substring(10, 12);
            String birthDay = cardnumber.substring(12, 14);

            int year = Integer.parseInt(birthYear);
            int month = Integer.parseInt(birthMonth);
            int day = Integer.parseInt(birthDay);

            java.util.Calendar birthDate = java.util.Calendar.getInstance();
            birthDate.set(year, month - 1, day);

            java.util.Calendar now = java.util.Calendar.getInstance();

            int age = now.get(java.util.Calendar.YEAR) - birthDate.get(java.util.Calendar.YEAR);
            if (now.get(java.util.Calendar.MONTH) < birthDate.get(java.util.Calendar.MONTH) ||
                (now.get(java.util.Calendar.MONTH) == birthDate.get(java.util.Calendar.MONTH) &&
                 now.get(java.util.Calendar.DAY_OF_MONTH) < birthDate.get(java.util.Calendar.DAY_OF_MONTH))) {
                age--;
            }

            return age < 18 ? "是" : "否";
        } catch (Exception e) {
            return "";
        }
    }

    /**
     * 从Map中获取值，忽略key的大小写
     * 解决MySQL在不同配置下可能返回大写或小写列名的问题
     */
    private Object getMapValueIgnoreCase(Map<String, Object> map, String key) {
        if (map == null || key == null) {
            return null;
        }
        // 先尝试原始key
        Object value = map.get(key);
        if (value != null) {
            return value;
        }
        // 尝试大写key
        value = map.get(key.toUpperCase());
        if (value != null) {
            return value;
        }
        // 尝试小写key
        value = map.get(key.toLowerCase());
        if (value != null) {
            return value;
        }
        // 遍历所有key进行不区分大小写匹配
        for (String k : map.keySet()) {
            if (k.equalsIgnoreCase(key)) {
                return map.get(k);
            }
        }
        return null;
    }

    // ========== 新增的join方法，用于新格式的导出 ==========

    /**
     * 拼接涉赌人员属性（多条记录用逗号分隔）
     */
    private String joinDuPersonAttribute(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getPersonAttribute()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌方式（多条记录用逗号分隔）
     */
    private String joinDuDbfs(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getDbfs()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌部位（多条记录用逗号分隔）
     */
    private String joinDuDbbw(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getDbbw()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌涉案地址（多条记录用逗号分隔）
     */
    private String joinDuCaseAddress(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getCaseAddressList()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌处罚结果（多条记录用逗号分隔）
     */
    private String joinDuCfjg(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getCfjg()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌处罚时间（多条记录用逗号分隔）
     */
    private String joinDuChsj(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChsj()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼人员属性（多条记录用逗号分隔）
     */
    private String joinChangPersonAttribute(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChang_scjs()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼方式（多条记录用逗号分隔）
     */
    private String joinChangMyfs(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChang_myfs()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼类型（多条记录用逗号分隔）
     */
    private String joinChangType(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChangType()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼涉案地址（多条记录用逗号分隔）
     */
    private String joinChangCaseAddress(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getCaseAddressList()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼处罚结果（多条记录用逗号分隔）
     */
    private String joinChangCfjg(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChang_cfjg()));
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼处罚时间（多条记录用逗号分隔）
     */
    private String joinChangChsj(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getChang_chsj()));
        }
        return sb.toString();
    }

    /**
     * 拼接陪侍活动场所（多条记录用逗号分隔）
     */
    private String joinPeiActivityVenue(List<ZaPei> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getActivityVenue()));
        }
        return sb.toString();
    }

    /**
     * 拼接陪侍采集来源（多条记录用逗号分隔）
     */
    private String joinPeiCollectSource(List<ZaPei> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getCollectSource()));
        }
        return sb.toString();
    }

    /**
     * 拼接陪侍采集时间（多条记录用逗号分隔）
     */
    private String joinPeiCollectDate(List<ZaPei> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getCollectDate()));
        }
        return sb.toString();
    }

    /**
     * 拼接陪侍角色标签（多条记录用逗号分隔）
     */
    private String joinPeiMemo(List<ZaPei> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(nullToEmpty(list.get(i).getMemo()));
        }
        return sb.toString();
    }

    /**
     * 构建陪侍记录关联的案件信息
     * @param peiList 陪侍记录列表
     * @param ajxxList 案件信息列表
     * @return 格式化的案件信息字符串
     */
    private String buildPeiRelatedAjxxInfo(List<ZaPei> peiList, List<Map<String, Object>> ajxxList) {
        if (peiList == null || peiList.isEmpty() || ajxxList == null || ajxxList.isEmpty()) {
            return "";
        }

        // 收集所有陪侍记录关联的案件ID
        java.util.Set<String> allAjIdSet = new java.util.HashSet<String>();
        for (ZaPei pei : peiList) {
            String relAjIds = pei.getRelAjIds();
            if (relAjIds != null && !relAjIds.trim().isEmpty()) {
                String[] ajIdArray = relAjIds.split(",");
                for (String ajId : ajIdArray) {
                    if (ajId != null && !ajId.trim().isEmpty()) {
                        allAjIdSet.add(ajId.trim());
                    }
                }
            }
        }

        if (allAjIdSet.isEmpty()) {
            return "";
        }

        // 构建案件信息字符串
        StringBuilder sb = new StringBuilder();
        boolean isFirst = true;
        for (Map<String, Object> aj : ajxxList) {
            Object ajId = getMapValueIgnoreCase(aj, "id");
            if (ajId != null && allAjIdSet.contains(ajId.toString())) {
                if (!isFirst) {
                    sb.append("\n");  // 多个案件用换行分隔
                }
                isFirst = false;

                sb.append(ajId);  // 案件ID
                sb.append(" | ");
                sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "jjbh")));  // 案件编号
                sb.append(" | ");
                sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "ajmc")));  // 案件名称
            }
        }

        return sb.toString();
    }

    /**
     * 拼接案件信息（简化版）- 格式：id | 案件编号 | 案件名称
     * 多条记录用换行符分隔
     */
    private String joinAjxxSimple(List<Map<String, Object>> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            Map<String, Object> aj = list.get(i);
            sb.append(i + 1);  // id（序号）
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "jjbh")));  // 案件编号
            sb.append(" | ");
            sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "ajmc")));  // 案件名称
        }
        return sb.toString();
    }

    /**
     * 拼接涉赌记录（未成年案件专用）
     * 格式：id | 人员类型 | 涉赌方式 | 涉赌部位 | 处罚结果 | 涉案地址 | 处罚时间
     * 多条记录用换行符分隔
     */
    private String joinDuRecordsForMinorCase(List<ZaDu> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            ZaDu du = list.get(i);
            sb.append(i + 1);  // id（序号）
            sb.append(" | ");
            sb.append(nullToEmpty(du.getPersonAttribute()));  // 人员类型
            sb.append(" | ");
            sb.append(nullToEmpty(du.getDbfs()));  // 涉赌方式
            sb.append(" | ");
            sb.append(nullToEmpty(du.getDbbw()));  // 涉赌部位
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCfjg()));  // 处罚结果
            sb.append(" | ");
            sb.append(nullToEmpty(du.getCaseAddressList()));  // 涉案地址
            sb.append(" | ");
            sb.append(nullToEmpty(du.getChsj()));  // 处罚时间
        }
        return sb.toString();
    }

    /**
     * 拼接涉娼记录（未成年案件专用）
     * 格式：id | 人员类型 | 涉娼方式 | 涉娼类型 | 处罚结果 | 涉案地址 | 处罚时间
     * 多条记录用换行符分隔
     */
    private String joinChangRecordsForMinorCase(List<ZaChang> list) {
        if (list == null || list.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) {
                sb.append("\n");
            }
            ZaChang chang = list.get(i);
            sb.append(i + 1);  // id（序号）
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_scjs()));  // 人员类型
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_myfs()));  // 涉娼方式
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChangType()));  // 涉娼类型
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_cfjg()));  // 处罚结果
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getCaseAddressList()));  // 涉案地址
            sb.append(" | ");
            sb.append(nullToEmpty(chang.getChang_chsj()));  // 处罚时间
        }
        return sb.toString();
    }


    /**
     * 根据关联案件ID列表构建案件信息字符串
     * @param relAjIds 关联案件ID列表，逗号分隔（例如："1,2,3"）
     * @param ajxxList 案件信息列表
     * @return 格式化的案件信息字符串，格式：id | 案件编号 | 案件名称，多个案件用换行分隔
     */
    private String buildRelatedAjxxInfo(String relAjIds, List<Map<String, Object>> ajxxList) {
        // 如果没有关联案件ID或案件列表为空，返回空字符串
        if (relAjIds == null || relAjIds.trim().isEmpty() || ajxxList == null || ajxxList.isEmpty()) {
            return "";
        }

        // 将逗号分隔的ID字符串转换为ID集合
        String[] ajIdArray = relAjIds.split(",");
        java.util.Set<String> ajIdSet = new java.util.HashSet<String>();
        for (String ajId : ajIdArray) {
            if (ajId != null && !ajId.trim().isEmpty()) {
                ajIdSet.add(ajId.trim());
            }
        }

        // 如果没有有效的案件ID，返回空字符串
        if (ajIdSet.isEmpty()) {
            return "";
        }

        // 构建案件信息字符串
        StringBuilder sb = new StringBuilder();
        boolean isFirst = true;
        for (Map<String, Object> aj : ajxxList) {
            Object ajId = getMapValueIgnoreCase(aj, "id");
            if (ajId != null && ajIdSet.contains(ajId.toString())) {
                if (!isFirst) {
                    sb.append("\n");  // 多个案件用换行分隔
                }
                isFirst = false;

                sb.append(ajId);  // 案件ID
                sb.append(" | ");
                sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "jjbh")));  // 案件编号
                sb.append(" | ");
                sb.append(nullToEmpty(getMapValueIgnoreCase(aj, "ajmc")));  // 案件名称
            }
        }

        return sb.toString();
    }


    @RequestMapping("/exportZaPersonnelSpecial.do")
    public void exportZaPersonnelSpecial(HttpServletResponse response,
                                         PersonnelExtend personnelExtend,
                                         ServletRequest request,
                                         @ModelAttribute("userSession") UserSession userSession,
                                         String exportType,
                                         int menuid){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String addtime = dateFormat.format(new Date());
        int maxExportCount = 5000;

        try {
// ========== 1. 清空前端传来的搜索条件，实现全量导出 ==========
            personnelExtend.setCardnumber(null);
            personnelExtend.setPersonname(null);
            personnelExtend.setHomeplace(null);
            personnelExtend.setPersontype(null);
            personnelExtend.setAttributelabels(null);
            personnelExtend.setIsMinor(null);
            // 注意：对于minor导出，isMinor会在后续根据导出类型重新设置

// ========== 2. 根据 exportType 分支获取人员ID列表 ==========
            List<Integer> personnelIds = null;
            String labelsql = "";

            if ("shedu".equals(exportType)) {
                // 涉赌人员：zslabel2=2178
                labelsql = "FIND_IN_SET(2178, pt.zslabel2)";
                personnelExtend.setLabelsql(labelsql);
                personnelIds = personnelDao.getPersonnelIdsByCondition(personnelExtend);

            } else if ("shechang".equals(exportType)) {
                // 涉娼人员：zslabel2=2219
                labelsql = "FIND_IN_SET(2219, pt.zslabel2)";
                personnelExtend.setLabelsql(labelsql);
                personnelIds = personnelDao.getPersonnelIdsByCondition(personnelExtend);

            } else if ("peishi".equals(exportType)) {
                // 陪侍人员：zslabel2=5001
                labelsql = "FIND_IN_SET(5001, pt.zslabel2)";
                personnelExtend.setLabelsql(labelsql);
                personnelIds = personnelDao.getPersonnelIdsByCondition(personnelExtend);

            } else if ("minor".equals(exportType)) {
                // 未成年人基础信息导出
                // 筛选条件：zslabel1=2046（治安分类）+ zslabel2包含5002（未成年人标签）
                labelsql = "FIND_IN_SET(2046, pt.zslabel1) AND FIND_IN_SET(5002, pt.zslabel2)";
                personnelExtend.setLabelsql(labelsql);
                personnelIds = personnelDao.getPersonnelIdsByCondition(personnelExtend);

            } else if ("minorCase".equals(exportType)) {
                // 涉娼未成年案件人员
                List<Integer> minorCaseIds = zaExtendDao.getMinorCasePersonnelIds();
                if (minorCaseIds != null && !minorCaseIds.isEmpty()) {
                    personnelExtend.setPersonnelIdList(minorCaseIds);
                    personnelIds = personnelDao.getPersonnelIdsByConditionWithIdLimit(personnelExtend);
                }

            } else {
                // 无效类型处理
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"无效的导出类型\"}");
                return;
            }

// ========== 3. 阈值校验 ==========
            if (personnelIds == null || personnelIds.isEmpty()) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"没有符合条件的数据\"}");
                return;
            }
            if (personnelIds.size() > maxExportCount) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"导出数据量超过" + maxExportCount + "条，请缩小查询范围\"}");
                return;
            }

// ========== 4. 批量查询人员基础信息 ==========
            String personnelIdStr = listToString(personnelIds);
            List<Personnel> personnelList = personnelDao.getPersonnelByIds(personnelIdStr);

// 提取身份证号列表，用于关联案件/警情
            List<String> cardnumbers = new ArrayList<String>();
            for (Personnel p : personnelList) {
                if (p.getCardnumber() != null && !"".equals(p.getCardnumber())) {
                    cardnumbers.add(p.getCardnumber());
                }
            }
            String cardnumberStr = listToStringWithQuotes(cardnumbers);

// ========== 5. 根据导出类型查询业务数据 ==========
            Map<Integer, List<ZaDu>> duRecordMap = null;
            Map<Integer, List<ZaChang>> changRecordMap = null;
            Map<Integer, List<ZaPei>> peiRecordMap = null;
            Map<String, List<Map<String, Object>>> ajxxMap = null;

            if ("shedu".equals(exportType)) {
                List<ZaDu> duList = zaExtendDao.getZaDuListByPersonnelIds(personnelIdStr);
                duRecordMap = groupDuByPersonnelId(duList);
                ajxxMap = groupAjxxMapByCardnumber(kaKouDao.getAjxxByCardnumbers(cardnumberStr));

            } else if ("shechang".equals(exportType)) {
                List<ZaChang> changList = zaExtendDao.getZaChangListByPersonnelIds(personnelIdStr);
                changRecordMap = groupChangByPersonnelId(changList);
                ajxxMap = groupAjxxMapByCardnumber(kaKouDao.getAjxxByCardnumbers(cardnumberStr));

            } else if ("peishi".equals(exportType)) {
                List<ZaPei> peiList = zaExtendDao.getZaPeiListByPersonnelIds(personnelIdStr);
                peiRecordMap = groupPeiByPersonnelId(peiList);
                // 陪侍人员需要案件信息
                ajxxMap = groupAjxxMapByCardnumber(kaKouDao.getAjxxByCardnumbers(cardnumberStr));

            } else if ("minor".equals(exportType)) {
                // 未成年人仅导出基础信息，无需查询业务数据

            } else if ("minorCase".equals(exportType)) {
                List<ZaDu> duList = zaExtendDao.getZaDuListByPersonnelIds(personnelIdStr);
                duRecordMap = groupDuByPersonnelId(duList);
                List<ZaChang> changList = zaExtendDao.getZaChangListByPersonnelIds(personnelIdStr);
                changRecordMap = groupChangByPersonnelId(changList);
                ajxxMap = groupAjxxMapByCardnumber(kaKouDao.getAjxxByCardnumbers(cardnumberStr));
            }

// ========== 6. 组装导出数据行 ==========
            List<List<String>> allRows = new ArrayList<List<String>>();
            int rowIndex = 1;  // 序号从1开始
            for (Personnel person : personnelList) {
                if ("shedu".equals(exportType)) {
                    List<ZaDu> duList = duRecordMap != null ? duRecordMap.get(person.getId()) : null;
                    List<Map<String, Object>> ajList = ajxxMap != null ? ajxxMap.get(person.getCardnumber()) : null;
                    List<List<String>> rows = buildSheduRowsData(rowIndex, person, duList, ajList);
                    allRows.addAll(rows);
                    rowIndex += rows.size();

                } else if ("shechang".equals(exportType)) {
                    List<ZaChang> changList = changRecordMap != null ? changRecordMap.get(person.getId()) : null;
                    List<Map<String, Object>> ajList = ajxxMap != null ? ajxxMap.get(person.getCardnumber()) : null;
                    List<List<String>> rows = buildShechangRowsData(rowIndex, person, changList, ajList);
                    allRows.addAll(rows);
                    rowIndex += rows.size();

                } else if ("peishi".equals(exportType)) {
                    List<ZaPei> peiList = peiRecordMap != null ? peiRecordMap.get(person.getId()) : null;
                    List<Map<String, Object>> ajList = ajxxMap != null ? ajxxMap.get(person.getCardnumber()) : null;
                    List<List<String>> rows = buildPeishiRowsData(rowIndex, person, peiList, ajList);
                    allRows.addAll(rows);
                    rowIndex += rows.size();

                } else if ("minor".equals(exportType)) {
                    List<String> rowData = buildMinorRowData(rowIndex, person);
                    allRows.add(rowData);
                    rowIndex++;

                } else if ("minorCase".equals(exportType)) {
                    List<ZaDu> duList = duRecordMap != null ? duRecordMap.get(person.getId()) : null;
                    List<ZaChang> changList = changRecordMap != null ? changRecordMap.get(person.getId()) : null;
                    List<Map<String, Object>> ajList = ajxxMap != null ? ajxxMap.get(person.getCardnumber()) : null;
                    List<String> rowData = buildMinorCaseRowData(rowIndex, person, duList, changList, ajList);
                    allRows.add(rowData);
                    rowIndex++;
                }
            }

// ========== 7. 生成 Excel ==========
            // 获取表头
            List<String> headers = getExportHeadersByType(exportType);
            // 获取文件名
            String fileName = getExportFileNameByType(exportType);

            // 【修复点1】重置响应，防止之前的输出干扰
            response.reset();

            // 【修复点2】移除 charset=UTF-8 和 setCharacterEncoding，二进制流不需要字符编码
            response.setContentType("application/vnd.ms-excel");

            // 使用标准格式设置Content-Disposition，确保中文文件名正确
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + ".xls\"");
            // 禁用缓存
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // 创建工作簿
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet(fileName);

            // 表头样式
            HSSFCellStyle headerStyle = wb.createCellStyle();
            headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            HSSFFont headerFont = wb.createFont();
            headerFont.setFontName("宋体");
            headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            headerFont.setFontHeightInPoints((short) 10);
            headerStyle.setFont(headerFont);

            // 数据样式
            HSSFCellStyle dataStyle = wb.createCellStyle();
            dataStyle.setWrapText(true);
            dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            dataStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
            dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
            HSSFFont dataFont = wb.createFont();
            dataFont.setFontName("宋体");
            dataFont.setFontHeightInPoints((short) 10);
            dataStyle.setFont(dataFont);

            // 创建表头行
            HSSFRow headerRow = sheet.createRow(0);
            headerRow.setHeightInPoints(25);
            for (int i = 0; i < headers.size(); i++) {
                HSSFCell cell = headerRow.createCell(i);
                cell.setCellValue(new HSSFRichTextString(headers.get(i)));
                cell.setCellStyle(headerStyle);
                sheet.setColumnWidth(i, 5000);
            }

            // 创建数据行
            for (int excelRowIndex = 0; excelRowIndex < allRows.size(); excelRowIndex++) {
                List<String> rowData = allRows.get(excelRowIndex);
                HSSFRow dataRow = sheet.createRow(excelRowIndex + 1);
                // 根据内容中换行符数量动态调整行高
                int maxLines = 1;
                for (String cellValue : rowData) {
                    if (cellValue != null) {
                        int lines = cellValue.split("\n").length;
                        if (lines > maxLines) {
                            maxLines = lines;
                        }
                    }
                }
                dataRow.setHeightInPoints(Math.max(20, maxLines * 15));

                for (int colIndex = 0; colIndex < rowData.size(); colIndex++) {
                    HSSFCell cell = dataRow.createCell(colIndex);
                    String value = rowData.get(colIndex);
                    cell.setCellValue(new HSSFRichTextString(value != null ? value : ""));
                    cell.setCellStyle(dataStyle);
                }
            }

            // 【修复点3】确保输出流在写入前没有被 getWriter() 占用
            OutputStream out = response.getOutputStream();
            wb.write(out);
            out.flush();
            // 注意：在 Spring 环境下，通常不需要手动 close response 的 outputStream
            // 但 wb 必须 close
            wb.close();

            // 记录日志
            logDao.recordLog(menuid, "导出" + fileName, userSession.getLoginUserName(), addtime, "成功", "导出" + allRows.size() + "条");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.reset();  // 重置响应，清除之前可能设置的内容
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"导出失败：" + e.getMessage().replaceAll("\"", "'") + "\"}");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * 根据导出类型获取文件名
     */
    private String getExportFileNameByType(String exportType) {
        if ("shedu".equals(exportType)) {
            return "涉赌人员信息";
        } else if ("shechang".equals(exportType)) {
            return "涉娼人员信息";
        } else if ("peishi".equals(exportType)) {
            return "陪侍人员信息";
        } else if ("minor".equals(exportType)) {
            return "未成年人基础信息";
        } else if ("minorCase".equals(exportType)) {
            return "涉娼未成年案件人员信息";
        }
        return "人员信息导出";
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

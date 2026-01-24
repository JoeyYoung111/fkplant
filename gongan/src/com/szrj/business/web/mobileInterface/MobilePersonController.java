package com.szrj.business.web.mobileInterface;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.company.YzdChemistryDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.DuExtendDao;
import com.szrj.business.dao.personel.HeiEditorDao;
import com.szrj.business.dao.personel.JointControlRecordDao;
import com.szrj.business.dao.personel.KongControlPowerDao;
import com.szrj.business.dao.personel.KongExtendDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.PersonnelPhotoDao;
import com.szrj.business.dao.personel.RealityShowDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.dao.personel.WenGradeDao;
import com.szrj.business.dao.personel.WenRiskDao;
import com.szrj.business.dao.personel.WenVisitDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.company.YzdChemistry;
import com.szrj.business.model.interfaces.KaKou;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.DuCheckRecord;
import com.szrj.business.model.personel.DuExtend;
import com.szrj.business.model.personel.HeiEditor;
import com.szrj.business.model.personel.JointControlRecord;
import com.szrj.business.model.personel.KongBackground;
import com.szrj.business.model.personel.KongControlPower;
import com.szrj.business.model.personel.KongExtend;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelPhoto;
import com.szrj.business.model.personel.RealityShow;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.WenGrade;
import com.szrj.business.model.personel.WenRisk;
import com.szrj.business.model.personel.WenVisit;

@Controller
public class MobilePersonController {
	private static String pathurl="";
	private static String basevideo="audio/";
	private static String basepicture="pictures/";
	@Autowired
	private UserDao userDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private PersonnelPhotoDao photoDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private WenGradeDao wenGradeDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private WenRiskDao wenRiskDao;
	@Autowired
	private RealityShowDao realityShowDao;
	@Autowired
	private WenVisitDao wenVisitDao;
	@Autowired
	private JointControlRecordDao jointControlRecordDao;
	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private KongExtendDao kongExtendDao;
	@Autowired
	private KongControlPowerDao kongControlPowerDao;
	@Autowired
	private DuExtendDao duextendDao;
	@Autowired
	private YzdChemistryDao chemistryDao;
	@Autowired
	private HeiEditorDao heiEditorDao;
	/******************************风险人员***************************************************/
	@RequestMapping("/searchWholePersonnel.post")
	@ResponseBody
	public JSONObject searchWholePersonnel(Personnel personnel,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(loginUserID>0){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
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
				System.out.println("===sql===="+sqlall);
				personnel.setSqlall(sqlall);
				personnel.setAddoperatorid(userSession.getLoginUserID());
				NewPageModel pagelist = personnelDao.getWholePersonnel(personnel, pm);
				List rows=pagelist.getRows();
				List results=new ArrayList();
				if(rows.size()>0){
					for (int i = 0; i < rows.size(); i++) {
						JSONObject person=JSONObject.fromObject(rows.get(i));
						String url="";
						int personnelid=Integer.parseInt(person.get("id").toString());
						List<PersonnelPhoto> photos=photoDao.getByPersonnelid(personnelid);
						if(photos.size()>0){
							for (int j = 0; j < photos.size(); j++) {
								int defaultflag=photos.get(j).getDefaultflag();
								if (defaultflag>0) {
									int validflag=photos.get(j).getValidflag();
									String fileallName=photos.get(j).getFileallName();
									if(validflag==1)url=pathurl+"pictures/"+fileallName;
									if(validflag>1)url=pathurl+""+fileallName;
								}
							}
						}
						if ("".equals(url))url=pathurl+"images/nophoto.png";
						person.put("url", url);
						
						String zslabel1=person.get("zslabel1").toString();
						String zslabel2=person.get("zslabel2").toString();
						if (!"".equals(zslabel1)) {
							String[] zslabel1s=zslabel1.split(",");
							String zslabel1name="";
							for (int j = 0; j < zslabel1s.length; j++) {
								if(!"".equals(zslabel1s[j])){
									AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel1s[j]));
									if(j>0)zslabel1name+=",";
									zslabel1name+=attributeLabel.getAttributelabel();
								}
							}
							person.put("zslabel1name", zslabel1name);
						}else person.put("zslabel1name", "");
						if (!"".equals(zslabel2)) {
							String[] zslabel2s=zslabel2.split(",");
							String zslabel2name="";
							for (int j = 0; j < zslabel2s.length; j++) {
								if(!"".equals(zslabel2s[j])){
									AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel2s[j]));
									if(j>0)zslabel2name+=",";
									zslabel2name+=attributeLabel.getAttributelabel();
								}
							}
							person.put("zslabel2name", zslabel2name);
						}else person.put("zslabel2name", "");
						results.add(person);
					}
				}
				result.put("code", 1);
				result.put("results", results.toArray());
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 0);
			result.put("msg", "调用失败");
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	
	@RequestMapping("/getPersonnelPhotoFlowList.post")
	@ResponseBody
	public JSONObject getPersonnelPhotoFlowList(int personnelid){
		System.out.println("/getPersonnelPhotoFlowList.post------------------------");
		List<PersonnelPhoto> list=photoDao.getByPersonnelid(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("count", list.size());
        result.put("photos", list);
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	/***********************涉稳专题**********************************************************/
	@RequestMapping("/searchWenGrade.post")
	@ResponseBody
	public JSONObject searchWenGrade(WenGrade wenGrade,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(loginUserID>0){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
				//是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
					case 1:
						wenGrade.setUnitFilter(userSession.getLoginUserDepartmentid());
						break;
					case 2:
						wenGrade.setPersonFilter(userSession.getLoginUserID());
						break;
					case 3:
						Department department=departmentDao.getById(userSession.getLoginUserDepartmentid());
						BasicMsg basicMsg=basicMsgDao.getByMemo(department.getDepartcode());
						int policeid=0;
						if(basicMsg!=null)policeid=basicMsg.getId();
						wenGrade.setPoliceFilter(policeid);
						break;
					}	
				}
				if (wenGrade.getPersonneltype()!=null&&!"".equals(wenGrade.getPersonneltype())) {
					String sqltype="";
					if (!wenGrade.getPersonneltype().contains(",")) {
						sqltype = "FIND_IN_SET("+wenGrade.getPersonneltype()+",pt.zslabel2)";
					}else {
						String[] typeStrings=wenGrade.getPersonneltype().split(",");
						sqltype = "FIND_IN_SET("+typeStrings[0]+",pt.zslabel2)";
						for(int i=1;i<typeStrings.length;i++){
							sqltype +=" OR FIND_IN_SET("+typeStrings[i]+",pt.zslabel2)"; 
						}
					}
					wenGrade.setSqltype(sqltype);
				}
				if (wenGrade.getResponsiblepolice()!=null&&!"".equals(wenGrade.getResponsiblepolice())) {
					String sqlpolice="";
					if (!wenGrade.getResponsiblepolice().contains(",")) {
						sqlpolice = "FIND_IN_SET("+wenGrade.getResponsiblepolice()+",gt.responsiblepolice)";
					}else {
						String[] policeStrings=wenGrade.getResponsiblepolice().split(",");
						sqlpolice = "FIND_IN_SET("+policeStrings[0]+",gt.responsiblepolice)";
						for(int i=1;i<policeStrings.length;i++){
							sqlpolice +=" OR FIND_IN_SET("+policeStrings[i]+",gt.responsiblepolice)"; 
						}
					}
					wenGrade.setSqlpolice(sqlpolice);
				}
	        	NewPageModel pagelist=wenGradeDao.searchWenGrade(wenGrade, pm);
	        	List rows=pagelist.getRows();
				List results=new ArrayList();
				if(rows.size()>0){
					for (int i = 0; i < rows.size(); i++) {
						JSONObject person=JSONObject.fromObject(rows.get(i));
						
						String zslabel2=person.get("typename").toString();
						if (!"".equals(zslabel2)) {
							String[] zslabel2s=zslabel2.split(",");
							String zslabel2name="";
							for (int j = 0; j < zslabel2s.length; j++) {
								if(!"".equals(zslabel2s[j])){
									AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel2s[j]));
									if(j>0)zslabel2name+=",";
									zslabel2name+=attributeLabel.getAttributelabel();
								}
							}
							person.put("typename", zslabel2name);
						}else person.put("typename", "");
						results.add(person);
					}
				}
	        	result.put("code", 1);
				result.put("results", results.toArray());
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/getPersonnelByPersonnelid.post")
	@ResponseBody
	public JSONObject getPersonnelByPersonnelid(int personnelid){
		System.out.println("/getWenPersonnelByPersonnelid.post------------------------");
		Personnel personnel=personnelDao.getById(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
		JSONObject person=JSONObject.fromObject(personnel);
		String url="";
		List<PersonnelPhoto> photos=photoDao.getByPersonnelid(personnelid);
		if(photos.size()>0){
			for (int j = 0; j < photos.size(); j++) {
				int defaultflag=photos.get(j).getDefaultflag();
				if (defaultflag>0) {
					int validflag=photos.get(j).getValidflag();
					String fileallName=photos.get(j).getFileallName();
					if(validflag==1)url=pathurl+"pictures/"+fileallName;
					if(validflag>1)url=pathurl+""+fileallName;
				}
			}
		}
		if ("".equals(url))url=pathurl+"images/nophoto.png";
		person.put("url", url);
//			int personnelid=Integer.parseInt(person.get("id").toString());
//			List<PersonnelPhoto> list=photoDao.getByPersonnelid(personnelid);
		String zslabel1=person.get("zslabel1").toString();
		String zslabel2=person.get("zslabel2").toString();
		if (!"".equals(zslabel1)) {
			String[] zslabel1s=zslabel1.split(",");
			String zslabel1name="";
			for (int j = 0; j < zslabel1s.length; j++) {
				AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel1s[j]));
				if(j>0)zslabel1name+=",";
				zslabel1name+=attributeLabel.getAttributelabel();
			}
			person.put("zslabel1name", zslabel1name);
		}else person.put("zslabel1name", "");
		if (!"".equals(zslabel2)) {
			String[] zslabel2s=zslabel2.split(",");
			String zslabel2name="";
			for (int j = 0; j < zslabel2s.length; j++) {
				AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel2s[j]));
				if(j>0)zslabel2name+=",";
				zslabel2name+=attributeLabel.getAttributelabel();
			}
			person.put("zslabel2name", zslabel2name);
		}else person.put("zslabel2name", "");
        //result.put("personnel", person);
        result.put("code", 1);
		result.put("results", person);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/getWenGradeByGradeid.post")
	@ResponseBody
	public JSONObject getWenGradeByGradeid(int gradeid){
		System.out.println("/getWenGradeByGradeid.post------------------------");
		WenGrade wenGrade=wenGradeDao.getById(gradeid);//获取分类分级信息
		Map<String, Object> result = new HashMap<String, Object>();
		//result.put("wenGrade", wenGrade);
		result.put("code", 1);
		result.put("results", wenGrade);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
		return json;
	}
	@RequestMapping("/getAttributeLabelByLabelid.post")
	@ResponseBody
	public JSONObject getAttributeLabelByLabelid(int labelid){
		System.out.println("/getAttributeLabelByLabelid.post------------------------");
		AttributeLabel attributeLabel=personnelDao.getAttributeLabelByid(labelid);
		Map<String, Object> result = new HashMap<String, Object>();
		//result.put("attributeLabel", attributeLabel);
		result.put("code", 1);
		result.put("results", attributeLabel);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
		return json;
	}
	@RequestMapping("/getRelationByPersonnelid.post")
	@ResponseBody
	public JSONObject getRelationByPersonnelid(int personnelid){
		System.out.println("/getWenPersonnelByPersonnelid.post------------------------");
		Relation relation=relationDao.searchrelation(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
        //result.put("relation", relation);
        result.put("code", 1);
		result.put("results", relation);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	
	@RequestMapping("/getWenRiskByPersonnelid.post")
	@ResponseBody
	public JSONObject getWenRiskByPersonnelid(int personnelid){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			WenRisk wenRisk=wenRiskDao.getByPersonnelid(personnelid);
			
			if(wenRisk==null){
				result.put("firstRisk",0);
				wenRisk=new WenRisk();
			}
			else result.put("firstRisk",1);
			
			//result.put("wenRisk",wenRisk);
			result.put("code", 1);
			result.put("basevideo", basevideo);
			result.put("results", wenRisk);
			result.put("currPage", 1);
			result.put("totalPage", 1);
			result.put("totalSize", 1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	
	@RequestMapping("/searchWenVisit.post")
	@ResponseBody
	public JSONObject searchWenVisit(WenVisit wenVisit,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
        try {
        	if (wenVisit.getPersonnelid()>0) {
        		NewPageModel pagelist=wenVisitDao.searchWenVisit(wenVisit, pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchAlltrajectoryKK.post")
	@ResponseBody
	public JSONObject searchAlltrajectoryKK(KaKou kakou,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
		if(!"".equals(kakou.getPersoncard_number())){
			NewPageModel pagelist = kaKouDao.searchAlltrajectoryKK(kakou, pm);
			List rows=pagelist.getRows();
			List results=new ArrayList();
			if(rows.size()>0){
				for (int i = 0; i < rows.size(); i++) {
					Map<String, Object> newkakou = new HashMap<String, Object>();
					JSONObject onekakou=JSONObject.fromObject(rows.get(i));
					
					String data_origin=onekakou.get("data_origin").toString();
					String appear_address=onekakou.get("appear_address").toString();
					String telephone_number=onekakou.get("telephone_number").toString();
					String personcard_number=onekakou.get("personcard_number").toString();
					String vehicle_number=onekakou.get("vehicle_number").toString();
					String longitude=onekakou.get("longitude").toString();
					String latitude=onekakou.get("latitude").toString();
					String kakou_point=onekakou.get("kakou_point").toString();
					if("人脸轨迹".equals(data_origin)){
						data_origin="人脸";
					}else if("电子围栏".equals(data_origin)){
						data_origin="手机："+(telephone_number!=null?telephone_number:"");
						appear_address+=((longitude!=null&&longitude!="")?("(经度:"+longitude+((latitude!=null&&latitude!="")?("，纬度:"+latitude+")"):"")):"");
					}else if("网吧记录".equals(data_origin)){
						data_origin="身份证："+(personcard_number!=null?personcard_number:"");
					}else if("车辆数据".equals(data_origin)){
						data_origin="车辆："+(vehicle_number!=null?vehicle_number:"");
						appear_address+=((kakou_point!=null&&kakou_point!="")?("(卡口点位:"+kakou_point+")"):"");
					}
					newkakou.put("data_origin", data_origin);
					newkakou.put("appear_address", appear_address);
					
					String appear_time=onekakou.get("appear_time").toString();
					newkakou.put("appear_time", appear_time);
					
					String insert_time=onekakou.get("insert_time").toString();
					newkakou.put("insert_time", insert_time);
					
					results.add(newkakou);
				}
			}
			result.put("code", 1);
			result.put("results", results.toArray());
			result.put("currPage", pagelist.getPageNumber());
			result.put("totalPage", pagelist.getAllpagenum());
			result.put("totalSize", pagelist.getTotal());
		}else {
			result.put("code", 0);
			result.put("msg", "未输入风险人员身份证号");
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/gettrajectoryKKtypesToJSON.post")
	@ResponseBody
	public JSONObject gettrajectoryKKtypesToJSON(){
		List<String> bmList=kaKouDao.gettrajectoryKKtypes();
		Map<String, Object> result = new HashMap<String, Object>();
		//result.put("types", bmList);
		result.put("code", 1);
		result.put("results", bmList);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchJointControlRecord.post")
	@ResponseBody
	public JSONObject searchJointControlRecord(JointControlRecord jointcontrolrecord,NewPageModel pm){
	    Map<String, Object> result = new HashMap<String, Object>();
	    try {
        	if (jointcontrolrecord.getPersonnelid()>0) {
        		NewPageModel pagelist=jointControlRecordDao.searchJointControlRecord(jointcontrolrecord, pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchsocialrelations.post")
	@ResponseBody
	public JSONObject searchsocialrelations(Relation relation,NewPageModel pm){
	    Map<String, Object> result = new HashMap<String, Object>();
	    try {
        	if (relation.getPersonnelid()>0) {
        		NewPageModel pagelist=relationDao.searchsocialrelations(relation.getPersonnelid(), pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchXdJqxx.post")
	@ResponseBody
	public JSONObject searchXdJqxx(XdJqxx xdjqxx,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
        	if (!"".equals(xdjqxx.getSfzh())) {
        		NewPageModel pagelist = kaKouDao.searchXdJqxx(xdjqxx, pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员身份证号");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchXdAjxx.post")
	@ResponseBody
	public JSONObject searchXdAjxx(XdAjxx xdajxx,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
        	if (!"".equals(xdajxx.getSfzh())) {
        		NewPageModel pagelist = kaKouDao.searchXdAjxx(xdajxx, pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员身份证号");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/getRealityShowByPersonnelid.post")
	@ResponseBody
	public JSONObject getRealityShowByPersonnelid(RealityShow realityShow){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			if (realityShow.getPersonnelid()>0) {
				if(realityShow.getDatalabel()>0){
					RealityShow realityShow1=realityShowDao.getByPersonnelid(realityShow);
					
					if(realityShow1==null){
						result.put("firstShow",0);
						realityShow1=new RealityShow();
					}
					else result.put("firstShow",1);
					
					//result.put("realityShow",realityShow1);
					result.put("code", 1);
					result.put("results", realityShow1);
					result.put("currPage", 1);
					result.put("totalPage", 1);
					result.put("totalSize", 1);
				}else {
					result.put("code", 0);
					result.put("msg", "未输入数据标签");
				}
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	/*********************涉恐专题************************************************************/
	@RequestMapping("/getKongPersonnel.post")
	@ResponseBody
	public JSONObject getKongPersonnel(KongExtend kongextend,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(!"".equals(kongextend.getIncontrollevel())){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
				kongextend.setPersonlabel("2");
				/**增加数据过滤   根据当前用户角色设置是否数据过滤 0-不过滤 1-单位过滤 2-民警过滤**/
				kongextend.setIsFilter(userSession.getLoginRoleFieldFilter()+"");
				if(userSession.getLoginRoleFieldFilter()==1){
					kongextend.setFiltervalue(userSession.getLoginUserDepartmentid()+"");
				}else if(userSession.getLoginRoleFieldFilter()==2){
					kongextend.setFiltervalue(userSession.getLoginUserID()+"");
				}
				NewPageModel pagelist=kongExtendDao.searchKongPersonnel(kongextend, pm);
				List rows=pagelist.getRows();
				List results=new ArrayList();
				if(rows.size()>0){
					for (int i = 0; i < rows.size(); i++) {
						JSONObject person=JSONObject.fromObject(rows.get(i));
						HashMap<String,Object> resultMap=new HashMap<String, Object>();
						Iterator personIt=person.keys();
						while (personIt.hasNext()) {
							String keyString=String.valueOf(personIt.next()).toString();
							if(!"gdtime".equals(keyString))resultMap.put(keyString,person.get(keyString));
						}
						results.add(resultMap);
					}
				}
				result.put("code", 1);
				result.put("results", results);
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入在控状态");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/getKongExtendByPersonnelid.post")
	@ResponseBody
	public JSONObject getKongExtendByPersonnelid(int personnelid){
		System.out.println("/getKongExtendByPersonnelid.post------------------------");
		KongExtend kongExtend=kongExtendDao.getKongExtendBypersonnelid(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 1);
		result.put("basepicture", basepicture);
		result.put("results", kongExtend);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
		return json;
	}
	@RequestMapping("/searchKongControlPower.post")
	@ResponseBody
	public JSONObject searchKongControlPower(KongControlPower kongcontrolpower,NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
	    System.out.println("/searchKongControlPower.post..............=");
	    if (kongcontrolpower.getPersonnelid()>0) {
	    	if (kongcontrolpower.getForcetype()>0) {
	    		NewPageModel listTemp=kongControlPowerDao.searchKongControlPower(kongcontrolpower, pm);
	    		result.put("code", 1);
	    		result.put("results", listTemp.getRows().toArray());
	    		result.put("currPage", listTemp.getPageNumber());
	    		result.put("totalPage", listTemp.getAllpagenum());
	    		result.put("totalSize", listTemp.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入管控力量类型");
			}
		}else {
			result.put("code", 0);
			result.put("msg", "未输入风险人员ID");
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchKongBackground.post")
	@ResponseBody
	public JSONObject searchKongBackground(KongBackground kongbackground,NewPageModel pm){
		System.out.println("/searchKongBackground.post..............=");
		Map<String, Object> result = new HashMap<String, Object>();
	    if (kongbackground.getPersonnelid()>0) {
	    	if (kongbackground.getDatatype()>0) {
	    		NewPageModel listTemp=kongControlPowerDao.searchKongBackground(kongbackground, pm);
	    		result.put("code", 1);
	    		result.put("results", listTemp.getRows().toArray());
	    		result.put("currPage", listTemp.getPageNumber());
	    		result.put("totalPage", listTemp.getAllpagenum());
	    		result.put("totalSize", listTemp.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入数据类型");
			}
		}else {
			result.put("code", 0);
			result.put("msg", "未输入风险人员ID");
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	/*********************涉毒专题************************************************************/
	@RequestMapping("/searchDuPersonnel.post")
	@ResponseBody
	public JSONObject searchDuPersonnel(DuExtend duextend,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(duextend.getPersonneltype()>0){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
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
				NewPageModel pagelist=duextendDao.searchDuPersonnel(duextend, pm);
				result.put("code", 1);
				result.put("results", pagelist.getRows().toArray());
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员类别");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	
	@RequestMapping("/searchChemistry1.post")
	@ResponseBody
	public JSONObject searchChemistry1(YzdChemistry chemistry, NewPageModel pm){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			NewPageModel pagelist = chemistryDao.searchYzdChemistry1(chemistry, pm);
			result.put("code", 1);
			result.put("results", pagelist.getRows().toArray());
			result.put("currPage", pagelist.getPageNumber());
			result.put("totalPage", pagelist.getAllpagenum());
			result.put("totalSize", pagelist.getTotal());
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	
	@RequestMapping("/getDuExtendByPersonnelid.post")
	@ResponseBody
	public JSONObject getDuExtendByPersonnelid(int personnelid){
		System.out.println("/getDuExtendByPersonnelid.post------------------------");
		DuExtend duExtend=duextendDao.getDuExtendBypersonnelid(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 1);
		result.put("results", duExtend);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
		return json;
	}
	@RequestMapping("/searchducheckrecord.post")
	@ResponseBody
	public JSONObject searchducheckrecord(DuCheckRecord ducheckrecord,NewPageModel pm){
		    System.out.println("/searchducheckrecord.post..............");
		    Map<String, Object> result = new HashMap<String, Object>();
		    if (ducheckrecord.getPersonnelid()>0) {
		    	NewPageModel listTemp=duextendDao.searchducheckrecord(ducheckrecord, pm);
	    		result.put("code", 1);
	    		result.put("results", listTemp.getRows().toArray());
	    		result.put("currPage", listTemp.getPageNumber());
	    		result.put("totalPage", listTemp.getAllpagenum());
	    		result.put("totalSize", listTemp.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入风险人员ID");
			}
			JSONObject json = JSONObject.fromObject(result);
		    return json;
	}
	/*********************涉黑恶专题************************************************************/
	@RequestMapping("/getHeiPersonnel.post")
	@ResponseBody
	public JSONObject  getHeiPersonnel(Personnel personnel,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(loginUserID>0){
				personnel.setAddoperatorid(loginUserID);
			    NewPageModel pagelist=heiEditorDao.searchHeiPersonnel(personnel, pm);
				result.put("code", 1);
				result.put("results", pagelist.getRows().toArray());
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/getHeiEditorByPersonnelid.post")
	@ResponseBody
	public JSONObject getHeiEditorByPersonnelid(int personnelid){
		System.out.println("/getHeiEditorByPersonnelid.post------------------------");
		HeiEditor heiEditor=heiEditorDao.getBypersonnelid(personnelid);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 1);
		result.put("results", heiEditor);
		result.put("currPage", 1);
		result.put("totalPage", 1);
		result.put("totalSize", 1);
		JSONObject json = JSONObject.fromObject(result);
		return json;
	}
}

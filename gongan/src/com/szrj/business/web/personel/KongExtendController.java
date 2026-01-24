package com.szrj.business.web.personel;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
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
import nl.justobjects.pushlet.util.Sys;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

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
import com.aladdin.util.FileUtil;
import com.aladdin.util.TimeFormate;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.alibaba.excel.write.metadata.fill.FillWrapper;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.interfaces.SendChat;
import com.szrj.business.dao.interfaces.ShortMessageDao;
import com.szrj.business.dao.personel.KongControlPowerDao;
import com.szrj.business.dao.personel.KongExtendDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.User;
import com.szrj.business.model.event.EventsInfo;
import com.szrj.business.model.personel.KongBackground;
import com.szrj.business.model.personel.KongControlPower;
import com.szrj.business.model.personel.KongDailyControl;
import com.szrj.business.model.personel.KongExtend;
import com.szrj.business.model.personel.KongPublicRelation;
import com.szrj.business.model.personel.KongPublicResume;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.SocialRelations;


@Controller
@SessionAttributes("userSession")
public class KongExtendController {
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private KongExtendDao kongExtendDao;
	@Autowired
	private KongControlPowerDao kongControlPowerDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private KaKouDao kaKouDao;
	private
    @Value("#{configProperties.uploadFile_Pricture}")
    String uploadFile_Pricture;	//读配置文件中的文件上传路径
	private
    @Value("#{configProperties.uploadFile}")
    String uploadFile;	//读配置文件中的文件上传路径
	
	/**
	 * 查询涉恐人员列表信息
	 * @param kongextend
	 * @param pm
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/getKongPersonnel.do")
	@ResponseBody
	public Map<String,Object>  getKongPersonnel(KongExtend  kongextend,int page,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
			Map<String, Object> result = new HashMap<String, Object>();
			try {
			    kongextend.setPersonlabel("2");
			    pm.setPageNumber(page);
			    /**增加数据过滤   根据当前用户角色设置是否数据过滤 0-不过滤 1-单位过滤 2-民警过滤**/
			    kongextend.setIsFilter(userSession.getLoginRoleFieldFilter()+"");
			    if(userSession.getLoginRoleFieldFilter()==1){
			    	kongextend.setFiltervalue(userSession.getLoginUserDepartmentid()+"");
			    }else if(userSession.getLoginRoleFieldFilter()==2){
			    	kongextend.setFiltervalue(userSession.getLoginUserID()+"");
			    }
			    NewPageModel listTemp=kongExtendDao.searchKongPersonnel(kongextend, pm);
		        result.put("code", 0);
		        result.put("count", listTemp.getTotal());
		        result.put("data", listTemp.getRows().toArray());
		        //生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("查询涉恐人员");
				String operate_Condition = "";
				if(kongextend.getCardnumber() != null && !"".equals(kongextend.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + kongextend.getCardnumber() + "'";
				}
				if(kongextend.getPersonname() != null && !"".equals(kongextend.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + kongextend.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + kongextend.getPersonname() + "'";
					}
				}
				if(kongextend.getSexes() != null && !"".equals(kongextend.getSexes())){
					if("".equals(operate_Condition)){
						operate_Condition += "性别 LIKE '" + kongextend.getSexes() + "'";
					}else{
						operate_Condition += " and 性别 LIKE '" + kongextend.getSexes() + "'";
					}
				}
				if(kongextend.getNativeplace() != null && !"".equals(kongextend.getNativeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "籍贯 LIKE '" + kongextend.getNativeplace() + "'";
					}else{
						operate_Condition += " and 籍贯 LIKE '" + kongextend.getNativeplace() + "'";
					}
				}
				if(kongextend.getHomeplace() != null && !"".equals(kongextend.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + kongextend.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + kongextend.getHomeplace() + "'";
					}
				}
				if(kongextend.getJointtype() != 0){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextend.getJointtype() + "'";
					}else{
						operate_Condition += " and 联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextend.getJointtype() + "'";
					}
				}
				if(kongextend.getIsassign() != 0){
					if("".equals(operate_Condition)){
						operate_Condition += "是否分配(0-未分配 1-已分配) = '" + kongextend.getIsassign() + "'";
					}else{
						operate_Condition += " and 是否分配(0-未分配 1-已分配) = '" + kongextend.getIsassign() + "'";
					}
				}
				if(kongextend.getIncontrollevel() != null && !"".equals(kongextend.getIncontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "在控状态 LIKE '" + kongextend.getIncontrollevel() + "'";
					}else{
						operate_Condition += " and 在控状态 LIKE '" + kongextend.getIncontrollevel() + "'";
					}
				}
				if(kongextend.getJurisdictunit1() != null && !"".equals(kongextend.getJurisdictunit1())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任单位 = '" + kongextend.getJurisdictunit1() + "'";
					}else{
						operate_Condition += " and 管辖责任单位 = '" + kongextend.getJurisdictunit1() + "'";
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
				log.setOperate_Name("查询涉恐人员");
				String operate_Condition = "";
				if(kongextend.getCardnumber() != null && !"".equals(kongextend.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + kongextend.getCardnumber() + "'";
				}
				if(kongextend.getPersonname() != null && !"".equals(kongextend.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + kongextend.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + kongextend.getPersonname() + "'";
					}
				}
				if(kongextend.getSexes() != null && !"".equals(kongextend.getSexes())){
					if("".equals(operate_Condition)){
						operate_Condition += "性别 LIKE '" + kongextend.getSexes() + "'";
					}else{
						operate_Condition += " and 性别 LIKE '" + kongextend.getSexes() + "'";
					}
				}
				if(kongextend.getNativeplace() != null && !"".equals(kongextend.getNativeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "籍贯 LIKE '" + kongextend.getNativeplace() + "'";
					}else{
						operate_Condition += " and 籍贯 LIKE '" + kongextend.getNativeplace() + "'";
					}
				}
				if(kongextend.getHomeplace() != null && !"".equals(kongextend.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + kongextend.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + kongextend.getHomeplace() + "'";
					}
				}
				if(kongextend.getJointtype() != 0){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextend.getJointtype() + "'";
					}else{
						operate_Condition += " and 联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextend.getJointtype() + "'";
					}
				}
				if(kongextend.getIsassign() != 0){
					if("".equals(operate_Condition)){
						operate_Condition += "是否分配(0-未分配 1-已分配) = '" + kongextend.getIsassign() + "'";
					}else{
						operate_Condition += " and 是否分配(0-未分配 1-已分配) = '" + kongextend.getIsassign() + "'";
					}
				}
				if(kongextend.getIncontrollevel() != null && !"".equals(kongextend.getIncontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "在控状态 LIKE '" + kongextend.getIncontrollevel() + "'";
					}else{
						operate_Condition += " and 在控状态 LIKE '" + kongextend.getIncontrollevel() + "'";
					}
				}
				if(kongextend.getJurisdictunit1() != null && !"".equals(kongextend.getJurisdictunit1())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任单位 = '" + kongextend.getJurisdictunit1() + "'";
					}else{
						operate_Condition += " and 管辖责任单位 = '" + kongextend.getJurisdictunit1() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
	        return result;
	}
	
	/**
	 * 添加涉恐人员信息
	 * @param personnel
	 * @param heieditor
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addKongPersonel.do")
	public @ResponseBody String addKongPersonel(Personnel personnel,KongExtend  kongextend,String ybssid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addKongPersonel.do.......................Jurisdictunit1="+kongextend.getJurisdictunit1()+"    Jurisdictunit2="+kongextend.getJurisdictunit2());
		try {
			int findid=personnelDao.findPersonInPersonnel(personnel.getCardnumber());
			if(findid>0){
				Personnel person=personnelDao.getById(findid);//根据身份证号查询人员基本信息
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为治安风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
				}
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1!="")zslabel1+=",";
				zslabel1+="2";
				person.setJdunit1(kongextend.getJurisdictunit1()+"");
				person.setJdpolice1(kongextend.getJurisdictpolice1()+"");
				if(kongextend.getJurisdictpolice1()!=null){
					User jurisdictpolice1=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice1()));
					person.setPphone1(jurisdictpolice1.getContactnumber());
				}
				person.setJdunit2(kongextend.getJurisdictunit2()+"");
				person.setJdpolice2(kongextend.getJurisdictpolice2()+"");
				if(kongextend.getJurisdictpolice2()!=null){
					User jurisdictpolice2=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice2()));
					person.setPphone2(jurisdictpolice2.getContactnumber());
				}
				person.setZslabel1(zslabel1);
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setUpdatetime(addtime);
				personnelDao.update(person);
				
				/*****添加涉恐子表信息*****/
				kongextend.setPersonnelid(findid);
				kongextend.setAddoperator(userSession.getLoginUserName());
				kongextend.setAddtime(addtime);
				if(kongextend.getJurisdictunit1().equals("0")&&kongextend.getJurisdictunit2().equals("0")){
					kongextend.setIsassign(1);
				}else{
					kongextend.setZptime(addtime);
					 kongextend.setIsassign(2);
				}
				kongExtendDao.add(kongextend);
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				/*****新增背景审查*****/
				if(!"".equals(kongextend.getSuspectaffair())){
					KongBackground kongBackground = new KongBackground();
					kongBackground.setPersonnelid(findid);
					kongBackground.setDatatype(1);
					kongBackground.setChecktime(TimeFormate.getYMD());
					kongBackground.setChecktype("平台核查");
					kongBackground.setCheckresume(kongextend.getSuspectaffair());
					kongBackground.setValidflag(1);
					kongBackground.setAddoperator(userSession.getLoginUserName());
					kongBackground.setAddtime(TimeFormate.getISOTimeToNow());
					kongBackground.setUpdateoperator(userSession.getLoginUserName());
					kongBackground.setUpdatetime(TimeFormate.getISOTimeToNow());
					kongControlPowerDao.addKongBackground(kongBackground);
				}
				
				message= new Message("true","涉恐人员-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addKongPersonel.do.......................添加成功");
			}else{
				/*****一标三识数据关联*****/
				Personnel ybssPersonnel = new Personnel();
			    if(ybssid!=null&&!"".equals(ybssid)){
			    	ybssPersonnel=kaKouDao.getYbssRkByID(ybssid);
			    	personnel.setPersontype(ybssPersonnel.getPersontype());
			    	personnel.setNation(ybssPersonnel.getNation());
			    	personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
			    	personnel.setEducation(ybssPersonnel.getEducation());
			    	personnel.setWorkplace(ybssPersonnel.getWorkplace());
			    	personnel.setHomex(ybssPersonnel.getHomex());
			    	personnel.setHomey(ybssPersonnel.getHomey());
			    }
				/*****风险人员主表添加*****/
		        personnel.setZslabel1("2");
		        personnel.setJdunit1(kongextend.getJurisdictunit1()+"");
		        personnel.setJdpolice1(kongextend.getJurisdictpolice1()+"");
		        if(kongextend.getJurisdictpolice1()!=null&&!"".equals(kongextend.getJurisdictpolice1())){
					User jurisdictpolice1=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice1()));
					if(jurisdictpolice1!=null&&jurisdictpolice1.getContactnumber()!=null){
						personnel.setPphone1(jurisdictpolice1.getContactnumber());
					}
				}
		        personnel.setJdunit2(kongextend.getJurisdictunit2()+"");
		        personnel.setJdpolice2(kongextend.getJurisdictpolice2()+"");
		        if(kongextend.getJurisdictpolice2()!=null&&!"".equals(kongextend.getJurisdictpolice2())){
					User jurisdictpolice2=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice2()));
					if(jurisdictpolice2!=null&&jurisdictpolice2.getContactnumber()!=null){
						personnel.setPphone2(jurisdictpolice2.getContactnumber());
					}
				}
		        personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
		        personnel.setValidflag(1);
		        personnel.setAddoperator(userSession.getLoginUserName());
		        personnel.setAddoperatorid(userSession.getLoginUserID());
		        personnel.setAddtime(addtime);
				int personid=personnelDao.add(personnel);
				if(ybssPersonnel.getTelnumber()!=null&&!"".equals(ybssPersonnel.getTelnumber())){
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
				/*****默认添加空关联信息*****/
				Relation relation=new Relation();
			    relation.setPersonnelid(personid);
			    relationDao.addrelation(relation);
				/*****涉恐人员子表添加*****/
				kongextend.setPersonnelid(personid);
				kongextend.setAddoperator(userSession.getLoginUserName());
				kongextend.setAddtime(addtime);
				if(kongextend.getJurisdictunit1().equals("0")&&kongextend.getJurisdictunit2().equals("0")){
					kongextend.setIsassign(1);
				}else{
					kongextend.setZptime(addtime);
					 kongextend.setIsassign(2);
				}
				kongExtendDao.add(kongextend);
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				/*****新增背景审查*****/
				if(!"".equals(kongextend.getSuspectaffair())){
					KongBackground kongBackground = new KongBackground();
					kongBackground.setPersonnelid(personid);
					kongBackground.setDatatype(1);
					kongBackground.setChecktime(TimeFormate.getYMD());
					kongBackground.setChecktype("平台核查");
					kongBackground.setCheckresume(kongextend.getSuspectaffair());
					kongBackground.setValidflag(1);
					kongBackground.setAddoperator(userSession.getLoginUserName());
					kongBackground.setAddtime(TimeFormate.getISOTimeToNow());
					kongBackground.setUpdateoperator(userSession.getLoginUserName());
					kongBackground.setUpdatetime(TimeFormate.getISOTimeToNow());
					kongControlPowerDao.addKongBackground(kongBackground);
				}
				
				message= new Message("true","涉恐人员-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addKongPersonel.do.......................添加成功");
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加涉恐人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addKongPersonel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉恐人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getKongPersonelUpdate.do")
	public String getHeiPersonelUpdate(KongExtend  kongextend,int menuid,String buttons,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getKongPersonelUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		model.addAttribute("buttons",buttons);
		try {
		    //获取基本信息
		    Personnel personnel=personnelDao.getById(kongextend.getPersonnelid());
			model.addAttribute("personnel",personnel);
			int age=CardnumberInfo.getAge(personnel.getCardnumber());
			model.addAttribute("age",age);
		     kongextend=kongExtendDao.getKongExtendBypersonnelid(kongextend.getPersonnelid());	//关联信息
			 model.addAttribute("kongextend",kongextend);
			 Relation relation=relationDao.searchrelation(kongextend.getPersonnelid());	//关联信息
		     model.addAttribute("relation",relation);
			
			
			if(page.equals("update")){
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
				
				List<BasicMsg> religion=basicMsgDao.getByType(33);//宗教特征情况
				model.addAttribute("religion",religion);
				List<BasicMsg> suspiciousthing=basicMsgDao.getByType(34);//可疑物品情况
				model.addAttribute("suspiciousthing",suspiciousthing);
				
				url="/jsp/personel/kong/update";
			}else if(page.equals("assign")){
				//派出所
				Department policeDepartment=new Department();
				policeDepartment.setDeparttype(String.valueOf(4));
				List<Department> policeList=departmentDao.getDepartmentList(policeDepartment);
				model.addAttribute("policeList",policeList);
				url="/jsp/personel/kong/assign";
			}else{
				url="/jsp/personel/kong/showinfo";
			}    
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID获取涉恐人员信息");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + kongextend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID获取涉恐人员信息");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + kongextend.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return url;
	}	
	
	
	@RequestMapping("/updateKongPersonel.do")
	public @ResponseBody String updateKongPersonel(KongExtend  kongextend,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongPersonel.do.......................");
		try {
		    personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			personnelDao.updateSK(personnel);
			
			kongextend.setId(Integer.parseInt(kongextend.getKongextendid()));
			kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
		   
			kongExtendDao.updateJSGK(kongextend);//分色管控信息
			message = new Message("true","涉恐人员-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateKongPersonel.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongPersonel.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateKongPersonelZP.do")
	public @ResponseBody String updateKongPersonelZP(KongExtend  kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongPersonelZP.do......................."+kongextend.getJurisdictunit2());
		try {
		    kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
			if(kongextend.getJurisdictunit1()!="0"){
				kongextend.setIsassign(2);
			}else{
				if(kongextend.getJurisdictunit2()!="0"){
					kongextend.setIsassign(2);
				}else{
					kongextend.setIsassign(1);
				}
			}
			kongExtendDao.updateZP(kongextend);//指派信息修改
			
			Personnel person=personnelDao.getById(kongextend.getPersonnelid());//根据身份证号查询人员基本信息
			User jurisdictpolice1=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice1()));
			if(!kongextend.getJurisdictunit2().equals("0")){
				User jurisdictpolice2=userDao.getById(Integer.parseInt(kongextend.getJurisdictpolice2()));
				person.setPphone2(jurisdictpolice2.getContactnumber());
				if(jurisdictpolice2.getContactnumber()!=null&&!"".equals(jurisdictpolice2.getContactnumber())){
					//调用短信接口发送管辖民警信息
					new ShortMessageDao().sendmessage(jurisdictpolice2.getContactnumber(),"【风控平台】您有新指派涉恐管控目标："+person.getPersonname());
				}
			}
			
			person.setJdunit1(kongextend.getJurisdictunit1()+"");
			person.setJdpolice1(kongextend.getJurisdictpolice1()+"");
			person.setPphone1(jurisdictpolice1.getContactnumber());
			person.setJdunit2(kongextend.getJurisdictunit2()+"");
			person.setJdpolice2(kongextend.getJurisdictpolice2()+"");
			
			person.setUpdateoperator(userSession.getLoginUserName());
			person.setUpdatetime(addtime);
			personnelDao.update(person);
			
			message = new Message("true","涉恐人员-指派信息修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-指派信息修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateKongPersonelZP.do.......................修改成功");
			//发送短信
			if(jurisdictpolice1.getContactnumber()!=null&&!"".equals(jurisdictpolice1.getContactnumber())){
				//调用短信接口发送管辖民警信息
				new ShortMessageDao().sendmessage(jurisdictpolice1.getContactnumber(),"【风控平台】您有新指派涉恐管控目标："+person.getPersonname());
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员指派信息修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-指派信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-指派信息修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongPersonelZP.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员指派信息修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getKongExtendByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getKongExtendByPersonnelid(int personnelid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("getKongExtendByPersonnelid.do.......................查询可疑特征");
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			KongExtend kongextend=kongExtendDao.getKongExtendBypersonnelid(personnelid);
			if(kongextend==null)result.put("firstRisk",0);
			else result.put("firstRisk",1);
			result.put("kongextend",kongextend);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询可疑特征");
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
			log.setOperate_Name("查询可疑特征");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + personnelid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	@RequestMapping("/updateKYTZ.do")
	public @ResponseBody String updateKYTZ(KongExtend  kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKYTZ.do.......................");
		try {
		    kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
		   
			kongExtendDao.updateKYTZ(kongextend);//可疑特征
			message = new Message("true","涉恐人员-可疑特征修改成功！");
			message.setFlag(kongextend.getPersonnelid());
			logDao.recordLog(menuid, "风险人员-涉恐人员-可疑特征修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateKYTZ.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员可疑特征修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-可疑特征修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-可疑特征修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKYTZ.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员可疑特征修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updatecontroltime.do")
	public @ResponseBody String updatecontroltime(KongExtend  kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updatecontroltime.do.......................");
		try {
		    kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
		   
			kongExtendDao.updatecontroltime(kongextend);//管控时间
			message = new Message("true","涉恐人员-管控时间修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-管控时间修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updatecontroltime.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员管控时间修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-管控时间修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-管控时间修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updatecontroltime.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员管控时间修改");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateincontrollevel.do")
	public @ResponseBody String updateincontrollevel(KongExtend  kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateincontrollevel.do.......................");
		try {
		    kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setGdtime(addtime);
			kongextend.setIncontrollevel("归档");
			kongExtendDao.gdKong(kongextend);//可疑特征
			message = new Message("true","涉恐人员-归档成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-归档", userSession.getLoginUserName(), addtime, "归档成功", "");
			System.out.println("updateincontrollevel.do.......................归档成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员归档");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-归档失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-归档", userSession.getLoginUserName(), addtime, "归档失败", "");
			System.out.println("updateincontrollevel.do.......................归档失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员归档");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/updateincontrollevelhy.do")
	public @ResponseBody String updateincontrollevelhy(KongExtend  kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateincontrollevelhy.do.......................");
		try {
		    kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
			kongextend.setIncontrollevel("在控");
			kongextend.setIsassign(1);
			kongextend.setJurisdictunit1("");
			kongextend.setJurisdictpolice1("");
			kongExtendDao.reduction(kongextend);//可疑特征
			message = new Message("true","涉恐人员-还原成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-还原", userSession.getLoginUserName(), addtime, "还原成功", "");
			System.out.println("updateincontrollevelhy.do.......................归档成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员还原");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-还原失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-还原", userSession.getLoginUserName(), addtime, "还原失败", "");
			System.out.println("updateincontrollevelhy.do.......................归档失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员还原");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelKongPersonel.do")
	public @ResponseBody String cancelKongPersonel(KongExtend kongextend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelKongPersonel.do.......................");
		try {
			kongextend.setUpdateoperator(userSession.getLoginUserName());
			kongextend.setUpdatetime(addtime);
			kongExtendDao.cancel(kongextend);
			
			Personnel person=personnelDao.getById(kongextend.getPersonnelid());
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
			int labelindex=Arrays.binarySearch(labelint,2);//涉恐-2
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex&&labelint[i]!=0){
					if(!"".equals(newlabel))newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			person.setZslabel1(newlabel);
			personnelDao.update(person);
			System.out.println("cancelKongPersonel.do.......................更新风险人员标签!!!!");
			/*if(newlabel.equals("")){
				if(person.getAttributelabels().equals("")){//人员属性标签为空 且 人员类型标签为空 即可彻底删除人员
					personnelDao.cancel(person);
					System.out.println("cancelKongPersonel.do.......................同时删除风险人员!!!!");
				}else{//人员类型为空 但存在其他人员属性标签 不可删除
					person.setPersonlabel("");
					personnelDao.update(person);
				}
			}else {
				person.setPersonlabel(newlabel);
				personnelDao.update(person);
				System.out.println("cancelKongPersonel.do.......................更新风险人员标签!!!!");
			}*/
			
			message = new Message("true","涉恐人员-删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelKongPersonel.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员删除");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelKongPersonel.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员删除");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongextend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	 /**  *********************************************************************日常管控***************************************************************  **/
	@RequestMapping("/searchKongDailyControl.do")
	@ResponseBody
	public Map<String,Object>  searchKongDailyControl(KongDailyControl kongdailycontrol,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchKongDailyControl.do..............="+userSession.getLoginUserID());
		   pm.setPageNumber(page); 
		   NewPageModel listTemp=kongExtendDao.searchKongDailyControl(kongdailycontrol, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询日常管控");
			String operate_Condition = "";
			if(kongdailycontrol.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + kongdailycontrol.getPersonnelid() + "'";
			}
			if(kongdailycontrol.getControltype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "日常管控类型（1-三天一走访 2-每月评估） = '" + kongdailycontrol.getControltype() + "'";
				}else{
					operate_Condition += " and 日常管控类型（1-三天一走访 2-每月评估） = '" + kongdailycontrol.getControltype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addkongdailycontrol.do")
	public @ResponseBody String addkongdailycontrol(KongDailyControl kongdailycontrol,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addkongdailycontrol.do.......................");
		try {
			    kongdailycontrol.setAddtime(addtime);
			    kongdailycontrol.setAddoperatorid(userSession.getLoginUserID());
			    kongdailycontrol.setAddoperator(userSession.getLoginUserName());
			    kongExtendDao.addkongdailycontrol(kongdailycontrol);
			    KongExtend kongExtend = new KongExtend();
			    kongExtend.setPersonnelid(kongdailycontrol.getPersonnelid());
			    kongExtend.setUpdateoperator(userSession.getLoginUserName());
			    kongExtend.setUpdatetime(addtime);
			    kongExtendDao.updateKongTime(kongExtend);
				message= new Message("true","日常管控信息添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员--日常管控信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addkongdailycontrol.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("日常管控信息添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","日常管控信息添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--日常管控信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addkongdailycontrol.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("日常管控信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/searchdailycontrolbyid.do")
	public String searchdailycontrolbyid(int id,String page,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("searchdailycontrolbyid.do.................id="+id);
		KongDailyControl kongdailycontrol=kongExtendDao.searchdailycontrolbyid(id);
		model.addAttribute("kongdailycontrol", kongdailycontrol);
		String  urlString="";
		if(page.equals("dailycontrol")){
			urlString="jsp/personel/kong/dailycontrol/update";
		}else if(page.equals("zhengbao_assessment")){
			urlString="jsp/personel/zhengbao/assessment/update";
		}else{
			urlString="jsp/personel/kong/monthlyassessment/update";
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询日常管控");
		String operate_Condition = "";
		operate_Condition += "日常管控id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/updatekongdailycontrol.do")
	public @ResponseBody String updatekongdailycontrol(KongDailyControl kongdailycontrol,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatekongdailycontrol.do.......................");
		try {
			    kongdailycontrol.setUpdatetime(updatetime);
			    kongdailycontrol.setUpdateoperator(userSession.getLoginUserName());
			    kongExtendDao.updatekongdailycontrol(kongdailycontrol);
			    KongExtend kongExtend = new KongExtend();
			    kongExtend.setPersonnelid(kongdailycontrol.getPersonnelid());
			    kongExtend.setUpdateoperator(userSession.getLoginUserName());
			    kongExtend.setUpdatetime(updatetime);
			    kongExtendDao.updateKongTime(kongExtend);
				message= new Message("true","日常管控信息修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员--日常管控信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
				System.out.println("updatekongdailycontrol.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("日常管控信息修改");
				String operate_Condition = "";
				operate_Condition += "日常管控id = '" + kongdailycontrol.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","日常管控信息修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--日常管控信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatekongdailycontrol.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("日常管控信息修改");
			String operate_Condition = "";
			operate_Condition += "日常管控id = '" + kongdailycontrol.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/cancelkongdailycontrol.do")
	public @ResponseBody String cancelkongdailycontrol(KongDailyControl kongdailycontrol,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelkongdailycontrol.do.......................");
		try {
			   kongdailycontrol.setUpdatetime(updatetime);
			   kongdailycontrol.setUpdateoperator(userSession.getLoginUserName());
			   kongExtendDao.cancelkongdailycontrol(kongdailycontrol);
				message= new Message("true","日常管控信息作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员--日常管控信息作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("cancelkongdailycontrol.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("日常管控信息作废");
				String operate_Condition = "";
				operate_Condition += "日常管控id = '" + kongdailycontrol.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","日常管控信息作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--日常管控信息作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelkongdailycontrol.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("日常管控信息作废");
			String operate_Condition = "";
			operate_Condition += "日常管控id = '" + kongdailycontrol.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
	@RequestMapping("/exportKongPersonnel.do")
	public void exportHeiPersonnel(HttpServletResponse response,KongExtend kongextendl,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,
											String personnelfield,String personneltext,
											String gradefield,String gradetext,
											String relationfield,String relationtext,
										    String showfield,String showtext,
											int menuid){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportKongPersonnel.do.......................gradefield="+gradefield+"  gradetext="+gradetext+"  relationfield="+relationfield+"  relationtext="+relationtext+"  showfield="+showfield+"  showtext="+showtext);
		
		try {
			List<KongExtend> list=kongExtendDao.searchKongPersonnelList(kongextendl);
			System.out.println("要导出数据共计行数===== "+list.size() );
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("风险人员(涉恐)信息.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet("涉恐人员");
				
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
				HSSFRichTextString valuehead = new HSSFRichTextString("涉恐人员信息");
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
				/*可编辑人员信息*/
				if(gradelength>0){
					if(gradelength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+gradelength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("分色管控信息");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=gradelength;
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
			
				/*现实表现*/
				if(showlength>0){
					if(showlength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+showlength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("现实表现");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=showlength;
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
				if(relationlength>0){
					for(int i=0;i<relationlength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(relationtextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=relationlength;
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
				
				/*数据行*/
				/*创建行*/
				for (int i = 0; i < list.size(); i++) {
					System.out.println("循环写入数据=============第"+i+"行" );
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
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=gradelength;
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
					
					if(showlength>0){
						node=JSONObject.fromObject(list.get(i));
						for (int j = 0; j < showlength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 6000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(showfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=showlength;
					}
				}
				
				message = new Message("true","涉恐人员导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "涉恐人员导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
			}else {
				message = new Message("false","涉恐人员-无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
			}
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员导出");
			String operate_Condition = "";
			if(kongextendl.getCardnumber() != null && !"".equals(kongextendl.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + kongextendl.getCardnumber() + "'";
			}
			if(kongextendl.getPersonname() != null && !"".equals(kongextendl.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + kongextendl.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + kongextendl.getPersonname() + "'";
				}
			}
			if(kongextendl.getSexes() != null && !"".equals(kongextendl.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + kongextendl.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + kongextendl.getSexes() + "'";
				}
			}
			if(kongextendl.getNativeplace() != null && !"".equals(kongextendl.getNativeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "籍贯 LIKE '" + kongextendl.getNativeplace() + "'";
				}else{
					operate_Condition += " and 籍贯 LIKE '" + kongextendl.getNativeplace() + "'";
				}
			}
			if(kongextendl.getHomeplace() != null && !"".equals(kongextendl.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + kongextendl.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + kongextendl.getHomeplace() + "'";
				}
			}
			if(kongextendl.getJointtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextendl.getJointtype() + "'";
				}else{
					operate_Condition += " and 联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextendl.getJointtype() + "'";
				}
			}
			if(kongextendl.getIsassign() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否分配(0-未分配 1-已分配) = '" + kongextendl.getIsassign() + "'";
				}else{
					operate_Condition += " and 是否分配(0-未分配 1-已分配) = '" + kongextendl.getIsassign() + "'";
				}
			}
			if(kongextendl.getIncontrollevel() != null && !"".equals(kongextendl.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 LIKE '" + kongextendl.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 LIKE '" + kongextendl.getIncontrollevel() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉恐人员-导出失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-导出", userSession.getLoginUserName(), addtime, "导出失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员导出");
			String operate_Condition = "";
			if(kongextendl.getCardnumber() != null && !"".equals(kongextendl.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + kongextendl.getCardnumber() + "'";
			}
			if(kongextendl.getPersonname() != null && !"".equals(kongextendl.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + kongextendl.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + kongextendl.getPersonname() + "'";
				}
			}
			if(kongextendl.getSexes() != null && !"".equals(kongextendl.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 LIKE '" + kongextendl.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 LIKE '" + kongextendl.getSexes() + "'";
				}
			}
			if(kongextendl.getNativeplace() != null && !"".equals(kongextendl.getNativeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "籍贯 LIKE '" + kongextendl.getNativeplace() + "'";
				}else{
					operate_Condition += " and 籍贯 LIKE '" + kongextendl.getNativeplace() + "'";
				}
			}
			if(kongextendl.getHomeplace() != null && !"".equals(kongextendl.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + kongextendl.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + kongextendl.getHomeplace() + "'";
				}
			}
			if(kongextendl.getJointtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextendl.getJointtype() + "'";
				}else{
					operate_Condition += " and 联控级别(1-红色、2-橙色、3-黄色、4-蓝色) = '" + kongextendl.getJointtype() + "'";
				}
			}
			if(kongextendl.getIsassign() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "是否分配(0-未分配 1-已分配) = '" + kongextendl.getIsassign() + "'";
				}else{
					operate_Condition += " and 是否分配(0-未分配 1-已分配) = '" + kongextendl.getIsassign() + "'";
				}
			}
			if(kongextendl.getIncontrollevel() != null && !"".equals(kongextendl.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 LIKE '" + kongextendl.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 LIKE '" + kongextendl.getIncontrollevel() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
	}
	
	@RequestMapping("/exportKongPersonel.do")
	public void exportKongPersonel(Personnel personnel,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession){
		try {
			//模板位置
			String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\personel\\template\\fsgk.xls";
			TemplateExportParams params = new TemplateExportParams(templateFileName,true);
			Map<String, Object> map = new HashMap<String, Object>();
			SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String addtime=dateFormat.format(new Date());
			//获取涉恐人员信息
			int personid = personnel.getId();
			KongExtend kongExtend = new KongExtend();
			kongExtend.setPersonnelid(personid);
			kongExtend = kongExtendDao.exportPersonnelById(kongExtend);
			personnel = kongExtend.getExportPersonnel();
			//填充图片
			if(kongExtend.getFilesallname()!=null&&!"".equals(kongExtend.getFilesallname())){
				String imageUrlStr="";
				if(kongExtend.getFilevalidflag()>1){
					imageUrlStr = uploadFile+"\\"+kongExtend.getFilesallname();
				}else{
					imageUrlStr = uploadFile_Pricture+"\\"+kongExtend.getFilesallname();
				}
				File file = new File(imageUrlStr);
				if(file.exists()) {
					ImageEntity imageEntity=new ImageEntity(FileUtil.getBytesByFile(imageUrlStr),100,150);
					map.put("image", imageEntity);
				}else{
					imageUrlStr = request.getSession().getServletContext().getRealPath("")+"\\images\\nophoto.png";
					ImageEntity imageEntity=new ImageEntity(FileUtil.getBytesByFile(imageUrlStr),100,150);
					map.put("image", imageEntity);
				}
			}
			//获取主要社会关系
			List<SocialRelations> socialrelationsList = relationDao.getNewSocialrelations(personid);
			//获取使用交通工具情况
			List<RelationVehicle> relcationvehicleList = relationDao.getNewRelationvehicle(personid);
			//获取工作地，居住地
			KongBackground kongbackground = new KongBackground();
			kongbackground.setPersonnelid(personid);
			kongbackground.setDatatype(2);
			List<KongBackground> kongBackgroundList = kongControlPowerDao.getNewKongBackground(kongbackground);
			//获取三日一走访数据
			KongDailyControl kongDailyControl = new KongDailyControl();
			kongDailyControl.setPersonnelid(personid);
			kongDailyControl.setControltype(1);
			List<KongDailyControl> kongdailyControlList = kongExtendDao.getNewDailycontrol(kongDailyControl);
			//填充数据
			if(personnel.getPersonname()!=null){
				map.put("personname", personnel.getPersonname());
			}
			if(personnel.getCardnumber()!=null){
				map.put("cardnumber", personnel.getCardnumber());
			}
			if(personnel.getCardnumber()!=null){
				map.put("birthday", CardnumberInfo.getBirthDay(personnel.getCardnumber()));
			}
			if(personnel.getSexes()!=null){
				map.put("sexes", personnel.getSexes());
			}
			if(personnel.getEducation()!=null){
				map.put("education", personnel.getEducation());
			}
			if(personnel.getUsedname()!=null){
				map.put("usedname", personnel.getUsedname());
			}
			if(personnel.getNickname()!=null){
				map.put("nickname", personnel.getNickname());
			}
			if(personnel.getPersontype()!=null){
				map.put("persontype", personnel.getPersontype());
			}
			if(personnel.getHouseplace()!=null){
				map.put("houseplace", personnel.getHouseplace());
			}
			if(personnel.getHomeplace()!=null){
				map.put("homeplace", personnel.getHomeplace());
			}
			if(personnel.getHomepolice()!=null){
				map.put("homepolice", personnel.getHomepolice());
			}
			
			if(kongExtend.getIdentity()!=null){
				map.put("identity", kongExtend.getIdentity());
			}
			if(kongExtend.getEngagedwork()!=null){
				map.put("engagedwork", kongExtend.getEngagedwork());
			}
			if(kongExtend.getServiceplace()!=null){
				map.put("serviceplace", kongExtend.getServiceplace());
			}
			if(kongExtend.getCometime()!=null){
				map.put("cometime", kongExtend.getCometime());
			}
			if(kongExtend.getLeavetime()!=null){
				map.put("leavetime", kongExtend.getLeavetime());
			}
			if(kongExtend.getComereason()!=null){
				map.put("comereason", kongExtend.getComereason());
			}
			if(kongExtend.getWechat()!=null){
				map.put("wechat", kongExtend.getWechat());
			}
			if(kongExtend.getQq()!=null){
				map.put("qq", kongExtend.getQq());
			}
			if(kongExtend.getContractperson()!=null){
				map.put("contractperson", kongExtend.getContractperson());
			}
			if(kongExtend.getSuspectaffair()!=null){
				map.put("suspectaffair", kongExtend.getSuspectaffair());
			}
			if(kongExtend.getExportRelation()!=null&&kongExtend.getExportRelation().getTelnumber()!=null){
				map.put("telnumber", kongExtend.getExportRelation().getTelnumber());
			}
			if(kongExtend.getCheckresume()!=null){
				map.put("checkresume", kongExtend.getCheckresume());
			}
			
			//社会关系
			List<Map<String, String>> socialrelationList = new ArrayList<Map<String, String>>();
			for(int i=0;i<socialrelationsList.size();i++){
				Map<String, String> lm = new HashMap<String, String>();
				lm.put("cardnumber", socialrelationsList.get(i).getCardnumber());
				lm.put("personname", socialrelationsList.get(i).getPersonname());
				lm.put("relationtype", socialrelationsList.get(i).getRelationtype());
				lm.put("homeplace", socialrelationsList.get(i).getHomeplace());
				socialrelationList.add(lm);
			}
			//车辆
			List<Map<String, String>> vehicleList = new ArrayList<Map<String, String>>();
			for(int i=0;i<relcationvehicleList.size();i++){
				Map<String, String> lm = new HashMap<String, String>();
				lm.put("vehicletype", relcationvehicleList.get(i).getVehicletype());
				lm.put("vehiclenum", relcationvehicleList.get(i).getVehiclenum());
				lm.put("vehicleorigin", relcationvehicleList.get(i).getVehicleorigin());
				vehicleList.add(lm);
			}
			//背景审查
			List<Map<String, String>> BackgroundList = new ArrayList<Map<String, String>>();
			for(int i=0;i<kongBackgroundList.size();i++){
				Map<String, String> lm = new HashMap<String, String>();
				lm.put("checktime", kongBackgroundList.get(i).getChecktime());
				lm.put("checktype", kongBackgroundList.get(i).getChecktype());
				BackgroundList.add(lm);
			}
			//日常管控
			List<Map<String, String>> dailyControlList = new ArrayList<Map<String, String>>();
			for(int i=0;i<kongdailyControlList.size();i++){
				Map<String, String> lm = new HashMap<String, String>();
				lm.put("controltime", kongdailyControlList.get(i).getControltime());
				lm.put("controlmode", kongdailyControlList.get(i).getControlmode());
				lm.put("addoperatordepart", kongdailyControlList.get(i).getAddoperatordepart());
				dailyControlList.add(lm);
			}
			map.put("socialrelationList", socialrelationList);
			map.put("vehicleList", vehicleList);
			map.put("BackgroundList", BackgroundList);
			map.put("dailyControlList", dailyControlList);
			Workbook workbook = ExcelExportUtil.exportExcel(params, map);
			/*设置输出类型*/
			response.setContentType("application/vnd.ms-excel");
			response.setCharacterEncoding("utf-8");
			/*设置输出文件名称*/
			String title = "涉恐_"+personnel.getPersonname()+"_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".xls", "UTF-8"));
			OutputStream outputStream=response.getOutputStream();
			workbook.write(outputStream);
			logDao.recordLog(0, "风险人员-涉恐人员-详细信息导出", userSession.getLoginUserName(), addtime, "导出成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员详细信息导出");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + personid + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员详细信息导出");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + personnel.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
	}
	
	/*模板文件需要是xlsx文件*/
	@RequestMapping("/exportKongcontrolpower.do")
	public void exportKongcontrolpower(KongControlPower kongControlPower,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession){
		try {
			//获取写入数据
			kongControlPower.setForcetype(1);
			List<KongControlPower> controlpowerList = kongControlPowerDao.exportKongcontrolpower(kongControlPower);
			//模板位置
			String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\personel\\template\\gggk.xlsx";
			File file = new File(templateFileName);
			FileInputStream fileInputStream = new FileInputStream(file);
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			//原模板只有一个sheet，通过poi复制出需要的sheet个数的模板
            XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);
            for (int i = 1; i < controlpowerList.size(); i++) {
                //复制模板，得到第i个sheet
                int num = i + 1;
                workbook.cloneSheet(0, "sheet" + num);
                //本机测试用
                //workbook.cloneSheet(0);
            }
            //写到流里
            workbook.write(bos);
            byte[] bArray = bos.toByteArray();
            InputStream is = new ByteArrayInputStream(bArray);
			/*设置输出类型*/
			response.setContentType("application/vnd.ms-excel");
			response.setCharacterEncoding("utf-8");
			/*设置输出文件名称*/
			String title = "公共管控力量_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".xlsx", "UTF-8"));
            ExcelWriter excelWriter = EasyExcel.write(response.getOutputStream()).withTemplate(is).build();
            //写入
            for(int i=0;i<controlpowerList.size();i++){
            	WriteSheet writeSheet = EasyExcel.writerSheet(i).build();
            	excelWriter.fill(controlpowerList.get(i), writeSheet);
            	KongPublicRelation kongpublicrelation = new KongPublicRelation();
            	kongpublicrelation.setControlpowerid(controlpowerList.get(i).getId());
            	kongpublicrelation.setRelationtype(1);
            	List<KongPublicRelation> publicRelationList = kongControlPowerDao.exportPublicrelation(kongpublicrelation);
            	kongpublicrelation.setRelationtype(2);
            	List<KongPublicRelation> socialRelationList = kongControlPowerDao.exportPublicrelation(kongpublicrelation);
            	List<KongPublicResume> publicResumeList = kongControlPowerDao.exportPublicresume(kongpublicrelation);
            	if(publicRelationList.size()>0){
            		excelWriter.fill(new FillWrapper("publicRelation",publicRelationList), writeSheet);
            	}
            	if(socialRelationList.size()>0){
            		excelWriter.fill(new FillWrapper("socialRelationList",socialRelationList), writeSheet);
            	}
            	if(publicResumeList.size()>0){
            		excelWriter.fill(new FillWrapper("publicResumeList",publicResumeList), writeSheet);
            	}
            }
            // 关闭流
            excelWriter.finish();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/importKongPersonel.do")
	@ResponseBody
    public   Map<String, Object>  importKongPersonel(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	Map<String, Object> json = new HashMap<String, Object>();  
    	String msg = "";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	System.out.println("importKongPersonel.do.......................");
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
            System.out.println("importKongPersonel.do.......................fileName="+fileName+"   totalRows="+totalRows);
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
                  		   person.setCardnumber(rowdata.getCell(0).getStringCellValue());
                  		   person.setPersonname(rowdata.getCell(1).getStringCellValue());
                  		   person.setZslabel1("2");//标签 涉恐-1
                  		   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
                  		   person.setValidflag(1);
                  		   person.setAddoperator(userSession.getLoginUserName());
                  		   person.setAddoperatorid(userSession.getLoginUserID());
                  		   person.setAddtime(addtime);
                  		   int personid=personnelDao.add(person);
                  		   person=personnelDao.getById(personid);
                  		   boolean personUpdate=false;
                  		 KongExtend kongextend=new KongExtend();
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
                  		  if(rowdata.getCell(7)!=null){//籍贯
                			   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                			   kongextend.setNativeplace(rowdata.getCell(7).getStringCellValue());
                			}
                  		   if(rowdata.getCell(8)!=null){//人员类别
                  			   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setPersontype(rowdata.getCell(8).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(9)!=null){//兵役状况
                  			   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setSoldierstatus(rowdata.getCell(9).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(10)!=null){//健康状态
                  			   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHeathstatus(rowdata.getCell(10).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(11)!=null){//政治面貌
                  			   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setPoliticalposition(rowdata.getCell(11).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(12)!=null){//宗教信仰
                  			   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setFaith(rowdata.getCell(12).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(13)!=null){//文化程度
                  			   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setEducation(rowdata.getCell(13).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(14)!=null){//网络社交技能习惯
                  			   rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setNetskillhabit(rowdata.getCell(14).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(15)!=null){//户籍地详址
                  			   rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHouseplace(rowdata.getCell(15).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		   if(rowdata.getCell(16)!=null){//户籍地派出所
                  			   rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
                  			   person.setHousepolice(rowdata.getCell(16).getStringCellValue());
                  			   personUpdate=true;
                  		   }
                  		  if(rowdata.getCell(17)!=null){//现住地详址
                 			   rowdata.getCell(17).setCellType(Cell.CELL_TYPE_STRING);
                 			   person.setHomeplace(rowdata.getCell(17).getStringCellValue());
                 			   personUpdate=true;
                 		   }
                  		  if(rowdata.getCell(18)!=null){//现住地派出所
                			   rowdata.getCell(18).setCellType(Cell.CELL_TYPE_STRING);
                			   person.setHomepolice(rowdata.getCell(18).getStringCellValue());
                			   personUpdate=true;
                		   }
                  		 if(rowdata.getCell(19)!=null){//工作地详址
	              			   rowdata.getCell(19).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setWorkplace(rowdata.getCell(19).getStringCellValue());
	              			   personUpdate=true;
              		      }
                  		 if(rowdata.getCell(20)!=null){//工作地派出所
	              			   rowdata.getCell(20).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setWorkpolice(rowdata.getCell(20).getStringCellValue());
	              			   personUpdate=true;
            		      }
                  		 if(rowdata.getCell(21)!=null){//特殊特征
	              			   rowdata.getCell(21).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setFeature(rowdata.getCell(21).getStringCellValue());
	              			   personUpdate=true;
          		           }
                  		 if(rowdata.getCell(22)!=null){//技能专长
	              			   rowdata.getCell(22).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setSpeciality(rowdata.getCell(22).getStringCellValue());
	              			   personUpdate=true;
          		          }
                  		 if(rowdata.getCell(23)!=null){//前科劣迹
	              			   rowdata.getCell(23).setCellType(Cell.CELL_TYPE_STRING);
	              			   person.setRecords(rowdata.getCell(23).getStringCellValue());
	              			   personUpdate=true;
          		          }
                  		   if(personUpdate)personnelDao.update(person);
                  		   
                  		   /*****默认添加空关联信息*****/
                  		   Relation relation=new Relation();
                  		   relation.setPersonnelid(personid);
                  		   relationDao.addrelation(relation);
	                  	   /*****添加涉恐子表信息*****/
	                  		kongextend.setPersonnelid(personid);
	   						kongextend.setAddoperator(userSession.getLoginUserName());
	   						kongextend.setAddtime(addtime);
	   						kongextend.setIsassign(1);
	   						kongExtendDao.add(kongextend);
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
        	msg+="<tr><td>成功导入：</td><td>风险人员（涉恐）<font color='red'>"+pCount+"</font> 名</td></tr>";
        	if(btmsg!=""){
        		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
        		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
        	}
        	msg+="</table>";
            json.put("success",msg);
            logDao.recordLog(0, "风险人员-涉恐人员-信息导入", userSession.getLoginUserName(), addtime, "导出成功", "");
    } catch (Exception e) {
        e.printStackTrace();
        logDao.recordLog(0, "风险人员-涉恐人员-信息导入", userSession.getLoginUserName(), addtime, "导出失败", "");
    }   
       return json;  
    }
	
	@RequestMapping("/getAllDailycontrol.do")
	@ResponseBody
	public Map<String,Object>  getAllDailycontrol(KongDailyControl kongdailycontrol,NewPageModel pm,int page,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/getAllDailycontrol.do..............="+userSession.getLoginUserID());
		   /**增加数据过滤   根据当前用户角色设置是否数据过滤 0-不过滤 1-单位过滤 2-民警过滤**/
		   kongdailycontrol.setIsFilter(userSession.getLoginRoleFieldFilter()+"");
		    if(userSession.getLoginRoleFieldFilter()==1){
		    	kongdailycontrol.setFiltervalue(userSession.getLoginUserDepartmentid()+"");
		    }else if(userSession.getLoginRoleFieldFilter()==2){
		    	kongdailycontrol.setFiltervalue(userSession.getLoginUserID()+"");
		    } 
		    pm.setPageNumber(page);
		   NewPageModel listTemp=kongExtendDao.getAllDailycontrol(kongdailycontrol, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        return result;
	}
	@RequestMapping("/exportAllDailycontrol.do")
	public void exportAllDailycontrol(HttpServletResponse response,KongDailyControl kongdailycontrol,ServletRequest request,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportAllDailycontrols.do.......................");
		try {
			/**增加数据过滤   根据当前用户角色设置是否数据过滤 0-不过滤 1-单位过滤 2-民警过滤**/
			kongdailycontrol.setIsFilter(userSession.getLoginRoleFieldFilter()+"");
			if(userSession.getLoginRoleFieldFilter()==1){
				kongdailycontrol.setFiltervalue(userSession.getLoginUserDepartmentid()+"");
			}else if(userSession.getLoginRoleFieldFilter()==2){
				kongdailycontrol.setFiltervalue(userSession.getLoginUserID()+"");
			} 
			List<KongDailyControl> list=kongExtendDao.exportAllDailycontrol(kongdailycontrol);
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("三日一走访(涉恐)记录.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet("三日一走访");
				
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
				
				/*定义标题*/
				HSSFRow rowtitle = sheet.createRow(0);
				rowtitle.setHeightInPoints(40);
				CellRangeAddress r = new CellRangeAddress(0,0,0,8);//对应8个字段
				sheet.addMergedRegion(r);
				HSSFCell cellhead = rowtitle.createCell(0);
				HSSFRichTextString valuehead = new HSSFRichTextString("三日一走访记录");
				cellhead.setCellValue(valuehead);
				cellhead.setCellStyle(style);
				
				/*数据*/
				HSSFRow row;
				HSSFCell cell;
				HSSFRichTextString value;
				
				/*标题行*/
				row = sheet.createRow(1);
				row.setHeightInPoints(25);
				cell = row.createCell(0);
				value = new HSSFRichTextString("编号");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(1);
				value = new HSSFRichTextString("姓名");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(2);
				value = new HSSFRichTextString("身份证号码");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(3);
				value = new HSSFRichTextString("管控时间");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(4);
				value = new HSSFRichTextString("管控方式");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(5);
				value = new HSSFRichTextString("反馈内容");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(6);
				value = new HSSFRichTextString("填写派出所");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(7);
				value = new HSSFRichTextString("填写民警");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				cell = row.createCell(8);
				value = new HSSFRichTextString("填写时间");
				cell.setCellValue(value);
				cell.setCellStyle(style2);
				
				/*数据行*/
				/*创建行*/
				for (int i = 0; i < list.size(); i++) {
					row = sheet.createRow(i+2);
					row.setHeightInPoints(60);
					cell = row.createCell(0);
					value = new HSSFRichTextString(String.valueOf(i+1));
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(1);
					value = new HSSFRichTextString(list.get(i).getPersonname());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(2);
					value = new HSSFRichTextString(list.get(i).getCardnumber());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(3);
					value = new HSSFRichTextString(list.get(i).getControltime());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(4);
					value = new HSSFRichTextString(list.get(i).getControlmode());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(5);
					value = new HSSFRichTextString(list.get(i).getControlcontent());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(6);
					value = new HSSFRichTextString(list.get(i).getAddoperatordepart());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(7);
					value = new HSSFRichTextString(list.get(i).getAddoperator());
					cell.setCellValue(value);
					cell.setCellStyle(border);
					
					cell = row.createCell(8);
					value = new HSSFRichTextString(list.get(i).getAddtime());
					cell.setCellValue(value);
					cell.setCellStyle(border);
				}
				
				message = new Message("true","三日一走访(涉恐)-导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "涉恐人员-三日一走访-导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
			}else {
				message = new Message("false","三日一走访(涉恐)-无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "涉恐人员-三日一走访-导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	@RequestMapping("/getKongStatistics.do")
	public String getKongStatistics(ModelMap model){
		try {
			List<KongExtend> kongextendList = kongExtendDao.countpersonByJointtype();
			model.addAttribute("kongextendList", kongextendList);
			List<PieModel> piemodelList = new ArrayList<PieModel>();
			int sum=0;
			for(int i=0;i<kongextendList.size();i++){
				sum += kongextendList.get(i).getPersoncount();
				PieModel pieModel = new PieModel();
				pieModel.setName(kongextendList.get(i).getJointtypename());
				pieModel.setValue(kongextendList.get(i).getPersoncount());
				piemodelList.add(pieModel);
			}
			model.addAttribute("sum", sum);
			model.addAttribute("jsonList", JSONArray.fromObject(piemodelList).toString());
			//按籍贯统计
			List<KongExtend> kextendList = kongExtendDao.countpersonByNativeplace();
			List<String> nativeplaceList = new ArrayList<String>();
			List<Integer> countList = new ArrayList<Integer>();
			for(int i=0;i<kextendList.size();i++){
				nativeplaceList.add(kextendList.get(i).getNativeplace());
				countList.add(kextendList.get(i).getPersoncount());
			}
			model.addAttribute("nativeplaceList", JSONArray.fromObject(nativeplaceList).toString());
			model.addAttribute("countList", JSONArray.fromObject(countList).toString());
			//按派出所统计
			List<KongExtend> pcsextendList = kongExtendDao.countpersonByPolice();
			List<String> policeList = new ArrayList<String>();
			List<Integer> policecountList = new ArrayList<Integer>();
			for(int i=0;i<pcsextendList.size();i++){
				policeList.add(pcsextendList.get(i).getJurisdictunit());
				policecountList.add(pcsextendList.get(i).getPersoncount());
			}
			model.addAttribute("policeList", JSONArray.fromObject(policeList).toString());
			model.addAttribute("policecountList", JSONArray.fromObject(policecountList).toString());
			//最新走访结果
			KongDailyControl kongdailycontrol = new KongDailyControl();
			kongdailycontrol.setControltype(1);
			List<KongDailyControl> zfresult = kongExtendDao.searchDailycontrolByControltype(kongdailycontrol);
			model.addAttribute("zfresult", zfresult);
			//最新评估
			kongdailycontrol.setControltype(2);
			List<KongDailyControl> pgresult = kongExtendDao.searchDailycontrolByControltype(kongdailycontrol);
			model.addAttribute("pgresult", pgresult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/chart/kong/list";
	}
	
	@RequestMapping("/tzKongPersonel.do")
	@ResponseBody
	public String tzKongPersonel(KongExtend kongExtend,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			kongExtendDao.tz(kongExtend);
			message= new Message("true","更新台账成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "台账更新", userSession.getLoginUserName(), addtime, "更新台账成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员台账更新");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongExtend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","更新台账失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "台账更新", userSession.getLoginUserName(), addtime, "更新台账失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐人员台账更新");
			String operate_Condition = "";
			operate_Condition += "涉恐扩展信息id = '" + kongExtend.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	public void checkMYPG(){
		try {
			System.out.println("-------每月28号检查每月评估是否录入每月评估-------");
			List<KongExtend> kongExtendList = kongExtendDao.checkMYPG();
			for(int i=0;i<kongExtendList.size();i++){
				//调用短信接口发送管辖民警信息
				if(kongExtendList.get(i).getPolicephone1()!=null&&!"".equals(kongExtendList.get(i).getPolicephone1())){
					new ShortMessageDao().sendmessage(kongExtendList.get(i).getPolicephone1(),"您所管控的人员（姓名："+kongExtendList.get(i).getPersonname()+"身份证："+kongExtendList.get(i).getCardnumber()+"）还未完成每月评估");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkSRYZF(){
		try {
			System.out.println("-------每天晚上10点检测是否录入三日一走访数据-------");
			List<KongExtend> kongExtendList = kongExtendDao.checkSRYZF();
			for(int i=0;i<kongExtendList.size();i++){
				//调用短信接口发送管辖民警信息
				if(kongExtendList.get(i).getPolicephone1()!=null&&!"".equals(kongExtendList.get(i).getPolicephone1())){
					new ShortMessageDao().sendmessage(kongExtendList.get(i).getPolicephone1(),"您所管控的人员（姓名："+kongExtendList.get(i).getPersonname()+"身份证："+kongExtendList.get(i).getCardnumber()+"）还未完成走访任务");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkSFYLR(){
		try {
			System.out.println("-------每天下午4点检测录入人员最近9天是否有录入信息-------");
			List<KongExtend> kongExtendList = kongExtendDao.checkSFYLR();
			String content = "以下人员超过9天未有数据更新：";
			for(int i=0;i<kongExtendList.size();i++){
				content+=kongExtendList.get(i).getPersonname()+"("+kongExtendList.get(i).getCardnumber()+"),";
			}
			content = new String(URLEncoder.encode(content, "UTF-8").getBytes());
			
			String param="fromId=liyi&toIds=liyi,h&content="+content;
			String url = "http://wlxt.jys.wux.js:505/websites/_ext/jyga/sendChat.jsp?"+param;
			
			SendChat sendchat=new SendChat();
			String result=sendchat.doHttpGet(url);
			System.out.println("领悟消息中心接口发送========"+result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/toDailycontrolPage.do")
	public String toDailycontrolPage(ModelMap model,int personnelid){
		try {
			KongExtend kongextend = new KongExtend();
			kongextend.setPersonnelid(personnelid);
			kongextend = kongExtendDao.exportPersonnelById(kongextend);
			int relationcount = relationDao.getSocialrelationsCount(personnelid);
			model.addAttribute("personnelid", personnelid);
			model.addAttribute("kongextend", kongextend);
			model.addAttribute("relationcount", relationcount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/personel/kong/dailycontrol/list";
	}
}

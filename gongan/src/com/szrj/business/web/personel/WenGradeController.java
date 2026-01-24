package com.szrj.business.web.personel;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
import org.apache.poi.xwpf.usermodel.XWPFDocument;
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
import org.springframework.web.servlet.ModelAndView;

import cn.afterturn.easypoi.entity.ImageEntity;
import cn.afterturn.easypoi.word.WordExportUtil;
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
import com.aladdin.util.TreeSelect;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.MaintainrateDao;
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
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.Maintainrate;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelPhoto;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.SocialRelations;
import com.szrj.business.model.personel.WenGrade;
import com.szrj.business.model.personel.WenJointControlLevel;
import com.szrj.business.model.personel.WenRisk;
import com.szrj.business.model.personel.RealityShow;
import com.szrj.business.model.personel.WenVisit;
@Controller
@SessionAttributes("userSession")
public class WenGradeController {
	@Autowired
	private WenGradeDao wenGradeDao;
	@Autowired
	private WenRiskDao wenRiskDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private RelationDao relationDao;
	@Autowired
	private MaintainrateDao maintainrateDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	@Autowired
	private PersonnelPhotoDao photoDao;
	@Autowired
	private RealityShowDao realityShowDao;
	@Autowired
	private WenVisitDao wenVisitDao;
	@Autowired
	private KaKouDao kaKouDao;
	private
    @Value("#{configProperties.uploadFile_Pricture}")
    String uploadFile_Pricture;	//读配置文件中的文件上传路径
	private
    @Value("#{configProperties.uploadFile}")
    String uploadFile;	//读配置文件中的文件上传路径
	@RequestMapping("/searchWenGrade.do")
	@ResponseBody
	public Map<String,Object> searchWenGrade(WenGrade wenGrade,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
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
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=wenGradeDao.searchWenGrade(wenGrade, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询涉稳人员");
			String operate_Condition = "";
			if(wenGrade.getCardnumber() != null && !"".equals(wenGrade.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + wenGrade.getCardnumber() + "'";
			}
			if(wenGrade.getPersonname() != null && !"".equals(wenGrade.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}
			}
			if(wenGrade.getHomeplace() != null && !"".equals(wenGrade.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}
			}
			if(wenGrade.getTelnumber() != null && !"".equals(wenGrade.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}
			}
			if(wenGrade.getUnitname1() != null && !"".equals(wenGrade.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}
			}
			if(wenGrade.getPolicename1() != null && !"".equals(wenGrade.getPolicename1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}else{
					operate_Condition += " and 管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}
			}
			if(wenGrade.getJointcontrollevel() != null && !"".equals(wenGrade.getJointcontrollevel())){
				if(!"1".equals(wenGrade.getJointcontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}else{
						operate_Condition += " and 联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}
				}
			}else{
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 != '存档'";
				}else{
					operate_Condition += " and 联控级别 != '存档'";
				}
			}
			if(wenGrade.getIncontrollevel() != null && !"".equals(wenGrade.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}
			}
			if(wenGrade.getPersontype() != null && !"".equals(wenGrade.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "户籍类别 = '" + wenGrade.getPersontype() + "'";
				}else{
					operate_Condition += " and 户籍类别 = '" + wenGrade.getPersontype() + "'";
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
			log.setOperate_Name("查询涉稳人员");
			String operate_Condition = "";
			if(wenGrade.getCardnumber() != null && !"".equals(wenGrade.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + wenGrade.getCardnumber() + "'";
			}
			if(wenGrade.getPersonname() != null && !"".equals(wenGrade.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}
			}
			if(wenGrade.getHomeplace() != null && !"".equals(wenGrade.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}
			}
			if(wenGrade.getTelnumber() != null && !"".equals(wenGrade.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}
			}
			if(wenGrade.getUnitname1() != null && !"".equals(wenGrade.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}
			}
			if(wenGrade.getPolicename1() != null && !"".equals(wenGrade.getPolicename1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}else{
					operate_Condition += " and 管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}
			}
			if(wenGrade.getJointcontrollevel() != null && !"".equals(wenGrade.getJointcontrollevel())){
				if(!"1".equals(wenGrade.getJointcontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}else{
						operate_Condition += " and 联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}
				}
			}else{
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 != '存档'";
				}else{
					operate_Condition += " and 联控级别 != '存档'";
				}
			}
			if(wenGrade.getIncontrollevel() != null && !"".equals(wenGrade.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}
			}
			if(wenGrade.getPersontype() != null && !"".equals(wenGrade.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "户籍类别 = '" + wenGrade.getPersontype() + "'";
				}else{
					operate_Condition += " and 户籍类别 = '" + wenGrade.getPersontype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/getMaintainrateByPersonnelid.do")
	@ResponseBody
	public Maintainrate getMaintainrateByPersonnelid(Maintainrate maintainrate,@ModelAttribute("userSession")UserSession userSession){
		try {
			maintainrate=maintainrateDao.getMaintainrate(maintainrate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maintainrate;
	}
	
	@RequestMapping("/exportWenGrade.do")
	public void exportWenGrade(HttpServletResponse response,WenGrade wenGrade,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,
											String personnelfield,String personneltext,
											String gradefield,String gradetext,
											String relationfield,String relationtext,
											String riskfield,String risktext,
											String showfield,String showtext,
											int menuid){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("exportWenGrade.do.......................");
		
		try {
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
			List<WenGrade> list=wenGradeDao.exportWenGrade(wenGrade);
			
			if(list.size()>0){
				/*设置输出类型*/
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				/*设置输出文件名称*/
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode("风险人员(涉稳)信息.xls", "UTF-8"));
				
				/*将数据写入excel*/
				/*建立新的HSSFWorkbook对象*/
				HSSFWorkbook wb = new HSSFWorkbook();
				/*建立新的工作簿*/
				HSSFSheet sheet = wb.createSheet("涉稳人员");
				
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
				
				String[] riskfieldStrings=riskfield.split(",");
				String[] risktextStrings=risktext.split(",");
				int risklength=(riskfield!=""?riskfieldStrings.length:0);
				
				String[] showfieldStrings=showfield.split(",");
				String[] showtextStrings=showtext.split(",");
				int showlength=(showfield!=""?showfieldStrings.length:0);
				
				/*定义标题*/
				HSSFRow rowtitle = sheet.createRow(0);
				rowtitle.setHeightInPoints(40);
				CellRangeAddress r = new CellRangeAddress(0,0,0,personnellength+gradelength+relationlength+risklength+showlength);
				sheet.addMergedRegion(r);
				HSSFCell cellhead = rowtitle.createCell(0);
				HSSFRichTextString valuehead = new HSSFRichTextString("涉稳人员信息");
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
				if(gradelength>0){
					if(gradelength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+gradelength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("分级分类信息");
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
				/*风险背景*/
				if(risklength>0){
					if(risklength>1){
						r=new CellRangeAddress(1,1,titlelength+1,titlelength+risklength);
						sheet.addMergedRegion(r);
					}
					cellhead = rowtitle.createCell(titlelength+1);
					valuehead=new HSSFRichTextString("风险背景");
					cellhead.setCellValue(valuehead);
					cellhead.setCellStyle(style);
					titlelength+=risklength;
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
				if(risklength>0){
					for(int i=0;i<risklength;i++){
						cell = row.createCell(cell2length+i+1);
						value = new HSSFRichTextString(risktextStrings[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					cell2length+=risklength;
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
					if(risklength>0){
						if(list.get(i).getExportWenRisk()!=null)node=JSONObject.fromObject(list.get(i).getExportWenRisk());
						else node=JSONObject.fromObject(new WenRisk());
						for (int j = 0; j < risklength; j++) {
							sheet.setColumnWidth(cellindex+j+1, 8000);
							cell = row.createCell(cellindex+j+1);
							value = new HSSFRichTextString(node.get(riskfieldStrings[j]).toString());
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
						cellindex+=risklength;
					}
					if(showlength>0){
						if(list.get(i).getExportRealityShow()!=null)node=JSONObject.fromObject(list.get(i).getExportRealityShow());
						else node=JSONObject.fromObject(new RealityShow());
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
				
				message = new Message("true","涉稳人员-导出成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉稳人员-导出", userSession.getLoginUserName(), addtime, "导出成功", "");
				
				/*将excel内容写入要输出的excel中*/
				OutputStream outputStream=response.getOutputStream();
				wb.write(outputStream);
				outputStream.flush();
				outputStream.close();
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("导出涉稳人员");
				String operate_Condition = "";
				if(wenGrade.getCardnumber() != null && !"".equals(wenGrade.getCardnumber())){
					operate_Condition += "身份证号 LIKE '" + wenGrade.getCardnumber() + "'";
				}
				if(wenGrade.getPersonname() != null && !"".equals(wenGrade.getPersonname())){
					if("".equals(operate_Condition)){
						operate_Condition += "姓名 LIKE '" + wenGrade.getPersonname() + "'";
					}else{
						operate_Condition += " and 姓名 LIKE '" + wenGrade.getPersonname() + "'";
					}
				}
				if(wenGrade.getHomeplace() != null && !"".equals(wenGrade.getHomeplace())){
					if("".equals(operate_Condition)){
						operate_Condition += "现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
					}else{
						operate_Condition += " and 现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
					}
				}
				if(wenGrade.getTelnumber() != null && !"".equals(wenGrade.getTelnumber())){
					if("".equals(operate_Condition)){
						operate_Condition += "名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
					}else{
						operate_Condition += " and 名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
					}
				}
				if(wenGrade.getUnitname1() != null && !"".equals(wenGrade.getUnitname1())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
					}else{
						operate_Condition += " and 管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
					}
				}
				if(wenGrade.getPolicename1() != null && !"".equals(wenGrade.getPolicename1())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
					}else{
						operate_Condition += " and 管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
					}
				}
				if(wenGrade.getJointcontrollevel() != null && !"".equals(wenGrade.getJointcontrollevel())){
					if(!"1".equals(wenGrade.getJointcontrollevel())){
						if("".equals(operate_Condition)){
							operate_Condition += "联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
						}else{
							operate_Condition += " and 联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
						}
					}
				}else{
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 != '存档'";
					}else{
						operate_Condition += " and 联控级别 != '存档'";
					}
				}
				if(wenGrade.getIncontrollevel() != null && !"".equals(wenGrade.getIncontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "在控状态 = '" + wenGrade.getIncontrollevel() + "'";
					}else{
						operate_Condition += " and 在控状态 = '" + wenGrade.getIncontrollevel() + "'";
					}
				}
				if(wenGrade.getPersontype() != null && !"".equals(wenGrade.getPersontype())){
					if("".equals(operate_Condition)){
						operate_Condition += "户籍类别 = '" + wenGrade.getPersontype() + "'";
					}else{
						operate_Condition += " and 户籍类别 = '" + wenGrade.getPersontype() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else {
				message = new Message("false","涉稳人员-无导出数据！");
				message.setFlag(-1);
				logDao.recordLog(menuid, "风险人员-涉稳人员-导出", userSession.getLoginUserName(), addtime, "无导出数据", "");
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-导出失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-导出", userSession.getLoginUserName(), addtime, "导出失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("导出涉稳人员");
			String operate_Condition = "";
			if(wenGrade.getCardnumber() != null && !"".equals(wenGrade.getCardnumber())){
				operate_Condition += "身份证号 LIKE '" + wenGrade.getCardnumber() + "'";
			}
			if(wenGrade.getPersonname() != null && !"".equals(wenGrade.getPersonname())){
				if("".equals(operate_Condition)){
					operate_Condition += "姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}else{
					operate_Condition += " and 姓名 LIKE '" + wenGrade.getPersonname() + "'";
				}
			}
			if(wenGrade.getHomeplace() != null && !"".equals(wenGrade.getHomeplace())){
				if("".equals(operate_Condition)){
					operate_Condition += "现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}else{
					operate_Condition += " and 现住地详址 LIKE '" + wenGrade.getHomeplace() + "'";
				}
			}
			if(wenGrade.getTelnumber() != null && !"".equals(wenGrade.getTelnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}else{
					operate_Condition += " and 名下手机号 LIKE '" + wenGrade.getTelnumber() + "'";
				}
			}
			if(wenGrade.getUnitname1() != null && !"".equals(wenGrade.getUnitname1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}else{
					operate_Condition += " and 管辖责任单位 包含 '" + wenGrade.getUnitname1() + "'";
				}
			}
			if(wenGrade.getPolicename1() != null && !"".equals(wenGrade.getPolicename1())){
				if("".equals(operate_Condition)){
					operate_Condition += "管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}else{
					operate_Condition += " and 管辖责任民警名称 LIKE '" + wenGrade.getPolicename1() + "'";
				}
			}
			if(wenGrade.getJointcontrollevel() != null && !"".equals(wenGrade.getJointcontrollevel())){
				if(!"1".equals(wenGrade.getJointcontrollevel())){
					if("".equals(operate_Condition)){
						operate_Condition += "联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}else{
						operate_Condition += " and 联控级别 = '" + wenGrade.getJointcontrollevel() + "'";
					}
				}
			}else{
				if("".equals(operate_Condition)){
					operate_Condition += "联控级别 != '存档'";
				}else{
					operate_Condition += " and 联控级别 != '存档'";
				}
			}
			if(wenGrade.getIncontrollevel() != null && !"".equals(wenGrade.getIncontrollevel())){
				if("".equals(operate_Condition)){
					operate_Condition += "在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}else{
					operate_Condition += " and 在控状态 = '" + wenGrade.getIncontrollevel() + "'";
				}
			}
			if(wenGrade.getPersontype() != null && !"".equals(wenGrade.getPersontype())){
				if("".equals(operate_Condition)){
					operate_Condition += "户籍类别 = '" + wenGrade.getPersontype() + "'";
				}else{
					operate_Condition += " and 户籍类别 = '" + wenGrade.getPersontype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		//return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getWenGradeUpdate.do")
	public String getWenGradeUpdate(WenGrade wen,int menuid,String buttons,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getWenGradeUpdate.do.................page="+page);
		String url="";
		model.addAttribute("menuid",menuid);
		model.addAttribute("buttons",buttons);
		try {
			if(page.equals("add")){
				url="/jsp/personel/wen/add";
				
//				model.addAttribute("jdunit1",userSession.getLoginUserDepartmentid());
//				model.addAttribute("jdpolice1",userSession.getLoginUserID());
				
//				List<BasicMsg> list1=basicMsgDao.getByType(46);//涉稳-涉稳人员类别
//				JSONArray json1=TreeSelect.listToTreeSelectJSON(list1, "basicName", "", "parentid", true, false);
//				model.addAttribute("personneltype",json1);
				
				List<BasicMsg> list2=basicMsgDao.getByType(24);//涉稳-责任警种
				model.addAttribute("responsiblepolice",JSONArray.fromObject(list2));
				model.addAttribute("wenGrade",wen);
			}else if (page.equals("update")) {
				url="/jsp/personel/wen/update";
				
				WenGrade wenGrade=wenGradeDao.getById(wen.getId());//获取分类分级信息
				model.addAttribute("wenGrade",wenGrade);
				Personnel personnel=personnelDao.getById(wenGrade.getPersonnelid());//获取基本信息
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
				
				List<BasicMsg> awaywill=basicMsgDao.getByType(109);//涉稳-上行意愿
				model.addAttribute("awaywill",awaywill);
				
				List<BasicMsg> incontrollevel=basicMsgDao.getByType(22);//通用-在控状态
				model.addAttribute("incontrollevel",incontrollevel);
				
				List<BasicMsg> list1=basicMsgDao.getByType(46);//涉稳-涉稳人员类别
				JSONArray json1=TreeSelect.listToTreeSelectJSON(list1, "basicName", "", "parentid", true, false);
				model.addAttribute("personneltype",json1);
				
				List<BasicMsg> list2=basicMsgDao.getByType(24);//涉稳-责任警种
				model.addAttribute("responsiblepolice",JSONArray.fromObject(list2));
				
				//社会关系
				Relation relation=relationDao.searchrelation(wenGrade.getPersonnelid());
				model.addAttribute("relation",relation);
				Relation zfw_relation=relationDao.searchrelation_zfw(wenGrade.getPersonnelid());
				model.addAttribute("zfw_relation",zfw_relation);
			}else if (page.equals("update1")) {
				url="/jsp/personel/wen/update";
				Personnel personnel=personnelDao.getById(wen.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
				WenGrade wenGrade=wenGradeDao.getBypersonnelid(wen.getPersonnelid());//获取分类分级信息
				model.addAttribute("wenGrade",wenGrade);
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
				
				List<BasicMsg> awaywill=basicMsgDao.getByType(109);//涉稳-上行意愿
				model.addAttribute("awaywill",awaywill);
				
				List<BasicMsg> incontrollevel=basicMsgDao.getByType(22);//通用-在控状态
				model.addAttribute("incontrollevel",incontrollevel);
				
				List<BasicMsg> list1=basicMsgDao.getByType(46);//涉稳-涉稳人员类别
				JSONArray json1=TreeSelect.listToTreeSelectJSON(list1, "basicName", "", "parentid", true, false);
				model.addAttribute("personneltype",json1);
				
				List<BasicMsg> list2=basicMsgDao.getByType(24);//涉稳-责任警种
				model.addAttribute("responsiblepolice",JSONArray.fromObject(list2));
				
				//社会关系
				Relation relation=relationDao.searchrelation(wenGrade.getPersonnelid());
				model.addAttribute("relation",relation);
			}else if(page.equals("showinfo")){
               url="/jsp/personel/wen/showinfo";
				
				WenGrade wenGrade=wenGradeDao.getById(wen.getId());//获取分类分级信息
				model.addAttribute("wenGrade",wenGrade);
				Personnel personnel=personnelDao.getById(wenGrade.getPersonnelid());//获取基本信息
				model.addAttribute("personnel",personnel);
				int age=CardnumberInfo.getAge(personnel.getCardnumber());
				model.addAttribute("age",age);
			    Relation relation=relationDao.searchrelation(wenGrade.getPersonnelid());	//社会关系
				model.addAttribute("relation",relation);
				WenRisk wenRisk=wenRiskDao.getByPersonnelid(wenGrade.getPersonnelid());	//风险背景
				model.addAttribute("wenRisk",wenRisk);
			}else if(page.equals("addinContradiction")){
				url="/jsp/event/contradictionInfo/person/add";
				
				model.addAttribute("jurisdictunit1",userSession.getLoginUserDepartmentid());
				model.addAttribute("jurisdictpolice1",userSession.getLoginUserID());
				
				List<BasicMsg> list1=basicMsgDao.getByType(46);//涉稳-涉稳人员类别
				JSONArray json1=TreeSelect.listToTreeSelectJSON(list1, "basicName", "", "parentid", true, false);
				model.addAttribute("personneltype",json1);
				
				List<BasicMsg> list2=basicMsgDao.getByType(24);//涉稳-责任警种
				model.addAttribute("responsiblepolice",JSONArray.fromObject(list2));
				model.addAttribute("wenGrade",wen);
				model.addAttribute("menuid",menuid);
			}else if(page.equals("addSjry")){
				url="/jsp/event/contradictionInfo/person/add";
				
				model.addAttribute("jurisdictunit1",userSession.getLoginUserDepartmentid());
				model.addAttribute("jurisdictppolice1",userSession.getLoginUserID());
				
				List<BasicMsg> list1=basicMsgDao.getByType(46);//涉稳-涉稳人员类别
				JSONArray json1=TreeSelect.listToTreeSelectJSON(list1, "basicName", "", "parentid", true, false);
				model.addAttribute("personneltype",json1);
				
				List<BasicMsg> list2=basicMsgDao.getByType(24);//涉稳-责任警种
				model.addAttribute("responsiblepolice",JSONArray.fromObject(list2));
				model.addAttribute("wenGrade",wen);
				model.addAttribute("page",page);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	
	@RequestMapping("/addWenGrade.do")
	public @ResponseBody String addWenGrade(WenGrade wenGrade,String ybssid,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addWenGrade.do.......................");
		try {
			int findid=personnelDao.findPersonInPersonnel(wenGrade.getCardnumber());
			if (findid>0) {
				Personnel person=personnelDao.getById(findid);
				/*****非风险人提升为风险人*****/
				if(person.getIsrisk()==2){
					//变为治安风险人员
					person.setIsrisk(1);
					person.setUpdateoperator(userSession.getLoginUserName());
					person.setUpdatetime(addtime);
					personnelDao.updateCyPersonRisk(person);
				}
				User jurisdictpolice1=userDao.getById(wenGrade.getJurisdictpolice1());
				/*****风险人员主表标签修改*****/
				String zslabel1=person.getZslabel1();
				if(zslabel1!="")zslabel1+=",";
				zslabel1+="1";
				person.setZslabel1(zslabel1);
				person.setJdunit1(wenGrade.getJurisdictunit1()+"");
				person.setJdpolice1(wenGrade.getJurisdictpolice1()+"");
				person.setPphone1(jurisdictpolice1.getContactnumber());
				person.setUpdateoperator(userSession.getLoginUserName());
				person.setUpdatetime(addtime);
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
				personnelDao.update(person);
				
				/*****涉稳人员子表添加*****/
				wenGrade.setPersonnelid(findid);
				wenGrade.setPolicephone1(jurisdictpolice1.getContactnumber());
				wenGrade.setValidflag(1);
				wenGrade.setAddoperator(userSession.getLoginUserName());
				wenGrade.setAddtime(addtime);
				wenGradeDao.add(wenGrade);
				
				/*****涉稳人员维护率表添加*****/
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(1);//添加标签 涉稳-1
				maintainrate.setPersonnelid(findid);
				maintainrateDao.add(maintainrate);
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				HashMap<String,Object> map=new HashMap<String,Object>();
	    		map.put("in_personnelid", findid);
	    		maintainrateDao.updateMaintainrateByPersonnelid(map);
				
				message= new Message("true","涉稳人员-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉稳人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addWenGrade.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("非风险人员提升为涉稳人员");
				String operate_Condition = "";
				operate_Condition += "人员id = '" + findid + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else {
				User jurisdictpolice1=userDao.getById(wenGrade.getJurisdictpolice1());
				/*****风险人员主表添加*****/
				Personnel person=new Personnel();
				person.setCardnumber(wenGrade.getCardnumber());
				person.setPersonname(wenGrade.getPersonname());
				person.setJdunit1(wenGrade.getJurisdictunit1()+"");
				person.setJdpolice1(wenGrade.getJurisdictpolice1()+"");
				person.setPphone1(jurisdictpolice1.getContactnumber());
				person.setZslabel1("1");
				person.setSexes(CardnumberInfo.getSex(wenGrade.getCardnumber()));
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
					personnelDao.update(person);
					
				}
			    
				/*****涉稳人员子表添加*****/
				wenGrade.setPersonnelid(personid);
				wenGrade.setPolicephone1(jurisdictpolice1.getContactnumber());
				wenGrade.setValidflag(1);
				wenGrade.setAddoperator(userSession.getLoginUserName());
				wenGrade.setAddtime(addtime);
				wenGradeDao.add(wenGrade);
				
				/*****涉稳人员维护率表添加*****/
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(1);//添加标签 涉稳-1
				maintainrate.setPersonnelid(personid);
				maintainrateDao.add(maintainrate);
				
				if(ybssid!=null&&!"".equals(ybssid)){
					HashMap<String,Object> map=new HashMap<String,Object>();
					map.put("in_personnelid", personid);
					maintainrateDao.updateMaintainrateByPersonnelid(map);
				}
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				message= new Message("true","涉稳人员-添加成功！");
				message.setFlag(personid);
				logDao.recordLog(menuid, "风险人员-涉稳人员-添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addWenGrade.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("添加涉稳人员");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addWenGrade.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加涉稳人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateWenGrade.do")
	public @ResponseBody String updateWenGrade(WenGrade wenGrade,Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateWenGrade.do.......................");
		try {
			wenGrade.setId(wenGrade.getPersonFilter());
			wenGrade.setUpdateoperator(userSession.getLoginUserName());
			wenGrade.setUpdatetime(addtime);
			wenGradeDao.update(wenGrade);
			
			personnel.setId(wenGrade.getPersonnelid());
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
//			personnelDao.update(personnel);
			personnelDao.updateSK(personnel);
			/*****涉稳人员维护率计算***Parameter1**/
			/*int maintainrate1=0;
			if(!personnel.getUsedname().equals("")||
					!personnel.getNickname().equals(""))maintainrate1++;	//曾用名、绰号			1分
			if(!personnel.getPersonheight().equals(""))maintainrate1++;		//身高				1分
			if(!personnel.getMarrystatus().equals(""))maintainrate1++;		//婚姻状态			1分
			if(!personnel.getEducation().equals(""))maintainrate1++;		//文化程度			1分
			if(!personnel.getPersontype().equals(""))maintainrate1++;		//人员类别			1分
			if(!personnel.getNation().equals(""))maintainrate1++;			//民族				1分
			if(!personnel.getPoliticalposition().equals(""))maintainrate1++;//政治面貌			1分
			if(!personnel.getFaith().equals(""))maintainrate1++;			//宗教信仰			1分
			if(!personnel.getSoldierstatus().equals(""))maintainrate1++;	//兵役情况			1分
			if(!personnel.getHouseplace().equals(""))maintainrate1++;		//户籍地详址			1分
			if(!personnel.getHousepolice().equals(""))maintainrate1++;		//户籍地派出所			1分
			if(!personnel.getHomeplace().equals(""))maintainrate1++;		//现住地详址			1分
			if(!personnel.getHomepolice().equals(""))maintainrate1++;		//现住地派出所			1分
			if(!personnel.getFeature().equals(""))maintainrate1++;			//特殊特征			1分
			if(!personnel.getSpeciality().equals(""))maintainrate1++;		//技能专长			1分
			if(!personnel.getRecords().equals(""))maintainrate1++;			//前科劣迹			1分
			if(!personnel.getWorkplace().equals(""))maintainrate1++;		//工作地详址			1分
			if(!personnel.getWorkpolice().equals(""))maintainrate1++;		//工作地派出所			1分
			if(!personnel.getHomewifi().equals("")||
					!personnel.getHomewide().equals(""))maintainrate1++;	//居住地宽带/wifi		1分
			if(!personnel.getWorkwifi().equals("")||
					!personnel.getWorkwide().equals(""))maintainrate1++;	//工作地宽带/wifi		1分
			if(!personnel.getNetskillhabit().equals(""))maintainrate1++;	//有无网络社交技能习惯	1分
			Maintainrate maintainrate=new Maintainrate();
			maintainrate.setPersonlabel(1);
			maintainrate.setPersonnelid(wenGrade.getPersonnelid());
			maintainrate=maintainrateDao.getMaintainrate(maintainrate);
			if(maintainrate!=null){
				maintainrate.setParameter1(maintainrate1);
				maintainrateDao.update(maintainrate);
			}*/
			HashMap<String,Object> map=new HashMap<String,Object>();
    		map.put("in_personnelid", wenGrade.getPersonnelid());
    		maintainrateDao.updateMaintainrateByPersonnelid(map);
			
			message = new Message("true","涉稳人员-修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateWenGrade.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改涉稳人员");
			String operate_Condition = "";
			operate_Condition += "涉稳id = '" + wenGrade.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateWenGrade.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改涉稳人员");
			String operate_Condition = "";
			operate_Condition += "涉稳id = '" + wenGrade.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/cancelWenGrade.do")
	public @ResponseBody String cancelWenGrade(WenGrade wenGrade,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelWenGrade.do.......................");
		try {
			wenGrade.setUpdateoperator(userSession.getLoginUserName());
			wenGrade.setUpdatetime(addtime);
			wenGradeDao.cancel(wenGrade);
			
			Personnel person=personnelDao.getById(wenGrade.getPersonnelid());
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
			int labelindex=Arrays.binarySearch(labelint,1);//涉稳-1
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
				List<AttributeLabel> aList=personnelDao.getAttributeLabelbyRootid(1);
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
			System.out.println("cancelWenGrade.do.......................更新风险人员标签!!!!");
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
				System.out.println("cancelWenGrade.do.......................更新风险人员标签!!!!");
			}*/
			
			message = new Message("true","涉稳人员-删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelWenGrade.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除涉稳人员");
			String operate_Condition = "";
			operate_Condition += "涉稳id = '" + wenGrade.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","涉稳人员-删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelWenGrade.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除涉稳人员");
			String operate_Condition = "";
			operate_Condition += "涉稳id = '" + wenGrade.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	/**  ******************************************************************联控级别调整*************************************************************************** **/
	@RequestMapping("/addjointcontrollevel.do")
	public @ResponseBody String addjointcontrollevel(WenJointControlLevel jointcontrollevel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			     jointcontrollevel.setApplicanttime(addtime);
			     jointcontrollevel.setApplicant(userSession.getLoginUserName());
			     jointcontrollevel.setApplicantid(userSession.getLoginUserID());
			     jointcontrollevel.setExaminestatus(1);
			    wenGradeDao.addjointcontrollevel(jointcontrollevel);//添加联控级别申请记录
			    WenGrade wenGrade=new WenGrade();
			    wenGrade.setJointcontrollevel(jointcontrollevel.getJointcontrollevel_old());
			    wenGrade.setJointcontrollevelapply(1);
			    wenGrade.setPersonnelid(jointcontrollevel.getPersonnelid());
			    wenGradeDao.updatejointcontrollevelapply(wenGrade);//修改联控级别调整状态
				message= new Message("true","涉稳人员-级别调整添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉稳人员-级别调整添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addjointcontrollevel.do.......................添加成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉稳人员级别调整添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉稳人员-级别调整添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉稳人员-级别调整添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addjointcontrollevel.do.......................添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉稳人员级别调整添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getjointcontrollevelCount.do")
	public @ResponseBody String getjointcontrollevelCount(int personnelid){
		System.out.println("getjointcontrollevelCount.do.......................");
		Message message;
		try {
			    int count=wenGradeDao.getjointcontrollevelCount(personnelid);
				message= new Message("true","");
				message.setFlag(count);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
	@RequestMapping("/getjointcontrollevelNew.do")
	public String getjointcontrollevelNew(int personnelid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getjointcontrollevelNew.do.......................");
	    String url="/jsp/personel/wen/jointcontrollevel/examine";
	    WenJointControlLevel jointcontrollevel=wenGradeDao.getjointcontrollevelNew(personnelid);
	    model.addAttribute("jointcontrollevel",jointcontrollevel);
	  //生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询人员级别调整");
		String operate_Condition = "";
		operate_Condition += "人员id = '" + personnelid + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	@RequestMapping("/examinejointcontrolleve.do")
	public @ResponseBody String examinejointcontrolleve(WenJointControlLevel jointcontrollevel,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("examinejointcontrolleve.do.......................");
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			     jointcontrollevel.setReviewertime(addtime);
			     jointcontrollevel.setReviewer(userSession.getLoginUserName());
			     jointcontrollevel.setReviewerid(userSession.getLoginUserID());
			     jointcontrollevel.setExaminestatus(2);
			    wenGradeDao.examinejointcontrolleve(jointcontrollevel);
			    WenGrade wenGrade=new WenGrade();
			    if(jointcontrollevel.getExamineresult()==1){//审核结果1- 通过/2-不通过
			    	 wenGrade.setJointcontrollevelapply(2);
			    	 wenGrade.setJointcontrollevel(jointcontrollevel.getJointcontrollevel_new());//更新联控级别
			    }else{
			    	 wenGrade.setJointcontrollevelapply(3);
			    	 wenGrade.setJointcontrollevel(jointcontrollevel.getJointcontrollevel_old());//更新联控级别
			    }
			   
			    wenGrade.setPersonnelid(jointcontrollevel.getPersonnelid());
			    wenGradeDao.updatejointcontrollevelapply(wenGrade);//修改联控级别调整状态
				message= new Message("true","涉稳人员-级别调整申请审核成功！");
				message.setFlag(1);
				logDao.recordLog(0, "风险人员-涉稳人员-级别调整申请审核", userSession.getLoginUserName(), addtime, "审核成功", "");
				System.out.println("examinejointcontrolleve.do.......................审核成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉稳人员级别调整申请审核");
				String operate_Condition = "";
				operate_Condition += "人员id = '" + jointcontrollevel.getPersonnelid() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉稳人员-级别调整申请审核添加失败！");
			message.setFlag(-1);
			logDao.recordLog(0, "风险人员-涉稳人员-级别调整申请审核", userSession.getLoginUserName(), addtime, "审核失败", "");
			System.out.println("examinejointcontrolleve.do......................审核失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉稳人员级别调整申请审核");
			String operate_Condition = "";
			operate_Condition += "人员id = '" + jointcontrollevel.getPersonnelid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/searchjointcontrollevel.do")
	@ResponseBody
	public Map<String,Object>  searchjointcontrollevel(WenJointControlLevel wj,int page,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchjointcontrollevel.do..............="+wj.getPersonnelid());
		   Map<String, Object> result = new HashMap<String, Object>();
		   result.put("code", 0);
		   try {
			   //是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
						case 1:
							wj.setUnitFilter(userSession.getLoginUserDepartmentid());
							break;
						case 2:
							wj.setPersonFilter(userSession.getLoginUserID());
							break;
						}
				}
			   //List<WenJointControlLevel> listTemp=wenGradeDao.searchjointcontrollevel(wj);
			   pm.setPageNumber(page);
			   NewPageModel pagelist = wenGradeDao.jointControllerList(wj, pm);
		       result.put("count", pagelist.getTotal());
		       result.put("data", pagelist.getRows().toArray());
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
	       return result;
	}
	@RequestMapping("/importWenGrade.do")
    @ResponseBody
    public Map<String, Object> importWenGrade(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
                  msg=importWenGradeXLS(sheet,rowdata,userSession);                 
              }else if(fileType.equals("xlsx")){   
            	  XSSFWorkbook workbook = new XSSFWorkbook(fis);
                  XSSFSheet sheet=workbook.getSheetAt(0);
                  XSSFRow rowdata=null;
                  msg=importWenGradeXLSX(sheet,rowdata,userSession);
              }        
              json.put("success",msg);
    } catch (Exception e) {
        e.printStackTrace();
    }   
    return json;  
    }
	
	private String importWenGradeXLSX(XSSFSheet sheet,XSSFRow rowdata,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
            	   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
            		   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
                	   if(findid>0){
                		   btmsg+="第"+rownum+"行，身份证号已存在；"+"<br/>";  //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
                	   }else {
                		   /*****风险人员主表添加*****/
                		   Personnel person=new Personnel();
                		   person.setCardnumber(rowdata.getCell(0).getStringCellValue());
                		   person.setPersonname(rowdata.getCell(1).getStringCellValue());
                		   person.setZslabel1("1");//标签 涉稳-1
                		   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
                		   person.setValidflag(1);
                		   person.setAddoperator(userSession.getLoginUserName());
                		   person.setAddoperatorid(userSession.getLoginUserID());
                		   if(userSession.getLoginRoleMsgFilter()==1){
                			   person.setJdunit1(userSession.getLoginUserDepartmentid()+"");
                			   person.setJdpolice1(userSession.getLoginUserID()+"");
                			   person.setPphone1(userSession.getLoginContactnumber());
                		   }
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
                		   if(personUpdate)personnelDao.update(person);
                		   
                		   /*****默认添加空关联信息*****/
                		   Relation relation=new Relation();
                		   relation.setPersonnelid(personid);
                		   relationDao.addrelation(relation);
                		   /*****涉稳人员子表添加*****/
                		   WenGrade wenGrade=new WenGrade();
                		   wenGrade.setPersonnelid(personid);
                		   wenGrade.setValidflag(1);
                		   wenGrade.setAddoperator(userSession.getLoginUserName());
                		   wenGrade.setAddtime(addtime);
                		   wenGradeDao.add(wenGrade);
                			/*****修改社会关系中人员风险类别*****/
							SocialRelations socialrelations=new SocialRelations();
							socialrelations.setUpdateoperator(userSession.getLoginUserName());
							socialrelations.setUpdatetime(addtime);
							socialrelations.setCardnumber(person.getCardnumber());
							relationDao.updateriskpersonnel(socialrelations);
                		   pCount++;
                		   /*****涉稳人员维护率表添加*****/
                		   Maintainrate maintainrate=new Maintainrate();
                		   maintainrate.setPersonlabel(1);//添加标签 涉稳-1
                		   maintainrate.setPersonnelid(personid);
                		   maintainrateDao.add(maintainrate);
                		   if (personUpdate) {
                			   /*****涉稳人员维护率计算***Parameter1**/
                			   HashMap<String,Object> map=new HashMap<String,Object>();
	           				   map.put("in_personnelid", personid);
	           				   maintainrateDao.updateMaintainrateByPersonnelid(map);
//                			   int maintainrate1=0;
//                			   if(!person.getUsedname().equals("")||
//                					   !person.getNickname().equals(""))maintainrate1++;	//曾用名、绰号			1分
//                			   if(!person.getPersonheight().equals(""))maintainrate1++;		//身高				1分
//                			   if(!person.getMarrystatus().equals(""))maintainrate1++;		//婚姻状态			1分
//                			   if(!person.getEducation().equals(""))maintainrate1++;		//文化程度			1分
//                			   if(!person.getPersontype().equals(""))maintainrate1++;		//人员类别			1分
//                			   if(!person.getNation().equals(""))maintainrate1++;			//民族				1分
//                			   if(!person.getPoliticalposition().equals(""))maintainrate1++;//政治面貌			1分
//                			   if(!person.getFaith().equals(""))maintainrate1++;			//宗教信仰			1分
//                			   if(!person.getSoldierstatus().equals(""))maintainrate1++;	//兵役情况			1分
//                			   if(!person.getNetskillhabit().equals(""))maintainrate1++;	//有无网络社交技能习惯	1分
//                			   maintainrate=maintainrateDao.getMaintainrate(maintainrate);
//                			   if(maintainrate!=null){
//                				   maintainrate.setParameter1(maintainrate1);
//                				   maintainrateDao.update(maintainrate);
//                			   }
                		   }
                	   }
            	   }else {
            		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            	   }
               }  
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险人员（涉稳）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
    }
	private String importWenGradeXLS(HSSFSheet sheet,HSSFRow rowdata,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
            	   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
            		   int findid=personnelDao.findPersonInPersonnel(rowdata.getCell(0).getStringCellValue());
                	   if(findid>0){
                		   btmsg+="第"+rownum+"行，身份证号已存在；"+"<br/>"; 
                	   }else {
                		   /*****风险人员主表添加*****/
                		   Personnel person=new Personnel();
                		   person.setCardnumber(rowdata.getCell(0).getStringCellValue());
                		   person.setPersonname(rowdata.getCell(1).getStringCellValue());
                		   person.setZslabel1("1");//标签 涉稳-1
                		   person.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
                		   person.setValidflag(1);
                		   person.setAddoperator(userSession.getLoginUserName());
                		   person.setAddoperatorid(userSession.getLoginUserID());
                		   if(userSession.getLoginRoleMsgFilter()==1){
                			   person.setJdunit1(userSession.getLoginUserDepartmentid()+"");
                			   person.setJdpolice1(userSession.getLoginUserID()+"");
                			   person.setPphone1(userSession.getLoginContactnumber());
                		   }
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
                		   if(personUpdate)personnelDao.update(person);
                		   
                		   /*****默认添加空关联信息*****/
                		   Relation relation=new Relation();
                		   relation.setPersonnelid(personid);
                		   relationDao.addrelation(relation);
                		   /*****涉稳人员子表添加*****/
                		   WenGrade wenGrade=new WenGrade();
                		   wenGrade.setPersonnelid(personid);
                		   wenGrade.setValidflag(1);
                		   wenGrade.setAddoperator(userSession.getLoginUserName());
                		   wenGrade.setAddtime(addtime);
                		   wenGradeDao.add(wenGrade);
                			/*****修改社会关系中人员风险类别*****/
							SocialRelations socialrelations=new SocialRelations();
							socialrelations.setUpdateoperator(userSession.getLoginUserName());
							socialrelations.setUpdatetime(addtime);
							socialrelations.setCardnumber(person.getCardnumber());
							relationDao.updateriskpersonnel(socialrelations);
                		   pCount++;
                		   /*****涉稳人员维护率表添加*****/
                		   Maintainrate maintainrate=new Maintainrate();
                		   maintainrate.setPersonlabel(1);//添加标签 涉稳-1
                		   maintainrate.setPersonnelid(personid);
                		   maintainrateDao.add(maintainrate);
                		   if (personUpdate) {
                			   /*****涉稳人员维护率计算***Parameter1**/
                			   HashMap<String,Object> map=new HashMap<String,Object>();
	           				   map.put("in_personnelid", personid);
	           				   maintainrateDao.updateMaintainrateByPersonnelid(map);
//                			   int maintainrate1=0;
//                			   if(!person.getUsedname().equals("")||
//                					   !person.getNickname().equals(""))maintainrate1++;	//曾用名、绰号			1分
//                			   if(!person.getPersonheight().equals(""))maintainrate1++;		//身高				1分
//                			   if(!person.getMarrystatus().equals(""))maintainrate1++;		//婚姻状态			1分
//                			   if(!person.getEducation().equals(""))maintainrate1++;		//文化程度			1分
//                			   if(!person.getPersontype().equals(""))maintainrate1++;		//人员类别			1分
//                			   if(!person.getNation().equals(""))maintainrate1++;			//民族				1分
//                			   if(!person.getPoliticalposition().equals(""))maintainrate1++;//政治面貌			1分
//                			   if(!person.getFaith().equals(""))maintainrate1++;			//宗教信仰			1分
//                			   if(!person.getSoldierstatus().equals(""))maintainrate1++;	//兵役情况			1分
//                			   if(!person.getNetskillhabit().equals(""))maintainrate1++;	//有无网络社交技能习惯	1分
//                			   maintainrate=maintainrateDao.getMaintainrate(maintainrate);
//                			   if(maintainrate!=null){
//                				   maintainrate.setParameter1(maintainrate1);
//                				   maintainrateDao.update(maintainrate);
//                			   }
                		   }
                	   }
            	   }else {
            		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            	   }
               }  
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险人员（涉稳）<font color='red'>"+pCount+"</font> 名</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
	}
	
	@RequestMapping("/printWenGrade.do")
	public void printWenGrade(WenGrade wenGrade,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession){
		try {
			wenGrade=wenGradeDao.getById(wenGrade.getId());
			Personnel personnel=personnelDao.getById(wenGrade.getPersonnelid());
			List<PersonnelPhoto> photoList=photoDao.getByPersonnelid(wenGrade.getPersonnelid());
			WenRisk wenRisk=wenRiskDao.getByPersonnelid(wenGrade.getPersonnelid());
			RealityShow realityShow=new RealityShow();
			realityShow.setPersonnelid(wenGrade.getPersonnelid());
			realityShow.setDatalabel(1);
			RealityShow realityShow1=realityShowDao.getByPersonnelid(realityShow);
			List<WenVisit> visitList=wenVisitDao.getListByPersonnelid(wenGrade.getPersonnelid());
			//模板位置
			String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\personel\\template\\wen_export.docx";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("personname", personnel.getPersonname());
			map.put("cardnumber", personnel.getCardnumber());
			if(wenGrade.getJointcontrollevel()!=null&&!"".equals(wenGrade.getJointcontrollevel())){
				map.put("jointcontrollevel", wenGrade.getJointcontrollevel());
			}else{
				map.put("jointcontrollevel", " ");
			}
			if(personnel.getSexes()!=null&&!"".equals(personnel.getSexes())){
				map.put("sexes", personnel.getSexes());
			}else{
				map.put("sexes", " ");
			}
			if(personnel.getPersonheight()!=null&&!"".equals(personnel.getPersonheight())){
				map.put("personheight", personnel.getPersonheight());
			}else{
				map.put("personheight", " ");
			}
			if(personnel.getZslabel2()!=null&&!"".equals(personnel.getZslabel2())){
				String[] zslabel2Strings=personnel.getZslabel2().split(",");
				StringBuffer zslabel2sBuffer=new StringBuffer("");
				for (int i = 0; i < zslabel2Strings.length; i++) {
					if (zslabel2Strings[i]!="") {
						AttributeLabel attributeLabel = personnelDao.getAttributeLabelByid(Integer.parseInt(zslabel2Strings[i]));
						if(attributeLabel!=null){
							if(attributeLabel.getAttributelabel()!=null&&!"".equals(attributeLabel.getAttributelabel())){
								zslabel2sBuffer.append(attributeLabel.getAttributelabel());
								if(i < zslabel2Strings.length-1)zslabel2sBuffer.append("\r\n");
							}
						}
					}
				}
				String zslabel2s=zslabel2sBuffer.toString();
				if("".equals(zslabel2s))zslabel2s=" ";
				map.put("zslabel2s", zslabel2s);
			}else{
				map.put("zslabel2s", " ");
			}
			if(photoList!=null&&photoList.size()>0){
				String url="";
				for (int i = 0; i < photoList.size(); i++) {
					PersonnelPhoto onePhoto=photoList.get(i);
					if(onePhoto.getDefaultflag()==1){
						if (onePhoto.getValidflag()>1) {
							url=uploadFile+"\\"+onePhoto.getFileallName();
						}else {
							url=uploadFile_Pricture+"\\"+onePhoto.getFileallName();
						}
						break;
					}
				}
				if ("".equals(url)) {
					url=request.getSession().getServletContext().getRealPath("")+"\\images\\nophoto.png";
				}
				ImageEntity imageEntity=new ImageEntity(FileUtil.getBytesByFile(url),100,150);
				map.put("defaultPhoto", imageEntity);
			}else{
				String url=request.getSession().getServletContext().getRealPath("")+"\\images\\nophoto.png";
				ImageEntity imageEntity=new ImageEntity(FileUtil.getBytesByFile(url),100,150);
				map.put("defaultPhoto", imageEntity);
			}
			if(personnel.getWorkplace()!=null&&!"".equals(personnel.getWorkplace())){
				map.put("workplace", personnel.getWorkplace());
			}else{
				map.put("workplace", " ");
			}
			if(personnel.getTelnumber()!=null&&!"".equals(personnel.getTelnumber())){
				StringBuffer telnumberBuffer=new StringBuffer("");
				String[] telnumbers=personnel.getTelnumber().split(",");
				for (int i = 0; i < telnumbers.length; i++) {
					telnumberBuffer.append(telnumbers[i]);
					if(i < telnumbers.length-1)telnumberBuffer.append("\r\n");
				}
				String telnumber=telnumberBuffer.toString();
				if("".equals(telnumber))telnumber=" ";
				map.put("telnumber", telnumber);
			}else{
				map.put("telnumber", " ");
			}
			if(personnel.getHouseplace()!=null&&!"".equals(personnel.getHouseplace())){
				map.put("houseplace", personnel.getHouseplace());
			}else{
				map.put("houseplace", " ");
			}
			if(personnel.getHousepolice()!=null&&!"".equals(personnel.getHousepolice())){
				map.put("housepolice", personnel.getHousepolice());
			}else{
				map.put("housepolice", " ");
			}
			if(personnel.getHomeplace()!=null&&!"".equals(personnel.getHomeplace())){
				map.put("homeplace", personnel.getHomeplace());
			}else{
				map.put("homeplace", " ");
			}
			if(personnel.getHomepolice()!=null&&!"".equals(personnel.getHomepolice())){
				map.put("homepolice", personnel.getHomepolice());
			}else{
				map.put("homepolice", " ");
			}
			if(wenGrade.getUnitname1()!=null&&!"".equals(wenGrade.getUnitname1())){
				map.put("unitname1", wenGrade.getUnitname1());
			}else{
				map.put("unitname1", " ");
			}
			if(wenGrade.getPolicename1()!=null&&!"".equals(wenGrade.getPolicename1())){
				map.put("policename1", wenGrade.getPolicename1());
			}else{
				map.put("policename1", " ");
			}
			if(wenGrade.getPolicephone1()!=null&&!"".equals(wenGrade.getPolicephone1())){
				map.put("policephone1", wenGrade.getPolicephone1());
			}else{
				map.put("policephone1", " ");
			}
			if(wenGrade.getUnitname2()!=null&&!"".equals(wenGrade.getUnitname2())){
				map.put("unitname2", wenGrade.getUnitname2());
			}else{
				map.put("unitname2", " ");
			}
			if(wenGrade.getPolicename2()!=null&&!"".equals(wenGrade.getPolicename2())){
				map.put("policename2", wenGrade.getPolicename2());
			}else{
				map.put("policename2", " ");
			}
			if(wenGrade.getPolicephone2()!=null&&!"".equals(wenGrade.getPolicephone2())){
				map.put("policephone2", wenGrade.getPolicephone2());
			}else{
				map.put("policephone2", " ");
			}
			if(wenRisk!=null&&wenRisk.getRiskappeal()!=null&&!"".equals(wenRisk.getRiskappeal())){
				map.put("riskappeal", wenRisk.getRiskappeal());
			}else{
				map.put("riskappeal", " ");
			}
			if (visitList!=null&&visitList.size()>0) {
				StringBuffer activityprocessBuffer=new StringBuffer("");
				for (int i = 0; i < visitList.size(); i++) {
					WenVisit oneVisit=visitList.get(i);
					int index=i+1;
					activityprocessBuffer.append(index+". "+(oneVisit.getStartdate()!=null&&!"".equals(oneVisit.getStartdate())?oneVisit.getStartdate():"无开始日期")+" 至 "+(oneVisit.getEnddate()!=null&&!"".equals(oneVisit.getEnddate())?oneVisit.getEnddate():"无结束日期")+"，"+oneVisit.getActivityprocess());
					if(i < visitList.size()-1)activityprocessBuffer.append("\r\n");
				}
				String activityprocess=activityprocessBuffer.toString();
				if("".equals(activityprocess))map.put("activityprocess", " ");
				else map.put("activityprocess",activityprocess);
			}else map.put("activityprocess", " ");
			if(realityShow1!=null&&realityShow1.getLifepattern()!=null&&!"".equals(realityShow1.getLifepattern())){
				map.put("lifepattern", realityShow1.getLifepattern());
			}else{
				map.put("lifepattern", " ");
			}
			if(wenGrade.getIncontrollevel()!=null&&!"".equals(wenGrade.getIncontrollevel())){
				map.put("incontrollevel", wenGrade.getIncontrollevel());
			}else{
				map.put("incontrollevel", " ");
			}
			XWPFDocument doc = WordExportUtil.exportWord07(templateFileName, map);
			/*设置输出文件名称*/
			String title = "涉稳风险人员登记表_"+personnel.getPersonname()+"_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".docx", "UTF-8"));
			OutputStream outputStream=response.getOutputStream();
			doc.write(outputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getWenStatistics.do")
	public String getWenStatistics(ModelMap model,int menuid){
		try {
			model.addAttribute("menuid", menuid);
			Personnel personnel = new Personnel();
			personnel.setPersonlabel("1");
			personnel.setIncontrolleve("在京");
			List<Personnel> zjpersonelList = personnelDao.getPersonInfoByIncontrollevel(personnel);
			model.addAttribute("zjpersonelList", zjpersonelList);
			personnel.setIncontrolleve("在宁");
			List<Personnel> znpersonelList = personnelDao.getPersonInfoByIncontrollevel(personnel);
			model.addAttribute("znpersonelList", znpersonelList);
			personnel.setIncontrolleve("下落不明");
			List<Personnel> xlbmpersonelList = personnelDao.getPersonInfoByIncontrollevel(personnel);
			model.addAttribute("xlbmpersonelList", xlbmpersonelList);
			/*int totalcount = personnelDao.getCountByJointcontrollevel(personnel);
			model.addAttribute("totalcount", totalcount);*/
			personnel.setJointcontrollevel("一级");
			int onecount = personnelDao.getCountByJointcontrollevel(personnel);
			List<Integer> pcsonecount = personnelDao.getPCSCountByJointcontrollevel(personnel);
			model.addAttribute("onecount", onecount);
			model.addAttribute("pcsonecount", pcsonecount);
			personnel.setJointcontrollevel("二级");
			int twocount = personnelDao.getCountByJointcontrollevel(personnel);
			List<Integer> pcstwocount = personnelDao.getPCSCountByJointcontrollevel(personnel);
			model.addAttribute("twocount", twocount);
			model.addAttribute("pcstwocount", pcstwocount);
			personnel.setJointcontrollevel("三级");
			int threecount = personnelDao.getCountByJointcontrollevel(personnel);
			List<Integer> pcsthreecount = personnelDao.getPCSCountByJointcontrollevel(personnel);
			model.addAttribute("threecount", threecount);
			model.addAttribute("pcsthreecount", pcsthreecount);
			model.addAttribute("totalcount", onecount+twocount+threecount);
			personnel.setJointcontrollevel("自控");
			int selfcount = personnelDao.getCountByJointcontrollevel(personnel);
			model.addAttribute("selfcount", selfcount);
			Department department = new Department();
			department.setDeparttype("4");
			List<String> departmentList = departmentDao.getDepartmentListOrderbyid(department);
			JSONArray departmentjson = JSONArray.fromObject(departmentList);
			model.addAttribute("departmentList", departmentjson.toString());
			List<PieModel> piemodelList = personnelDao.countPersonByResponsiblepolice(personnel);
			JSONArray piemodeljson = JSONArray.fromObject(piemodelList);
			model.addAttribute("piemodelList", piemodeljson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/chart/wen/list";
	}
	
	@RequestMapping("/getRelationchart.do")
	public String getRelationchart(WenGrade wenGrade,ModelMap model){
		try {
			List<Personnel> personList = wenGradeDao.getRelationchart(wenGrade);
			ContradictionInfo contradictionInfo = new ContradictionInfo();
			contradictionInfo.setPersonnelid(wenGrade.getPersonnelid());
			List<ContradictionInfo> contradictionInfoList = contradictionInfoDao.getCdtByPerson(contradictionInfo);
			model.addAttribute("personList", JSONArray.fromObject(personList).toString());
			model.addAttribute("contradictionInfoList", JSONArray.fromObject(contradictionInfoList).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "/jsp/personel/wen/relationchart";
	}
	
	@RequestMapping("/expandRelationchart.do")
	@ResponseBody
	public Map<String,Object> expandRelationchart(WenGrade wenGrade){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	List<Personnel> personList = wenGradeDao.getRelationchart(wenGrade);
        	result.put("data", personList);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/expandFxsjPerson.do")
	@ResponseBody
	public Map<String,Object> expandFxsjPerson(int cdtid){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	List<Personnel> personList = personnelDao.expandFxsjPerson(cdtid);
        	result.put("data", personList);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/exportWenJointcontrollevel.do")
	@ResponseBody
	public void exportWenJointcontrollevel(HttpServletResponse response,HttpServletRequest request,WenJointControlLevel wj,@ModelAttribute("userSession")UserSession userSession){
		  System.out.println("/exportWenJointcontrollevel.do....导出审核记录");
		  ModelAndView view = new ModelAndView(JsonView.instance);
		  try{
			  List<WenJointControlLevel> jointList = wenGradeDao.searchjointcontrollevel(wj);
			  /*在temp中创建文件*/
			  TimeFormate tf = new TimeFormate();
				SimpleDateFormat tfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String addTime = tfs.format(new Date());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String fileName = "审核记录信息"+sdf.format(new Date());
				/*将数据写入file*/
				//设置输出类型
				response.setContentType("application/vnd.ms-excel");
				//设置输出文件名称
				response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(fileName+".xls", "UTF-8"));
				//建立新的HSSFWorkbook对象
				HSSFWorkbook wb = new HSSFWorkbook();
				//建立新的工作簿
				HSSFSheet sheet = wb.createSheet("sheet1");
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
				font.setFontHeightInPoints((short)16);
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
				/*设置每一列的行宽*/
				sheet.setColumnWidth(0, 3500);//姓名
				sheet.setColumnWidth(1, 6000);//身份证号
				sheet.setColumnWidth(2, 3500);//联控级别(申请前)
				sheet.setColumnWidth(3, 3500);//联控级别(申请后)
				sheet.setColumnWidth(4, 8000);//调整理由
				sheet.setColumnWidth(5, 5500);//管辖单位
				sheet.setColumnWidth(6, 3500);//申请人
				sheet.setColumnWidth(7, 4500);//申请时间
				sheet.setColumnWidth(8, 3500);//审核人
				sheet.setColumnWidth(9, 4500);//审核时间
				sheet.setColumnWidth(10, 3500);//审核结果
				sheet.setColumnWidth(11, 8000);//审核理由
				/*数据*/
				HSSFRow row;
				HSSFCell cell;
				HSSFRichTextString value;								
				row = sheet.createRow(0);
				row.setHeightInPoints(40);
				String titleArray[] = {
						"姓名","身份证号","联控级别(申请前)","联控级别(申请后)",
						"调整理由","管辖单位","申请人","申请时间","审核人",
						"审核时间","审核结果","审核理由"
				};
				for(int i=0;i<12;i++){
					cell = row.createCell(i);
					value = new HSSFRichTextString(titleArray[i]);
					cell.setCellValue(value);
					cell.setCellStyle(style2);
				}
				/*数据行*/
				for(int i=0;i<jointList.size();i++){
					/*创建行*/
					row = sheet.createRow(i+1);
					row.setHeightInPoints(25);
					
					/*获取行数据*/
					WenJointControlLevel temp = jointList.get(i);
					int c=i+1;
					String d = Integer.toString(c);
					String data[] = {
						temp.getPersonname(),temp.getCardnumber(),temp.getJointcontrollevel_old(),temp.getJointcontrollevel_new(),
						temp.getApplicantreason(),temp.getHomepolice(),temp.getApplicant(),temp.getApplicanttime(),temp.getReviewer(),
						temp.getReviewertime(),temp.getExamineresult()==1?"通过":temp.getExamineresult()==2?"不通过":"",temp.getMemo()
					};
					for(int j=0;j<12;j++){
						/*创建列*/
						cell = row.createCell(j);
						value = new HSSFRichTextString(data[j]);
						cell.setCellValue(value);
						cell.setCellStyle(border);
					}
				}
				
				wb.write(response.getOutputStream());
				logDao.recordLog(0, "审核级别信息导出", userSession.getLoginUserName(), addTime, "导出成功", "");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("审核级别信息导出");
				String operate_Condition = "";
				if(wj.getPersonnelid() != 0){
					operate_Condition += "人员主表id = '" + wj.getPersonnelid() + "'";
				}
				if(wj.getStarttime() != null && !"".equals(wj.getStarttime())){
					if("".equals(operate_Condition)){
						operate_Condition += "申请时间 >= '" + wj.getStarttime() + "'";
					}else{
						operate_Condition += " and 申请时间 >= '" + wj.getStarttime() + "'";
					}
				}
				if(wj.getEndtime() != null && !"".equals(wj.getEndtime())){
					if("".equals(operate_Condition)){
						operate_Condition += "申请时间 <= '" + wj.getEndtime() + "'";
					}else{
						operate_Condition += " and 申请时间 <= '" + wj.getEndtime() + "'";
					}
				}
				if(wj.getHomepolice() != null && !"".equals(wj.getHomepolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任单位 = '" + wj.getHomepolice() + "'";
					}else{
						operate_Condition += " and 管辖责任单位 = '" + wj.getHomepolice() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			} catch (Exception e) {
				e.printStackTrace();
				Message message = new Message("false","数据导出失败");
				message.setFlag(-1);
				view.addObject(JsonView.JSON_ROOT,message);
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("0");	//0：失败 1：成功
				log.setOperate_Name("审核级别信息导出");
				String operate_Condition = "";
				if(wj.getPersonnelid() != 0){
					operate_Condition += "人员主表id = '" + wj.getPersonnelid() + "'";
				}
				if(wj.getStarttime() != null && !"".equals(wj.getStarttime())){
					if("".equals(operate_Condition)){
						operate_Condition += "申请时间大于等于 '" + wj.getStarttime() + "'";
					}else{
						operate_Condition += " and 申请时间大于等于 '" + wj.getStarttime() + "'";
					}
				}
				if(wj.getEndtime() != null && !"".equals(wj.getEndtime())){
					if("".equals(operate_Condition)){
						operate_Condition += "申请时间小于等于 '" + wj.getEndtime() + "'";
					}else{
						operate_Condition += " and 申请时间小于等于 '" + wj.getEndtime() + "'";
					}
				}
				if(wj.getHomepolice() != null && !"".equals(wj.getHomepolice())){
					if("".equals(operate_Condition)){
						operate_Condition += "管辖责任单位 = '" + wj.getHomepolice() + "'";
					}else{
						operate_Condition += " and 管辖责任单位 = '" + wj.getHomepolice() + "'";
					}
				}
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		}
	
	@RequestMapping("/searchZfwPersonnel.do")
	@ResponseBody
	public Map<String,Object> searchZfwPersonnel(Personnel personnel,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist=personnelDao.searchZfwPersonnel(personnel, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/getZfwPersonById.do")
	public String getZfwPersonById(int id,int menuid,ModelMap model,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		try {
			Personnel personnel = personnelDao.getZfwPersonById(id);
			int age=CardnumberInfo.getAge(personnel.getCardnumber());
			model.addAttribute("age",age);
			model.addAttribute("menuid",menuid);
			model.addAttribute("personnel", personnel);

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/jsp/personel/zfw/check";
	}
	
	@RequestMapping("/updateZfwPerson.do")
	public @ResponseBody String updateZfwPerson(Personnel personnel,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		try {
			personnel.setUpdateoperator(userSession.getLoginUserName());
			personnel.setUpdatetime(addtime);
			//加入风险人员库
			Personnel person = personnelDao.getPersonnelByCardnumber(personnel.getCardnumber());
			if(person==null){
				/*****风险人员主表添加*****/
		        personnel.setZslabel1("1");
		        personnel.setAddoperator(userSession.getLoginUserName());
		        personnel.setAddoperatorid(userSession.getLoginUserID());
		        personnel.setAddtime(addtime);
		        int id = personnelDao.addZfwPerson(personnel);
		        /*****涉稳人员子表添加*****/
		        WenGrade wenGrade = new WenGrade();
				wenGrade.setPersonnelid(id);
				wenGrade.setPolicephone1(personnel.getPphone1());
				wenGrade.setValidflag(1);
				wenGrade.setAddoperator(userSession.getLoginUserName());
				wenGrade.setAddtime(addtime);
				wenGradeDao.add(wenGrade);
				/*****涉稳人员维护率表添加*****/
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(1);//添加标签 涉稳-1
				maintainrate.setPersonnelid(id);
				maintainrateDao.add(maintainrate);
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(personnel.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				/*更新政法委人员表*/
				personnel.setId(id);
				personnelDao.updateZfwPerson(personnel);
			}else{
				int personid = person.getId();
				String zslabel1 = ","+person.getZslabel1()+",";
				if(zslabel1.indexOf(",1,")<0){
					person.setZslabel1(person.getZslabel1()+",1");
					personnelDao.updateCheckedPersonLabel(person);
				}
				 /*****涉稳人员子表添加*****/
		        WenGrade wenGrade = new WenGrade();
				wenGrade.setPersonnelid(personid);
				wenGrade.setPolicephone1(person.getPphone1());
				wenGrade.setValidflag(1);
				wenGrade.setAddoperator(userSession.getLoginUserName());
				wenGrade.setAddtime(addtime);
				wenGradeDao.add(wenGrade);
				/*****涉稳人员维护率表添加*****/
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(1);//添加标签 涉稳-1
				maintainrate.setPersonnelid(personid);
				maintainrateDao.add(maintainrate);
				
				/*****修改社会关系中人员风险类别*****/
				SocialRelations socialrelations=new SocialRelations();
				socialrelations.setUpdateoperator(userSession.getLoginUserName());
				socialrelations.setUpdatetime(addtime);
				socialrelations.setCardnumber(person.getCardnumber());
				relationDao.updateriskpersonnel(socialrelations);
				
				/*更新政法委人员表*/
				personnel.setId(personid);
				personnelDao.updateZfwPerson(personnel);
			}
			message = new Message("true","政法委风险人员-审核成功！");
			message.setFlag(1);
		} catch (Exception e) {
			message = new Message("false","政法委风险人员-审核失败！");
			message.setFlag(0);
			e.printStackTrace();
		}
		return JSONObject.fromObject(message).toString();
	}
}

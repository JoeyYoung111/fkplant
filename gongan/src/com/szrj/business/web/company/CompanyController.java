package com.szrj.business.web.company;

import java.net.URLEncoder;
import java.io.IOException;
import java.io.InputStream;
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

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
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
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.aladdin.web.JsonView;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.FileDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.dao.company.VehicleDao;
import com.szrj.business.dao.company.YzdLicenceDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.File;
import com.szrj.business.model.company.Company;
import com.szrj.business.model.company.Vehicle;
import com.szrj.business.model.company.YzdLicence;

/**
 * @author 李昊
 * Aug 26, 2021
 */

@Controller
@SessionAttributes("userSession")
public class CompanyController {
	
	/*
	private
	@Value("#{configProperties.uploadFile_Document}")
	String uploadFile_Document;
	*/
	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Picture;
	@Autowired
	private CompanyDao companyDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private YzdLicenceDao licenceDao;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private DepartmentDao departmentDao;
	
	/**
	 * 分页查询单位
	 * @param company
	 * @return
	 */
	@RequestMapping("/searchCompany.do")
	@ResponseBody
	public Map<String, Object> searchCompany(Company company, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchCompany.do ... ");
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = companyDao.searchCompany(company, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");
			log.setOperate_Name("查询风险单位");
			String operate_Condition = "";
			if(company.getCompanyname() != null && !"".equals(company.getCompanyname())){
				operate_Condition += "风险单位名称 LIKE '" + company.getCompanyname() + "'";
			}
			if(company.getCompanycode() != null && !"".equals(company.getCompanycode())){
				if("".equals(operate_Condition)){
					operate_Condition += "社会统一代码 LIKE '" + company.getCompanycode() + "'";
				}else{
					operate_Condition += " and 社会统一代码 LIKE '" + company.getCompanycode() + "'";
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
			log.setOperate_Result("0");
			log.setOperate_Name("查询风险单位");
			String operate_Condition = "";
			if(company.getCompanyname() != null && !"".equals(company.getCompanyname())){
				operate_Condition += "风险单位名称 LIKE '" + company.getCompanyname() + "'";
			}
			if(company.getCompanycode() != null && !"".equals(company.getCompanycode())){
				if("".equals(operate_Condition)){
					operate_Condition += "社会统一代码 LIKE '" + company.getCompanycode() + "'";
				}else{
					operate_Condition += " and 社会统一代码 LIKE '" + company.getCompanycode() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	
	/**
	 * 根据id查询
	 * @param id
	 * @param menuid
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getCompanyById.do")
	public String getById(int id, int menuid, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getCompanyById.do ... menuid="+menuid);
		String url = "";
		List<File> files = new ArrayList<File>();
		List<BasicMsg> infoList = new ArrayList<BasicMsg>();
		String managetypeName = "";
		String fileName = "";
		
		Company company = new Company();
		try {
			company = companyDao.getById(id);
			String photos = company.getCodephoto();
			if(photos!=null && photos.length()>0){
				photos = "("+photos+")";
				files = fileDao.getFileMsgByIdstr(photos);
				for(int i=0;i<files.size();i++){
					fileName += files.get(i).getFileallName()+",";
				}
				model.addAttribute("fileName", fileName.substring(0, fileName.length()-1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String[] affecttype = company.getAffecttype().split(",");
		for(String s : affecttype){
			if("运输".equals(s)){
				model.addAttribute("yunshu",1039);
			}
		}
		
		model.addAttribute("files", files);
		model.addAttribute("company",company);
		model.addAttribute("id",id);
		model.addAttribute("menuid",menuid);
		String companytype=company.getCompanytype();
		if(companytype!=null&&!"".equals(companytype)){
			String[] typeStrings=companytype.split(",");
			String companytypename="";
			for (int i = 0; i < typeStrings.length; i++) {
				int msgid=Integer.parseInt(typeStrings[i]);
				BasicMsg basicMsg=basicMsgDao.getById(msgid);
				if(!"".equals(companytypename))companytypename+=",";
				companytypename+=basicMsg.getBasicName();
			}
			model.addAttribute("companytypename",companytypename);
		}
		String PU = uploadFile_Picture.replace("\\", "/");
		if(page.equals("showinfo")){
			model.addAttribute("pictureurl", PU);
			if(null!=company.getManagetype() && company.getManagetype().length()>0){
				String idlist = "("+ company.getManagetype()+ ")";
				infoList = basicMsgDao.getBasicNamesById(idlist);
				for(int i=0;i<infoList.size();i++){
					managetypeName += infoList.get(i).getBasicName() + ",";
				}
				model.addAttribute("managetypeName", managetypeName.substring(0, managetypeName.length()-1));
			}
			url = "/jsp/company/company_showinfo";
		}else if(page.equals("showinfoCustom")){
			model.addAttribute("pictureurl", PU);
			if(null!=company.getManagetype() && company.getManagetype().length()>0){
				String idlist = "("+ company.getManagetype()+ ")";
				infoList = basicMsgDao.getBasicNamesById(idlist);
				for(int i=0;i<infoList.size();i++){
					managetypeName += infoList.get(i).getBasicName() + ",";
				}
				model.addAttribute("managetypeName", managetypeName.substring(0, managetypeName.length()-1));
			}
			url = "/jsp/company/custom/showinfo";
		}else if(page.equals("update")){
			model.addAttribute("pictureurl", PU.substring(PU.indexOf("upload")-1)+"/");
			url = "/jsp/company/company_update";
		}else if(page.equals("updateCustom")){
			model.addAttribute("pictureurl", PU.substring(PU.indexOf("upload")-1)+"/");
			url = "/jsp/company/custom/update";
		}
		
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");
		log.setOperate_Name("根据ID查询风险单位");
		String operate_Condition = "";
		operate_Condition += "风险单位ID = '" + company.getId() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 添加单位
	 * @param company
	 * @param menuid
	 * @param userSession
	 * @return ModelAndView
	 */
	@RequestMapping("/addCompany.do")
	public @ResponseBody String addCompany(Company company,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addCompany.do ... menuid="+menuid);
		try {
			int num = companyDao.checkCompanycode(company.getCompanycode());
			if(num>0){
				Company repeatCompany=companyDao.getById(num);
				String companytype=repeatCompany.getCompanytype();
				if(companytype!=null&&!"".equals(companytype)){
					repeatCompany.setCompanytype(companytype+","+company.getCompanytype().toString());
				}else {
					repeatCompany.setCompanytype(company.getCompanytype().toString());
				}
				repeatCompany.setUpdateoperator(userSession.getLoginUserName());
				repeatCompany.setUpdatetime(addtime);
				companyDao.update(repeatCompany);
			}else {
				company.setAddtime(addtime);
				company.setAddoperator(userSession.getLoginUserName());
				companyDao.add(company);
			}
			message = new Message("true","添加成功!");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险单位信息添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addCompany.do ... 单位添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");
			log.setOperate_Name("添加风险单位");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","单位添加失败!");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险单位信息添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addCompany.do ... 单位添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除单位
	 * @param company
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelCompany.do")
	@ResponseBody
	public String cancelCompany(Company company, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelCompany.do ... menuid="+menuid);
		try {
			Company repeatCompany=companyDao.getById(company.getId());
			String companytype=repeatCompany.getCompanytype();
			String[] labelstr=companytype.split(",");
			int[] labelint=new int[labelstr.length];
			for (int i = 0; i < labelstr.length; i++) {
				labelint[i]=Integer.parseInt(!"".equals(labelstr[i])?labelstr[i]:"0");
			}
			Arrays.sort(labelint);//数组排序
			int labelindex=Arrays.binarySearch(labelint,Integer.parseInt(company.getCompanytype()));
			String newlabel="";
			for (int i = 0; i < labelint.length; i++) {
				if(i!=labelindex&&labelint[i]!=0){
					if(!"".equals(newlabel))newlabel+=",";
					newlabel+=String.valueOf(labelint[i]);
				}
			}
			if(!"".equals(newlabel)){
				repeatCompany.setCompanytype(newlabel);
				companyDao.update(repeatCompany);
			}else {
				companyDao.cancel(company.getId());
				licenceDao.cancelValidFlag(company.getId());
			}
			message = new Message("true","单位信息已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "单位信息删除",userSession.getLoginUserName(),updatetime,"删除成功","");
			System.out.println("cancelCompany.do ... 删除成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");
			log.setOperate_Name("删除风险单位");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","单位信息删除失败");
			message.setFlag(-1);
			System.out.println("cancelCompany.do ... 删除失败");
			logDao.recordLog(menuid, "单位信息删除",userSession.getLoginUserName(),updatetime,"删除失败","");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");
			log.setOperate_Name("删除风险单位");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	} 
	
	/**
	 * 修改单位信息
	 * @param company
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateCompany.do")
	@ResponseBody
	public String updateCompany(Company company, int menuid, String oldName,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updateTime = dateFormat.format(new Date());
		System.out.println("updateCompany.do ... menyid="+menuid);
		company.setUpdateoperator(userSession.getLoginUserName());
		company.setUpdatetime(updateTime);
		try {
			companyDao.update(company);
			String newName = company.getCompanyname();
			if(!oldName.equals(newName)){
				YzdLicence licence = new YzdLicence();
				licence.setCompanyid(company.getId());
				licence.setCompanyname(newName);
				licenceDao.updateCompanyName(licence);
				
				Vehicle vehicle = new Vehicle();
				vehicle.setCompanyid(company.getId());
				vehicle.setCompanyname(newName);
				vehicleDao.upVehCompanyName(vehicle);
			}
			message = new Message("true","单位信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险单位信息修改", userSession.getLoginUserName(), updateTime, "修改成功", "");
			System.out.println("updateCompany.do ... 修改成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");
			log.setOperate_Name("修改风险单位");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("fasle","单位信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险单位信息修改", userSession.getLoginUserName(), updateTime, "修改失败", "");
			System.out.println("updateCompany.do ... 修改失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");
			log.setOperate_Name("修改风险单位");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改单位法人信息
	 * @param company
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateCompanyFR.do")
	@ResponseBody
	public String updateCompanyFR(Company company, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updateTime = dateFormat.format(new Date());
		System.out.println("updateCompanyFR.do ... menyid="+menuid);
		company.setUpdateoperator(userSession.getLoginUserName());
		company.setUpdatetime(updateTime);
		try {
			companyDao.updateFR(company);
			message = new Message("true","单位信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险单位信息修改", userSession.getLoginUserName(), updateTime, "修改成功", "");
			System.out.println("updateCompany.do ... 修改成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改风险单位法人信息");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("fasle","单位信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险单位信息修改", userSession.getLoginUserName(), updateTime, "修改失败", "");
			System.out.println("updateCompany.do ... 修改失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改风险单位法人信息");
			String operate_Condition = "";
			operate_Condition += "风险单位ID = '" + company.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 检查社会统一代码是否重复
	 * @param companycode
	 * @return
	 */
	@RequestMapping("/checkComCode.do")
	@ResponseBody
	public Map<String, Object> checkComCode(String companycode){
		boolean flag = false;
		Map<String,Object> map = new HashMap<String, Object>();
		int num = companyDao.checkCompanycode(companycode);
		if(num>0){
			flag = true;
			Company company=companyDao.getById(num);
			map.put("company", company);
			List<BasicMsg> companyList=basicMsgDao.getByType(49);
			map.put("companyList",companyList);
		}
		map.put("flag", flag);
		return map;
	}
	
	/**
	 * 添加
	 * @param affecttype
	 * @return
	 */
	@RequestMapping("/getCompanyToJSON.do")
	public ModelAndView getCompanyToJSON(String affecttype){
		ModelAndView view = new ModelAndView(JsonView.instance);
		Company company = new Company();
		if("0".equals(affecttype)){
			affecttype = "";
		}else if("1039".equals(affecttype)){
			affecttype = "运输";
		}
		company.setAffecttype(affecttype);
		List<Company> comList = companyDao.getCompanyToJSON(company);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<comList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(comList.get(i).getCompanyname());
			sm.setValue(String.valueOf(comList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT, smList);
		return view;
	}
	
	@RequestMapping("/selectSJPZ.do")
	@ResponseBody
	public String selectSJPZ(Integer id){
		Message message;
		Company company = companyDao.getById(id);
		message = new Message("true",company.getManagetype());
		message.setFlag(id);
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 导出单位信息
	 * @param response
	 * @param company
	 * @param request
	 * @param userSession
	 */
	@RequestMapping("/exportYzdCompany.do")
	public void exportYzdCompany(HttpServletResponse response,Company company,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("风险单位导出");
		ModelAndView view = new ModelAndView(JsonView.instance);
		try {
			List<Company> companyList = companyDao.getCompanyList(company);
			/*在temp中创建文件*/
			TimeFormate tf = new TimeFormate();
			SimpleDateFormat tfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String addTime = tfs.format(new Date());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String fileName = "风险单位信息"+sdf.format(new Date());
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
			sheet.setColumnWidth(0, 8000);//单位名称
			sheet.setColumnWidth(1, 6000);//社会统一代码
			sheet.setColumnWidth(2, 3500);//单位类型
			sheet.setColumnWidth(3, 3500);//是否入网
			sheet.setColumnWidth(4, 8000);//涉及品种
			sheet.setColumnWidth(5, 5500);//联系电话
			sheet.setColumnWidth(6, 3500);//企业状态
			sheet.setColumnWidth(7, 4500);//停用原因
			sheet.setColumnWidth(8, 8000);//经营范围
			sheet.setColumnWidth(9, 8000);//注册地详址
			sheet.setColumnWidth(10, 5000);//注册地所属辖区
			sheet.setColumnWidth(11, 8000);//实际办公地详址
			sheet.setColumnWidth(12, 5000);//实际办公地所属辖区
			sheet.setColumnWidth(13, 4000);//经度
			sheet.setColumnWidth(14, 4000);//维度
			sheet.setColumnWidth(15, 7000);//法人信息-姓名
			sheet.setColumnWidth(16, 3000);//法人性别
			sheet.setColumnWidth(17, 4000);//法人证件类型
			sheet.setColumnWidth(18, 6000);//法人信息-身份证号码/证件号码
			sheet.setColumnWidth(19, 4000);//法人信息-民族
			sheet.setColumnWidth(20, 3500);//法人信息-文化程度
			sheet.setColumnWidth(21, 5000);//法人信息-政治面貌
			sheet.setColumnWidth(22, 5500);//法人信息-联系电话
			sheet.setColumnWidth(23, 8000);//法人信息-户籍地详址
			sheet.setColumnWidth(24, 8000);//法人信息-现住地详址
			/*数据*/
			HSSFRow row;
			HSSFCell cell;
			HSSFRichTextString value;								
			row = sheet.createRow(0);
			row.setHeightInPoints(40);
			String titleArray[] = {
					"单位名称","社会统一代码","单位类型","是否入网",
					"涉及品种","联系电话","企业状态","停用原因","经营范围",
					"注册地详址","注册地所属辖区","办公地详址","办公地所属辖区",
					"经度","维度","法人姓名","法人性别","法人证件类型","证件号码","法人民族",
					"法人文化程度","法人政治面貌","法人联系电话","法人户籍地","法人现住地"
			};
			for(int i=0;i<25;i++){
				cell = row.createCell(i);
				value = new HSSFRichTextString(titleArray[i]);
				cell.setCellValue(value);
				cell.setCellStyle(style2);
			}
			/*数据行*/
			for(int i=0;i<companyList.size();i++){
				/*创建行*/
				row = sheet.createRow(i+1);
				row.setHeightInPoints(25);
				
				/*获取行数据*/
				Company temp = companyList.get(i);
				int c=i+1;
				String d = Integer.toString(c);
				String data[] = {
					temp.getCompanyname(),temp.getCompanycode(),temp.getAffecttype(),temp.getInnet()==1?"是":"否",
					temp.getSjpzMsg(),temp.getTelephone(),temp.getCompanystatus(),temp.getUnusedreason(),temp.getManagerange(),
					temp.getRegisterplace(),temp.getRegisterownerString(),temp.getRealworkplace(),temp.getRealworkownerString(),
					temp.getLongitude(),temp.getLatitude(),temp.getLegalname(),temp.getSexes(),temp.getZjlx(),temp.getCardnumber(),temp.getNation(),
					temp.getEducation(),temp.getPoliticalposition(),temp.getLegalphone(),temp.getHomeplace(),temp.getLifeplace()
				};
				for(int j=0;j<25;j++){
					/*创建列*/
					cell = row.createCell(j);
					value = new HSSFRichTextString(data[j]);
					cell.setCellValue(value);
					cell.setCellStyle(border);
				}
			}
			
			wb.write(response.getOutputStream());
			logDao.recordLog(0, "风险单位信息导出", userSession.getLoginUserName(), addTime, "导出成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("导出风险单位信息");
			String operate_Condition = "";
			if(company.getCompanyname() != null && !"".equals(company.getCompanyname())){
				operate_Condition += "风险单位名称 LIKE '" + company.getCompanyname() + "'";
			}
			if(company.getCompanycode() != null && !"".equals(company.getCompanycode())){
				if("".equals(operate_Condition)){
					operate_Condition += "社会统一代码 LIKE '" + company.getCompanycode() + "'";
				}else{
					operate_Condition += " and 社会统一代码 LIKE '" + company.getCompanycode() + "'";
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
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("导出风险单位信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		
	}
	@RequestMapping("/importCompany.do")
    @ResponseBody
    public Map<String, Object> importCompany(HttpServletRequest request,HttpServletResponse response,String companytype,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
                  msg=importCompanyXLS(sheet,rowdata,companytype,userSession);                 
              }else if(fileType.equals("xlsx")){   
            	  XSSFWorkbook workbook = new XSSFWorkbook(fis);
                  XSSFSheet sheet=workbook.getSheetAt(0);
                  XSSFRow rowdata=null;
                  msg=importCompanyXLSX(sheet,rowdata,companytype,userSession);
              }        
              json.put("success",msg);
    } catch (Exception e) {
        e.printStackTrace();
    }   
    return json;  
    }
	private String importCompanyXLSX(XSSFSheet sheet,XSSFRow rowdata,String companytype,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
    	String msg="";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	List<BasicMsg> affecttypeList=basicMsgDao.getByType(52);//单位类型 msg
    	List<BasicMsg> managetypeList=basicMsgDao.getByType(50);//涉及品种 msg
    	Department department=new Department();
		department.setDeparttype("0");
		List<Department> departmentList=departmentDao.getDepartmentList(department);
    	for (int i =2; i < sheet.getLastRowNum()+1; i++) {
               rowdata = sheet.getRow(i);
               int rownum=i+1;
               if(rownum>3)rowmsg=" 第3行 至 第"+rownum+"行<br/>"; 
	   		   else if(rownum==3)rowmsg=" 第3行<br/>"; 
	   		   else rowmsg="<font color='red'>无数据导入</font><br/>"; 
	   		   if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
	   			   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK)break;
	   			   btmsg+="第"+rownum+"行，第一列(单位名称)为必填项；"+"<br/>"; 
               }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
            	   btmsg+="第"+rownum+"行，第二列(社会统一征信代码)为必填项；"+"<br/>";
               }else if(rowdata.getCell(2)==null||rowdata.getCell(2).getCellType()==rowdata.getCell(2).CELL_TYPE_BLANK){           	
            	   btmsg+="第"+rownum+"行，第三列(单位类型)为必填项；"+"<br/>";
               }else{  
            	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
            	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
            	   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
        		   int findid = companyDao.checkCompanycode(rowdata.getCell(1).getStringCellValue());
            	   if(findid>0){
            		   btmsg+="第"+rownum+"行，社会统一征信代码("+rowdata.getCell(1).getStringCellValue()+")已存在；"+"<br/>";
            	   }else {
            		   List<String> onelist = new ArrayList<String>();
                	   for(BasicMsg st : affecttypeList){
                		   onelist.add(st.getBasicName());
                	   }
            		   String InputType = rowdata.getCell(2).getStringCellValue();
            		   String[] InputAffectType = InputType.split("\\|");
            		   boolean affecttypeFlag = true;
            		   String affecttype = "";
            		   for (int j = 0; j < InputAffectType.length; j++) {
            			   if (onelist.contains(InputAffectType[j])) {
            				   if(affecttype!=""){
            					   affecttype+=",";
            				   }
            				   affecttype+=InputAffectType[j];
            			   }else{
            				   affecttypeFlag = false;
            				   break;
            			   }
            		   }
            		   
            		   if (affecttypeFlag) {
            			   Company company=new Company();
            			   /*-- 单位基本信息 --*/
            			   company.setCompanytype(companytype);//单位大类
            			   company.setCompanyname(rowdata.getCell(0).getStringCellValue());//单位名称
            			   company.setCompanycode(rowdata.getCell(1).getStringCellValue());//社会统一征信代码
            			   company.setAffecttype(affecttype);//单位类型
            			   if(rowdata.getCell(3)!=null){//涉及品种
                			   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                			   String managetypeCellString=rowdata.getCell(3).getStringCellValue();
                			   String managetype="";
                			   if(!"".equals(managetypeCellString)){
                				   String[] managetypeStrings=managetypeCellString.split("\\|");
                				   for (int j = 0; j < managetypeStrings.length; j++) {
                					   for (int j2 = 0; j2 < managetypeList.size(); j2++) {
                						   if (managetypeStrings[j].equals(managetypeList.get(j2).getBasicName())) {
                							   if(managetype!="")managetype+=",";
                							   managetype+=String.valueOf(managetypeList.get(j2).getId());
                							   break;
                						   }
                					   }
                				   }
                			   }
                			   company.setManagetype(managetype);
                		   }
            			   if(rowdata.getCell(4)!=null){//企业状态
                			   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                			   company.setCompanystatus(rowdata.getCell(4).getStringCellValue());
                		   }
            			   if(rowdata.getCell(5)!=null){//停用原因
            				   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setUnusedreason(rowdata.getCell(5).getStringCellValue());
            			   }
            			   if(rowdata.getCell(6)!=null){//是否入网
            				   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
            				   int innet=0;
            				   if ("是".equals(rowdata.getCell(6).getStringCellValue()))innet=1;
            				   company.setInnet(innet);
            			   }
            			   if(rowdata.getCell(7)!=null){//联系电话
            				   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setTelephone(rowdata.getCell(7).getStringCellValue());
            			   }
            			   if(rowdata.getCell(8)!=null){//经营范围
            				   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setManagerange(rowdata.getCell(8).getStringCellValue());
            			   }
            			   if(rowdata.getCell(9)!=null){//注册地所属辖区
            				   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
            				   for (int j = 0; j < departmentList.size(); j++) {
            					   if (departmentList.get(j).getDepartcode()!=null&&departmentList.get(j).getDepartcode().equals(rowdata.getCell(9).getStringCellValue())) {
            						   company.setRegisterowner(String.valueOf(departmentList.get(j).getId()));
            						   break;
            					   }
            				   }
            			   }
            			   if(rowdata.getCell(10)!=null){//办公地所属辖区
            				   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
            				   for (int j = 0; j < departmentList.size(); j++) {
            					   if (departmentList.get(j).getDepartcode()!=null&&departmentList.get(j).getDepartcode().equals(rowdata.getCell(10).getStringCellValue())) {
            						   company.setRealworkowner(String.valueOf(departmentList.get(j).getId()));
            						   break;
            					   }
            				   }
            			   }
            			   if(rowdata.getCell(11)!=null){//注册地详址
            				   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setRegisterplace(rowdata.getCell(11).getStringCellValue());
            			   }
            			   if(rowdata.getCell(12)!=null){//实际办公地详址
            				   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setRealworkplace(rowdata.getCell(12).getStringCellValue());
            			   }
            			   if(rowdata.getCell(13)!=null){//经度
            				   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setLongitude(rowdata.getCell(13).getStringCellValue());
            			   }
            			   if(rowdata.getCell(14)!=null){//纬度
            				   rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setLatitude(rowdata.getCell(14).getStringCellValue());
            			   }
            			   /*-- 法人信息 --*/
            			   if(rowdata.getCell(15)!=null){//姓名
            				   rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setLegalname(rowdata.getCell(15).getStringCellValue());
            			   }
            			   if(rowdata.getCell(16)!=null){//性别
            				   rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setSexes(rowdata.getCell(16).getStringCellValue());
            			   }
            			   if(rowdata.getCell(17)!=null){//证件号码
            				   rowdata.getCell(17).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setCardnumber(rowdata.getCell(17).getStringCellValue());
            			   }
            			   if(rowdata.getCell(18)!=null){//民族
            				   rowdata.getCell(18).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setNation(rowdata.getCell(18).getStringCellValue());
            			   }
            			   if(rowdata.getCell(19)!=null){//文化程度
            				   rowdata.getCell(19).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setEducation(rowdata.getCell(19).getStringCellValue());
            			   }
            			   if(rowdata.getCell(20)!=null){//政治面貌
            				   rowdata.getCell(20).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setPoliticalposition(rowdata.getCell(20).getStringCellValue());
            			   }
            			   if(rowdata.getCell(21)!=null){//联系电话
            				   rowdata.getCell(21).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setLegalphone(rowdata.getCell(21).getStringCellValue());
            			   }
            			   if(rowdata.getCell(22)!=null){//户籍地详址
            				   rowdata.getCell(22).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setHomeplace(rowdata.getCell(22).getStringCellValue());
            			   }
            			   if(rowdata.getCell(23)!=null){//现住地详址
            				   rowdata.getCell(23).setCellType(Cell.CELL_TYPE_STRING);
            				   company.setLifeplace(rowdata.getCell(23).getStringCellValue());
            			   }
            			   
            			   company.setValidflag(1);
            			   company.setAddoperator(userSession.getLoginUserName());
            			   company.setAddtime(addtime);
            			   companyDao.add(company);
            			   pCount++;
            		   }else{
            			   btmsg+="第"+rownum+"行，检查单位类型及分隔符；"+"<br/>";
            		   }
            	   }
               }  
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格:</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险单位 <font color='red'>"+pCount+"</font> 个</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入:</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
    }
	private String importCompanyXLS(HSSFSheet sheet,HSSFRow rowdata,String companytype,@ModelAttribute("userSession")UserSession userSession) throws IOException {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		String msg="";
		String btmsg="";
		String rowmsg="";
		int pCount=0;
		List<BasicMsg> affecttypeList=basicMsgDao.getByType(52);//单位类型 msg
		List<BasicMsg> managetypeList=basicMsgDao.getByType(50);//涉及品种 msg
		Department department=new Department();
		department.setDeparttype("0");
		List<Department> departmentList=departmentDao.getDepartmentList(department);
		for (int i =2; i < sheet.getLastRowNum()+1; i++) {
			rowdata = sheet.getRow(i);
			int rownum=i+1;
			if(rownum>3)rowmsg=" 第3行 至 第"+rownum+"行<br/>"; 
			else if(rownum==3)rowmsg=" 第3行<br/>"; 
			else rowmsg="<font color='red'>无数据导入</font><br/>"; 
			if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
				if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK)break;
				btmsg+="第"+rownum+"行，第一列(单位名称)为必填项；"+"<br/>"; 
			}else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
				btmsg+="第"+rownum+"行，第二列(社会统一征信代码)为必填项；"+"<br/>";
			}else if(rowdata.getCell(2)==null||rowdata.getCell(2).getCellType()==rowdata.getCell(2).CELL_TYPE_BLANK){           	
				btmsg+="第"+rownum+"行，第三列(单位类型)为必填项；"+"<br/>";
			}else{  
				rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
				rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
				rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
				int findid = companyDao.checkCompanycode(rowdata.getCell(1).getStringCellValue());
				if(findid>0){
					btmsg+="第"+rownum+"行，社会统一征信代码("+rowdata.getCell(1).getStringCellValue()+")已存在；"+"<br/>";
				}else {
					 List<String> onelist = new ArrayList<String>();
              	   for(BasicMsg st : affecttypeList){
              		   onelist.add(st.getBasicName());
              	   }
          		   String InputType = rowdata.getCell(2).getStringCellValue();
          		   String[] InputAffectType = InputType.split("\\|");
          		   boolean affecttypeFlag = true;
          		   String affecttype = "";
          		   for (int j = 0; j < InputAffectType.length; j++) {
          			   if (onelist.contains(InputAffectType[j])) {
          				   if(affecttype!=""){
          					   affecttype+=",";
          				   }
          				   affecttype+=InputAffectType[j];
          			   }else{
          				   affecttypeFlag = false;
          				   break;
          			   }
          		   }
	     		   
         		    if (affecttypeFlag) {
						Company company=new Company();
						/*-- 单位基本信息 --*/
						company.setCompanytype(companytype);//单位大类
						company.setCompanyname(rowdata.getCell(0).getStringCellValue());//单位名称
						company.setCompanycode(rowdata.getCell(1).getStringCellValue());//社会统一征信代码
						company.setAffecttype(affecttype);//单位类型
						if(rowdata.getCell(3)!=null){//涉及品种
							rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
							String managetypeCellString=rowdata.getCell(3).getStringCellValue();
							String managetype="";
							if(!"".equals(managetypeCellString)){
								String[] managetypeStrings=managetypeCellString.split("\\|");
								for (int j = 0; j < managetypeStrings.length; j++) {
									for (int j2 = 0; j2 < managetypeList.size(); j2++) {
										if (managetypeStrings[j].equals(managetypeList.get(j2).getBasicName())) {
											if(managetype!="")managetype+=",";
											managetype+=String.valueOf(managetypeList.get(j2).getId());
											break;
										}
									}
								}
							}
							company.setManagetype(managetype);
						}
						
						if(rowdata.getCell(4)!=null){//企业状态
							rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
							company.setCompanystatus(rowdata.getCell(4).getStringCellValue());
						}
						if(rowdata.getCell(5)!=null){//停用原因
							rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
							company.setUnusedreason(rowdata.getCell(5).getStringCellValue());
						}
						if(rowdata.getCell(6)!=null){//是否入网
							rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
							int innet=0;
							if ("是".equals(rowdata.getCell(6).getStringCellValue()))innet=1;
							company.setInnet(innet);
						}
						if(rowdata.getCell(7)!=null){//联系电话
							rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
							company.setTelephone(rowdata.getCell(7).getStringCellValue());
						}
						if(rowdata.getCell(8)!=null){//经营范围
							rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
							company.setManagerange(rowdata.getCell(8).getStringCellValue());
						}
						if(rowdata.getCell(9)!=null){//注册地所属辖区
         				   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
         				   for (int j = 0; j < departmentList.size(); j++) {
         					   if (departmentList.get(j).getDepartcode()!=null&&departmentList.get(j).getDepartcode().equals(rowdata.getCell(9).getStringCellValue())) {
         						   company.setRegisterowner(String.valueOf(departmentList.get(j).getId()));
         						   break;
         					   }
         				   }
         			   }
         			   if(rowdata.getCell(10)!=null){//办公地所属辖区
         				   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
         				   for (int j = 0; j < departmentList.size(); j++) {
         					   if (departmentList.get(j).getDepartcode()!=null&&departmentList.get(j).getDepartcode().equals(rowdata.getCell(10).getStringCellValue())) {
         						   company.setRealworkowner(String.valueOf(departmentList.get(j).getId()));
         						   break;
         					   }
         				   }
         			   }
						if(rowdata.getCell(11)!=null){//注册地详址
							rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
							company.setRegisterplace(rowdata.getCell(11).getStringCellValue());
						}
						if(rowdata.getCell(12)!=null){//实际办公地详址
							rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
							company.setRealworkplace(rowdata.getCell(12).getStringCellValue());
						}
						if(rowdata.getCell(13)!=null){//经度
							rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
							company.setLongitude(rowdata.getCell(13).getStringCellValue());
						}
						if(rowdata.getCell(14)!=null){//纬度
							rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
							company.setLatitude(rowdata.getCell(14).getStringCellValue());
						}
						/*-- 法人信息 --*/
						if(rowdata.getCell(15)!=null){//姓名
							rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
							company.setLegalname(rowdata.getCell(15).getStringCellValue());
						}
						if(rowdata.getCell(16)!=null){//性别
							rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
							company.setSexes(rowdata.getCell(16).getStringCellValue());
						}
						if(rowdata.getCell(17)!=null){//证件号码
							rowdata.getCell(17).setCellType(Cell.CELL_TYPE_STRING);
							company.setCardnumber(rowdata.getCell(17).getStringCellValue());
						}
						if(rowdata.getCell(18)!=null){//民族
							rowdata.getCell(18).setCellType(Cell.CELL_TYPE_STRING);
							company.setNation(rowdata.getCell(18).getStringCellValue());
						}
						if(rowdata.getCell(19)!=null){//文化程度
							rowdata.getCell(19).setCellType(Cell.CELL_TYPE_STRING);
							company.setEducation(rowdata.getCell(19).getStringCellValue());
						}
						if(rowdata.getCell(20)!=null){//政治面貌
							rowdata.getCell(20).setCellType(Cell.CELL_TYPE_STRING);
							company.setPoliticalposition(rowdata.getCell(20).getStringCellValue());
						}
						if(rowdata.getCell(21)!=null){//联系电话
							rowdata.getCell(21).setCellType(Cell.CELL_TYPE_STRING);
							company.setLegalphone(rowdata.getCell(21).getStringCellValue());
						}
						if(rowdata.getCell(22)!=null){//户籍地详址
							rowdata.getCell(22).setCellType(Cell.CELL_TYPE_STRING);
							company.setHomeplace(rowdata.getCell(22).getStringCellValue());
						}
						if(rowdata.getCell(23)!=null){//现住地详址
							rowdata.getCell(23).setCellType(Cell.CELL_TYPE_STRING);
							company.setLifeplace(rowdata.getCell(23).getStringCellValue());
						}
						
						company.setValidflag(1);
						company.setAddoperator(userSession.getLoginUserName());
						company.setAddtime(addtime);
						companyDao.add(company);
						pCount++;
					}else{
						btmsg+="第"+rownum+"行，检查单位类型及分隔符；"+"<br/>";
					}
				}
			}  
		}
		msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格:</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险单位 <font color='red'>"+pCount+"</font> 个</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入:</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
	}
}

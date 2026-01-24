package com.szrj.business.web.company;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
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

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.FileDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.dao.company.VehicleDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.File;
import com.szrj.business.model.company.Vehicle;

@Controller
@SessionAttributes("userSession")
public class VehicleController {

	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Picture;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private BasicMsgDao basicMsgDao;
	@Autowired
	private CompanyDao companyDao;
	
	
	@RequestMapping("/searchVehicle.do")
	@ResponseBody
	public Map<String, Object> searchLicence(Vehicle vehicle, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchvehicle.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = vehicleDao.searchVehicle(vehicle, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询风险车辆信息");
			String operate_Condition = "";
			if(vehicle.getCompanyname() != null && !"".equals(vehicle.getCompanyname())){
				operate_Condition += "风险车辆名称 LIKE '" + vehicle.getCompanyname() + "'";
			}
			if(vehicle.getVehiclecategory()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "车辆大类 = '" + vehicle.getVehiclecategory() + "'";
				}else{
					operate_Condition += " and 车辆大类 = '" + vehicle.getVehiclecategory() + "'";
				}
			}
			if(vehicle.getVehicleno() != null && !"".equals(vehicle.getVehicleno())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险牌照 LIKE '" + vehicle.getVehicleno() + "'";
				}else{
					operate_Condition += " and 风险牌照 LIKE '" + vehicle.getVehicleno() + "'";
				}
			}
			if(vehicle.getVehiclecolor() != null && !"".equals(vehicle.getVehiclecolor())){
				if("".equals(operate_Condition)){
					operate_Condition += "车辆颜色 LIKE '" + vehicle.getVehiclecolor() + "'";
				}else{
					operate_Condition += " and 车辆颜色 LIKE '" + vehicle.getVehiclecolor() + "'";
				}
			}
			if(vehicle.getVehicletype() != null && !"".equals(vehicle.getVehicletype())){
				if("".equals(operate_Condition)){
					operate_Condition += "车辆类型 = '" + vehicle.getVehicletype() + "'";
				}else{
					operate_Condition += " and 车辆类型 = '" + vehicle.getVehicletype() + "'";
				}
			}
			if(vehicle.getTransportNo() != null && !"".equals(vehicle.getTransportNo())){
				if("".equals(operate_Condition)){
					operate_Condition += "道路运输编号 = '" + vehicle.getTransportNo() + "'";
				}else{
					operate_Condition += " and 道路运输编号 = '" + vehicle.getTransportNo() + "'";
				}
			}
			if(vehicle.getEngineno() != null && !"".equals(vehicle.getEngineno())){
				if("".equals(operate_Condition)){
					operate_Condition += "发动机号 = '" + vehicle.getEngineno() + "'";
				}else{
					operate_Condition += " and 发动机号 = '" + vehicle.getEngineno() + "'";
				}
			}
			if(vehicle.getIdentificationCode() != null && !"".equals(vehicle.getIdentificationCode())){
				if("".equals(operate_Condition)){
					operate_Condition += "车辆识别代码 = '" + vehicle.getIdentificationCode() + "'";
				}else{
					operate_Condition += " and 车辆识别代码 = '" + vehicle.getIdentificationCode() + "'";
				}
			}
			if(vehicle.getCompanyid() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "所属单位id = '" + vehicle.getCompanyid() + "'";
				}else{
					operate_Condition += " and 所属单位id = '" + vehicle.getCompanyid() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
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
	@RequestMapping("/getVehicleById.do")
	public String getById(int id, int menuid, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getvehicleById.do ...  menuid="+menuid);
		String url = "";
		List<File> files = new ArrayList<File>();
		String fileName = "";
		
		Vehicle vehicle = new Vehicle();
		try {
			vehicle = vehicleDao.getById(id);
			
			if(null!=vehicle.getAttachments()&&vehicle.getAttachments().length()>0){
				String att = "(" + vehicle.getAttachments() + ")";
				files = fileDao.getFileMsgByIdstr(att);
				for(int i=0;i<files.size();i++){
					fileName += files.get(i).getFileallName()+",";
				}
				model.addAttribute("fileName", fileName.substring(0, fileName.length()-1));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("files", files);
		model.addAttribute("vehicle", vehicle);
		model.addAttribute("id", id);
		model.addAttribute("menuid", menuid);
		String PU = uploadFile_Picture.replace("\\", "/");
		if(page.equals("showinfo")){
			model.addAttribute("pictureurl", PU);
			url = "jsp/company/vehicle_showinfo";
		}else if(page.equals("update")){
			model.addAttribute("pictureurl", PU.substring(PU.indexOf("upload")-1)+"/");
			url = "jsp/company/vehicle_update";
		}else if(page.equals("update2")){
			model.addAttribute("pictureurl", PU.substring(PU.indexOf("upload")-1)+"/");
			url = "jsp/vehicle/vehicle_update";
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询选定风险车辆信息");
		String operate_Condition = "";
		operate_Condition += "车辆ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 新增
	 * @param vehicle
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addVehicle.do")
	public @ResponseBody String addvehicle(Vehicle vehicle,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addvehicle.do ... menuid="+menuid);
		vehicle.setAddtime(addtime);
		vehicle.setAddoperator(userSession.getLoginUserName());
		try {
			int cpid = vehicleDao.checkCP(vehicle.getVehicleno());
			if(cpid > 0){
				message = new Message("true","添加失败,车牌号重复");
				message.setFlag(-1);
				logDao.recordLog(menuid, "风险车辆添加", userSession.getLoginUserName(), addtime, "添加失败", "");
				System.out.println("addvehicle.do ... 车牌号重复");
			}else{
				vehicleDao.add(vehicle);
				message = new Message("true","添加成功");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险车辆添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addvehicle.do ... 风险车辆添加成功");
			}
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("新增风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","风险车辆添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险车辆添加失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("新增风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除风险车辆
	 * @param vehicle
	 * @return
	 */
	@RequestMapping("/cancelVehicle.do")
	@ResponseBody
	public String cancelvehicle(Vehicle vehicle, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelvehicle.do ... menuid"+menuid);
		try {
			vehicleDao.cancel(vehicle);
			message = new Message("true","风险车辆已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险车辆信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","风险车辆删除失败");
			message.setFlag(-1);
			System.out.println("cancelvehicle.do ... 删除失败");
			logDao.recordLog(menuid, "风险车辆信息删除失败", userSession.getLoginUserName(), updatetime, "删除失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改风险车辆信息
	 * @param vehicle
	 * @return
	 */
	@RequestMapping("/updateVehicle.do")
	@ResponseBody
	public String updatevehicle(Vehicle vehicle, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updateTime = dateFormat.format(new Date());
		vehicle.setUpdateoperator(userSession.getLoginUserName());
		vehicle.setUpdatetime(updateTime);
		try {
			vehicleDao.update(vehicle);
			message = new Message("true","风险车辆信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险车辆信息修改", userSession.getLoginUserName(), updateTime, "修改成功", "");
			System.out.println("updatevehicle.do ... 修改成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","风险车辆信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险车辆信息修改失败", userSession.getLoginUserName(), updateTime, "修改失败", "");
			System.out.println("updatevehicle.do ... 修改失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改风险车辆");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 导入风险车辆
	 * @return
	 */
	@RequestMapping("/importVehicle.do")
	@ResponseBody
	public Map<String,Object> importVehicle(HttpServletRequest request, HttpServletResponse response,@RequestParam("file") MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException{
		Map<String,Object> json = new HashMap<String,Object>();
		String msg = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//原文件名
			String fileName = myFile.getOriginalFilename();
			//文件扩展名
			String fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
			InputStream fis = (InputStream) myFile.getInputStream();
      	  	XSSFWorkbook workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet=workbook.getSheetAt(0);
            XSSFRow rowdata=null;
            msg=importVehicleXLSX(sheet,rowdata,userSession);
            json.put("success",msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	private String importVehicleXLSX(XSSFSheet sheet,XSSFRow rowdata,@ModelAttribute("userSession")UserSession userSession) throws IOException {
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
    	String msg="";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	List<BasicMsg> managetypeList=basicMsgDao.getByType(50);//涉及品种 msg
    	for(int i=2;i<sheet.getLastRowNum()+1;i++){
    		rowdata = sheet.getRow(i);
    		int rownum=i+1;
         	if(rownum>3)rowmsg=" 第3行 至 第"+rownum+"行<br/>"; 
   		   	else if(rownum==3)rowmsg=" 第3行<br/>"; 
   		   	else rowmsg="<font color='red'>无数据导入</font><br/>"; 
         	if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
	   			   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK)break;
	   			   btmsg+="第"+rownum+"行，第一列(所属单位)为必填项；"+"<br/>"; 
            }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
         	   btmsg+="第"+rownum+"行，第二列(车牌照)为必填项；"+"<br/>";
            }else{
            	rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
         	   	rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
         	   	Integer companyid = companyDao.getIdByName(rowdata.getCell(0).getStringCellValue());
         	   	Integer CPid = vehicleDao.checkCP(rowdata.getCell(1).getStringCellValue());
         	   	if(null==companyid){
         	   		btmsg +="第"+rownum+"行，第一列(企业名)系统未录入；"+"<br/>";
         	   	}else if(CPid > 0){
         	   		btmsg +="第"+rownum+"行，第二列(车牌号)重复；"+"<br/>";
         	   	}else{
         	   		List<String> onelist = new ArrayList<String>();
         	   		String relatedtype = "";
         	   		if(rowdata.getCell(2)!=null){
         	   			rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
	         	   		String sjpz = rowdata.getCell(2).getStringCellValue();
	         	   		if(!"".equals(sjpz)){
	         	   			String[] sjpzString = sjpz.split("\\|");
	         	   			for(int j=0;j<sjpzString.length;j++){
	         	   				for(int k=0;k<managetypeList.size();k++){
	         	   					if(sjpzString[j].equals(managetypeList.get(k).getBasicName())){
		         	   					if(relatedtype!=""){
		         	   						relatedtype+=",";
		         	   					}
		         	   					relatedtype += managetypeList.get(k).getId();
		         	   					break;
		         	   				}
	         	   				}
	         	   			}
	         	   		}
         	   		}
         	   		Vehicle vehicle = new Vehicle();
         	   		vehicle.setCompanyid(companyid);//单位id
         	   		vehicle.setVehiclecategory(1039);
         	   		vehicle.setCompanyname(rowdata.getCell(0).getStringCellValue());//单位名称
         	   		vehicle.setVehicleno(rowdata.getCell(1).getStringCellValue());//车牌
         	   		vehicle.setRelatedtype(relatedtype);//涉及品种
	         	   	if(rowdata.getCell(3)!=null){//品牌型号
	     	   			rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setVehiclebrand(rowdata.getCell(3).getStringCellValue());
	     	   		}
	         	    if(rowdata.getCell(4)!=null){//车辆类型
	     	   			rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setVehicletype(rowdata.getCell(4).getStringCellValue());
	     	   		}
	         	    if(rowdata.getCell(5)!=null){//车辆颜色
	     	   			rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setVehiclecolor(rowdata.getCell(5).getStringCellValue());
	     	   		}
	         	    if(rowdata.getCell(6)!=null){//道路运输编号
	     	   			rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setTransportNo(rowdata.getCell(6).getStringCellValue());
	     	   		}
	         	    if(rowdata.getCell(7)!=null){//许可范围
        	   			rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
        	   			vehicle.setAllowrange(rowdata.getCell(7).getStringCellValue());
        	   		}
	         	    if(rowdata.getCell(8)!=null){//发动机号
	     	   			rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setEngineno(rowdata.getCell(8).getStringCellValue());
	     	   		}
	         	   if(rowdata.getCell(9)!=null){//车辆识别代码
	     	   			rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
	     	   			vehicle.setIdentificationCode(rowdata.getCell(9).getStringCellValue());
	     	   		}
	         	    vehicle.setValidflag(1);
	         	    vehicle.setAddoperator(userSession.getLoginUserName());
	         	    vehicle.setAddtime(addtime);
	         	    vehicleDao.add(vehicle);
	         	    pCount++;
         	   	}
            }
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格:</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>风险车辆 <font color='red'>"+pCount+"</font>条</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入:</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
	}
}


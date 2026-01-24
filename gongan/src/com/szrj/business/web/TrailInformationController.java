package com.szrj.business.web;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberCheck;
import com.aladdin.util.CardnumberInfo;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.TrailInformationDao;
import com.szrj.business.model.TrailInformation;

@Controller
@SessionAttributes("userSession")
public class TrailInformationController {
	@Autowired
	private TrailInformationDao trailDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchTrailInformation.do")
	@ResponseBody
	public Map<String,Object> searchTrailInformation(TrailInformation trailInformation,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=trailDao.searchTrailInformation(trailInformation, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/cancelTrailInformation.do")
	public @ResponseBody String cancelTrailInformation(String ids,TrailInformation trailInformation,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message=null;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		String msg="";
		switch (trailInformation.getTrailtype()) {
			case 1:
				msg+="全国银行信息";
				break;
			case 2:
				msg+="全国铁路信息";
				break;
			case 3:
				msg+="全国民航离港信息";
				break;
			case 4:
				msg+="全国民航订票信息";
				break;
			case 5:
				msg+="全国机动车违章信息";
				break;
			case 6:
				msg+="全国出入境信息";
				break;
		}
		try {
			trailInformation.setUpdateoperator(userSession.getLoginUserName());
			trailInformation.setUpdatetime(addtime);
			String[] idstrings=ids.split(",");
			for (int i = 0; i < idstrings.length; i++) {
				trailInformation.setId(Integer.parseInt(idstrings[i]));
				trailDao.cancel(trailInformation);
			}
			message= new Message("true",msg+"删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, msg+"删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelTrailInformation.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false",msg+"删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, msg+"删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelTrailInformation.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
	@RequestMapping("/importTrailInformation.do")
    @ResponseBody
    public Map<String, Object> importTrailInformation(HttpServletRequest request,HttpServletResponse response,@RequestParam("trailtype")int trailtype,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
                  msg=importTrailInformationXLS(sheet,rowdata,trailtype,userSession);                 
              }else if(fileType.equals("xlsx")){   
            	  XSSFWorkbook workbook = new XSSFWorkbook(fis);
                  XSSFSheet sheet=workbook.getSheetAt(0);
                  XSSFRow rowdata=null;
                  msg=importTrailInformationXLSX(sheet,rowdata,trailtype,userSession);
              }        
              json.put("success",msg);
    } catch (Exception e) {
        e.printStackTrace();
    }   
    return json;  
    }
	
	private String importTrailInformationXLSX(XSSFSheet sheet,XSSFRow rowdata,int trailtype,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
					   TrailInformation trail=new TrailInformation();
					   trail.setCardnumber(rowdata.getCell(0).getStringCellValue());
					   trail.setPersonname(rowdata.getCell(1).getStringCellValue());
					   trail.setTrailtype(trailtype);//标签
					   trail.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
					   trail.setValidflag(1);
					   trail.setAddoperator(userSession.getLoginUserName());
					   trail.setAddtime(addtime);

					    if(rowdata.getCell(2)!=null){
						   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter1(rowdata.getCell(2).getStringCellValue());
					   }
						if(rowdata.getCell(3)!=null){
						   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter2(rowdata.getCell(3).getStringCellValue());
					   }
						if(rowdata.getCell(4)!=null){
						   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter3(rowdata.getCell(4).getStringCellValue());
					   }
						if(rowdata.getCell(5)!=null){
						   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter4(rowdata.getCell(5).getStringCellValue());
					   }
						if(rowdata.getCell(6)!=null){
						   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter5(rowdata.getCell(6).getStringCellValue());
					   }
						if(rowdata.getCell(7)!=null){
						   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter6(rowdata.getCell(7).getStringCellValue());
					   }
						if(rowdata.getCell(8)!=null){
						   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter7(rowdata.getCell(8).getStringCellValue());
					   }
						if(rowdata.getCell(9)!=null){
						   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter8(rowdata.getCell(9).getStringCellValue());
					   }
						if(rowdata.getCell(10)!=null){
						   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter9(rowdata.getCell(10).getStringCellValue());
					   }
						if(rowdata.getCell(11)!=null){
						   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter10(rowdata.getCell(11).getStringCellValue());
					   }
						if(rowdata.getCell(12)!=null){
						   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter11(rowdata.getCell(12).getStringCellValue());
					   }
						if(rowdata.getCell(13)!=null){
						   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter12(rowdata.getCell(13).getStringCellValue());
					   }
						if(rowdata.getCell(14)!=null){
						   rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter13(rowdata.getCell(14).getStringCellValue());
					   }
						if(rowdata.getCell(15)!=null){
						   rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter14(rowdata.getCell(15).getStringCellValue());
					   }
						if(rowdata.getCell(16)!=null){
						   rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter15(rowdata.getCell(16).getStringCellValue());
					   }
						trailDao.add(trail);
						pCount++;
            	   }else {
            		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            	   }
               }  
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>";
		switch(trailtype){
			case 1:
				msg+="全国银行信息";
				break;
			case 2:
				msg+="全国铁路信息";
				break;
			case 3:
				msg+="全国民航离港信息";
				break;
			case 4:
				msg+="全国民航订票信息";
				break;
			case 5:
				msg+="全国机动车违章信息";
				break;
			case 6:
				msg+="全国出入境信息";
				break;
			
		}
		msg+="<font color='red'>"+pCount+"</font> 条</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
    }
	private String importTrailInformationXLS(HSSFSheet sheet,HSSFRow rowdata,int trailtype,@ModelAttribute("userSession")UserSession userSession) throws IOException {
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
					   TrailInformation trail=new TrailInformation();
					   trail.setCardnumber(rowdata.getCell(0).getStringCellValue());
					   trail.setPersonname(rowdata.getCell(1).getStringCellValue());
					   trail.setTrailtype(trailtype);//标签
					   trail.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
					   trail.setValidflag(1);
					   trail.setAddoperator(userSession.getLoginUserName());
					   trail.setAddtime(addtime);

					    if(rowdata.getCell(2)!=null){
						   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter1(rowdata.getCell(2).getStringCellValue());
					   }
						if(rowdata.getCell(3)!=null){
						   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter2(rowdata.getCell(3).getStringCellValue());
					   }
						if(rowdata.getCell(4)!=null){
						   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter3(rowdata.getCell(4).getStringCellValue());
					   }
						if(rowdata.getCell(5)!=null){
						   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter4(rowdata.getCell(5).getStringCellValue());
					   }
						if(rowdata.getCell(6)!=null){
						   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter5(rowdata.getCell(6).getStringCellValue());
					   }
						if(rowdata.getCell(7)!=null){
						   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter6(rowdata.getCell(7).getStringCellValue());
					   }
						if(rowdata.getCell(8)!=null){
						   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter7(rowdata.getCell(8).getStringCellValue());
					   }
						if(rowdata.getCell(9)!=null){
						   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter8(rowdata.getCell(9).getStringCellValue());
					   }
						if(rowdata.getCell(10)!=null){
						   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter9(rowdata.getCell(10).getStringCellValue());
					   }
						if(rowdata.getCell(11)!=null){
						   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter10(rowdata.getCell(11).getStringCellValue());
					   }
						if(rowdata.getCell(12)!=null){
						   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter11(rowdata.getCell(12).getStringCellValue());
					   }
						if(rowdata.getCell(13)!=null){
						   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter12(rowdata.getCell(13).getStringCellValue());
					   }
						if(rowdata.getCell(14)!=null){
						   rowdata.getCell(14).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter13(rowdata.getCell(14).getStringCellValue());
					   }
						if(rowdata.getCell(15)!=null){
						   rowdata.getCell(15).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter14(rowdata.getCell(15).getStringCellValue());
					   }
						if(rowdata.getCell(16)!=null){
						   rowdata.getCell(16).setCellType(Cell.CELL_TYPE_STRING);
						   trail.setParameter15(rowdata.getCell(16).getStringCellValue());
					   }
						trailDao.add(trail);
						pCount++;
            	   }else {
            		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
            	   }
               }  
    	}
    	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
    	msg+="<tr><td>成功导入:</td><td>";
		switch(trailtype){
			case 1:
				msg+="全国银行信息";
				break;
			case 2:
				msg+="全国铁路信息";
				break;
			case 3:
				msg+="全国民航离港信息";
				break;
			case 4:
				msg+="全国民航订票信息";
				break;
			case 5:
				msg+="全国机动车违章信息";
				break;
			case 6:
				msg+="全国出入境信息";
				break;
		}
		msg+="<font color='red'>"+pCount+"</font> 条</td></tr>";
    	if(btmsg!=""){
    		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
    		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
    	}
    	msg+="</table>";
    	return msg;
	}
}

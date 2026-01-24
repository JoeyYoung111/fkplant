package com.szrj.business.web.mobileInterface;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.szrj.business.dao.FileDao;

@Controller
@SessionAttributes("userSession")
public class MobileFileController {
	@Autowired
	private FileDao fileDao;
	private
    @Value("#{configProperties.uploadFile_Pricture}")
    String uploadFile_Pricture;	//读配置文件中的文件上传路径
    private
    @Value("#{configProperties.uploadFile_Document}")
    String uploadFile_Document;	//读配置文件中的文件上传路径
	private
    @Value("#{configProperties.uploadFile}")
    String uploadFile;	//读配置文件中的文件上传路径	
	@Value("#{configProperties.uploadFile_Sign}")
	String uploadFile_Sign;	//读配置文件中的文件上传路径
	
	@RequestMapping("/downMobileUpfile.post")
	public void downMobileUpfile(String type,HttpServletRequest request,HttpServletResponse response,String fileid) {
		try {
			 System.out.println("-------（根据上传的文件ID下载该文件）/downUpfile.do（开始）-------");			
			 /*获取要下载的文件路径*/
				java.io.File file = null;
				String fileName="";
				 String fileallName="";
			       com.szrj.business.model.File file1 = fileDao.getFileById(Integer.parseInt(fileid));
				    fileName = file1.getFileName();				
				    fileallName=file1.getFileallName();
			
			     String filePath = "";
			      if(type!=null){
			    	  if(file1.getValidflag()>1)filePath = uploadFile+"\\"+fileallName;
			    	  else filePath = uploadFile_Pricture+"\\"+fileallName;
			      }else{
			    	  if(file1.getValidflag()>1)filePath = uploadFile+"\\"+fileallName;
			    	  else filePath = uploadFile_Document+"\\"+fileallName;
			    	  
			      }
			     System.out.println("-------文件下载路径-------"+filePath);
                file = new java.io.File(filePath);
			        InputStream fis;
					fis = new BufferedInputStream(new FileInputStream(file));
					response.reset();    
			        response.setContentType("application/x-download"); 
			        response.addHeader("Content-Disposition","attachment;filename="+ new String(fileName.getBytes(),"iso-8859-1"));
					response.addHeader("Content-Length", "" + file.length());    
			        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());    
			        response.setContentType("application/octet-stream");    
			        byte[] buffer = new byte[1024 * 1024 * 4];    
			        int i = -1;    
			        while ((i = fis.read(buffer)) != -1) {    
			              toClient.write(buffer, 0, i);   
			          }    
			
			         fis.close();    
			         toClient.flush();    
			         toClient.close();    
			       } catch (Exception e) { 
			          e.printStackTrace(); 
			        }   
	}
}

package com.szrj.business.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.aladdin.model.Message;
import com.szrj.business.dao.FileDao;


@Controller
@SessionAttributes("userSession")
public class FileController {
	@Autowired
	private FileDao fileDao;
	private
    @Value("#{configProperties.uploadFile_Pricture}")
    String uploadFile_Pricture;	//读配置文件中的文件上传路径
    private
    @Value("#{configProperties.uploadFile_Document}")
    String uploadFile_Document;	//读配置文件中的文件上传路径
    private
    @Value("#{configProperties.uploadFile_Audio}")
    String uploadFile_Audio;	//读配置文件中的文件上传路径
	private
    @Value("#{configProperties.uploadFile}")
    String uploadFile;	//读配置文件中的文件上传路径	
	private
	@Value("#{configProperties.layeditPricture}")
	String layeditPricture;	//读配置文件中的文件上传路径	
	@Value("#{configProperties.uploadFile_Sign}")
	String uploadFile_Sign;	//读配置文件中的文件上传路径
	
	
	@RequestMapping("/upload.do")
	@ResponseBody
	public List<String> upload(String str){
	    List<String> list = new ArrayList();
	    list.add(str);
	    return list;
	}
	

	//上传图片
	@RequestMapping("/newuploadfile.do")
    @ResponseBody
    public Map<String, Object> updatePhoto(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile){
        Map<String, Object> json = new HashMap<String, Object>();    
        String fileallName="";
        System.out.println("进入文件上传newuploadfile====="+myFile.getOriginalFilename());    
        String filename =myFile.getOriginalFilename();
        //输出文件后缀名称
        try { 
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");                     
        //获取当前时间
        String newdate=df.format(new Date()); 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        fileallName=newdate+filename;
        System.out.println("上传文件名称="+fileallName);          
        //存入文件磁盘中       
        String url = uploadFile_Pricture+"\\"+ ymd + "\\";
        String path =fileallName;
        System.out.println("上传文件路径="+url);       
        File file = new File(url);
        if(!file.exists()){
            file.mkdirs();
        }
        System.out.println("完整相对路径="+url+path);
        myFile.transferTo(new File(url+path));
        //插入文件表中
        com.szrj.business.model.File file2 = new com.szrj.business.model.File();       
        file2.setFileallName(ymd +"/"+fileallName);
        file2.setFileName(myFile.getOriginalFilename().toLowerCase());
        int fileid=fileDao.addFile(file2);     
        json.put("success", fileid);
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return json;             
    }
	
	//上传文件
	@RequestMapping("/newuploadfile1.do")
    @ResponseBody
    public Map<String, Object> updatefile(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile){
        Map<String, Object> json = new HashMap<String, Object>();    
        String fileallName="";
        System.out.println("进入文件上传newuploadfile====="+myFile.getOriginalFilename());    
        String filename =myFile.getOriginalFilename();
        //输出文件后缀名称
        try {
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");                     
        //获取当前时间
        String newdate=df.format(new Date()); 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        fileallName=newdate+filename;
        System.out.println("上传文件名称="+fileallName);          
         //存入文件磁盘中       
        String url = uploadFile_Document+"\\"+ymd + "\\";
        String path =fileallName;
        System.out.println("上传文件路径="+url);       
        File file = new File(url);
        if(!file.exists()){
            file.mkdirs();
        }
        System.out.println("完整相对路径="+url+path);
        myFile.transferTo(new File(url+path));
        //插入文件表中
        com.szrj.business.model.File file2 = new com.szrj.business.model.File();       
        file2.setFileallName(ymd +"/"+fileallName);
        file2.setFileName(myFile.getOriginalFilename().toLowerCase());
        file2.setAddTime(addtime);
        int fileid=fileDao.addFile(file2);     
        json.put("success", fileid);
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return json;           
    }
	
	//上传音频文件
	@RequestMapping("/newuploadrecodefile.do")
    @ResponseBody
    public Map<String, Object> newuploadrecodefile(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")  MultipartFile myFile){
        Map<String, Object> json = new HashMap<String, Object>();    
        String fileallName="";
        System.out.println("进入文件上传newuploadfile====="+myFile.getOriginalFilename());    
        String filename =myFile.getOriginalFilename();
        //输出文件后缀名称
        try { 
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");                     
        //获取当前时间
        String newdate=df.format(new Date()); 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        fileallName=filename;
        System.out.println("上传文件名称="+fileallName);          
         //存入文件磁盘中       
        String url = uploadFile_Audio+"\\"+ymd + "\\";
        String path =fileallName;
        System.out.println("上传文件路径="+url);       
        File file = new File(url);
        if(!file.exists()){
            file.mkdirs();
        }
        System.out.println("完整相对路径="+url+path);
        myFile.transferTo(new File(url+path));
        //插入文件表中
        com.szrj.business.model.File file2 = new com.szrj.business.model.File();       
        file2.setFileallName(ymd +"/"+fileallName);
        file2.setFileName(myFile.getOriginalFilename().toLowerCase());
        int fileid=fileDao.addFile(file2);     
        json.put("success", fileid);
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return json;         
    }
	
	//根据文件id删除数据库和磁盘文件（多个）
	@RequestMapping("/deletefilesbyidstr.do")
    @ResponseBody
    public Map<String, Object> deletefilesbyidstr(HttpServletRequest request,String deleteidstr,String type){
    System.out.println("进入删除");
    System.out.println(deleteidstr);
    String idstr=deleteidstr.substring(0, deleteidstr.length()-1);
    idstr="("+idstr+")";
    String names="";
    String filepath="";
    String url = request.getSession().getServletContext().getRealPath("/")+"upload"+"\\";
    Map<String, Object> json = new HashMap<String, Object>();
    	try {
    		List<com.szrj.business.model.File> list=fileDao.getFileMsgByIdstr(idstr);   
    		/*从数据库删除文件*/   		
    		fileDao.deleteFile(idstr);   		
    		/*物理删除该文件*/
    		/*根据上传的文件名获取该文件的路径*/
    		for(com.szrj.business.model.File f:list){
    			if(type.equals("picture")){
    				 filepath=uploadFile_Pricture+"\\"+f.getFileallName();	
    			}else if(type.equals("files")){   				
    				filepath=uploadFile_Document+"\\"+f.getFileallName();	
    			}
    			
    			int dot=f.getFileallName().lastIndexOf(".");
    			if((dot>-1)&&(dot<(f.getFileallName().length()))){           	
    	       //得到不带后缀名的文件名称
    				names=f.getFileallName().substring(0,dot);   	       
    	        }  			
    	        System.out.println("待删除的文件路径："+filepath);   	        
    	        java.io.File fi = new java.io.File(filepath);	//定义文件路径
    	        org.apache.tools.ant.util.FileUtils.delete(fi);	//删除文件	   	        
    	      
    		}
    		json.put("success", "删除成功");
		} catch (Exception e) {
			// TODO: handle exception
			json.put("success", "删除失败");
		}
		System.out.println("删除结束");
    	return json;
    }
	
	//根据文件id删除数据库和磁盘文件（单个）
	@RequestMapping("/deletefilebyid.do")
    @ResponseBody
    public Map<String, Object>  deletefilebyid(HttpServletRequest request,int id,String type){
    System.out.println("进入删除");
    System.out.println(id);
    String names="";
    String filepath="";
    String url = request.getSession().getServletContext().getRealPath("/")+"upload"+"\\";
    Map<String, Object> json = new HashMap<String, Object>();
    	try {
    		com.szrj.business.model.File file=fileDao.getFileById(id);   
    		/*从数据库删除文件*/   		
    		fileDao.cancelFileById(id);   		
    		/*物理删除该文件*/
    		/*根据上传的文件名获取该文件的路径*/
    		
    		if(type.equals("picture")){
    			 filepath=uploadFile_Pricture+"\\"+file.getFileallName();	
    		}else if(type.equals("files")){   				
    			filepath=uploadFile_Document+"\\"+file.getFileallName();	
    		}			
            System.out.println("待删除的文件路径："+filepath);   	        
            java.io.File fi = new java.io.File(filepath);	//定义文件路径
            org.apache.tools.ant.util.FileUtils.delete(fi);	//删除文件	   	              
    		json.put("success", "删除成功");
		} catch (Exception e) {
			// TODO: handle exception
			json.put("success", "删除失败");
		}
    System.out.println("删除结束");
    	return json;
    }
	
	/**
	 * 将layuiedit中的图片添加到服务器
	 * @param request
	 * @param file
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
    @RequestMapping("/leuploadFile.do")
    public Map leuploadFile(HttpServletRequest request, @RequestParam("file") MultipartFile myFile) throws IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> map2 = new HashMap<String, Object>();
        if (myFile != null) {
            String fileallName="";
            System.out.println("进入文件上传newuploadfile====="+myFile.getOriginalFilename());    
            String filename =myFile.getOriginalFilename();
            //输出文件后缀名称
            try { 
		            DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");                     
		            //获取当前时间
		            String newdate=df.format(new Date()); 
		            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		            String ymd = sdf.format(new Date());
		            fileallName=newdate+filename;
		            System.out.println("上传文件名称="+fileallName);          
		             //存入文件磁盘中       
		            String url = layeditPricture+"\\"+ymd + "\\";
		            //文本框的图片插入路径
		            String leurl = layeditPricture+"/"+ymd + "/";
		            String path =fileallName;
		            System.out.println("上传文件路径="+url);       
		            File file = new File(url);
		            if(!file.exists()){
		                file.mkdirs();
		            }
		            System.out.println("完整相对路径="+url+path);
		            myFile.transferTo(new File(url+path));
		            //插入文件表中
		            com.szrj.business.model.File file2 = new com.szrj.business.model.File();       
		            file2.setFileallName(ymd +"/"+fileallName);
		            file2.setFileName(myFile.getOriginalFilename().toLowerCase());
		            int fileid=fileDao.addFile(file2); 
	                map.put("code", 0);//0表示成功，1失败
	                map.put("msg", "上传成功");//提示消息
	                map.put("data", map2);
	                leurl = leurl.replaceAll("\\", "/");
	                map2.put("src", leurl.substring(leurl.indexOf("upload")-1)+path);//图片url
	                map2.put("title", fileallName);//图片名称，这个会显示在输入框里
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return map;
    }
	
	/**
     * 文件下载
     * @param response
     * @param fileid
     */
    @RequestMapping("/downUpfile.do")
	public void downUpfile(String type,HttpServletRequest request,HttpServletResponse response,String fileid) {					
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
    
    @RequestMapping("/getFileNames.do")
    public @ResponseBody String getFileNames(String fileattachments) {	
    	Message message;
     try {
    	com.szrj.business.model.File file1 = fileDao.getFileNames(fileattachments);
    	message = new Message(file1.getFileName(),file1.getFileallName());
    	message.setMark(file1.getAddOperator());
		message.setFlag(1);
    } catch (Exception e) {
		e.printStackTrace();
		message = new Message("","");
		message.setFlag(-1);
	}
	return JSONObject.fromObject(message).toString();
    }
    
    
    
}

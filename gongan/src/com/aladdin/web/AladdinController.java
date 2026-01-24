package com.aladdin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.aladdin.model.Message;
import com.aladdin.util.ArithUtil;
import com.aladdin.util.Configuration;
import com.aladdin.util.FileOperate;
import com.aladdin.util.TimeFormate;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.io.*;

@Controller
@SessionAttributes("userSession")
public class AladdinController implements ServletContextListener{
	/*---------------------各文件类型上传的路径------------------------------------------*/
	private String uploadFile;				//文件根目录
	private String uploadFile_Pricture;		//图片存放路径
	private String uploadFile_Document;		//文档存放路径
	private String uploadFile_Video;		//视频存放路径
	private String uploadFile_Other;		//其他存放路径
	private String uploadFile_Temp;			//临时文件存放路径
	/*---------------------构造函数（用于封装文件地址的值）--------------------------------*/
    public AladdinController(){
    
    }
    /*---------------------get/set方法------------------------------------------------*/
    public String getUploadFile_Pricture() {
		return uploadFile_Pricture;
	}

	public void setUploadFile_Pricture(String uploadFile_Pricture) {
		this.uploadFile_Pricture = uploadFile_Pricture;
	}

	public String getUploadFile_Document() {
		return uploadFile_Document;
	}

	public void setUploadFile_Document(String uploadFile_Document) {
		this.uploadFile_Document = uploadFile_Document;
	}

	public String getUploadFile_Video() {
		return uploadFile_Video;
	}

	public void setUploadFile_Video(String uploadFile_Video) {
		this.uploadFile_Video = uploadFile_Video;
	}

	public String getUploadFile_Other() {
		return uploadFile_Other;
	}

	public void setUploadFile_Other(String uploadFile_Other) {
		this.uploadFile_Other = uploadFile_Other;
	}

	public String getUploadFile_Temp() {
		return uploadFile_Temp;
	}

	public void setUploadFile_Temp(String uploadFile_Temp) {
		this.uploadFile_Temp = uploadFile_Temp;
	}
	
	public String getUploadFile() {
		return uploadFile;
	}
	
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}
	/*---------------------可执行的各类方法------------------------------------------------*/
	/**
	 * 检查设置的上传文件路径下对应文件夹是否存在
	 * @author xuxj
	 */
	public void contextInitialized(ServletContextEvent arg0) {
		/*服务开启时执行操作*/
		System.out.println("-------检查设置的上传文件路径下对应文件夹是否存在-------");
		System.out.println("-------根路径：" + uploadFile + "-------");
		File file = new File(uploadFile.substring(0, uploadFile.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------根路径不存在！开始创建根路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile.substring(0, uploadFile.length()-1));
		}else{
			System.out.println("-------根路径存在！-------");
		}
		
		System.out.println("-------图片存放路径：" + uploadFile_Pricture + "-------");
		file = new File(uploadFile_Pricture.substring(0, uploadFile_Pricture.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------图片存放路径不存在！开始创建图片存放路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile_Pricture.substring(0, uploadFile_Pricture.length()-1));
		}else{
			System.out.println("-------图片存放路径存在！-------");
		}
		
		System.out.println("-------文档存放路径：" + uploadFile_Document + "-------");
		file = new File(uploadFile_Document.substring(0, uploadFile_Document.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------文档存放路径不存在！开始创建文档存放路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile_Document.substring(0, uploadFile_Document.length()-1));
		}else{
			System.out.println("-------文档存放路径存在！-------");
		}
		
		System.out.println("-------视频存放路径：" + uploadFile_Video + "-------");
		file = new File(uploadFile_Video.substring(0, uploadFile_Video.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------视频存放路径不存在！开始创建视频存放路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile_Video.substring(0, uploadFile_Video.length()-1));
		}else{
			System.out.println("-------视频存放路径存在！-------");
		}
		
		System.out.println("-------其他存放路径：" + uploadFile_Other + "-------");
		file = new File(uploadFile_Other.substring(0, uploadFile_Other.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------其他存放路径不存在！开始创建其他存放路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile_Other.substring(0, uploadFile_Other.length()-1));
		}else{
			System.out.println("-------其他存放路径存在！-------");
		}
		
		System.out.println("-------临时文件存放路径：" + uploadFile_Temp + "-------");
		file = new File(uploadFile_Temp.substring(0, uploadFile_Temp.length()-1));
		if(!file.exists() && !file.isDirectory()){
			System.out.println("-------临时文件存放路径不存在！开始创建临时文件存放路径！-------");
			FileOperate fo = new FileOperate();
			fo.newFolder(uploadFile_Temp.substring(0, uploadFile_Temp.length()-1));
		}else{
			System.out.println("-------临时文件存放路径存在！-------");
		}
	}
	public void contextDestroyed(ServletContextEvent arg0) {
		/*服务关闭时执行操作*/
	}
    
    /**
     * 根据上传的文件名查询该文件所对应的路径
     * @author xuxj
     * @param filename
     * @return String
     */
    public String getFilePathByFileName(String filename){
		String filepath = "";
        if(filename.substring(filename.lastIndexOf(".") + 1).indexOf("JPG") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("GIF") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("JPEG") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("BMP") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("PNG") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("TIF") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("TIFF") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("DWG") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("ICO") > -1){
            filepath = uploadFile_Pricture + filename;
        }else if(filename.substring(filename.lastIndexOf(".") + 1).indexOf("TXT") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("DOC") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("DOCX") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("XLS") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("XLSX") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("PDF") > -1
                || filename.substring(filename.lastIndexOf(".") + 1).indexOf("PPT") > -1){
            filepath = uploadFile_Document + filename;
        }else if(filename.substring(filename.lastIndexOf(".") + 1).indexOf("AVI") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("RMVB") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("RM") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("ASF") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("DIVX") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("MPG") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("MPEG") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("MPE") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("WMV") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("MP4") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("MKV") > -1
        		|| filename.substring(filename.lastIndexOf(".") + 1).indexOf("VOB") > -1){
            filepath = uploadFile_Video + filename;
        }else{
        	filepath = uploadFile_Other + filename;
        }
		return filepath;
	}
    
    /**
     * 文件上传
     * @author xuxj
     * @param request
     * @return ModelAndView
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/uploadfile.do")
    public ModelAndView uploadfileNow(HttpServletRequest request){
    	ModelAndView view = new ModelAndView(JsonView.instance);
    	System.out.println("-------开始准备上传文件-------");
    	try {
    		/*上传文件的类型*/
    		String filetype = "";
    		/*上传文件的大小*/
    		String filesize = "0";
			/*临时文件的保存路径*/
			AladdinController al = new AladdinController();
			String tempFilePath = al.uploadFile_Temp;
			File tempFile = new File(tempFilePath);
			
			/*
			 * 使用Apache文件上传组件处理文件上传
			 * 1.创建一个DiskFileItemFactory工厂
			 * 2.设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中
			 * 3.设置上传时生成的临时文件的保存目录
			 * 4.创建文件上传解析器
			 * 5.解决上传文件名的中文乱码
			 * 6.使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合
			 * 7.设置文件上传的大小
			 * */
			/*-------1.创建一个DiskFileItemFactory工厂-------*/
			DiskFileItemFactory factory = new DiskFileItemFactory();
			/*-------2.设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中厂（缓冲区100KB）-------*/
			factory.setSizeThreshold(1024*100);
			/*-------3.设置上传时生成的临时文件的保存目录-------*/
			factory.setRepository(tempFile);
			/*-------4.创建文件上传解析器-------*/
			ServletFileUpload upload = new ServletFileUpload(factory);
			/*-------5.解决上传文件名的中文乱码-------*/
			upload.setHeaderEncoding("UTF-8");
			/*-------6.使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合-------*/
			List<FileItem> list = upload.parseRequest(request);
			for(FileItem item : list){
				if(item.isFormField()){
					if("filetype".equals(item.getFieldName())){
						filetype = item.getString().toUpperCase();
					}else if("filesize".equals(item.getFieldName())){
						/*-------7.设置文件上传的大小-------*/
						filesize = item.getString();
					}
				}else{
					/*获取上传文件的后缀*/
					String houzhui = item.getName().substring(item.getName().lastIndexOf(".")+1).toUpperCase();
					/*获取item中的上传文件的输入流*/
					InputStream in = item.getInputStream();
					if(!filetype.contains(".*")){
						if(filetype.indexOf(houzhui) < 0){
							/*关闭输入流*/
							in.close();
							/*删除缓存文件*/
							item.delete();
							
							Message message = new Message("false","文件后缀不匹配！请选择正确的文件类型！");
							message.setFlag(-1);
							view.addObject(JsonView.JSON_ROOT, message);
							return view;
						}
					}
					
					if(!filesize.contains(".*")){
						double filetruesize = ArithUtil.div(ArithUtil.div(item.getSize(), 1024, 2), 1024, 2);
						System.out.println("-------上传文件的大小：" + filetruesize + "M");
						if(filetruesize > Double.parseDouble(filesize)){
							/*关闭输入流*/
							in.close();
							/*删除缓存文件*/
							item.delete();
							
							Message message = new Message("false","上传的文件过大！");
							message.setFlag(-1);
							view.addObject(JsonView.JSON_ROOT, message);
							return view;
						}
					}
					
					
					
					/*
					 * 获取上传文件的名称
					 * 注意：不同浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，有些是不带路径的，所以要对文件名进行处理
					 * */
					String filename = item.getName();
					
					filename = filename.substring(filename.lastIndexOf("\\")+1);
					
					String filenamenohouzhui = filename.substring(0, filename.lastIndexOf("."));
					String nameTime = TimeFormate.getISOTimeToNow2() + item.getName().substring(item.getName().lastIndexOf(".")).toUpperCase();
					/*获取上传后的文件全名*/
					String fileallname = filenamenohouzhui + "_" + nameTime;
					/*获取上传后的保存文件路径*/
					System.out.println("-------上传的文件名:" + fileallname);
					String filePath = getFilePathByFileName(fileallname);
					/*创建文件输出流*/
					FileOutputStream out = new FileOutputStream(filePath);
					/*创建缓冲区*/
					byte buffer[] = new byte[1024];
					/*判断是入流中的数据是否已经读完的标识*/
					int len = 0;
					/*循环将输入流读到缓冲区当中*/
					while((len = in.read(buffer)) > 0){
						out.write(buffer, 0 ,len);
					}
					/*关闭输入流*/
					in.close();
					/*关闭输出流*/
					out.close();
					/*删除缓存文件*/
					item.delete();
					
					Message message = new Message(filename,fileallname);
					message.setFlag(1);
					view.addObject(JsonView.JSON_ROOT, message);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			Message message = new Message("false","文件上传失败！");
			message.setFlag(-1);
			view.addObject(JsonView.JSON_ROOT, message);
		}
    	return view;
    }
    
    /**
     * 下载文件
     * @author xuxj
     * @param response
     * @param request
     */
    @RequestMapping("/download.do")
    public void downloadbig(HttpServletResponse response, HttpServletRequest request) {
    	try {
    		/*需要下载的文件名*/
    		String fileName = request.getParameter("downFile");
    		/*获取要下载的文件路径*/
            String filePath = getFilePathByFileName(fileName);
            /*获取需要下载的文件对象*/
            File file = new File(filePath);
            
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("GB2312"), "ISO-8859-1"));
            response.addHeader("Content-Length", "" + file.length());
            
            FileInputStream in = new FileInputStream(file);
            
            PrintWriter out = response.getWriter();
            
            byte b[] = new byte[1024];
            
            while(in.read(b,0,1024) != -1){
            	out.write(new String(b,"ISO-8859-1"));
            }
            out.flush();
            out.close();
    	} catch (Exception e) {
			//e.printStackTrace();
		}
    }
    
    /**
     * 删除上传的文件
     * @author xuxj
     * @param filesname（文件名的全称，支持多个文件，用,隔开）
     */
    @RequestMapping("/deleteFile.do")
	public void deleteFile(String filesname){
		//System.out.println("-------开始删除上传的文件-------");
		//System.out.println("需删除的文件全称："+filesname);
		if(filesname != null){
			String[] name = filesname.split(",");
			for(int i=0;i<name.length;i++){
				//System.out.println("要删除的文件名：" + name[i]);
				try {
					String filepath = getFilePathByFileName(name[i]);
		            System.out.println("-------要删除的文件路径：" + filepath + "-------");
		            File f = new File(filepath);//定义文件路径
		            org.apache.tools.ant.util.FileUtils.delete(f);//删除文件
				} catch (Exception e) {}
			}
		}
	}
}
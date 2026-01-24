package com.aladdin.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import service.web.kaituo.org.LogService;
import service.web.kaituo.org.LogServicePortType;

import com.aladdin.model.InterfaceServiceLog;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;

public class CreateLogXML {
	
	//平台ID号
	static String Reg_ID = "JY320281100721";
	static String logXmlPath = "C:\\JYGAWebCityCrisis_Log\\UserActionLog.xml";
	static String logInterfacepath = "C:\\JYGAWebCityCrisis_Log\\InterfaceServiceLog.xml";
	static String savePath = "C:\\JYGAWebCityCrisis_Log\\save";
	static final Lock lock = new ReentrantLock();
	
	/**
	 * 生成用户操作日志
	 * @param userActionLog
	 */
	public static void UserActionLog(UserActionLog userActionLog){
		if(!"".equals(userActionLog.getOperate_Condition())){
			userActionLog.setOperate_Condition(userActionLog.getOperate_Condition().replace(">=", "大于等于"));
			userActionLog.setOperate_Condition(userActionLog.getOperate_Condition().replace("<=", "小于等于"));
		}
		File file = new File(logXmlPath);
		Document document = null;
		Element Aspt = null;
		Element Logs = null;
		//文件目录是否存在
		File dirFile = file.getParentFile();
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//判断文件是否存在
		if(file.exists()){
			double fileSize = file.length();
			fileSize = fileSize/(1024*1024);
			if(fileSize>1){
				System.out.println("----------用户操作日志已满-------------");
				//上传文件
				sendSaveUserActionLogs();
				
			}
		}
		/**
		 * 存在就读取根节点Aspt->Logs节点
		 */
		lock.lock();
		if(file.exists()){
			document = DocumentHelper.createDocument();
			Aspt = document.addElement("Aspt");
			WriterELE(Aspt, "Version", "1.0");
			WriterELE(Aspt, "RegID", userActionLog.getReg_ID());
			Logs = Aspt.addElement("Logs");
			try {
				SAXReader reader = new SAXReader();
				document = reader.read(logXmlPath);
				Aspt = document.getRootElement();
				Logs = Aspt.element("Logs");
			} catch (DocumentException e) {
				e.printStackTrace();
				System.out.println("----文件读取失败,文件格式出现错误----");
				String sendID = "fail"+getSendID("1");
				File startfile = new File(logXmlPath);
				File newlocation = new File(savePath);
				if(!newlocation.exists()){
					newlocation.mkdirs();
				}
				File endFile = new File(newlocation + File.separator + sendID + ".xml");
				startfile.renameTo(endFile);
				if(!dirFile.exists()){
					dirFile.mkdirs();
				}
				document = DocumentHelper.createDocument();
				Aspt = document.addElement("Aspt");
				WriterELE(Aspt, "Version", "1.0");
				WriterELE(Aspt, "RegID", userActionLog.getReg_ID());
				Logs = Aspt.addElement("Logs");
				OutputFormat format = OutputFormat.createPrettyPrint();
				//日志数据字符集要求统一采用GBK
				format.setEncoding("GBK");
				//生成文件
				XMLWriter writer;
				try {
					writer = new XMLWriter(new FileOutputStream(file),format);
					writer.setEscapeText(false);
					writer.write(document);
					writer.close();
				} catch (UnsupportedEncodingException e1) {
					e1.printStackTrace();
				} catch (FileNotFoundException e1) {
					e1.printStackTrace();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		/**
		 * 不存在就Dom4j新建xml
		 */
		else{
			document = DocumentHelper.createDocument();
			Aspt = document.addElement("Aspt");
			WriterELE(Aspt, "Version", "1.0");
			WriterELE(Aspt, "RegID", userActionLog.getReg_ID());
			Logs = Aspt.addElement("Logs");
		}
		
		//在Logs节点上添加数据
		Element log = Logs.addElement("Log");
		WriterELE(log, "Num_ID",userActionLog.getNum_ID()+"");
		WriterELE(log, "User_ID", userActionLog.getUser_ID());
		WriterELE(log, "Organization", userActionLog.getOrganization());
		WriterELE(log, "Organization_ID", userActionLog.getOrganization_ID());
		WriterELE(log, "user_Name", userActionLog.getUser_Name());
		WriterELE(log, "Terminal_ID", userActionLog.getTerminal_ID());
		WriterELE(log, "operate_Time", userActionLog.getOperate_Time());
		WriterELE(log, "Operate_Type", userActionLog.getOperate_Type()+"");
		WriterELE(log, "Operate_Result", userActionLog.getOperate_Result());
		WriterELE(log, "Error_Code", userActionLog.getError_Code());
		WriterELE(log, "Operate_Name", userActionLog.getOperate_Name());
		WriterELE(log, "Operate_Condition", userActionLog.getOperate_Condition());
		
		OutputFormat format = OutputFormat.createPrettyPrint();
		//日志数据字符集要求统一采用GBK
		format.setEncoding("GBK");
		//生成文件
		XMLWriter writer;
		try {
			writer = new XMLWriter(new FileOutputStream(file),format);
			writer.setEscapeText(false);
			writer.write(document);
			writer.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		lock.unlock();
	}
	
	/**
	 * 生成接口服务日志
	 * @param interfaceServiceLog
	 */
	public static void InterfaceServiceLog(InterfaceServiceLog interfaceServiceLog){
		
		File file = new File(logInterfacepath);
		Document document = null;
		Element Aspt = null;
		Element Logs = null;
		
		//判断文件是否存在
		/**
		 * 存在就读取根节点Aspt->Logs节点
		 */
		if(file.exists()){
			try {
				SAXReader reader = new SAXReader();
				document = reader.read(logInterfacepath);
				Aspt = document.getRootElement();
				Logs = Aspt.element("Logs");
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
		/**
		 * 不存在就Dom4j新建xml
		 */
		else{
			document = DocumentHelper.createDocument();
			Aspt = document.addElement("Aspt");
			WriterELE(Aspt, "Version", "1.0");
			WriterELE(Aspt, "RegID", interfaceServiceLog.getReg_ID());
			Logs = Aspt.addElement("Logs");
		}
		
		//在Logs节点上添加数据
		Element log = Logs.addElement("Log");
		WriterELE(log, "Num_ID",interfaceServiceLog.getNum_ID()+"");
		WriterELE(log, "Interface_Name", interfaceServiceLog.getInterface_Name());
		WriterELE(log, "Requester", interfaceServiceLog.getRequester());
		WriterELE(log, "User_ID", interfaceServiceLog.getUser_ID());
		WriterELE(log, "Organization", interfaceServiceLog.getOrganization());
		WriterELE(log, "Organization_ID", interfaceServiceLog.getOrganization_ID());
		WriterELE(log, "User_Name", interfaceServiceLog.getUser_Name());
		WriterELE(log, "Interface_Time", interfaceServiceLog.getInterface_Time());
		WriterELE(log, "Interface_Result", interfaceServiceLog.getInterface_Result());
		WriterELE(log, "Terminal_ID", interfaceServiceLog.getTerminal_ID());
		WriterELE(log, "Error_Code", interfaceServiceLog.getError_Code());
		WriterELE(log, "Interface_Condition", interfaceServiceLog.getInterface_Condition());
		
		OutputFormat format = OutputFormat.createPrettyPrint();
		//日志数据字符集要求统一采用GBK
		format.setEncoding("GBK");
		//生成文件
		XMLWriter writer;
		try {
			writer = new XMLWriter(new FileOutputStream(file),format);
			writer.setEscapeText(false);
			writer.write(document);
			writer.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 新增节点并赋属性值
	 */
	private static void WriterELE(Element element1, String element2Name, String text) {
		Element newElement = element1.addElement(element2Name);
		if(null != text && text.length()>0){
			newElement.setText(text);
		}
	}
	
	/**
	 * 生成唯一Num_ID
	 * 截取 年月日时分十位 以及 System.nanotime()中最高位十秒位级单位数字八位
	 * 注:long的最大值是2开头的十九位数
	 * @return NumIDString
	 */
	private static String getNumID(String TimeNow){
		String dateTime = TimeNow.substring(2, 12);
		String nanoTime = String.valueOf(System.nanoTime());
		String NumIDString = dateTime + nanoTime.substring(nanoTime.length()-11, nanoTime.length()-3);
		return NumIDString;
	}
	
	/**
	 * 上传不可删除的用户操作日志
	 */
	public static void sendSaveUserActionLogs(){
		String logType = "1";
		String sendID = getSendID(logType);
		String logs = getXML(logXmlPath);
		
		if(null!=logs && logs.length()>0){
			LogService ls = new LogService();
			LogServicePortType lspt = ls.getLogServiceHttpSoap12Endpoint();
			String acceptString;
			acceptString = lspt.acceptLogs(Reg_ID, sendID, logType, logs);
			
			if(null!=acceptString && acceptString.length()>0 && acceptString.substring(0, 3).equals("000")){
				System.out.println("***上传用户操作日志成功,批次号:" + sendID);
				File startfile = new File(logXmlPath);
				File newlocation = new File(savePath);
				if(!newlocation.exists()){
					newlocation.mkdirs();
				}
				File endFile = new File(newlocation + File.separator + sendID + ".xml");
				startfile.renameTo(endFile);
				System.out.println("-----日志迁移成功-----");
			}
			else {
				System.out.println("***上传用户操作日志失败,返回码:"+ acceptString);
				//新建文档
				sendID = "fail"+getSendID("1");
				File startfile = new File(logXmlPath);
				File newlocation = new File(savePath);
				if(!newlocation.exists()){
					newlocation.mkdirs();
				}
				File endFile = new File(newlocation + File.separator + sendID + ".xml");
				startfile.renameTo(endFile);
				System.out.println("-----生成失败日志-----");
			}
		}
	}
	
	/**
	 * 读取xml文件并生成内容String
	 * @param path
	 * @return
	 */
	private static String getXML(String path) {
		File fileTest = new File(path);
		if(!fileTest.exists()){
			return null;
		}
		String xml = "";
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			org.w3c.dom.Document doc = builder.parse(path);
			
			Source oldData = new DOMSource(doc);
			StreamResult newData = new StreamResult(new StringWriter());
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
			transformer.transform(oldData, newData);
			
			xml = newData.getWriter().toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xml;
	}
	
	/**
	 * 生成SendID批次号
	 * @return
	 */
	private static String getSendID(String logType) {
		String IsoTimeToNow = TimeFormate.getISOTimeToNow2();
		return "JY"+ logType + IsoTimeToNow;
	}
	
	/**
	 * UserActionLog赋值
	 * Num_ID,Reg_ID,User_ID,Organization,User_Name,Operate_Time,Terminal_ID
	 * @param userSession
	 * @return UserActionLog
	 */
	public static UserActionLog AssignUserLog(UserSession userSession){
		String TimeNow = TimeFormate.getISOTimeToNow2();
		String NumIDString = getNumID(TimeNow);
		Long Num_ID = Long.parseLong(NumIDString);
		
		UserActionLog log = new UserActionLog();
		log.setNum_ID(Num_ID);
		log.setReg_ID(Reg_ID);
		log.setUser_ID(userSession.getLoginPoliceCode());
		log.setOrganization(userSession.getLoginUserDepartname());
		log.setOrganization_ID(userSession.getLoginDepartcode());
		log.setUser_Name(userSession.getLoginUserName());
		log.setOperate_Time(TimeNow);
		
		return log;
	}
}

package com.szrj.business.web.company;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.FileDao;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.company.YzdLicenceDao;
import com.szrj.business.model.File;
import com.szrj.business.model.company.YzdLicence;

/**
 * @author 李昊
 * Sep 8, 2021
 */

@Controller
@SessionAttributes("userSession")
public class YzdLicenceController {

	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Picture;
	@Autowired
	private YzdLicenceDao licenceDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private FileDao fileDao;
	
	@RequestMapping("/searchLicence.do")
	@ResponseBody
	public Map<String, Object> searchLicence(YzdLicence licence, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchLicence.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = licenceDao.searchLicence(licence, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询许可证信息");
			String operate_Condition = "";
			if(licence.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + licence.getCompanyid() + "'";
			}
			if(licence.getAllowdate() != null && !"".equals(licence.getAllowdate())){
				if("".equals(operate_Condition)){
					operate_Condition += "发证日期 = '" + licence.getAllowdate() + "'";
				}else{
					operate_Condition += " and 发证日期 = '" + licence.getAllowdate() + "'";
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
			log.setOperate_Name("查询许可证信息");
			String operate_Condition = "";
			if(licence.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + licence.getCompanyid() + "'";
			}
			if(licence.getAllowdate() != null && !"".equals(licence.getAllowdate())){
				if("".equals(operate_Condition)){
					operate_Condition += "发证日期 = '" + licence.getAllowdate() + "'";
				}else{
					operate_Condition += " and 发证日期 = '" + licence.getAllowdate() + "'";
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
	@RequestMapping("/getLicenceById.do")
	public String getById(int id, int menuid, String affecttype, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getLicenceById.do ...  menuid="+menuid);
		String url = "";
		List<File> files = new ArrayList<File>();
		String fileName = "";
		
		YzdLicence licence = new YzdLicence();
		try {
			licence = licenceDao.getById(id);
			String attm = licence.getAttachments();
			if(attm!=null && attm.length()>0){
				attm = "(" + attm + ")";
				files = fileDao.getFileMsgByIdstr(attm);
				for(int i=0;i<files.size();i++){
					fileName += files.get(i).getFileallName()+",";
				}
				model.addAttribute("fileName", fileName.substring(0, fileName.length()-1));
			}
			model.addAttribute("files", files);
			model.addAttribute("licence", licence);
			model.addAttribute("id", id);
			model.addAttribute("menuid", menuid);
			model.addAttribute("affecttype", affecttype);
			String PU = uploadFile_Picture.replace("\\", "/");
			if(page.equals("showinfo")){
				model.addAttribute("pictureurl", PU);
				url = "jsp/company/licence_showinfo";
			}else if(page.equals("update")){
				model.addAttribute("pictureurl", PU.substring(PU.indexOf("upload")-1)+"/");
				url = "jsp/company/licence_update";
			}
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询许可证信息");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询许可证信息");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return url;
	}
	
	/**
	 * 新增许可证
	 * @param licence
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addLicence.do")
	public @ResponseBody String addLicence(YzdLicence licence,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addLicence.do ... menuid="+menuid);
		licence.setAddtime(addtime);
		licence.setAddoperator(userSession.getLoginUserName());
		try {
			licenceDao.add(licence);
			message = new Message("true","添加成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "许可证添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addLicence.do ... 许可证添加成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("许可证添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","许可证添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "许可证添加失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("许可证添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除许可证
	 * @param licence
	 * @return
	 */
	@RequestMapping("/cancelLicence.do")
	@ResponseBody
	public String cancelLicence(YzdLicence licence, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelLicence.do ... menuid"+menuid);
		try {
			licenceDao.cancel(licence.getId());
			message = new Message("true","许可证已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "许可证信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("许可证信息删除");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + licence.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","许可证删除失败");
			message.setFlag(-1);
			System.out.println("cancelLicence.do ... 删除失败");
			logDao.recordLog(menuid, "许可证信息删除失败", userSession.getLoginUserName(), updatetime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("许可证信息删除");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + licence.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改许可证信息
	 * @param licence
	 * @return
	 */
	@RequestMapping("/updateLicence.do")
	@ResponseBody
	public String updateLicence(YzdLicence licence, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updateTime = dateFormat.format(new Date());
		licence.setUpdateoperator(userSession.getLoginUserName());
		licence.setUpdatetime(updateTime);
		try {
			licenceDao.update(licence);
			message = new Message("true","许可证信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "许可证信息修改", userSession.getLoginUserName(), updateTime, "修改成功", "");
			System.out.println("updateLicence.do ... 修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("许可证信息修改");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + licence.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","许可证信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "许可证信息修改失败", userSession.getLoginUserName(), updateTime, "修改失败", "");
			System.out.println("updateLicence.do ... 修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("许可证信息修改");
			String operate_Condition = "";
			operate_Condition += "许可证id = '" + licence.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

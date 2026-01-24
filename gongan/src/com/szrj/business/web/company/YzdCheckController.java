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
import com.szrj.business.dao.company.YzdCheckDao;
import com.szrj.business.model.File;
import com.szrj.business.model.company.YzdCheck;

@Controller
@SessionAttributes("userSession")
public class YzdCheckController {

	private
	@Value("#{configProperties.uploadFile_Document}")
	String uploadFile_Document;
	@Autowired
	private YzdCheckDao checkDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private FileDao fileDao;
	
	/**
	 * 分页查询
	 * @param equipment
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchCheck.do")
	@ResponseBody
	public Map<String, Object> searchCheck(YzdCheck check, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = checkDao.searchYzdCheck(check, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询单位检查");
			String operate_Condition = "";
			if(check.getCheckdate() != null && !"".equals(check.getCheckdate())){
				operate_Condition += "核查日期 = '" + check.getCheckdate() + "'";
			}
			if(check.getCompanyid()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位id = '" + check.getCompanyid() + "'";
				}else{
					operate_Condition += " and 风险单位id = '" + check.getCompanyid() + "'";
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
			log.setOperate_Name("查询单位检查");
			String operate_Condition = "";
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
	@RequestMapping("/getCheckById.do")
	public String getById(int id, int menuid, String companyname, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		String url = "";
		
		List<File> files = new ArrayList<File>();
		String fileName = "";
		
		YzdCheck Check = new YzdCheck();
		try {
			Check = checkDao.getById(id);
			String attm = Check.getAttachments();
			if(null!=attm && attm.length()>0){
				attm = "(" + attm + ")";
				files = fileDao.getFileMsgByIdstr(attm);
				for(int i=0; i<files.size(); i++){
					fileName += files.get(i).getFileallName()+",";
				}
				model.addAttribute("fileName", fileName.substring(0, fileName.length()-1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("check", Check);
		model.addAttribute("id", id);
		model.addAttribute("menuid", menuid);
		model.addAttribute("companyname", companyname);
		model.addAttribute("files", files);
		model.addAttribute("pictureurl", uploadFile_Document.replace("\\", "/"));
		if(page.equals("showinfo")){
			url = "/jsp/company/check_showinfo";
		}else if(page.equals("update")){
			url = "/jsp/company/check_update";
		}
		
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询单位检查");
		String operate_Condition = "";
		operate_Condition += "核查id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 添加设备
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addCheck.do")
	public @ResponseBody String addCheck(YzdCheck Check, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addCheck.do ... menuid="+menuid);
		Check.setAddtime(addtime);
		Check.setAddoperator(userSession.getLoginUserName());
		try {
			checkDao.add(Check);
			message = new Message("true","添加成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加检查表信息成功", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addCheck.do ... 添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加检查表信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "添加检查表信息失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addCheck.do ... 添加失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加检查表信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除检查表
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelCheck.do")
	@ResponseBody
	public String cancelCheck(YzdCheck check, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		check.setUpdatetime(updatetime);
		check.setUpdateoperator(userSession.getLoginUserName());
		try {
			checkDao.cancel(check);
			message = new Message("true","检查表已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "检查表信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除检查表信息");
			String operate_Condition = "";
			operate_Condition += "核查id = '" + check.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","检查表删除失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "检查表信息删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除检查表信息");
			String operate_Condition = "";
			operate_Condition += "核查id = '" + check.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改检查表
	 * @param chemistry
	 * @param menuid
	 * @return
	 */
	@RequestMapping("/updateCheck.do")
	@ResponseBody
	public String updateCheck(YzdCheck check, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		check.setUpdateoperator(userSession.getLoginUserName());
		check.setUpdatetime(updatetime);
		try {
			checkDao.update(check);
			message = new Message("true","修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "检查表信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改检查表信息");
			String operate_Condition = "";
			operate_Condition += "核查id = '" + check.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "检查表信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改检查表信息");
			String operate_Condition = "";
			operate_Condition += "核查id = '" + check.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
}

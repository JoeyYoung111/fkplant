package com.szrj.business.web.company;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CardnumberCheck;
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.dao.company.YzdChemistryDao;
import com.szrj.business.model.company.YzdChemistry;

@Controller
@SessionAttributes("userSession")
public class YzdChemistryController {

	@Autowired
	private YzdChemistryDao chemistryDao;
	@Autowired
	private LogDao logDao;
	@Autowired
	private CompanyDao companyDao;
	
	/**
	 * 分页查询
	 * @param chemistry
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchChemistry.do")
	@ResponseBody
	public Map<String, Object> searchChemistry(YzdChemistry chemistry, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = chemistryDao.searchYzdChemistry(chemistry, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询懂化学技术人员");
			String operate_Condition = "";
			if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
				operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
			}
			if(chemistry.getCompanyid()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位id = '" + chemistry.getCompanyid() + "'";
				}else{
					operate_Condition += " and 风险单位id = '" + chemistry.getCompanyid() + "'";
				}
			}
			if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
				}
			}
			if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
				}
			}
			if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
				}
			}
			if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
				}
			}
			if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}
			}
			if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
				if("".equals(operate_Condition)){
					operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
				}else{
					operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
				}
			}
			if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
				if("".equals(operate_Condition)){
					operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
				}else{
					operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
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
			log.setOperate_Name("查询懂化学技术人员");
			String operate_Condition = "";
			if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
				operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
			}
			if(chemistry.getCompanyid()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位id = '" + chemistry.getCompanyid() + "'";
				}else{
					operate_Condition += " and 风险单位id = '" + chemistry.getCompanyid() + "'";
				}
			}
			if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
				}
			}
			if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
				}
			}
			if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
				}
			}
			if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
				}
			}
			if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}
			}
			if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
				if("".equals(operate_Condition)){
					operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
				}else{
					operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
				}
			}
			if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
				if("".equals(operate_Condition)){
					operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
				}else{
					operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	@RequestMapping("/searchChemistry1.do")
	@ResponseBody
	public Map<String, Object> searchChemistry1(YzdChemistry chemistry, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = chemistryDao.searchYzdChemistry1(chemistry, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询懂化学技术人员");
			String operate_Condition = "";
			if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
				operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
			}
			if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
				}
			}
			if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
				}
			}
			if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
				}
			}
			if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
				}
			}
			if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}
			}
			if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
				if("".equals(operate_Condition)){
					operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
				}else{
					operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
				}
			}
			if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
				if("".equals(operate_Condition)){
					operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
				}else{
					operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
				}
			}
			if(chemistry.getCompanyname() != null && !"".equals(chemistry.getCompanyname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
				}else{
					operate_Condition += " and 风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
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
			log.setOperate_Name("查询懂化学技术人员");
			String operate_Condition = "";
			if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
				operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
			}
			if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
				if("".equals(operate_Condition)){
					operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
				}else{
					operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
				}
			}
			if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
				if("".equals(operate_Condition)){
					operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
				}else{
					operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
				}
			}
			if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
				if("".equals(operate_Condition)){
					operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
				}else{
					operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
				}
			}
			if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
				if("".equals(operate_Condition)){
					operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
				}else{
					operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
				}
			}
			if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
				if("".equals(operate_Condition)){
					operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}else{
					operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
				}
			}
			if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
				if("".equals(operate_Condition)){
					operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
				}else{
					operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
				}
			}
			if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
				if("".equals(operate_Condition)){
					operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
				}else{
					operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
				}
			}
			if(chemistry.getCompanyname() != null && !"".equals(chemistry.getCompanyname())){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
				}else{
					operate_Condition += " and 风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
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
	 * @param companyname
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getChemistryById.do")
	public String getById(int id, int menuid, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		String url = "";
		
		YzdChemistry chemistry = new YzdChemistry();
		try {
			chemistry = chemistryDao.getById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("chemistry", chemistry);
		model.addAttribute("id",id);
		model.addAttribute("menuid", menuid);
		if(page.equals("showinfo")){
			url = "/jsp/company/chemistry_showinfo";
		}else if(page.equals("update")){
			url = "/jsp/company/chemistry_update";
		}else if(page.equals("du")){
			url = "/jsp/personel/du/chemistry/chemistry_update";
		}
		
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询懂化学技术人员");
		String operate_Condition = "";
		operate_Condition += "懂化学技术人员ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 添加懂化学技术人员
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addChemistry.do")
	public @ResponseBody String addChemistry(YzdChemistry chemistry, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addChemistry.do ... menuid="+menuid);
		chemistry.setAddtime(addtime);
		chemistry.setAddoperator(userSession.getLoginUserName());
		try {
			int findid=chemistryDao.getByCardnumber(chemistry.getCardnumber());
			if(findid>0){
				message = new Message("false","该身份证号人员已存在，不可重复添加");
				message.setFlag(-1);
				
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("0");	//0：失败 1：成功
				log.setOperate_Name("添加懂化学技术人员信息");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}else{
				chemistryDao.add(chemistry);
				message = new Message("true","添加成功");
				message.setFlag(1);
				logDao.recordLog(menuid, "添加懂化学技术人员信息成功", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addChemistry.do ... 添加成功");
				
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("添加懂化学技术人员信息");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
			}
		} catch (Exception e) {
			message = new Message("true","添加成功");
			message.setFlag(-1);
			logDao.recordLog(menuid, "添加懂化学技术人员信息失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addChemistry.do ... 添加失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加懂化学技术人员信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除懂化学技术人员
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelChemistry.do")
	@ResponseBody
	public String cancelChemistry(YzdChemistry chemistry, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		chemistry.setUpdatetime(updatetime);
		chemistry.setUpdateoperator(userSession.getLoginUserName());
		try {
			chemistryDao.cancel(chemistry);
			message = new Message("true","懂化学技术人员已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "懂化学技术人员信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除懂化学技术人员信息");
			String operate_Condition = "";
			operate_Condition += "懂化学技术人员ID = '" + chemistry.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","懂化学技术人员删除失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "懂化学技术人员信息删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除懂化学技术人员信息");
			String operate_Condition = "";
			operate_Condition += "懂化学技术人员ID = '" + chemistry.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改懂化学技术人员
	 * @param chemistry
	 * @param menuid
	 * @return
	 */
	@RequestMapping("/updateChemistry.do")
	@ResponseBody
	public String updateChemistry(YzdChemistry chemistry, int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		chemistry.setUpdateoperator(userSession.getLoginUserName());
		chemistry.setUpdatetime(updatetime);
		try {
			chemistryDao.update(chemistry);
			message = new Message("true","懂化学技术人员修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "懂化学技术人员信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改懂化学技术人员信息");
			String operate_Condition = "";
			operate_Condition += "懂化学技术人员ID = '" + chemistry.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","懂化学技术人员修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "懂化学技术人员信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改懂化学技术人员信息");
			String operate_Condition = "";
			operate_Condition += "懂化学技术人员ID = '" + chemistry.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	

	@RequestMapping("/importChemistryPersonel.do")
	@ResponseBody
    public   Map<String, Object>  importChemistryPersonel(HttpServletRequest request,HttpServletResponse response,int personneltype,@RequestParam("file")  MultipartFile myFile,@ModelAttribute("userSession")UserSession userSession) throws IOException {
    	Map<String, Object> json = new HashMap<String, Object>();  
    	String msg = "";
    	String btmsg="";
    	String rowmsg="";
    	int pCount=0;
    	System.out.println("importChemistryPersonel.do.......................");
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String addtime=dateFormat.format(new Date());
    	try{
    	  String fileName = myFile.getOriginalFilename();
          String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
          Sheet sheet;
          int totalRows=0;
            Workbook workbook=WorkbookFactory.create(myFile.getInputStream());
            sheet=workbook.getSheetAt(0);
            totalRows=sheet.getPhysicalNumberOfRows();//返回索引
            Row rowdata;
            System.out.println("importChemistryPersonel.do.......................fileName="+fileName+"   totalRows="+totalRows);
            for (int i =1; i < totalRows; i++) {
            	rowdata=sheet.getRow(i);
            	 int rownum=i+1;
            	 rowmsg=" 第2行 至 第"+totalRows+"行<br/>"; 
            	//System.out.println("开始读取.......................读取行号="+rownum+"   身份证号码="+rowdata.getCell(0).getStringCellValue());
            	 if(rowdata.getCell(0)==null||rowdata.getCell(0).getCellType()==rowdata.getCell(0).CELL_TYPE_BLANK){            	  
              	   if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){
              		 if(rowdata.getCell(2)==null||rowdata.getCell(2).getCellType()==rowdata.getCell(2).CELL_TYPE_BLANK){
              		   if(rownum>2)rowmsg=" 第2行 至 第"+i+"行<br/>"; 
              		   else rowmsg="<font color='red'>无数据导入</font><br/>";
              		   break;
              		 }
              	   }
              	   btmsg+="第"+rownum+"行，第一列(身份证号)为必填项；"+"<br/>"; 
                 }else if(rowdata.getCell(1)==null||rowdata.getCell(1).getCellType()==rowdata.getCell(1).CELL_TYPE_BLANK){           	
              	   btmsg+="第"+rownum+"行，第二列(姓名)为必填项；"+"<br/>";
                 }else if(rowdata.getCell(2)==null||rowdata.getCell(2).getCellType()==rowdata.getCell(2).CELL_TYPE_BLANK){           	
                   btmsg+="第"+rownum+"行，第三列(所属企业)为必填项；"+"<br/>"; 
                 }else{  
              	   rowdata.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
              	   rowdata.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
              	   rowdata.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
              	   if(CardnumberCheck.check(rowdata.getCell(0).getStringCellValue())){
              		   int findid=chemistryDao.getByCardnumber(rowdata.getCell(0).getStringCellValue());
              		   Integer companyid = companyDao.getIdByName(rowdata.getCell(2).getStringCellValue());
                  	   if(findid>0){
                  		   btmsg+="第"+rownum+"行，第一列(身份证号)已存在；"+"<br/>";   //暂时未处理身份证已存在数据覆盖问题，需确认数据更新顺序
                  	   }else if(null==companyid){
                  		 btmsg+="第"+rownum+"行，第三列(企业名)系统未录入；"+"<br/>";
                  	   }else {
                  		   /*****风险人员主表添加*****/
                  		   YzdChemistry chemistry=new YzdChemistry();
                  		   chemistry.setCardnumber(rowdata.getCell(0).getStringCellValue().trim());
                  		   chemistry.setPersonname(rowdata.getCell(1).getStringCellValue());
                  		   chemistry.setCompanyid(companyid);
                  		   chemistry.setSexes(CardnumberInfo.getSex(rowdata.getCell(0).getStringCellValue()));
                  		   chemistry.setValidflag(1);
                  		   chemistry.setAddoperator(userSession.getLoginUserName());
                  		   chemistry.setAddtime(addtime);
                  		   if(rowdata.getCell(3)!=null){//文化程度
                  			   rowdata.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setEducation(rowdata.getCell(3).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(4)!=null){//联系电话
                  			   rowdata.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setTelephone(rowdata.getCell(4).getStringCellValue());
                  	       }
                  		   if(rowdata.getCell(5)!=null){//岗位
                  			   rowdata.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                  			  chemistry.setStation(rowdata.getCell(5).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(6)!=null){//民族
                  			   rowdata.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setNation(rowdata.getCell(6).getStringCellValue());
                  			  }
                  		   if(rowdata.getCell(7)!=null){//政治面貌
                  			   rowdata.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                  			  chemistry.setPoliticalposition(rowdata.getCell(7).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(8)!=null){//毕业院校
                  			   rowdata.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                  			  chemistry.setSchool(rowdata.getCell(8).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(9)!=null){//专业
                  			   rowdata.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setMajor(rowdata.getCell(9).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(10)!=null){//微信号
                  			   rowdata.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setWechat(rowdata.getCell(10).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(11)!=null){//QQ
                  			   rowdata.getCell(11).setCellType(Cell.CELL_TYPE_STRING);
                  			  chemistry.setQq(rowdata.getCell(11).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(12)!=null){//户籍地详址
                  			   rowdata.getCell(12).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setHomeplace(rowdata.getCell(12).getStringCellValue());
                  			 }
                  		   if(rowdata.getCell(13)!=null){//现住地详址
                  			   rowdata.getCell(13).setCellType(Cell.CELL_TYPE_STRING);
                  			   chemistry.setLifeplace(rowdata.getCell(13).getStringCellValue());
                  			 }
                  		     chemistryDao.add(chemistry);
                  		     pCount++;
                  	   }
              	   }else {
              		   btmsg+="第"+rownum+"行，第一列(身份证号)格式错误；"+"<br/>"; 
              	   }
                 } 
            }
        	msg+="<table style='border-collapse:collapse;' width='95%'><tr><td width='20%'>导入表格：</td><td width='80%'>"+rowmsg+"</td></tr>";
        	msg+="<tr><td>成功导入：</td><td>风险人员（懂化学技术人员）<font color='red'>"+pCount+"</font> 名</td></tr>";
        	if(btmsg!=""){
        		msg+="<tr><td><font color='red'>失败导入：</font></td><td></td></tr>";
        		msg+="<tr><td></td><td><font color='red'>"+btmsg+"</font></td></tr>";
        	}
        	msg+="</table>";
            json.put("success",msg);
            logDao.recordLog(0, "懂化学技术人员-信息导入", userSession.getLoginUserName(), addtime, "导出成功", "");
    } catch (Exception e) {
        e.printStackTrace();
        logDao.recordLog(0, "懂化学技术人员-信息导入", userSession.getLoginUserName(), addtime, "导出失败", "");
    }   
       return json;  
    }
	
	
	  @RequestMapping("/exportChemistryPersonel.do")
		public void exportChemistryPersonel(HttpServletResponse response,YzdChemistry chemistry,HttpServletRequest request,@ModelAttribute("userSession")UserSession userSession){   	   	
	    	ModelAndView view = new ModelAndView(JsonView.instance);
	    	try {   		
				    List<YzdChemistry> chemistrylist=chemistryDao.searchYzdChemistryList(chemistry);
					/*在temp创建该文件*/				
					TimeFormate tf = new TimeFormate();
					SimpleDateFormat tfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String addTime=tfs.format(new Date());
					String fileName ="懂化学技术人员信息";
			        /*将数据写入file中*/
					/*设置输出类型*/
				    response.setContentType("application/vnd.ms-excel");
					//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
					/*设置输出文件名称*/
					response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(fileName+".xls", "UTF-8"));				
					/*建立新的HSSFWorkbook对象*/
					HSSFWorkbook wb = new HSSFWorkbook();						 
					/*建立新的工作簿*/
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
					sheet.setColumnWidth(0, 8000);//企业名称
					sheet.setColumnWidth(1, 7000);//姓名
					sheet.setColumnWidth(2, 8000);//身份证号
					sheet.setColumnWidth(3, 3500);//性别
					sheet.setColumnWidth(4, 3500);//文化程度
					sheet.setColumnWidth(5, 5500);//联系电话
					sheet.setColumnWidth(6, 5000);//岗位
					sheet.setColumnWidth(7, 4000);//民族
					sheet.setColumnWidth(8, 5000);//政治面貌
					sheet.setColumnWidth(9, 6500);//毕业院校
					sheet.setColumnWidth(10,4000);//	专业	
					sheet.setColumnWidth(11,7000);//微信号
					sheet.setColumnWidth(12,3500);//QQ
					sheet.setColumnWidth(13,8000);//户籍地详址
					sheet.setColumnWidth(14,8000);//	现住地详址
					sheet.setColumnWidth(15,8000);//备注信息
					sheet.setColumnWidth(16,3500);
					sheet.setColumnWidth(17,8000);
					/*数据*/
					HSSFRow row;
					HSSFCell cell;
					HSSFRichTextString value;								
					row = sheet.createRow(0);
					row.setHeightInPoints(40);		
					String titleArray[] = {
							"企业名称","姓名","身份证号","性别","文化程度","联系电话","岗位","民族","政治面貌",
							"毕业院校","专业","微信号","QQ","户籍地详址","现住地详址","备注信息","建档人",
							"建档时间"
							};			
					for(int i=0;i<18;i++){				
						cell = row.createCell(i);
						value = new HSSFRichTextString(titleArray[i]);
						cell.setCellValue(value);
						cell.setCellStyle(style2);
					}
					/*数据行*/
					for(int i=0;i<chemistrylist.size();i++){
						/*创建行*/
						row = sheet.createRow(i+1);
						row.setHeightInPoints(25);
						
						/*获取行数据*/
						YzdChemistry temp = chemistrylist.get(i);
						  int c=i+1;
					      String d=Integer.toString(c);
					      String data[] = {
                                temp.getCompanyname(),temp.getPersonname(),temp.getCardnumber(),temp.getSexes(),temp.getEducation(),temp.getTelephone(),
								temp.getStation(),temp.getNation(),temp.getPoliticalposition(),temp.getSchool(),temp.getMajor(),temp.getWechat(),
								temp.getQq(),temp.getHomeplace(),temp.getLifeplace(),temp.getMemo(),temp.getAddoperator(),temp.getAddtime()
								};				
						for(int j=0;j<18;j++){
							/*创建列*/
							cell = row.createCell(j);
							value = new HSSFRichTextString(data[j]);
							cell.setCellValue(value);
							cell.setCellStyle(border);
						}
					}
			
					wb.write(response.getOutputStream());
					logDao.recordLog(0, "涉毒人员-懂化学技术人员信息导出", userSession.getLoginUserName(), addTime, "导出成功", "");
					
					//生成操作日志
					UserActionLog log = CreateLogXML.AssignUserLog(userSession);
					log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
					log.setOperate_Result("1");	//0：失败 1：成功
					log.setOperate_Name("导出懂化学技术人员");
					String operate_Condition = "";
					if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
						operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
					}
					if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
						if("".equals(operate_Condition)){
							operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
						}else{
							operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
						}
					}
					if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
						if("".equals(operate_Condition)){
							operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
						}else{
							operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
						}
					}
					if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
						if("".equals(operate_Condition)){
							operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
						}else{
							operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
						}
					}
					if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
						if("".equals(operate_Condition)){
							operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
						}else{
							operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
						}
					}
					if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
						if("".equals(operate_Condition)){
							operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
						}else{
							operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
						}
					}
					if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
						if("".equals(operate_Condition)){
							operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
						}else{
							operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
						}
					}
					if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
						if("".equals(operate_Condition)){
							operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
						}else{
							operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
						}
					}
					if(chemistry.getCompanyname() != null && !"".equals(chemistry.getCompanyname())){
						if("".equals(operate_Condition)){
							operate_Condition += "风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
						}else{
							operate_Condition += " and 风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
						}
					}
					log.setOperate_Condition(operate_Condition);
					log.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(log);
				}catch(Exception e) {
					e.printStackTrace();
				
					Message message = new Message("false","数据导出失败！");
					message.setFlag(-1);
					view.addObject(JsonView.JSON_ROOT, message);
					
					//生成操作日志
					UserActionLog log = CreateLogXML.AssignUserLog(userSession);
					log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
					log.setOperate_Result("0");	//0：失败 1：成功
					log.setOperate_Name("导出懂化学技术人员");
					String operate_Condition = "";
					if(chemistry.getPersonname() != null && !"".equals(chemistry.getPersonname())){
						operate_Condition += "姓名 LIKE '" + chemistry.getPersonname() + "'";
					}
					if(chemistry.getSexes() != null && !"".equals(chemistry.getSexes())){
						if("".equals(operate_Condition)){
							operate_Condition += "性别 = '" + chemistry.getSexes() + "'";
						}else{
							operate_Condition += " and 性别 = '" + chemistry.getSexes() + "'";
						}
					}
					if(chemistry.getEducation() != null && !"".equals(chemistry.getEducation())){
						if("".equals(operate_Condition)){
							operate_Condition += "文化程度 = '" + chemistry.getEducation() + "'";
						}else{
							operate_Condition += " and 文化程度 = '" + chemistry.getEducation() + "'";
						}
					}
					if(chemistry.getTelephone() != null && !"".equals(chemistry.getTelephone())){
						if("".equals(operate_Condition)){
							operate_Condition += "联系电话 = '" + chemistry.getTelephone() + "'";
						}else{
							operate_Condition += " and 联系电话 = '" + chemistry.getTelephone() + "'";
						}
					}
					if(chemistry.getCardnumber() != null && !"".equals(chemistry.getCardnumber())){
						if("".equals(operate_Condition)){
							operate_Condition += "身份证号码 = '" + chemistry.getCardnumber() + "'";
						}else{
							operate_Condition += " and 身份证号码 = '" + chemistry.getCardnumber() + "'";
						}
					}
					if(chemistry.getPoliticalposition() != null && !"".equals(chemistry.getPoliticalposition())){
						if("".equals(operate_Condition)){
							operate_Condition += "政治面貌 = '" + chemistry.getPoliticalposition() + "'";
						}else{
							operate_Condition += " and 政治面貌 = '" + chemistry.getPoliticalposition() + "'";
						}
					}
					if(chemistry.getSchool() != null && !"".equals(chemistry.getSchool())){
						if("".equals(operate_Condition)){
							operate_Condition += "毕业院校 = '" + chemistry.getSchool() + "'";
						}else{
							operate_Condition += " and 毕业院校 = '" + chemistry.getSchool() + "'";
						}
					}
					if(chemistry.getStation() != null && !"".equals(chemistry.getStation())){
						if("".equals(operate_Condition)){
							operate_Condition += "岗位 = '" + chemistry.getStation() + "'";
						}else{
							operate_Condition += " and 岗位 = '" + chemistry.getStation() + "'";
						}
					}
					if(chemistry.getCompanyname() != null && !"".equals(chemistry.getCompanyname())){
						if("".equals(operate_Condition)){
							operate_Condition += "风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
						}else{
							operate_Condition += " and 风险单位名称 LIKE '" + chemistry.getCompanyname() + "'";
						}
					}
					log.setOperate_Condition(operate_Condition);
					log.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(log);
				} 
	    
	    }
	
	
	
	
	
	
}

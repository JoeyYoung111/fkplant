package com.szrj.business.web.position;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.position.OrganizationDao;
import com.szrj.business.model.position.Organization;
import com.szrj.business.model.position.OrganizationPerson;
import com.szrj.business.model.position.WorkRecord;

@Controller
@SessionAttributes("userSession")
public class OrganizationController {
	@Autowired
	private OrganizationDao organizationDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchOrganization.do")
	@ResponseBody
	public Map<String,Object> searchOrganization(Organization organization, NewPageModel pm, @ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	//是否需要根据角色过滤
			if(userSession.getLoginRoleMsgFilter()==1){
				switch (userSession.getLoginRoleFieldFilter()) {
				case 1:
					organization.setUnitFilter(userSession.getLoginUserDepartmentid());
					break;
				case 2:
					organization.setPersonFilter(userSession.getLoginUserID());
					break;
				}	
			}
        	pm.setPageNumber(page);
        	NewPageModel pagelist= organizationDao.searchOrganization(organization, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addOrganization.do")
	@ResponseBody
	public String addOrganization(Organization organization,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addOrganization.do.......................");
		try {
			organization.setValidflag(1);
			organization.setAddoperator(userSession.getLoginUserName());
			organization.setAddtime(addtime);
			organizationDao.add(organization);
			message = new Message("true","政保组织添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保组织添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addPosition.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保组织添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保组织添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addPosition.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateOrganization.do")
	public @ResponseBody String updateOrganization(Organization organization,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePosition.do.......................");
		try {
			organization.setUpdateoperator(userSession.getLoginUserName());
			organization.setUpdatetime(updatetime);
			organizationDao.update(organization);
			message = new Message("true","政保组织修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保组织修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePosition.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保组织修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保组织修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePosition.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getOrganizationUpdate.do")
	public String getOrganizationUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getOrganizationUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		Organization organization = organizationDao.getById(id);
		model.addAttribute("organization",organization);
		if (page.equals("update")){
			url="/jsp/position/organization/update";
		}else if(page.equals("showinfo")){
			List<OrganizationPerson> plist=organizationDao.getOrganizationPersonListByOrgid(id);
			model.addAttribute("personnum",plist.size());
			model.addAttribute("plist",plist);
			url="/jsp/position/organization/showinfo";
		}
		return url;
	}
	
	@RequestMapping("/cancelOrganization.do")
	@ResponseBody
	public String cancelOrganization(Organization organization,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelOrganization.do.......................");
		try {
			organization.setUpdateoperator(userSession.getLoginUserName());
			organization.setUpdatetime(addtime);
			organizationDao.cancel(organization);
			message = new Message("true","政保组织删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保组织删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelOrganization.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保组织删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保组织删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelOrganization.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/*************************组织人员*******************************/
	
	@RequestMapping("/searchOrganizationPerson.do")
	@ResponseBody
	public Map<String,Object> searchOrganizationPerson(OrganizationPerson organizationPerson, NewPageModel pm, @ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist= organizationDao.searchOrgPersonnel(organizationPerson, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addOrganizationPerson.do")
	@ResponseBody
	public String addOrganizationPerson(OrganizationPerson organizationPerson,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addOrganizationPerson.do.......................");
		try {
			organizationPerson.setValidflag(1);
			organizationPerson.setAddoperator(userSession.getLoginUserName());
			organizationPerson.setAddtime(addtime);
			organizationDao.addOrganizationPerson(organizationPerson);
			message = new Message("true","组织人员添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "组织人员添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addOrganizationPerson.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","组织人员添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "组织人员添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addOrganizationPerson.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateOrganizationPerson.do")
	public @ResponseBody String updateOrganizationPerson(OrganizationPerson organizationPerson,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionPerson.do.......................");
		try {
			organizationPerson.setUpdateoperator(userSession.getLoginUserName());
			organizationPerson.setUpdatetime(updatetime);
			organizationDao.updateOrganizationPerson(organizationPerson);
			message = new Message("true","政保组织修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保组织修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionPerson.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保组织修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保组织修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionPerson.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getOrganizationPersonUpdate.do")
	public String getOrganizationPersonUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getOrganizationPersonUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		OrganizationPerson organizationPerson = organizationDao.getOrganizationPersonnById(id);
		model.addAttribute("organizationPerson",organizationPerson);
		if (page.equals("update")){
			url="/";
		}else if(page.equals("showinfo")){
			url="/";
		}
		return url;
	}
	
	@RequestMapping("/cancelOrganizationPerson.do")
	@ResponseBody
	public String cancelOrganizationPerson(OrganizationPerson organizationPerson,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelOrganizationPerson.do.......................");
		try {
			organizationPerson.setUpdateoperator(userSession.getLoginUserName());
			organizationPerson.setUpdatetime(addtime);
			organizationDao.cancelOrganizationPerson(organizationPerson);
			message = new Message("true","政保组织删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "政保组织删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelOrganizationPerson.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","政保组织删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "政保组织删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelOrganizationPerson.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/dayinOrganization.do")
	public void dayinOrganization(Organization org,HttpServletRequest request,HttpServletResponse response,@ModelAttribute("userSession")UserSession userSession) throws IOException{
		System.out.println(".....dayinOrganization.do............");
		//模板位置
		String templateFileName = request.getSession().getServletContext().getRealPath("")+"\\jsp\\position\\template\\zzdj.xls";
		TemplateExportParams params = new TemplateExportParams(templateFileName,true);
		Map<String,Object> map = new HashMap<String,Object>();
		
		//获取组织信息
		org = organizationDao.getById(org.getId());
		if(org.getOrgName()!=null && !"".equals(org.getOrgName())){
			//组织名称
			map.put("orgName", org.getOrgName());
			//组织类别
			if(org.getOrgType()!=null && !"".equals(org.getOrgType())){
				map.put("orgType", org.getOrgType());
			}else{
				map.put("orgType", " ");
			}
			//外文名称
			if(org.getOrgForeignName()!=null && !"".equals(org.getOrgForeignName())){
				map.put("orgForeignName", org.getOrgForeignName());
			}else{
				map.put("orgForeignName", " ");
			}
			//是否省内组织
			if(org.getInProvince()!=null && !"".equals(org.getInProvince())){
				map.put("inProvince", org.getInProvince());
			}else{
				map.put("inProvince", " ");
			}
			//是否登记注册
			if(org.getIsRegister()!=null && !"".equals(org.getIsRegister())){
				map.put("isRegister", org.getIsRegister());
			}else{
				map.put("isRegister", " ");
			}
			//成立时间
			if(org.getCreateTime()!=null && !"".equals(org.getCreateTime())){
				map.put("createTime", org.getCreateTime());
			}else{
				map.put("createTime", " ");
			}
			//成立地点
			if(org.getCreateAddress()!=null && !"".equals(org.getCreateAddress())){
				map.put("createAddress", org.getCreateAddress());
			}else{
				map.put("createAddress", " ");
			}
			//详细地址
			if(org.getAddress()!=null && !"".equals(org.getAddress())){
				map.put("adress", org.getAddress());
			}else{
				map.put("address", " ");
			}
			//活跃程度
			if(org.getActiveLevel()!=null && !"".equals(org.getActiveLevel())){
				map.put("activeLevel", org.getActiveLevel());
			}else{
				map.put("activeLevel", " ");
			}
			//活动范围
			if(org.getActiveRange()!=null && !"".equals(org.getActiveRange())){
				map.put("activeRange", org.getActiveRange());
			}else{
				map.put("activeRange", " ");
			}
			//是否与境外存在勾连
			if(org.getIsForeignConnections()!=null && !"".equals(org.getIsForeignConnections())){
				map.put("isForeignConnections", org.getIsForeignConnections());
			}else{
				map.put("isForeignConnections", " ");
			}
			//活动方式
			if(org.getActiveWay()!=null && !"".equals(org.getActiveWay())){
				map.put("activeWay", org.getActiveWay());
			}else{
				map.put("activeWay", " ");
			}
			//活动方式简要描述
			if(org.getActiveWayDetails()!=null && !"".equals(org.getActiveWayDetails())){
				map.put("activeWayDetails", org.getActiveWayDetails());
			}else{
				map.put("activeWayDetails", " ");
			}
			//组织概况
			if(org.getOrgGeneral()!=null && !"".equals(org.getOrgGeneral())){
				map.put("orgGeneral", org.getOrgGeneral());
			}else{
				map.put("orgGeneral", " ");
			}
			//政治主张
			if(org.getProposition()!=null && !"".equals(org.getProposition())){
				map.put("proposition", org.getProposition());
			}else{
				map.put("proposition", " ");
			}
			//财务状况
			if(org.getFinance()!=null && !"".equals(org.getFinance())){
				map.put("finance", org.getFinance());
			}else{
				map.put("finance", " ");
			}
			//接受注资情况
			if(org.getSubsidize()!=null && !"".equals(org.getSubsidize())){
				map.put("subsidize", org.getSubsidize());
			}else{
				map.put("subsidize", " ");
			}
			//管控时间
			if(org.getControlTime()!=null && !"".equals(org.getControlTime())){
				map.put("controlTime", org.getControlTime());
			}else{
				map.put("controlTime", " ");
			}
			//管控单位
			if(org.getUnitname()!=null && !"".equals(org.getUnitname())){
				map.put("unitname", org.getUnitname());
			}else{
				map.put("unitname", " ");
			}
			//管控民警
			if(org.getPolicename()!=null && !"".equals(org.getPolicename())){
				map.put("policename", org.getPolicename());
			}else{
				map.put("policename", " ");
			}
			//联系电话
			if(org.getControlPhone()!=null && !"".equals(org.getControlPhone())){
				map.put("controlPhone", org.getControlPhone());
			}else{
				map.put("controlPhone", " ");
			}
			
			List<OrganizationPerson> personlist=organizationDao.getOrganizationPersonListByOrgid(org.getId());
			List<Map<String, String>> organizationPersonList = new ArrayList<Map<String, String>>();
			if (personlist!=null&&personlist.size()>0) {
				for (int i = 0; i < personlist.size(); i++) {
					if(i>=6){
						break;
					}
					Map<String, String> lm = new HashMap<String, String>();
					lm.put("identity", personlist.get(i).getIdentity());
					lm.put("personName", personlist.get(i).getPersonName());
					lm.put("cardnumber", personlist.get(i).getCardnumber());
					lm.put("homeplace", personlist.get(i).getHomeplace());
					lm.put("telnumber", personlist.get(i).getTelnumber());
					organizationPersonList.add(lm);
				}
			}
			map.put("organizationPersonList", organizationPersonList);
			
			Workbook workbook = ExcelExportUtil.exportExcel(params, map);
			/*设置输出类型*/
			response.setContentType("application/vnd.ms-excel");
			response.setCharacterEncoding("utf-8");
			/*设置输出文件名称*/
			String title = "政保组织_"+org.getOrgName()+"_"+TimeFormate.getISOTimeToNow2();
			response.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(title+".xls", "UTF-8"));
			OutputStream outputStream=response.getOutputStream();
			workbook.write(outputStream);
			
		}
		
		
		
	}
	
	/*************************民警工作记载*******************************/
	
	@RequestMapping("/searchWorkRecord.do")
	@ResponseBody
	public Map<String,Object> searchWorkRecord(WorkRecord workRecord, NewPageModel pm, @ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        try {
        	pm.setPageNumber(page);
        	NewPageModel pagelist= organizationDao.searchWorkRecord(workRecord, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/addWorkRecord.do")
	@ResponseBody
	public String addWorkRecord(WorkRecord workRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addWorkRecord.do.......................");
		try {
			workRecord.setValidflag(1);
			workRecord.setAddoperator(userSession.getLoginUserName());
			workRecord.setAddtime(addtime);
			organizationDao.addWorkRecord(workRecord);
			message = new Message("true","民警工作记载添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "民警工作记载添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addWorkRecord.do.......................添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","民警工作记载添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "民警工作记载添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addWorkRecord.do.......................添加失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/updateWorkRecord.do")
	public @ResponseBody String updateWorkRecord(WorkRecord workRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("updatePositionPerson.do.......................");
		try {
			workRecord.setUpdateoperator(userSession.getLoginUserName());
			workRecord.setUpdatetime(updatetime);
			organizationDao.updateWorkRecord(workRecord);
			message = new Message("true","民警工作记载修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "民警工作记载修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updatePositionPerson.do.......................修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","民警工作记载修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "民警工作记载修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updatePositionPerson.do.......................修改失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
	@RequestMapping("/getWorkRecordUpdate.do")
	public String getWorkRecordUpdate(int id,int menuid,ModelMap model,String page,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getWorkRecordUpdate.do.................");
		String url="";
		model.addAttribute("menuid",menuid);
		WorkRecord workRecord = organizationDao.getWorkRecordById(id);
		model.addAttribute("workRecord",workRecord);
		if (page.equals("update")){
			url="/jsp/position/record/update";
		}else if(page.equals("showinfo")){
			url="/jsp/position/record/showinfo";
		}
		return url;
	}
	
	@RequestMapping("/cancelWorkRecord.do")
	@ResponseBody
	public String cancelWorkRecord(WorkRecord workRecord,int menuid,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelWorkRecord.do.......................");
		try {
			workRecord.setUpdateoperator(userSession.getLoginUserName());
			workRecord.setUpdatetime(addtime);
			organizationDao.cancelWorkRecord(workRecord);
			message = new Message("true","民警工作记载删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "民警工作记载删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelWorkRecord.do.......................删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","民警工作记载删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "民警工作记载删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelWorkRecord.do.......................删除失败");
		}
		return JSONObject.fromObject(message).toString();
	}
	
}

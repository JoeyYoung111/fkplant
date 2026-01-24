package com.szrj.business.web.company;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.company.YzdEquipmentDao;
import com.szrj.business.model.company.YzdEquipment;

@Controller
@SessionAttributes("userSession")
public class YzdEquipmentController {

	@Autowired
	private YzdEquipmentDao equipmentDao;
	@Autowired
	private LogDao logDao;
	
	/**
	 * 分页查询
	 * @param equipment
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchEquipment.do")
	@ResponseBody
	public Map<String, Object> searchEquipment(YzdEquipment equipment, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = equipmentDao.searchYzdEquipment(equipment, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询设备信息");
			String operate_Condition = "";
			if(equipment.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + equipment.getCompanyid() + "'";
			}
			if(equipment.getEquipmentname()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "设备名称id = '" + equipment.getEquipmentname() + "'";
				}else{
					operate_Condition += " and 设备名称id = '" + equipment.getEquipmentname() + "'";
				}
			}
			if(equipment.getMakecompany() != null && !"".equals(equipment.getMakecompany())){
				if("".equals(operate_Condition)){
					operate_Condition += "制造厂商 LIKE '" + equipment.getMakecompany() + "'";
				}else{
					operate_Condition += " and 制造厂商 LIKE '" + equipment.getMakecompany() + "'";
				}
			}
			if(equipment.getEquipmentbrand() != null && !"".equals(equipment.getEquipmentbrand())){
				if("".equals(operate_Condition)){
					operate_Condition += "品牌 LIKE '" + equipment.getEquipmentbrand() + "'";
				}else{
					operate_Condition += " and 品牌 LIKE '" + equipment.getEquipmentbrand() + "'";
				}
			}
			if(equipment.getBuydate() != null && !"".equals(equipment.getBuydate())){
				if("".equals(operate_Condition)){
					operate_Condition += "购买日期 = '" + equipment.getBuydate() + "'";
				}else{
					operate_Condition += " and 购买日期 = '" + equipment.getBuydate() + "'";
				}
			}
			if(equipment.getUsestatus() != null && !"".equals(equipment.getUsestatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "使用情况 = '" + equipment.getUsestatus() + "'";
				}else{
					operate_Condition += " and 使用情况 = '" + equipment.getUsestatus() + "'";
				}
			}
			if(equipment.getUsestate() != null && !"".equals(equipment.getUsestate())){
				if("".equals(operate_Condition)){
					operate_Condition += "使用状态 = '" + equipment.getUsestate() + "'";
				}else{
					operate_Condition += " and 使用状态 = '" + equipment.getUsestate() + "'";
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
			log.setOperate_Name("查询设备信息");
			String operate_Condition = "";
			if(equipment.getCompanyid()!= 0){
				operate_Condition += "风险单位id = '" + equipment.getCompanyid() + "'";
			}
			if(equipment.getEquipmentname()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "设备名称id = '" + equipment.getEquipmentname() + "'";
				}else{
					operate_Condition += " and 设备名称id = '" + equipment.getEquipmentname() + "'";
				}
			}
			if(equipment.getMakecompany() != null && !"".equals(equipment.getMakecompany())){
				if("".equals(operate_Condition)){
					operate_Condition += "制造厂商 LIKE '" + equipment.getMakecompany() + "'";
				}else{
					operate_Condition += " and 制造厂商 LIKE '" + equipment.getMakecompany() + "'";
				}
			}
			if(equipment.getEquipmentbrand() != null && !"".equals(equipment.getEquipmentbrand())){
				if("".equals(operate_Condition)){
					operate_Condition += "品牌 LIKE '" + equipment.getEquipmentbrand() + "'";
				}else{
					operate_Condition += " and 品牌 LIKE '" + equipment.getEquipmentbrand() + "'";
				}
			}
			if(equipment.getBuydate() != null && !"".equals(equipment.getBuydate())){
				if("".equals(operate_Condition)){
					operate_Condition += "购买日期 = '" + equipment.getBuydate() + "'";
				}else{
					operate_Condition += " and 购买日期 = '" + equipment.getBuydate() + "'";
				}
			}
			if(equipment.getUsestatus() != null && !"".equals(equipment.getUsestatus())){
				if("".equals(operate_Condition)){
					operate_Condition += "使用情况 = '" + equipment.getUsestatus() + "'";
				}else{
					operate_Condition += " and 使用情况 = '" + equipment.getUsestatus() + "'";
				}
			}
			if(equipment.getUsestate() != null && !"".equals(equipment.getUsestate())){
				if("".equals(operate_Condition)){
					operate_Condition += "使用状态 = '" + equipment.getUsestate() + "'";
				}else{
					operate_Condition += " and 使用状态 = '" + equipment.getUsestate() + "'";
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
	@RequestMapping("/getEquipmentById.do")
	public String getById(int id, int menuid, String companyname, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		String url = "";
		
		YzdEquipment equipment = new YzdEquipment();
		try {
			equipment = equipmentDao.getById(id);
			model.addAttribute("equipment", equipment);
			model.addAttribute("id", id);
			model.addAttribute("menuid", menuid);
			model.addAttribute("companyname", companyname);
			if(page.equals("showinfo")){
				url = "/jsp/company/equipment_showinfo";
			}else if(page.equals("update")){
				url = "/jsp/company/equipment_update";
			}
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("根据ID查询设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + id + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return url;
	}
	
	/**
	 * 添加设备
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addEquipment.do")
	public @ResponseBody String addEquipment(YzdEquipment equipment, int menuid,ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addEquipment.do ... menuid="+menuid);
		equipment.setAddtime(addtime);
		equipment.setAddoperator(userSession.getLoginUserName());
		try {
			equipmentDao.add(equipment);
			message = new Message("true","添加成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加设备信息成功", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addEquipment.do ... 添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加设备信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "添加设备信息失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addEquipment.do ... 添加失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加设备信息");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除设备
	 * @param chemistry
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelEquipment.do")
	@ResponseBody
	public String cancelEquipment(YzdEquipment equipment, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		equipment.setUpdatetime(updatetime);
		equipment.setUpdateoperator(userSession.getLoginUserName());
		try {
			equipmentDao.cancel(equipment);
			message = new Message("true","设备已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "设备信息删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("删除设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + equipment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","设备删除失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "设备信息删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("删除设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + equipment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改设备
	 * @param chemistry
	 * @param menuid
	 * @return
	 */
	@RequestMapping("/updateEquipment.do")
	@ResponseBody
	public String updateEquipment(YzdEquipment equipment, int menuid, ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		equipment.setUpdateoperator(userSession.getLoginUserName());
		equipment.setUpdatetime(updatetime);
		try {
			equipmentDao.update(equipment);
			message = new Message("true","设备修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "设备信息修改", userSession.getLoginUserName(), updatetime, "修改成功", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + equipment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","设备修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "设备信息修改", userSession.getLoginUserName(), updatetime, "修改失败", "");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改设备信息");
			String operate_Condition = "";
			operate_Condition += "设备id = '" + equipment.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

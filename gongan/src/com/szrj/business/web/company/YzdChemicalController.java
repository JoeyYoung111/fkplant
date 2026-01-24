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
import com.szrj.business.dao.company.YzdChemicalDao;
import com.szrj.business.model.company.YzdChemical;

/**
 * @author 李昊
 * Sep 6, 2021
 */
@Controller
@SessionAttributes("userSession")
public class YzdChemicalController {

	@Autowired
	private YzdChemicalDao chemicalDao;
	@Autowired
	private LogDao logDao;
	
	/**
	 * 分页查询
	 * @param chemical
	 * @param pm
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchChemical.do")
	@ResponseBody
	public Map<String, Object> searchChemical(YzdChemical chemical, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("searchChemical.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = chemicalDao.searchYzdChemical(chemical, pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询化学品种类");
			String operate_Condition = "";
			if(chemical.getChemicalname() != null && !"".equals(chemical.getChemicalname())){
				operate_Condition += "化学品名称 LIKE '" + chemical.getChemicalname() + "'";
			}
			if(chemical.getCompanyid()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位id = '" + chemical.getCompanyid() + "'";
				}else{
					operate_Condition += " and 风险单位id = '" + chemical.getCompanyid() + "'";
				}
			}
			if(chemical.getBelongtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "化学品所属类别 = '" + chemical.getBelongtype() + "'";
				}else{
					operate_Condition += " and 化学品所属类别 = '" + chemical.getBelongtype() + "'";
				}
			}
			if(chemical.getPurpose() != null && !"".equals(chemical.getPurpose())){
				if("".equals(operate_Condition)){
					operate_Condition += "用途 = '" + chemical.getPurpose() + "'";
				}else{
					operate_Condition += " and 用途 = '" + chemical.getPurpose() + "'";
				}
			}
			if(chemical.getChemicaltype() != null && !"".equals(chemical.getChemicaltype())){
				if("".equals(operate_Condition)){
					operate_Condition += "化学品类别 = '" + chemical.getChemicaltype() + "'";
				}else{
					operate_Condition += " and 化学品类别 = '" + chemical.getChemicaltype() + "'";
				}
			}
			if(chemical.getPackingtype() != null && !"".equals(chemical.getPackingtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "包装 = '" + chemical.getPackingtype() + "'";
				}else{
					operate_Condition += " and 包装 = '" + chemical.getPackingtype() + "'";
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
			log.setOperate_Name("查询化学品种类");
			String operate_Condition = "";
			if(chemical.getChemicalname() != null && !"".equals(chemical.getChemicalname())){
				operate_Condition += "化学品名称 LIKE '" + chemical.getChemicalname() + "'";
			}
			if(chemical.getCompanyid()!=0){
				if("".equals(operate_Condition)){
					operate_Condition += "风险单位id = '" + chemical.getCompanyid() + "'";
				}else{
					operate_Condition += " and 风险单位id = '" + chemical.getCompanyid() + "'";
				}
			}
			if(chemical.getBelongtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "化学品所属类别 = '" + chemical.getBelongtype() + "'";
				}else{
					operate_Condition += " and 化学品所属类别 = '" + chemical.getBelongtype() + "'";
				}
			}
			if(chemical.getPurpose() != null && !"".equals(chemical.getPurpose())){
				if("".equals(operate_Condition)){
					operate_Condition += "用途 = '" + chemical.getPurpose() + "'";
				}else{
					operate_Condition += " and 用途 = '" + chemical.getPurpose() + "'";
				}
			}
			if(chemical.getChemicaltype() != null && !"".equals(chemical.getChemicaltype())){
				if("".equals(operate_Condition)){
					operate_Condition += "化学品类别 = '" + chemical.getChemicaltype() + "'";
				}else{
					operate_Condition += " and 化学品类别 = '" + chemical.getChemicaltype() + "'";
				}
			}
			if(chemical.getPackingtype() != null && !"".equals(chemical.getPackingtype())){
				if("".equals(operate_Condition)){
					operate_Condition += "包装 = '" + chemical.getPackingtype() + "'";
				}else{
					operate_Condition += " and 包装 = '" + chemical.getPackingtype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 根据Id查询
	 * @param id
	 * @param menuid
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getChemicalById.do")
	public String getById(int id, int menuid, String companyname, ModelMap model, String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getChemical.do ... menuid="+menuid);
		String url = "";
		
		YzdChemical chemical = new YzdChemical();
		try {
			chemical = chemicalDao.getById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("chemical",chemical);
		model.addAttribute("id", id);
		model.addAttribute("menuid",menuid);
		model.addAttribute("companyname",companyname);
		if(page.equals("showinfo")){
			int btypeid = chemical.getBelongtype();
			String btype = btypeid==1?"第一类":btypeid==2?"第二类":"第三类";
			model.addAttribute("btype", btype);
			url = "/jsp/company/chemical_showinfo";
		}else if(page.equals("update")){
			url = "/jsp/company/chemical_update";
		}
		
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询化学品种类");
		String operate_Condition = "";
		operate_Condition += "化学品种类ID = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return url;
	}
	
	/**
	 * 添加化学品种类
	 * @param chemical
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addChemical.do")
	public @ResponseBody String addChemical(YzdChemical chemical,int menuid,ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = dateFormat.format(new Date());
		System.out.println("addChemical.do ... menuid="+menuid);
		chemical.setAddtime(addtime);
		chemical.setAddoperator(userSession.getLoginUserName());
		
		try {
			chemicalDao.add(chemical);
			message = new Message("true","化学品信息添加成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "添加化学品种类成功", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addChemical.do ... 添加成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("化学品信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("true","化学品信息添加失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "添加化学品种类失败", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addChemical.do ... 添加失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("化学品信息添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 删除化学品种类
	 * @param chemical
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/cancelChemical.do")
	@ResponseBody
	public String cancelChemical(YzdChemical chemical, int menuid,ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("cancelChemical.do ... menuid="+ menuid);
		try {
			chemicalDao.cancel(chemical.getId());
			message = new Message("true","化学品种类已删除");
			message.setFlag(1);
			logDao.recordLog(menuid, "化学品种类已删除", userSession.getLoginUserName(), updatetime, "删除成功", "");
			System.out.println("cancelChemical.do ... 删除成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("化学品信息删除");
			String operate_Condition = "";
			operate_Condition += "化学品种类ID = '" + chemical.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","化学品种类删除失败");
			message.setFlag(-1);
			System.out.println("cancelChemical.do ... 删除失败");
			logDao.recordLog(menuid, "化学品种类删除", userSession.getLoginUserName(), updatetime, "删除失败", "");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("化学品信息删除");
			String operate_Condition = "";
			operate_Condition += "化学品种类ID = '" + chemical.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 修改化学品种类信息
	 * @param chemical
	 * @param menuid
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/updateChemical.do")
	@ResponseBody
	public String updateChemical(YzdChemical chemical, int menuid,ServletRequest request, @ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = dateFormat.format(new Date());
		System.out.println("updateChemical.do ... menuid="+ menuid);
		chemical.setUpdateoperator(userSession.getLoginUserName());
		chemical.setUpdatetime(updatetime);
		try {
			chemicalDao.update(chemical);
			message = new Message("true","化学品信息修改成功");
			message.setFlag(1);
			logDao.recordLog(menuid, "化学品信息修改成功", userSession.getLoginUserName(), updatetime, "修改成功", "");
			System.out.println("updateChemical.do ... 修改成功");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("化学品信息修改");
			String operate_Condition = "";
			operate_Condition += "化学品种类ID = '" + chemical.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","化学品信息修改失败");
			message.setFlag(-1);
			logDao.recordLog(menuid, "化学品信息修改失败", userSession.getLoginUserName(), updatetime, "修改失败", "");
			System.out.println("updateChemical.do ... 修改失败");
			
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("化学品信息修改");
			String operate_Condition = "";
			operate_Condition += "化学品种类ID = '" + chemical.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

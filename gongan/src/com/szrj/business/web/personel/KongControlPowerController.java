package com.szrj.business.web.personel;

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
import com.szrj.business.dao.personel.KongControlPowerDao;
import com.szrj.business.model.personel.KongBackground;
import com.szrj.business.model.personel.KongControlPower;
import com.szrj.business.model.personel.KongPublicRelation;
import com.szrj.business.model.personel.KongPublicResume;

@Controller
@SessionAttributes("userSession")
public class KongControlPowerController {
	@Autowired
	private KongControlPowerDao kongControlPowerDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/searchKongControlPower.do")
	@ResponseBody
	public Map<String,Object>  searchKongControlPower(KongControlPower kongcontrolpower,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchKongControlPower.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		   NewPageModel listTemp=kongControlPowerDao.searchKongControlPower(kongcontrolpower, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询管控力量");
			String operate_Condition = "";
			if(kongcontrolpower.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + kongcontrolpower.getPersonnelid() + "'";
			}
			if(kongcontrolpower.getForcetype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "管控力量类型(1-公共管控力量2-秘密管控力量) = '" + kongcontrolpower.getForcetype() + "'";
				}else{
					operate_Condition += " and 管控力量类型(1-公共管控力量2-秘密管控力量) = '" + kongcontrolpower.getForcetype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addKongControlPower.do")
	public @ResponseBody String addKongControlPower(KongControlPower kongcontrolpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addKongControlPower.do.......................");
		try {
			
				kongcontrolpower.setAddtime(addtime);
				kongcontrolpower.setAddoperator(userSession.getLoginUserName());
				kongControlPowerDao.addKongControlPower(kongcontrolpower);
			    message= new Message("true","秘密管控力量-添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addKongControlPower.do.......................更新成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("秘密管控力量添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","秘密管控力量-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addKongControlPower.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("秘密管控力量添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updateKongControlPower.do")
	public @ResponseBody String updateKongControlPower(KongControlPower kongcontrolpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongControlPower.do.......................");
		try {
			
				kongcontrolpower.setAddtime(addtime);
				kongcontrolpower.setAddoperator(userSession.getLoginUserName());
				kongControlPowerDao.updateKongControlPower(kongcontrolpower);
			    message= new Message("true","秘密管控力量-修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量修改", userSession.getLoginUserName(), addtime, "修改成功", "");
				System.out.println("updateKongControlPower.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("秘密管控力量修改");
				String operate_Condition = "";
				operate_Condition += "管控力量id = '" + kongcontrolpower.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","秘密管控力量-修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongControlPower.do.......................修改失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("秘密管控力量修改");
			String operate_Condition = "";
			operate_Condition += "管控力量id = '" + kongcontrolpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	@RequestMapping("/getkongcontrolpowerbyid.do")
	public String getkongcontrolpowerbyid(int id,String page,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getkongcontrolpowerbyid.do.................");
		KongControlPower kongcontrolpower=kongControlPowerDao.getkongcontrolpowerbyid(id);
		model.addAttribute("kongcontrolpower", kongcontrolpower);
		model.addAttribute("menuid", menuid);
		String urlString;
		if(page.equals("update")){
			urlString="/jsp/personel/kong/kongcontrolpower_gg/update";
		}else if(page.equals("update_mm")){
			urlString="/jsp/personel/kong/kongcontrolpower_mm/update";
		}else{
			urlString="/jsp/personel/kong/kongcontrolpower_gg/showinfo";
		}
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询管控力量");
		String operate_Condition = "";
		operate_Condition += "管控力量id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/cancelkongcontrolpower.do")
	public @ResponseBody String cancelkongcontrolpower(KongControlPower kongcontrolpower,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime=dateFormat.format(new Date());
		System.out.println("cancelkongcontrolpower.do.......................");
		try {
			    kongcontrolpower.setUpdatetime(updatetime);
			    kongcontrolpower.setUpdateoperator(userSession.getLoginUserName());
			    kongControlPowerDao.cancelKongControlPower(kongcontrolpower);
				message= new Message("true","秘密管控力量-作废成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量作废", userSession.getLoginUserName(), updatetime, "作废成功", "");
				System.out.println("cancelkongcontrolpower.do.......................作废成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("秘密管控力量作废");
				String operate_Condition = "";
				operate_Condition += "管控力量id = '" + kongcontrolpower.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","秘密管控力量-作废失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-秘密管控力量作废", userSession.getLoginUserName(), updatetime, "作废失败", "");
			System.out.println("cancelkongcontrolpower.do.......................作废失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("秘密管控力量作废");
			String operate_Condition = "";
			operate_Condition += "管控力量id = '" + kongcontrolpower.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	/*******************************************************************公共管控力量-个人简历***********************************************************************************************/
	@RequestMapping("/searchKongPublicResume.do")
	@ResponseBody
	public Map<String,Object>  searchKongPublicResume(KongPublicResume kongpublicresume,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchKongPublicResume.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		    NewPageModel listTemp=kongControlPowerDao.searchKongPublicResume(kongpublicresume, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询公共管控力量个人简历");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + kongpublicresume.getControlpowerid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/searchZbPublicResume.do")
	@ResponseBody
	public Map<String,Object>  searchZbPublicResume(KongPublicResume kongpublicresume,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/searchKongPublicResume.do..............="+userSession.getLoginUserID());
		pm.setPageNumber(page);
		NewPageModel listTemp=kongControlPowerDao.searchZbPublicResume(kongpublicresume, pm);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("count", listTemp.getTotal());
		result.put("data", listTemp.getRows().toArray());
		//生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("查询公共管控力量个人简历");
		String operate_Condition = "";
		operate_Condition += "人员主表id = '" + kongpublicresume.getControlpowerid() + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return result;
	}
	@RequestMapping("/addKongPublicResume.do")
	public @ResponseBody String addKongPublicResume(KongPublicResume kongpublicresume,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addKongPublicResume.do.......................");
		try {
		    kongpublicresume.setAddtime(addtime);
		    kongpublicresume.setAddoperator(userSession.getLoginUserName());
		    kongControlPowerDao.addKongPublicResume(kongpublicresume);
		    message= new Message("true","个人简历添加成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员--个人简历添加", userSession.getLoginUserName(), addtime, "添加成功", "");
			System.out.println("addKongPublicResume.do.......................更新成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("个人简历添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","个人简历添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--个人简历添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addKongPublicResume.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("个人简历添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updateKongPublicResume.do")
	public @ResponseBody String updateKongPublicResume(KongPublicResume kongpublicresume,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongPublicResume.do.......................");
		try {
			    kongpublicresume.setUpdatetime(addtime);
			    kongpublicresume.setUpdateoperator(userSession.getLoginUserName());
			    kongControlPowerDao.updateKongPublicResume(kongpublicresume);
			    message= new Message("true","个人简历修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员--个人简历修改", userSession.getLoginUserName(), addtime, "修改成功", "");
				System.out.println("updateKongPublicResume.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("个人简历修改");
				String operate_Condition = "";
				operate_Condition += "个人简历id = '" + kongpublicresume.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","个人简历修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--个人简历修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongPublicResume.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("个人简历修改");
			String operate_Condition = "";
			operate_Condition += "个人简历id = '" + kongpublicresume.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getkongpublicresumebyid.do")
	public String getkongpublicresumebyid(int id,String page,ModelMap model) throws Exception{
		System.out.println("getkongpublicresumebyid.do.................");
		 KongPublicResume kongpublicresume=kongControlPowerDao.getkongpublicresumebyid(id);
		model.addAttribute("kongpublicresume", kongpublicresume);
	    String	urlString="/jsp/personel/kong/kongpublicresume/update";
	    if(page.equals("update_zhengbao")){
	    	urlString="/jsp/personel/zhengbao/resume/update";
	    }
		return urlString;
	}
	@RequestMapping("/cancelKongPublicResume.do")
	public @ResponseBody String cancelKongPublicResume(KongPublicResume kongpublicresume,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelKongPublicResume.do.......................");
		try {
			    kongpublicresume.setUpdatetime(addtime);
			    kongpublicresume.setUpdateoperator(userSession.getLoginUserName());
			    kongControlPowerDao.cancelKongPublicResume(kongpublicresume);
			    message= new Message("true","个人简历删除成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员--个人简历删除", userSession.getLoginUserName(), addtime, "删除成功", "");
				System.out.println("cancelKongPublicResume.do.......................删除成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("个人简历删除");
				String operate_Condition = "";
				operate_Condition += "个人简历id = '" + kongpublicresume.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","个人简历删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员--个人简历删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelKongPublicResume.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("个人简历删除");
			String operate_Condition = "";
			operate_Condition += "个人简历id = '" + kongpublicresume.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
	/*******************************************************************公共管控力量-家庭关系***********************************************************************************************/
	@RequestMapping("/searchKongPublicRelation.do")
	@ResponseBody
	public Map<String,Object>  searchKongPublicRelation(KongPublicRelation kongpublicrelation,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchKongPublicRelation.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		    NewPageModel listTemp=kongControlPowerDao.searchKongPublicRelation(kongpublicrelation, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询公共管控力量--家庭关系");
			String operate_Condition = "";
			if(kongpublicrelation.getControlpowerid() != 0){
				operate_Condition += "人员主表id = '" + kongpublicrelation.getControlpowerid() + "'";
			}
			if(kongpublicrelation.getRelationtype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "关系类型(1-家庭关系2-社会关系) = '" + kongpublicrelation.getRelationtype() + "'";
				}else{
					operate_Condition += " and 关系类型(1-家庭关系2-社会关系) = '" + kongpublicrelation.getRelationtype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addKongPublicRelation.do")
	public @ResponseBody String addKongPublicResume(KongPublicRelation kongpublicrelation,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addKongPublicRelation.do.......................");
		try {
			
			     kongpublicrelation.setAddtime(addtime);
			     kongpublicrelation.setAddoperator(userSession.getLoginUserName());
			    kongControlPowerDao.addKongPublicRelation(kongpublicrelation);
			    message= new Message("true","公共管控力量--家庭关系添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量-家庭关系添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addKongPublicRelation.do.......................更新成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("公共管控力量--家庭关系添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","公共管控力量--家庭关系添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量--家庭关系添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addKongPublicRelation.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("公共管控力量--家庭关系添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updateKongPublicRelation.do")
	public @ResponseBody String updateKongPublicResume(KongPublicRelation kongpublicrelation,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongPublicRelation.do.......................");
		try {
			
			    kongpublicrelation.setUpdatetime(addtime);
			    kongpublicrelation.setUpdateoperator(userSession.getLoginUserName());
			    kongControlPowerDao.updateKongPublicRelation(kongpublicrelation);
			    message= new Message("true","公共管控力量-家庭关系修改成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量-家庭关系修改", userSession.getLoginUserName(), addtime, "修改成功", "");
				System.out.println("updateKongPublicRelation.do.......................修改成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("公共管控力量-家庭关系修改");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","公共管控力量-家庭关系修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量-家庭关系修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongPublicRelation.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("公共管控力量-家庭关系修改");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getkongpublicrelationbyid.do")
	public String getkongpublicrelationbyid(int id,ModelMap model) throws Exception{
		System.out.println("getkongpublicrelationbyid.do.................");
		KongPublicRelation kongpublicrelation=kongControlPowerDao.getkongpublicrelationbyid(id);
		model.addAttribute("kongpublicrelation", kongpublicrelation);
	    String	urlString="/jsp/personel/kong/kongpublicrelation/update";
	    
		return urlString;
	}
	@RequestMapping("/cancelKongPublicRelation.do")
	public @ResponseBody String cancelKongPublicRelation(KongPublicRelation kongpublicrelation,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelKongPublicRelation.do.......................");
		try {
			
			    kongpublicrelation.setUpdatetime(addtime);
			    kongpublicrelation.setUpdateoperator(userSession.getLoginUserName());
			    kongControlPowerDao.cancelKongPublicRelation(kongpublicrelation);
			    message= new Message("true","公共管控力量-家庭关系删除成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量-家庭关系删除", userSession.getLoginUserName(), addtime, "删除成功", "");
				System.out.println("cancelKongPublicRelation.do.......................删除成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("公共管控力量-家庭关系删除");
				String operate_Condition = "";
				operate_Condition += "家庭关系id = '" + kongpublicrelation.getId() + "'";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","公共管控力量-家庭关系删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-公共管控力量-家庭关系删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelKongPublicRelation.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("公共管控力量-家庭关系删除");
			String operate_Condition = "";
			operate_Condition += "家庭关系id = '" + kongpublicrelation.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
	/*******************************************************************背景审查***********************************************************************************************/
	@RequestMapping("/searchKongBackground.do")
	@ResponseBody
	public Map<String,Object>  searchKongBackground(KongBackground kongbackground,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		   System.out.println("/searchKongBackground.do..............="+userSession.getLoginUserID());
		    pm.setPageNumber(page);
		    NewPageModel listTemp=kongControlPowerDao.searchKongBackground(kongbackground, pm);
		    Map<String, Object> result = new HashMap<String, Object>();
	        result.put("code", 0);
	        result.put("count", listTemp.getTotal());
	        result.put("data", listTemp.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询背景审查");
			String operate_Condition = "";
			if(kongbackground.getPersonnelid() != 0){
				operate_Condition += "人员主表id = '" + kongbackground.getPersonnelid() + "'";
			}
			if(kongbackground.getDatatype() != 0){
				if("".equals(operate_Condition)){
					operate_Condition += "数据类型(1-背景审查 2-工作地、居住地) = '" + kongbackground.getDatatype() + "'";
				}else{
					operate_Condition += " and 数据类型(1-背景审查 2-工作地、居住地) = '" + kongbackground.getDatatype() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
	        return result;
	}
	@RequestMapping("/addKongBackground.do")
	public @ResponseBody String addKongBackground(KongBackground kongbackground,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("addKongBackground.do.......................");
		try {
			
			kongbackground.setAddtime(addtime);
			kongbackground.setAddoperator(userSession.getLoginUserName());
			    kongControlPowerDao.addKongBackground(kongbackground);
			    message= new Message("true","涉恐人员-涉恐背景审查添加成功！");
				message.setFlag(1);
				logDao.recordLog(menuid, "风险人员-涉恐人员-涉恐背景审查添加", userSession.getLoginUserName(), addtime, "添加成功", "");
				System.out.println("addKongBackground.do.......................更新成功");
				//生成操作日志
				UserActionLog log = CreateLogXML.AssignUserLog(userSession);
				log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
				log.setOperate_Result("1");	//0：失败 1：成功
				log.setOperate_Name("涉恐背景审查添加");
				String operate_Condition = "";
				log.setOperate_Condition(operate_Condition);
				log.setTerminal_ID(request.getRemoteAddr());
				CreateLogXML.UserActionLog(log);
		
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉恐人员-涉恐背景审查添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-涉恐背景审查添加", userSession.getLoginUserName(), addtime, "添加失败", "");
			System.out.println("addKongBackground.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐背景审查添加");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/updateKongBackground.do")
	public @ResponseBody String updateKongBackground(KongBackground kongbackground,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateKongBackground.do.......................");
		try {
			
			kongbackground.setUpdatetime(addtime);
			kongbackground.setUpdateoperator(userSession.getLoginUserName());
		    kongControlPowerDao.updateKongBackground(kongbackground);
		    message= new Message("true","涉恐人员-涉恐背景审查修改成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-涉恐背景审查修改", userSession.getLoginUserName(), addtime, "修改成功", "");
			System.out.println("updateKongBackground.do.......................修改成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐背景审查修改");
			String operate_Condition = "";
			operate_Condition += "涉恐背景id = '" + kongbackground.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉恐人员-涉恐背景审查修改失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-涉恐背景审查修改", userSession.getLoginUserName(), addtime, "修改失败", "");
			System.out.println("updateKongBackground.do.......................更新失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐背景审查修改");
			String operate_Condition = "";
			operate_Condition += "涉恐背景id = '" + kongbackground.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	@RequestMapping("/getkongbackgroundbyid.do")
	public String getkongbackgroundbyid(int id,ModelMap model,String page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		System.out.println("getkongbackgroundbyid.do.................");
		KongBackground kongbackground=kongControlPowerDao.getkongbackgroundbyid(id);
		model.addAttribute("kongbackground", kongbackground);
	    String	urlString="";
	    if(page.equals("update1")){
	    	urlString="/jsp/personel/kong/kongbackground/update";
	    }else{
	    	urlString="/jsp/personel/kong/workandlive/update";
	    }
	    //生成操作日志
		UserActionLog log = CreateLogXML.AssignUserLog(userSession);
		log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		log.setOperate_Result("1");	//0：失败 1：成功
		log.setOperate_Name("根据ID查询涉恐背景审查");
		String operate_Condition = "";
		operate_Condition += "涉恐背景id = '" + id + "'";
		log.setOperate_Condition(operate_Condition);
		log.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(log);
		return urlString;
	}
	@RequestMapping("/cancelKongBackground.do")
	public @ResponseBody String cancelKongPublicRelation(KongBackground kongbackground,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("cancelKongBackground.do.......................");
		try {
			
			kongbackground.setUpdatetime(addtime);
			kongbackground.setUpdateoperator(userSession.getLoginUserName());
		    kongControlPowerDao.cancelKongBackground(kongbackground);
		    message= new Message("true","涉恐人员-涉恐背景审查删除成功！");
			message.setFlag(1);
			logDao.recordLog(menuid, "风险人员-涉恐人员--涉恐背景审查删除", userSession.getLoginUserName(), addtime, "删除成功", "");
			System.out.println("cancelKongBackground.do.......................删除成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("涉恐背景审查删除");
			String operate_Condition = "";
			operate_Condition += "涉恐背景id = '" + kongbackground.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message= new Message("false","涉恐人员-涉恐背景审查删除失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "风险人员-涉恐人员-涉恐背景审查删除", userSession.getLoginUserName(), addtime, "删除失败", "");
			System.out.println("cancelKongBackground.do.......................删除失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("涉恐背景审查删除");
			String operate_Condition = "";
			operate_Condition += "涉恐背景id = '" + kongbackground.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}	
	
}

package com.szrj.business.web.personel;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.szrj.business.dao.personel.MaintainrateDao;
import com.szrj.business.dao.personel.RealityShowDao;
import com.szrj.business.model.personel.Maintainrate;
import com.szrj.business.model.personel.RealityShow;

@Controller
@SessionAttributes("userSession")
public class RealityShowController {
	@Autowired
	private RealityShowDao realityShowDao;
	@Autowired
	private MaintainrateDao maintainrateDao;
	@Autowired
	private LogDao logDao;
	
	@RequestMapping("/getRealityShowByPersonnelid.do")
	@ResponseBody
	public Map<String,Object> getRealityShowByPersonnelid(RealityShow realityShow,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			RealityShow realityShow1=realityShowDao.getByPersonnelid(realityShow);
			
			if(realityShow1==null)result.put("firstShow",0);
			else result.put("firstShow",1);
			result.put("realityShow",realityShow1);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("根据人员id查询现实表现");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + realityShow.getPersonnelid() + "'";
			if("".equals(operate_Condition)){
				operate_Condition += "数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}else{
				operate_Condition += " and 数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
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
			log.setOperate_Name("根据人员id查询现实表现");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + realityShow.getPersonnelid() + "'";
			if("".equals(operate_Condition)){
				operate_Condition += "数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}else{
				operate_Condition += " and 数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/searchRealityShow.do")
	@ResponseBody
	public Map<String,Object> searchRealityShow(RealityShow realityShow,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		System.out.println("searchRealityShow.do.......................");
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=realityShowDao.searchRealityShow(realityShow, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询现实表现");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + realityShow.getPersonnelid() + "'";
			if("".equals(operate_Condition)){
				operate_Condition += "数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}else{
				operate_Condition += " and 数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
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
			log.setOperate_Name("查询现实表现");
			String operate_Condition = "";
			operate_Condition += "人员主表id = '" + realityShow.getPersonnelid() + "'";
			if("".equals(operate_Condition)){
				operate_Condition += "数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}else{
				operate_Condition += " and 数据标签(1-涉稳2-涉黑3-涉恐4-涉毒) = '" + realityShow.getDatalabel() + "'";
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	@RequestMapping("/updateRealityShow.do")
	public @ResponseBody String updateRealityShow(RealityShow realityShow,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime=dateFormat.format(new Date());
		System.out.println("updateRealityShow.do.......................");
		try {
			if (realityShow.getId()>0) {
				realityShow.setUpdateoperator(userSession.getLoginUserName());
				realityShow.setUpdatetime(addtime);
				realityShow.setValidflag(1);//历史
				realityShowDao.update(realityShow);
			}
			
			realityShow.setAddoperator(userSession.getLoginUserName());
			realityShow.setAddtime(addtime);
			realityShow.setValidflag(2);//当前
			realityShowDao.add(realityShow);
			
			if(realityShow.getDatalabel()==1){
				/*****涉稳人员维护率计算***Parameter3**/
				int maintainrate1=0;
				if(!realityShow.getLifepattern().equals(""))maintainrate1+=2;		//日常生活规律			2分
				if(!realityShow.getHealthstate().equals(""))maintainrate1+=2;		//健康状况			2分
				if(!realityShow.getCharacteristic().equals(""))maintainrate1+=2;	//性格特点			2分
				if(!realityShow.getLifehabit().equals(""))maintainrate1+=2;			//生活习惯			2分
				Maintainrate maintainrate=new Maintainrate();
				maintainrate.setPersonlabel(realityShow.getDatalabel());
				maintainrate.setPersonnelid(realityShow.getPersonnelid());
				maintainrate=maintainrateDao.getMaintainrate(maintainrate);
				if(maintainrate!=null){
					maintainrate.setParameter3(maintainrate1);
					maintainrateDao.update(maintainrate);
				}
			}
		
			
			message = new Message("true","现实表现-添加成功！");
			message.setFlag(realityShow.getPersonnelid());
			logDao.recordLog(menuid, "现实表现-添加", userSession.getLoginUserName(), addtime, "提交成功", "");
			System.out.println("updateRealityShow.do.......................提交成功");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加现实表现");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","现实表现-添加失败！");
			message.setFlag(-1);
			logDao.recordLog(menuid, "现实表现-添加", userSession.getLoginUserName(), addtime, "提交失败", "");
			System.out.println("updateRealityShow.do.......................提交失败");
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加现实表现");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**政法委**/
	@RequestMapping("/getRealityShowByPersonnelid_zfw.do")
	@ResponseBody
	public Map<String,Object> getRealityShowByPersonnelid_zfw(RealityShow realityShow,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result=new HashMap<String, Object>();
		try {
			RealityShow realityShow_zfw=realityShowDao.getByPersonnelid_zfw(realityShow);
			
			if(realityShow_zfw==null)result.put("firstShow",0);
			else result.put("firstShow",1);
			result.put("realityShow",realityShow_zfw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/searchRealityShow_zfw.do")
	@ResponseBody
	public Map<String,Object> searchRealityShow_zfw(RealityShow realityShow,NewPageModel pm,ServletRequest request,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
        	NewPageModel pagelist=realityShowDao.searchRealityShow_zfw(realityShow, pm);
        	result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

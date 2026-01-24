package com.szrj.business.web.goods;

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
import com.aladdin.util.CardnumberInfo;
import com.aladdin.util.CreateLogXML;
import com.aladdin.util.TimeFormate;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.goods.DangerousItemDao;
import com.szrj.business.dao.interfaces.KaKouDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.RelationDao;
import com.szrj.business.dao.personel.ZaExtendDao;
import com.szrj.business.model.Log;
import com.szrj.business.model.goods.DangerousItem;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.ZaExtend;

@Controller
@SessionAttributes("userSession")
public class DangerousItemController {
	@Autowired
	private DangerousItemDao dangerousItemDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired 
	private LogDao logDao;
	@Autowired
	private KaKouDao kaKouDao;
	@Autowired
	private ZaExtendDao zaExtendDao;
	@Autowired
	private RelationDao relationDao;
	
	@RequestMapping("/searchDangerousItem.do")
	@ResponseBody
	public Map<String,Object> searchDangerousItem(DangerousItem dangerousItem,NewPageModel pm,int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = dangerousItemDao.search(dangerousItem, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
	        //生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询风险物品信息");
			String operate_Condition = "";
			if(dangerousItem.getCasename() != null && !"".equals(dangerousItem.getCasename())){
				operate_Condition += "案件名称 LIKE '" + dangerousItem.getCasename() + "'";
			}
			if(dangerousItem.getGoodscode() != null && !"".equals(dangerousItem.getGoodscode())){
				if("".equals(operate_Condition)){
					operate_Condition += "物品型号 LIKE '" + dangerousItem.getGoodscode() + "'";
				}else{
					operate_Condition += " and 物品型号 LIKE '" + dangerousItem.getGoodscode() + "'";
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
			log.setOperate_Name("查询风险物品信息");
			String operate_Condition = "";
			if(dangerousItem.getCasename() != null && !"".equals(dangerousItem.getCasename())){
				operate_Condition += "案件名称 LIKE '" + dangerousItem.getCasename() + "'";
			}
			if(dangerousItem.getGoodscode() != null && !"".equals(dangerousItem.getGoodscode())){
				if("".equals(operate_Condition)){
					operate_Condition += "物品型号 LIKE '" + dangerousItem.getGoodscode() + "'";
				}else{
					operate_Condition += " and 物品型号 LIKE '" + dangerousItem.getGoodscode() + "'";
				}
			}
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
        return result;
	}
	
	@RequestMapping("/addDangerousItem.do")
	@ResponseBody
	public Map<String,Object> addDangerousItem(DangerousItem dangerousItem,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			dangerousItem.setAddtime(addtime);
			dangerousItem.setAddoperator(userSession.getLoginUserName());
			dangerousItem.setValidflag(1);
			//查询绑定人员是否存在
			if(!"".equals(dangerousItem.getDxsfz())){
				int id= personnelDao.findPersonInPersonnel(dangerousItem.getDxsfz());
				if(id!=0){
					dangerousItem.setPersonid(id);
				}else{
					/*****一标三识数据关联*****/
					Personnel personnel = new Personnel();
					personnel.setCardnumber(dangerousItem.getDxsfz());
					personnel.setPersonname(dangerousItem.getSjdx());
					personnel.setZslabel1("2046");
					personnel.setValidflag(1);
					personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
					personnel.setAddtime(addtime);
					personnel.setAddoperator(userSession.getLoginUserName());
					personnel.setAddoperatorid(userSession.getLoginUserID());
					if(dangerousItem.getYbssid()!=null&&!"".equals(dangerousItem.getYbssid())){
						Personnel ybssPersonnel=kaKouDao.getYbssRkByID(dangerousItem.getYbssid());
						personnel.setNation(ybssPersonnel.getNation());
						personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
						personnel.setEducation(ybssPersonnel.getEducation());
						personnel.setHouseplace(ybssPersonnel.getHouseplace());
						personnel.setHomeplace(ybssPersonnel.getHomeplace());
						personnel.setHomex(ybssPersonnel.getHomex());
						personnel.setHomey(ybssPersonnel.getHomey());
						personnel.setWorkplace(ybssPersonnel.getWorkplace());
						personnel.setTelnumber(ybssPersonnel.getTelnumber());
					}
					int personid = personnelDao.add(personnel);
					/*****新增扩展表*****/
					ZaExtend zaExtend = new ZaExtend();
					zaExtend.setPersonnelid(personid);
					zaExtendDao.add(zaExtend);
					if(personnel.getTelnumber()!=null&&!"".equals(personnel.getTelnumber())){
						String[] telnumbers=personnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(personid);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
					dangerousItem.setPersonid(personid);
					result.put("msg", "人员添加成功!");
					result.put("flag", 1);
					//日志
					Log log = new Log();
					log.setMenuId(menuid);
					log.setOperation("人员添加");
					log.setOperator(userSession.getLoginUserName());
					log.setOperationTime(addtime);
					log.setOperationResult("人员添加成功");
					log.setMemo("案件名称："+dangerousItem.getCasename());
					log.setOperatedept(userSession.getLoginUserDepartname());
					logDao.recordEventLog(log);
					//生成操作日志
					UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
					alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
					alog.setOperate_Result("1");	//0：失败 1：成功
					alog.setOperate_Name("风险物品添加");
					String operate_Condition = "";
					alog.setOperate_Condition(operate_Condition);
					alog.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(alog);
				}
			}
			dangerousItemDao.add(dangerousItem);
			result.put("msg", "新增风险物品成功！");
			result.put("flag", 1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("案件名称："+dangerousItem.getCasename());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("风险物品添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "新增风险物品失败！");
			result.put("flag", -1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品添加");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("案件名称："+dangerousItem.getCasename());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("风险物品添加");
			String operate_Condition = "";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
	
	@RequestMapping("/getDangerousItem.do")
	public String getDangerousItem(int id,int menuid,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession) throws Exception{
		model.addAttribute("menuid",menuid);
		DangerousItem dangerousItem = dangerousItemDao.getById(id);
		model.addAttribute("dangerousItem",dangerousItem);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("风险物品添加");
		String operate_Condition = "";
		operate_Condition += "风险物品id = '" + id + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/goods/goods/update";
	}
	
	@RequestMapping("/updateDangerousItem.do")
	@ResponseBody
	public Map<String,Object> updateDangerousItem(DangerousItem dangerousItem,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			dangerousItem.setUpdateoperator(userSession.getLoginUserName());
			dangerousItem.setUpdatetime(addtime);
			//查询绑定人员是否存在
			if(!"".equals(dangerousItem.getDxsfz())){
				int id= personnelDao.findPersonInPersonnel(dangerousItem.getDxsfz());
				if(id!=0){
					dangerousItem.setPersonid(id);
				}else{
					/*****一标三识数据关联*****/
					Personnel personnel = new Personnel();
					personnel.setCardnumber(dangerousItem.getDxsfz());
					personnel.setPersonname(dangerousItem.getSjdx());
					personnel.setZslabel1("2046");
					personnel.setValidflag(1);
					personnel.setSexes(CardnumberInfo.getSex(personnel.getCardnumber()));
					personnel.setAddtime(addtime);
					personnel.setAddoperator(userSession.getLoginUserName());
					personnel.setAddoperatorid(userSession.getLoginUserID());
					if(dangerousItem.getYbssid()!=null&&!"".equals(dangerousItem.getYbssid())){
						Personnel ybssPersonnel=kaKouDao.getYbssRkByID(dangerousItem.getYbssid());
						personnel.setNation(ybssPersonnel.getNation());
						personnel.setMarrystatus(ybssPersonnel.getMarrystatus());
						personnel.setEducation(ybssPersonnel.getEducation());
						personnel.setHouseplace(ybssPersonnel.getHouseplace());
						personnel.setHomeplace(ybssPersonnel.getHomeplace());
						personnel.setHomex(ybssPersonnel.getHomex());
						personnel.setHomey(ybssPersonnel.getHomey());
						personnel.setWorkplace(ybssPersonnel.getWorkplace());
						personnel.setTelnumber(ybssPersonnel.getTelnumber());
					}
					int personid = personnelDao.add(personnel);
					/*****新增扩展表*****/
					ZaExtend zaExtend = new ZaExtend();
					zaExtend.setPersonnelid(personid);
					zaExtendDao.add(zaExtend);
					if(personnel.getTelnumber()!=null&&!"".equals(personnel.getTelnumber())){
						String[] telnumbers=personnel.getTelnumber().split(";");
						for (int i = 0; i < telnumbers.length; i++) {
							if(!"".equals(telnumbers[i])&&telnumbers[i].length()>10){
								RelationTelnumber relationtelnumber=new RelationTelnumber();
								relationtelnumber.setPersonnelid(personid);
								relationtelnumber.setTelnumber(telnumbers[i]);
								relationtelnumber.setAddtime(addtime);
								relationtelnumber.setAddoperator(userSession.getLoginUserName());
								relationDao.addrelationtelnumber(relationtelnumber);
							}
						}
					}
					dangerousItem.setPersonid(personid);
					result.put("msg", "人员添加成功!");
					result.put("flag", 1);
					//日志
					Log log = new Log();
					log.setMenuId(menuid);
					log.setOperation("人员添加");
					log.setOperator(userSession.getLoginUserName());
					log.setOperationTime(addtime);
					log.setOperationResult("人员添加成功");
					log.setMemo("案件名称："+dangerousItem.getCasename());
					log.setOperatedept(userSession.getLoginUserDepartname());
					logDao.recordEventLog(log);
					//生成操作日志
					UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
					alog.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
					alog.setOperate_Result("1");	//0：失败 1：成功
					alog.setOperate_Name("风险物品添加");
					String operate_Condition = "";
					alog.setOperate_Condition(operate_Condition);
					alog.setTerminal_ID(request.getRemoteAddr());
					CreateLogXML.UserActionLog(alog);
				}
			}
			dangerousItemDao.update(dangerousItem);
			result.put("msg", "修改风险物品成功！");
			result.put("flag", 1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setMemo("案件名称："+dangerousItem.getCasename());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("风险物品修改");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "修改风险物品失败！");
			result.put("flag", -1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品修改");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setMemo("案件名称："+dangerousItem.getCasename());
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("风险物品修改");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
	
	@RequestMapping("/cancelDangerousItem.do")
	@ResponseBody
	public String cancelDangerousItem(DangerousItem dangerousItem,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Message message;
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			dangerousItem.setUpdateoperator(userSession.getLoginUserName());
			dangerousItem.setUpdatetime(addtime);
			dangerousItemDao.cancel(dangerousItem);
			message= new Message("true","删除风险物品成功！");
			message.setFlag(1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("成功");
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("风险物品删除");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			message = new Message("false","删除风险物品失败！");
			message.setFlag(-1);
			//日志
			Log log = new Log();
			log.setMenuId(menuid);
			log.setOperation("风险物品删除");
			log.setOperator(userSession.getLoginUserName());
			log.setOperationTime(addtime);
			log.setOperationResult("失败");
			log.setOperatedept(userSession.getLoginUserDepartname());
			logDao.recordEventLog(log);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(4);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("风险物品删除");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 显示详情页面
	 * @param id
	 * @param model
	 * @return String
	 */
	
	@RequestMapping("/showDangerousItem.do")
	public String showDangerousItem(int id,ModelMap model,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		DangerousItem dangerousItem = dangerousItemDao.getById(id);
		model.addAttribute("dangerousItem", dangerousItem);
		//生成操作日志
		UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
		alog.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
		alog.setOperate_Result("1");	//0：失败 1：成功
		alog.setOperate_Name("查询风险物品详情");
		String operate_Condition = "";
		operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
		alog.setOperate_Condition(operate_Condition);
		alog.setTerminal_ID(request.getRemoteAddr());
		CreateLogXML.UserActionLog(alog);
		return "/jsp/goods/goods/showinfo";
	}
	
	@RequestMapping("/generateCodenum.do")
	@ResponseBody
	public Map<String,Object> generateCodenum(){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			int count = dangerousItemDao.generateCodenum();
			String code = String.format("%04d", count);
			String today = TimeFormate.getISOTimeToNow2().substring(0, 8);
			String codenum = "320281"+today+code;
			result.put("codenum", codenum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/searchItemByPerson.do")
	@ResponseBody
	public Map<String,Object> searchItemByPerson(DangerousItem dangerousItem,NewPageModel pm,@ModelAttribute("userSession")UserSession userSession,int page){
		Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = dangerousItemDao.searchItemByPerson(dangerousItem, pm);
	        result.put("count", pagelist.getTotal());
	        result.put("data", pagelist.getRows().toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
        return result;
	}
	
	@RequestMapping("/updatePersonByCodenum.do")
	@ResponseBody
	public Map<String,Object> updatePersonByCodenum(DangerousItem dangerousItem,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			dangerousItem.setUpdateoperator(userSession.getLoginUserName());
			dangerousItem.setUpdatetime(addtime);
			dangerousItemDao.updatePersonByCodenum(dangerousItem);
			result.put("msg", "物品绑定成功！");
			result.put("flag", 1);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("物品绑定");
			String operate_Condition = "";
			operate_Condition += "唯一标识码 = '" + dangerousItem.getCodenum() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "物品绑定失败！");
			result.put("flag", 0);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("物品绑定");
			String operate_Condition = "";
			operate_Condition += "唯一标识码 = '" + dangerousItem.getCodenum() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
	
	@RequestMapping("/cancelGoodsConnect.do")
	@ResponseBody
	public Map<String,Object> cancelGoodsConnect(DangerousItem dangerousItem,int menuid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		Map<String, Object> result = new HashMap<String, Object>();
		String addtime = TimeFormate.getISOTimeToNow();
		try {
			dangerousItem.setPersonid(0);
			dangerousItem.setUpdateoperator(userSession.getLoginUserName());
			dangerousItem.setUpdatetime(addtime);
			dangerousItemDao.cancelGoodsConnect(dangerousItem);
			result.put("msg", "物品取消绑定成功！");
			result.put("flag", 1);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("1");	//0：失败 1：成功
			alog.setOperate_Name("物品取消绑定");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "物品取消绑定失败！");
			result.put("flag", 0);
			//生成操作日志
			UserActionLog alog = CreateLogXML.AssignUserLog(userSession);
			alog.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			alog.setOperate_Result("0");	//0：失败 1：成功
			alog.setOperate_Name("物品取消绑定");
			String operate_Condition = "";
			operate_Condition += "风险物品id = '" + dangerousItem.getId() + "'";
			alog.setOperate_Condition(operate_Condition);
			alog.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(alog);
		}
		return result;
	}
}

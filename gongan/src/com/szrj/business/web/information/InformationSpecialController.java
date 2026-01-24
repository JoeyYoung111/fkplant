package com.szrj.business.web.information;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.aladdin.model.Message;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.aladdin.web.JsonView;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.dao.information.InformationSendDao;
import com.szrj.business.dao.information.InformationSpecialDao;
import com.szrj.business.model.information.InfoTimeLine;
import com.szrj.business.model.information.InformationSend;
import com.szrj.business.model.information.InformationSpecial;

@Controller
@SessionAttributes("userSession")
public class InformationSpecialController {

	@Autowired
	private InformationSpecialDao informationSpecialDao;
	@Autowired
	private InformationSendDao informationSendDao;
	@Autowired
	private InfoTimeLineDao infoTimeLineDao;
	
	/**
	 * 添加新标签
	 * @param informationSpecial
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/addInformationSpecial.do")
	public @ResponseBody String addInformationSpecial(InformationSpecial informationSpecial,Integer informationid,Integer informationsendid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("addInformationSpecial.do ...");
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = sdf.format(new Date());
		informationSpecial.setAddtime(addtime);
		informationSpecial.setAddoperator(userSession.getLoginUserName());
		try {
			Integer id = informationSpecialDao.add(informationSpecial);
			
			String content = userSession.getLoginUserDepartname()+" "+userSession.getLoginUserName()+" "+informationSpecial.getSpecialName();
			String title = "【添加专项标签】";
			InfoTimeLine infoTimeLine = new InfoTimeLine(informationid,informationsendid+"","0",0,0,title,content,addtime,0);
			infoTimeLineDao.add(infoTimeLine);
			System.out.println("已录入时间轴");
			
			message = new Message("true","添加成功");
			message.setFlag(id);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加专项标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","添加失败");
			message.setFlag(-1);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("添加专项标签");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 查询本部门已有的标签
	 * @param informationSpecial
	 * @return
	 */
	@RequestMapping("/searchInformationSpecial.do")
	@ResponseBody
	public Map<String, Object> searchRadio(InformationSpecial informationSpecial, NewPageModel pm, int page,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("/searchRadio.do ... ");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		try {
			pm.setPageNumber(page);
			NewPageModel pagelist = informationSpecialDao.searchRadio(informationSpecial,pm);
			result.put("count", pagelist.getTotal());
			result.put("data", pagelist.getRows().toArray());
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("查询专项标签信息");
			String operate_Condition = "";
			operate_Condition += "部门id = '" + informationSpecial.getDepartmentid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(1);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("查询专项标签信息");
			String operate_Condition = "";
			operate_Condition += "部门id = '" + informationSpecial.getDepartmentid() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return result;
	}
	
	/**
	 * 修改标签
	 * @return
	 */
	@RequestMapping("/updateInformationSpecial.do")
	public @ResponseBody String updateInformationSpecial(InformationSpecial informationSpecial,Integer informationid,Integer informationsendid,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("updateInformationSpecial.do ... ");
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		informationSpecial.setUpdatetime(updatetime);
		informationSpecial.setUpdateoperator(userSession.getLoginUserName());
		try {
			informationSpecialDao.update(informationSpecial);
			
			message = new Message("true","修改成功");
			message.setFlag(1);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("修改专项标签信息");
			String operate_Condition = "";
			operate_Condition += "专项标签id = '" + informationSpecial.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		} catch (Exception e) {
			message = new Message("false","修改失败");
			message.setFlag(-1);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(3);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("0");	//0：失败 1：成功
			log.setOperate_Name("修改专项标签信息");
			String operate_Condition = "";
			operate_Condition += "专项标签id = '" + informationSpecial.getId() + "'";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 给信息添加/修改标签
	 * @param id
	 * @param userSession
	 * @return
	 */
	@RequestMapping("/changeInformationSendSpecial.do")
	public @ResponseBody String changeInformationSpecial(Integer informationid,Integer informationsendid,String specialName, Integer specialid ,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("changeInformationSpecial.do ... ");
		Message message;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = sdf.format(new Date());
		
		InformationSend informationSend = informationSendDao.getById(informationsendid);
		Integer oldspecialid = informationSend.getSpecialid();
		informationSend.setSpecialid(specialid);
		
		try {
			informationSendDao.changeSpecialid(informationSend);
			if(oldspecialid>0){
				informationSpecialDao.changeCount(oldspecialid, "reduce");
			}
			informationSpecialDao.changeCount(specialid, "add");
			
			String content = userSession.getLoginUserDepartname()+" "+userSession.getLoginUserName()+" "+specialName;
			String title = "【修改标签】";
			InfoTimeLine infoTimeLine = new InfoTimeLine(informationid,informationsendid+"","0",0,0,title,content,updatetime,0);
			infoTimeLineDao.add(infoTimeLine);
			
			message = new Message("true","修改成功");
			message.setFlag(1);
		} catch (Exception e) {
			message = new Message("false","修改失败");
			message.setFlag(-1);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	/**
	 * 专项标签下拉
	 * @param departmentid
	 * @return
	 */
	@RequestMapping("/getSpecialidToJSON.do")
	public ModelAndView getSpecialidToJSON(Integer departmentid){
		ModelAndView view = new ModelAndView(JsonView.instance);
		InformationSpecial informationSpecial = new InformationSpecial();
		informationSpecial.setDepartmentid(departmentid);
		List<InformationSpecial> bmList = informationSpecialDao.searchSelect(informationSpecial);
		List<SelectModel> smList = new ArrayList<SelectModel>();
		for(int i=0;i<bmList.size();i++){
			SelectModel sm = new SelectModel();
			sm.setText(bmList.get(i).getSpecialName());
			sm.setValue(String.valueOf(bmList.get(i).getId()));
			smList.add(sm);
		}
		view.addObject(JsonView.JSON_ROOT,smList);
		return view;
	}
	
}

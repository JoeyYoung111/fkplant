package com.szrj.business.web.information;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.Message;
import com.aladdin.model.UserActionLog;
import com.aladdin.model.UserSession;
import com.aladdin.util.CreateLogXML;
import com.szrj.business.dao.information.InfoJointPersonDao;
import com.szrj.business.model.information.InfoJointPerson;

@Controller
@SessionAttributes("userSession")
public class InfoJointPersonController {

	@Autowired
	private InfoJointPersonDao infoJointPersonDao;
	
	
	@RequestMapping("/addInfoJointPerson.do")
	public @ResponseBody String addInfoJointPerson(InfoJointPerson info,ServletRequest request,@ModelAttribute("userSession")UserSession userSession){
		System.out.println("addInfoJointPerson.do ... cardNumber:"+info.getJointCardNumber());
		Message message;
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = sdFormat.format(new Date());
		info.setAddtime(addtime);
		info.setAddoperator(userSession.getLoginUserName());
		try {
			int id = infoJointPersonDao.add(info);
			message = new Message("true","添加成功");
			message.setFlag(id);
			//生成操作日志
			UserActionLog log = CreateLogXML.AssignUserLog(userSession);
			log.setOperate_Type(2);//0：登录；1：查询；2：新增；3：修改；4：删除
			log.setOperate_Result("1");	//0：失败 1：成功
			log.setOperate_Name("添加情报新增涉及人员");
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
			log.setOperate_Name("添加情报新增涉及人员");
			String operate_Condition = "";
			log.setOperate_Condition(operate_Condition);
			log.setTerminal_ID(request.getRemoteAddr());
			CreateLogXML.UserActionLog(log);
		}
		return JSONObject.fromObject(message).toString();
	}
	
	
}

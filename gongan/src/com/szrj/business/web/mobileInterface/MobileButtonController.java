package com.szrj.business.web.mobileInterface;

import java.util.List;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.szrj.business.dao.AppButtonDao;
import com.szrj.business.model.AppButton;
import com.szrj.business.model.mobileInterface.MobileObj;

@Controller
@SessionAttributes("userSession")
public class MobileButtonController {
	@Autowired
	private AppButtonDao appButtonDao;
	
	@RequestMapping("/getMainMobileButton.post")
	@ResponseBody
	public JSONObject getMainMobileButton(int roleid){
		System.out.println("*******手 机 端******获取主界面按钮。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			List<AppButton> appButtonList = appButtonDao.getMainMobileButton(roleid);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取按钮成功！");
			mobileObj.setResults(appButtonList);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取按钮失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileButtonByParentid.post")
	@ResponseBody
	public JSONObject getMobileButtonByParentid(AppButton appButton){
		System.out.println("*******手 机 端******获取功能模块按钮。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			List<AppButton> appButtonList = appButtonDao.getMobileButtonByParentid(appButton);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取功能模块按钮成功！");
			mobileObj.setResults(appButtonList);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取功能模块按钮失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

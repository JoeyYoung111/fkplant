package com.szrj.business.web.mobileInterface;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.UserSession;
import com.aladdin.util.Md5Util;
import com.szrj.business.dao.LogDao;
import com.szrj.business.dao.UserDao;
import com.szrj.business.model.User;
import com.szrj.business.model.mobileInterface.MobileObj;
import com.szrj.business.model.mobileInterface.TestUserinfo;

@Controller
@SessionAttributes("userSession")
public class MobileUserController {
	@Autowired
	private UserDao userDao;
	@Autowired 
	private LogDao logDao;
	
	@RequestMapping("/getUserInfoById.post")
	@ResponseBody
	public JSONObject getUserInfoById(int id){
		TestUserinfo userinfo = new TestUserinfo();
		userinfo.setId(id);
		userinfo.setUsername("测试");
		userinfo.setRemark("测试");
		MobileObj mobileObj = new MobileObj();
		mobileObj.setCode(1);
		mobileObj.setMsg("操作成功");
		mobileObj.setResults(userinfo);
		JSONObject json = JSONObject.fromObject(mobileObj);
	    return json;
	}
	
	@RequestMapping("/getAllUserInfo.post")
	@ResponseBody
	public JSONObject getAllUserInfo(){
		List<TestUserinfo> userList = new ArrayList<TestUserinfo>();
		TestUserinfo userinfo = new TestUserinfo();
		userinfo.setId(1);
		userinfo.setUsername("测试");
		userinfo.setRemark("测试");
		userList.add(userinfo);
		TestUserinfo userinfo2 = new TestUserinfo();
		userinfo2.setId(2);
		userinfo2.setUsername("测试2");
		userinfo2.setRemark("测试2");
		userList.add(userinfo2);
		MobileObj mobileObj = new MobileObj();
		mobileObj.setCode(1);
		mobileObj.setMsg("操作成功");
		mobileObj.setResults(userList);
		JSONObject json = JSONObject.fromObject(mobileObj);
	    return json;
	}
	
	@RequestMapping("/loginUser.post")
	@ResponseBody
	public JSONObject loginUser(User user){
		System.out.println("*******手 机 端******系统登录验证。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			/*
			 * 1.检查该用户是否存在
			 * 2.检查密码是否正确
			 * 3.如果都对则记录当前登录信息
			 * */
			/*-------1.检查该用户是否存在-------*/
			int i = userDao.getUserInUse(user.getUsercode());
			if(i == 0){
				mobileObj.setCode(0);
				mobileObj.setMsg("登录失败，该用户不存在！");
			}else{
				/*-------2.检查密码是否正确-------*/
			    Md5Util md5 = new Md5Util();
                user.setUserpassword(md5.md5s(user.getUserpassword()));
				i = userDao.checkUserMsg(user);
				if(i == 0){
					mobileObj.setCode(0);
					mobileObj.setMsg("登录失败，密码错误！");
				}else{
					/*-------3.如果都对则记录当前登录信息-------*/
					User temp = userDao.getUserByCodeAndPwd(user);
					UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
					mobileObj.setCode(1);
					mobileObj.setMsg("登录成功！");
					mobileObj.setResults(userSession);
					SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String addtime=dateFormat.format(new Date());
					logDao.recordLog(0, "APP登录", userSession.getLoginUserName(), addtime, "登录成功", "账号："+temp.getUsercode()+" 部门:"+temp.getDepartname());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("登录验证失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileUserInfoById.post")
	@ResponseBody
	public JSONObject getMobileUserInfoById(int id){
		User user=userDao.getById(id);
		MobileObj mobileObj = new MobileObj();
		mobileObj.setCode(1);
		mobileObj.setMsg("获取当前用户信息成功");
		mobileObj.setResults(user);
		JSONObject json = JSONObject.fromObject(mobileObj);
	    return json;
	}
	
	@RequestMapping("/changeMobileUserPWD.post")
	@ResponseBody
	public JSONObject changeMobileUserPWD(User user){
		Md5Util md5 = new Md5Util();
		MobileObj mobileObj = new MobileObj();
		try {
			user.setUserpassword(md5.md5s(user.getUserpassword()));
			userDao.changePWD(user);
			mobileObj.setCode(1);
			mobileObj.setMsg("重置密码成功");
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("重置密码失败");
			
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
	    return json;
	}
}

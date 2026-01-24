package com.szrj.business.web.mobileInterface;

import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.Department;
import com.szrj.business.model.mobileInterface.MobileObj;
import com.szrj.business.model.personel.AttributeLabel;

@Controller
@SessionAttributes("userSession")
public class MobileUtilController {
	@Autowired
	private BasicMsgDao	basicMsgDao;
	@Autowired
	private DepartmentDao	departmentDao;
	@Autowired
	private PersonnelDao personnelDao;
	
	@RequestMapping("/getMobilebasicMsgJSON.post")
	@ResponseBody
	public JSONObject searchMobileEventsInfo(int basicType,MobileObj mobileObj){
		System.out.println("*******手 机 端******获取字典信息。。。。。");
		try {
			List<BasicMsg> bmList=basicMsgDao.getByType(basicType);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取字典信息成功！");
			mobileObj.setResults(bmList);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取字典信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileDepartmentTree.post")
	@ResponseBody
	public JSONObject getMobileDepartmentTree(Department department,MobileObj mobileObj){
		System.out.println("*******手 机 端******获取部门树。。。。。");
		try {
			List<Department> list1 = departmentDao.getDepartmentList(department);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取部门树成功！");
			mobileObj.setResults(list1);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取部门树失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getChildrenLabelByParentid.post")
	@ResponseBody
	public JSONObject getChildrenLabelByParentid(int parentid,MobileObj mobileObj){
		System.out.println("*******手 机 端******获取人员属性标签。。。。。");
		try {
			List<AttributeLabel> attributeLabelList=new ArrayList<AttributeLabel>();
			if (parentid>0) {
				attributeLabelList = personnelDao.getChildrenLabelByParentid(parentid);
			}else {
				attributeLabelList = personnelDao.searchAttributeLabelWithoutChildren();
			}
			mobileObj.setCode(1);
			mobileObj.setMsg("获取人员属性标签成功！");
			mobileObj.setResults(attributeLabelList);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取人员属性标签失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

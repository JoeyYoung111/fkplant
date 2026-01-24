package com.szrj.business.web.mobileInterface;

import java.util.List;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.AxisEvent;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.RoleDao;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.dao.event.DefuseInfoDao;
import com.szrj.business.dao.event.EventsInfoDao;
import com.szrj.business.dao.event.KeypersonnelDao;
import com.szrj.business.dao.event.LeadsInfoDao;
import com.szrj.business.dao.event.WorkInfoDao;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.model.Role;
import com.szrj.business.model.User;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.DefuseInfo;
import com.szrj.business.model.event.EventsInfo;
import com.szrj.business.model.event.Keypersonnel;
import com.szrj.business.model.event.LeadsInfo;
import com.szrj.business.model.event.WorkInfo;
import com.szrj.business.model.mobileInterface.MobileObj;
import com.szrj.business.model.personel.Personnel;

@Controller
@SessionAttributes("userSession")
public class MobileContradictionController {
	@Autowired
	private ContradictionInfoDao contradictionInfoDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private EventsInfoDao eventsInfoDao;
	@Autowired
	private LeadsInfoDao leadsInfoDao;
	@Autowired
	private KeypersonnelDao keypersonnelDao;
	@Autowired
	private PersonnelDao personnelDao;
	@Autowired
	private DefuseInfoDao defuseInfoDao;
	@Autowired
	private WorkInfoDao workInfoDao;
	
	@RequestMapping("/searchMobileContradictionInfo.post")
	@ResponseBody
	public JSONObject searchMobileContradictionInfo(ContradictionInfo contradictionInfo,User user,NewPageModel pm){
		System.out.println("*******手 机 端******获取风险事件。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			Role role = roleDao.getById(user.getRoleid());
			if(role.getEventFilter()==1){
				contradictionInfo.setRolefilterdept(user.getDepartmentid());
			}
			NewPageModel pagelist = contradictionInfoDao.searchContradictionInfo(contradictionInfo, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险事件成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险事件失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileContradictionInfoById.post")
	@ResponseBody
	public JSONObject searchMobileContradictionInfoById(int id){
		System.out.println("*******手 机 端******获取风险事件详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			ContradictionInfo contradictionInfo=contradictionInfoDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险事件详情成功！");
			mobileObj.setResults(contradictionInfo);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险事件详情失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileEventsInfo.post")
	@ResponseBody
	public JSONObject searchMobileEventsInfo(EventsInfo eventsInfo,NewPageModel pm){
		System.out.println("*******手 机 端******获取引发风险事件。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = eventsInfoDao.search(eventsInfo, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险事件成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险事件失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileEventsInfoById.post")
	@ResponseBody
	public JSONObject getMobileEventsInfoById(int id){
		System.out.println("*******手 机 端******获取引发风险事件。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			EventsInfo eventsInfo = eventsInfoDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前风险事件成功！");
			mobileObj.setResults(eventsInfo);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前风险事件失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileLeadsInfo.post")
	@ResponseBody
	public JSONObject searchMobileLeadsInfo(LeadsInfo leadsInfo,NewPageModel pm){
		System.out.println("*******手 机 端******获取情报线索。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = leadsInfoDao.search(leadsInfo, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取情报线索成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取情报线索失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileLeadsInfoById.post")
	@ResponseBody
	public JSONObject getMobileLeadsInfoById(int id){
		System.out.println("*******手 机 端******获取情报线索。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			LeadsInfo leadsInfo = leadsInfoDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前情报线索成功！");
			mobileObj.setResults(leadsInfo);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前情报线索失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileKeypersonnel.post")
	@ResponseBody
	public JSONObject searchMobileKeypersonnel(Keypersonnel keypersonnel,NewPageModel pm){
		System.out.println("*******手 机 端******获取矛盾主要组织人员。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = keypersonnelDao.search(keypersonnel, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取矛盾主要组织人员成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取矛盾主要组织人员失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileKeypersonnelById.post")
	@ResponseBody
	public JSONObject getMobileKeypersonnelById(int id){
		System.out.println("*******手 机 端******获取矛盾主要组织人员。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			Personnel personnel=personnelDao.getById(id);//获取基本信息
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前矛盾主要组织人员成功！");
			mobileObj.setResults(personnel);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前矛盾主要组织人员失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileDefuseInfo.post")
	@ResponseBody
	public JSONObject searchMobileDefuseInfo(DefuseInfo defuseInfo,NewPageModel pm){
		System.out.println("*******手 机 端******获取稳控化解情况。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = defuseInfoDao.search(defuseInfo, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取稳控化解情况成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取稳控化解情况失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileDefuseInfoById.post")
	@ResponseBody
	public JSONObject getMobileDefuseInfoById(int id){
		System.out.println("*******手 机 端******获取稳控化解情况。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			DefuseInfo defuseInfo = defuseInfoDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前稳控化解情况成功！");
			mobileObj.setResults(defuseInfo);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前稳控化解情况失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileTimeaxis.post")
	@ResponseBody
	public JSONObject searchMobileTimeaxis(ContradictionInfo contradictionInfo){
		System.out.println("*******手 机 端******获取矛盾时间轴。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			List<AxisEvent> axisTemp = contradictionInfoDao.searchTimeaxis(contradictionInfo);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取矛盾时间轴成功！");
			mobileObj.setResults(axisTemp);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取矛盾时间轴失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileWorkInfo.post")
	@ResponseBody
	public JSONObject searchMobileWorkInfo(WorkInfo workInfo,NewPageModel pm){
		System.out.println("*******手 机 端******获取工作交办列表。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = workInfoDao.search(workInfo, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取工作交办列表成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取工作交办列表失败！");
			mobileObj.setResults("");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileFeedback.post")
	@ResponseBody
	public JSONObject getMobileFeedback(int id){
		System.out.println("*******手 机 端******获取工作反馈详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			WorkInfo workInfo=workInfoDao.getFeedback(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取工作反馈详情成功！");
			if(workInfo!=null){
				System.out.println("---------测试----------");
				mobileObj.setResults(workInfo);
			}else{
				mobileObj.setResults("");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取工作反馈详情失败！");
			mobileObj.setResults("");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

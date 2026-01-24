package com.szrj.business.web.mobileInterface;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.UserSession;
import com.szrj.business.dao.UserDao;
import com.szrj.business.dao.personel.PersonnelExtendDao;
import com.szrj.business.dao.position.OrganizationDao;
import com.szrj.business.dao.position.PositionDao;
import com.szrj.business.model.User;
import com.szrj.business.model.personel.PersonnelExtend;
import com.szrj.business.model.position.Organization;
import com.szrj.business.model.position.Position;

@Controller
@SessionAttributes("userSession")
public class MobileZhengBaoController {
	@Autowired
	private UserDao userDao;
	@Autowired
	private PersonnelExtendDao extendDao;
	@Autowired
	private PositionDao	positionDao;
	@Autowired
	private OrganizationDao organizationDao;
	
	@RequestMapping("/searchZhengbaoPersonnel.post")
	@ResponseBody
	public JSONObject searchZhengbaoPersonnel(PersonnelExtend personnelExtend,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if(loginUserID>0){
				personnelExtend.setPersonlabelid(9);
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
				//是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
					case 1:
						personnelExtend.setUnitFilter(userSession.getLoginUserDepartmentid());//部门过滤
						break;
					case 2:
						personnelExtend.setPersonFilter(userSession.getLoginUserID());//民警过滤
						break;
					}	
				}
				String labelsql="";
				if (personnelExtend.getAttributelabels()!=null&!"".equals(personnelExtend.getAttributelabels())) {
					if (!personnelExtend.getAttributelabels().contains(",")) {
						if (labelsql!="")labelsql +=" AND ";
						labelsql += "FIND_IN_SET("+personnelExtend.getAttributelabels()+",pt.zslabel2)";
					}else {
						String[] attributes=personnelExtend.getAttributelabels().split(",");
						for (int i = 0; i < attributes.length; i++) {
							if(i>0)labelsql += " OR ";
							labelsql += "FIND_IN_SET("+attributes[i]+",pt.zslabel2)";
						}
					}
				}
				if(!"".equals(labelsql))personnelExtend.setLabelsql(labelsql);
				NewPageModel pagelist=extendDao.searchPersonnelExtend(personnelExtend, pm);
				result.put("code", 1);
				result.put("results", pagelist.getRows().toArray());
				result.put("currPage", pagelist.getPageNumber());
				result.put("totalPage", pagelist.getAllpagenum());
				result.put("totalSize", pagelist.getTotal());
			}else {
				result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchPosition.post")
	@ResponseBody
	public JSONObject searchPosition(Position position,NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
        try {
        	if(loginUserID>0){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
        		if(userSession.getLoginRoleMsgFilter()==1){
        			switch (userSession.getLoginRoleFieldFilter()) {
        			case 1:
        				position.setUnitFilter(userSession.getLoginUserDepartmentid());
        				break;
        			case 2:
        				position.setPersonFilter(userSession.getLoginUserID());
        				break;
        			}	
        		}
        		NewPageModel pagelist=positionDao.searchPosition(position, pm);
        		result.put("code", 1);
        		result.put("results", pagelist.getRows().toArray());
        		result.put("currPage", pagelist.getPageNumber());
        		result.put("totalPage", pagelist.getAllpagenum());
        		result.put("totalSize", pagelist.getTotal());
        	}else {
        		result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
	@RequestMapping("/searchOrganization.post")
	@ResponseBody
	public JSONObject searchOrganization(Organization organization, NewPageModel pm,int loginUserID){
		Map<String, Object> result = new HashMap<String, Object>();
        try {
        	if(loginUserID>0){
				User user=userDao.getById(loginUserID);
				User temp=userDao.getUserByCodeAndPwd(user);
				UserSession userSession = new UserSession(temp.getId(),temp.getUsercode(),temp.getStaffName(), temp.getRoleid(),temp.getDepartmentid(),temp.getDepartname(),temp.getMsgFilter(),temp.getFieldFilter(),temp.getContactnumber(),temp.getEventFilter(),temp.getCardnumber(),temp.getAlarmsignal(),temp.getDepartcode());
	        	//是否需要根据角色过滤
				if(userSession.getLoginRoleMsgFilter()==1){
					switch (userSession.getLoginRoleFieldFilter()) {
					case 1:
						organization.setUnitFilter(userSession.getLoginUserDepartmentid());
						break;
					case 2:
						organization.setPersonFilter(userSession.getLoginUserID());
						break;
					}	
				}
	        	NewPageModel pagelist= organizationDao.searchOrganization(organization, pm);
	        	result.put("code", 1);
	    		result.put("results", pagelist.getRows().toArray());
	    		result.put("currPage", pagelist.getPageNumber());
	    		result.put("totalPage", pagelist.getAllpagenum());
	    		result.put("totalSize", pagelist.getTotal());
	    	}else {
	    		result.put("code", 0);
				result.put("msg", "未输入用户ID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject json = JSONObject.fromObject(result);
	    return json;
	}
}

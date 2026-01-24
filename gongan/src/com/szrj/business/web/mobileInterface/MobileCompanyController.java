package com.szrj.business.web.mobileInterface;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.dao.company.YzdCheckDao;
import com.szrj.business.dao.company.YzdChemicalDao;
import com.szrj.business.dao.company.YzdChemistryDao;
import com.szrj.business.dao.company.YzdEquipmentDao;
import com.szrj.business.dao.company.YzdLicenceDao;
import com.szrj.business.dao.company.YzdMessengerDao;
import com.szrj.business.model.company.Company;
import com.szrj.business.model.company.YzdCheck;
import com.szrj.business.model.company.YzdChemical;
import com.szrj.business.model.company.YzdChemistry;
import com.szrj.business.model.company.YzdEquipment;
import com.szrj.business.model.company.YzdLicence;
import com.szrj.business.model.company.YzdMessenger;
import com.szrj.business.model.mobileInterface.MobileObj;

@Controller
@SessionAttributes("userSession")
public class MobileCompanyController {
	@Autowired
	private CompanyDao companyDao;
	@Autowired
	private YzdLicenceDao licenceDao;
	@Autowired
	private YzdChemicalDao chemicalDao;
	@Autowired
	private YzdMessengerDao messengerDao;
	@Autowired
	private YzdChemistryDao chemistryDao;
	@Autowired
	private YzdEquipmentDao equipmentDao;
	@Autowired
	private YzdCheckDao checkDao;
	
	@RequestMapping("/searchMobileCompany.post")
	@ResponseBody
	public JSONObject searchMobileCompany(Company company,NewPageModel pm){
		System.out.println("*******手 机 端******获取风险地址。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = companyDao.searchCompany(company, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险地址成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pagelist.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险地址失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileCompanyById.post")
	@ResponseBody
	public JSONObject getMobileCompanyById(int id){
		System.out.println("*******手 机 端******获取风险地址详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			Company company = companyDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前风险地址成功！");
			mobileObj.setResults(company);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前风险地址失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileLicence.post")
	@ResponseBody
	public JSONObject searchMobileLicence(YzdLicence licence,NewPageModel pm){
		System.out.println("*******手 机 端******获取许可证信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = licenceDao.searchLicence(licence, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取许可证信息成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取许可证信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileLicenceById.post")
	@ResponseBody
	public JSONObject getMobileLicenceById(int id){
		System.out.println("*******手 机 端******获取许可证信息详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdLicence licence = licenceDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前许可证信息成功！");
			mobileObj.setResults(licence);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前许可证信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileChemical.post")
	@ResponseBody
	public JSONObject searchMobileChemical(YzdChemical chemical,NewPageModel pm){
		System.out.println("*******手 机 端******获取化学品种类。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = chemicalDao.searchYzdChemical(chemical, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取化学品种类成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取化学品种类失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileChemicalById.post")
	@ResponseBody
	public JSONObject getMobileChemicalById(int id){
		System.out.println("*******手 机 端******获取化学品种类详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdChemical chemical = chemicalDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前化学品种类成功！");
			mobileObj.setResults(chemical);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前化学品种类失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileMessenger.post")
	@ResponseBody
	public JSONObject searchMobileMessenger(YzdMessenger messenger,NewPageModel pm){
		System.out.println("*******手 机 端******获取办证人员信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = messengerDao.searchYzdMessenger(messenger, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取办证人员信息成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取办证人员信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileMessengerById.post")
	@ResponseBody
	public JSONObject getMobileMessengerById(int id){
		System.out.println("*******手 机 端******获取办证人员信息详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdMessenger messenger = messengerDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前办证人员信息成功！");
			mobileObj.setResults(messenger);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前办证人员信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileChemistry.post")
	@ResponseBody
	public JSONObject searchMobileChemistry(YzdChemistry chemistry,NewPageModel pm){
		System.out.println("*******手 机 端******获取从业人员信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = chemistryDao.searchYzdChemistry(chemistry, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取从业人员信息成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取从业人员信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileChemistryById.post")
	@ResponseBody
	public JSONObject getMobileChemistryById(int id){
		System.out.println("*******手 机 端******获取从业人员信息详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdChemistry chemistry = chemistryDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前从业人员信息成功！");
			mobileObj.setResults(chemistry);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前从业人员信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileEquipment.post")
	@ResponseBody
	public JSONObject searchMobileEquipment(YzdEquipment equipment,NewPageModel pm){
		System.out.println("*******手 机 端******获取设备基本信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = equipmentDao.searchYzdEquipment(equipment, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取设备基本信息成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取设备基本信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileEquipmentById.post")
	@ResponseBody
	public JSONObject getMobileEquipmentById(int id){
		System.out.println("*******手 机 端******获取设备基本信息详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdEquipment equipment = equipmentDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前设备基本信息成功！");
			mobileObj.setResults(equipment);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前设备基本信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/searchMobileCheck.post")
	@ResponseBody
	public JSONObject searchMobileCheck(YzdCheck check,NewPageModel pm){
		System.out.println("*******手 机 端******获取单位核查记录。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = checkDao.searchYzdCheck(check, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取单位核查记录成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取单位核查记录失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileCheckById.post")
	@ResponseBody
	public JSONObject getMobileCheckById(int id){
		System.out.println("*******手 机 端******获取设备基本信息详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			YzdCheck check = checkDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前设备基本信息成功！");
			mobileObj.setResults(check);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前设备基本信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

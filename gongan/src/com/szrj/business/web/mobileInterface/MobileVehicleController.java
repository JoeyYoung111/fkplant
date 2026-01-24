package com.szrj.business.web.mobileInterface;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.VehicleDao;
import com.szrj.business.model.company.Vehicle;
import com.szrj.business.model.mobileInterface.MobileObj;

@Controller
@SessionAttributes("userSession")
public class MobileVehicleController {
	@Autowired
	private VehicleDao vehicleDao;
	
	@RequestMapping("/searchMobileVehicle.post")
	@ResponseBody
	public JSONObject searchMobileVehicle(Vehicle vehicle,NewPageModel pm){
		System.out.println("*******手 机 端******获取风险车辆基本信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = vehicleDao.searchVehicle(vehicle, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险车辆基本信息成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险车辆基本信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileVehicleById.post")
	@ResponseBody
	public JSONObject getMobileVehicleById(int id){
		System.out.println("*******手 机 端******获取风险车辆基本信息。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			Vehicle vehicle = vehicleDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前风险车辆基本信息成功！");
			mobileObj.setResults(vehicle);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前风险车辆基本信息失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

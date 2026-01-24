package com.szrj.business.web.mobileInterface;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.goods.DangerousItemDao;
import com.szrj.business.model.goods.DangerousItem;
import com.szrj.business.model.mobileInterface.MobileObj;

@Controller
@SessionAttributes("userSession")
public class MobileGoodsController {
	@Autowired
	private DangerousItemDao dangerousItemDao;
	
	@RequestMapping("/searchMobileDangerousItem.post")
	@ResponseBody
	public JSONObject searchMobileDangerousItem(DangerousItem dangerousItem,NewPageModel pm){
		System.out.println("*******手 机 端******获取风险物品。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			NewPageModel pagelist = dangerousItemDao.search(dangerousItem, pm);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取风险物品成功！");
			mobileObj.setTotalPage(pagelist.getAllpagenum());
			mobileObj.setTotalSize(pagelist.getTotal());
			mobileObj.setResults(pagelist.getRows().toArray());
			mobileObj.setCurrPage(pm.getPageNumber());
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取风险物品失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
	
	@RequestMapping("/getMobileDangerousItemById.post")
	@ResponseBody
	public JSONObject getMobileDangerousItemById(int id){
		System.out.println("*******手 机 端******获取风险物品详情。。。。。");
		MobileObj mobileObj = new MobileObj();
		try {
			DangerousItem dangerousItem = dangerousItemDao.getById(id);
			mobileObj.setCode(1);
			mobileObj.setMsg("获取当前风险物品成功！");
			mobileObj.setResults(dangerousItem);
		} catch (Exception e) {
			e.printStackTrace();
			mobileObj.setCode(0);
			mobileObj.setMsg("获取当前风险物品失败！");
		}
		JSONObject json = JSONObject.fromObject(mobileObj);
		return json;
	}
}

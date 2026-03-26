package com.szrj.business.web.openapi;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.dao.personel.PersonnelPhotoDao;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.PersonnelPhoto;

/**
 * 开放接口 - 人员头像查询（无需登录验证）
 * 使用 .post 映射，绕过 sessionFilter（sessionFilter 仅拦截 *.do）
 */
@Controller
public class PersonnelPhotoOpenController {

	@Autowired
	private PersonnelDao personnelDao;

	@Autowired
	private PersonnelPhotoDao photoDao;

	private
	@Value("#{configProperties.uploadFile_Pricture}")
	String uploadFile_Pricture;	//图片上传根路径

	private
	@Value("#{configProperties.uploadFile}")
	String uploadFile;	//文件上传根路径

	/**
	 * 根据身份证号查询人员默认头像文件地址
	 * 接口地址: /getPhotoByCardnumber.post?cardnumber=身份证号
	 * 无需登录验证，可直接访问
	 *
	 * @param cardnumber 身份证号
	 */
	@RequestMapping("/getPhotoByCardnumber.post")
	public void getPhotoByCardnumber(String cardnumber, HttpServletResponse response) {
		System.out.println("/getPhotoByCardnumber.post------------------------cardnumber=" + cardnumber);
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			// 参数校验
			if (cardnumber == null || "".equals(cardnumber.trim())) {
				result.put("code", 0);
				result.put("msg", "身份证号不能为空");
				writeJson(response, result);
				return;
			}

			// 根据身份证号查询人员信息
			Personnel personnel = personnelDao.getPersonnelByCardnumber(cardnumber.trim());
			if (personnel == null) {
				result.put("code", 0);
				result.put("msg", "未找到该身份证号对应的人员信息");
				writeJson(response, result);
				return;
			}

			// 根据人员ID查询照片列表
			List<PersonnelPhoto> photoList = photoDao.getByPersonnelid(personnel.getId());
			if (photoList == null || photoList.size() == 0) {
				result.put("code", 0);
				result.put("msg", "该人员未上传头像");
				writeJson(response, result);
				return;
			}

			// 查找默认头像（defaultflag=1），如果没有默认头像则取第一张（列表已按defaultflag desc排序）
			PersonnelPhoto defaultPhoto = photoList.get(0);
			for (PersonnelPhoto photo : photoList) {
				if (photo.getDefaultflag() == 1) {
					defaultPhoto = photo;
					break;
				}
			}

			// 拼接头像文件完整路径
			String photoUrl;
			if (defaultPhoto.getValidflag() > 1) {
				photoUrl = uploadFile + "/" + defaultPhoto.getFileallName();
			} else {
				photoUrl = uploadFile_Pricture + "/" + defaultPhoto.getFileallName();
			}
			photoUrl = photoUrl.replace("\\", "/");

			result.put("code", 1);
			result.put("msg", "查询成功");
			result.put("photoUrl", photoUrl);
			result.put("fileName", defaultPhoto.getFileName());
			result.put("fileallName", defaultPhoto.getFileallName());
			result.put("personnelid", personnel.getId());
			result.put("photoCount", photoList.size());

		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", 0);
			result.put("msg", "查询失败：" + e.getMessage());
		}
		writeJson(response, result);
	}

	/**
	 * 手动写出JSON响应，绕过Spring内容协商机制
	 */
	private void writeJson(HttpServletResponse response, Map<String, Object> data) {
		response.setContentType("application/json;charset=UTF-8");
		try {
			PrintWriter writer = response.getWriter();
			writer.write(JSONObject.fromObject(data).toString());
			writer.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}


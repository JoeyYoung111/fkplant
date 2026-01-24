package com.szrj.business.dao.personel;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.MapModel;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.CustomLabel;
import com.szrj.business.model.personel.CustomText;
import com.szrj.business.model.personel.PersonLabel;
import com.szrj.business.model.personel.Personnel;

public interface PersonnelDao {
	/**
	 * 根据id获取风险人员基本信息主表
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public Personnel getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Personnel personnel) throws DataAccessException;
	
	/**
	 * @param cardnumber  身份证是否已存在
	 * @return  id
	 * @throws DataAccessException
	 */
	public int findPersonInPersonnel(String cardnumber) throws DataAccessException;
	
	/**
	 * 修改
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public int update(Personnel personnel) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(Personnel personnel) throws DataAccessException;
	/**
	 * @param cardnumber  根据身份证号获取最新风险人信息
	 * @return  id
	 * @throws DataAccessException
	 */
	public Personnel getPersonnelByCardnumber(String cardnumber) throws DataAccessException;
	
	/**
	 * 综合查询
	 * @param personnel
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel getAllPersonnel(Personnel personnel,NewPageModel pm) throws DataAccessException;
	public int countAllPersonnel(Personnel personnel) throws DataAccessException;
	public NewPageModel getWholePersonnel(Personnel personnel,NewPageModel pm) throws DataAccessException;
	public List<MapModel> countAllMapPersonnel() throws DataAccessException;
	public List<MapModel> countAllTrendPersonnel() throws DataAccessException;
	public List<MapModel> countAllpersonAndAllevent() throws DataAccessException;
	public List<MapModel> countAllAddByAddtime() throws DataAccessException;
	
	/**
	 * 根据在控状态获取人员
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public List<Personnel> getPersonInfoByIncontrollevel(Personnel personnel) throws DataAccessException;
	
	/**
	 * 根据联控级别获取人员计数
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public int getCountByJointcontrollevel(Personnel personnel) throws DataAccessException;
	public List<SelectModel> getAllCountByIncontrollevel(String levelString) throws DataAccessException;
	public List<SelectModel> getAllCountByJointcontrollevel(String levelString) throws DataAccessException;
	public List<SelectModel> getAllCountByAttributelabel(String levelString) throws DataAccessException;
	
	/**
	 * 根据派出所分联控等级查询人数
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public List<Integer> getPCSCountByJointcontrollevel(Personnel personnel) throws DataAccessException;
	
	/**
	 * 根据责任警种查询人数
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public List<PieModel> countPersonByResponsiblepolice(Personnel personnel) throws DataAccessException;
	
	/**
	 * 拓展风险事件主要关联人员
	 * @param cdtid
	 * @return
	 * @throws DataAccessException
	 */
	public List<Personnel> expandFxsjPerson(int cdtid) throws DataAccessException;
	/**
	 * 人员属性标签 查询、新增、修改、删除
	 * @return
	 * @throws DataAccessException
	 */
	public List<AttributeLabel> searchAttributeLabel()throws DataAccessException;
	public List<AttributeLabel> searchAttributeLabelWithoutChildren()throws DataAccessException;
	public List<AttributeLabel> searchAllAttributeLabel()throws DataAccessException;
	public List<AttributeLabel> searchAttributeLabelBySearch(String searchtext)throws DataAccessException;
	public int addattributelabel(AttributeLabel attributelabel) throws DataAccessException;
	public int updateattributelabel(AttributeLabel attributelabel) throws DataAccessException;
	public int cancelattributelabel(AttributeLabel attributelabel) throws DataAccessException;
	public AttributeLabel getAttributeLabelByid(int id) throws DataAccessException;
	public List<AttributeLabel> getAttributeLabelByids(String attributelabel)throws DataAccessException;
	public List<AttributeLabel> getAttributeLabelByParentid(int parentid)throws DataAccessException;
	public List<AttributeLabel> getChildrenLabelByParentid(int parentid)throws DataAccessException;
	public List<AttributeLabel> getChildrenLabelByParentid1(int parentid)throws DataAccessException;
	public int examineattributelabel(AttributeLabel attributelabel) throws DataAccessException;
	public List<AttributeLabel> getAttributeLabelByDepartmentid(AttributeLabel attributelabel)throws DataAccessException;
	public String getAttributeLabelnoexamine(AttributeLabel attributelabel)throws DataAccessException;
	public String selectParentIds(HashMap map)throws DataAccessException;
	public List<AttributeLabel> getAttributeLabelbyids(String ids)throws DataAccessException;
	public List<AttributeLabel> getAttributeLabelbyRootid(int rootid)throws DataAccessException;
	public String getUserCodeForSendChat(Integer id) throws DataAccessException;
	public int updaterootid(AttributeLabel attributelabel) throws DataAccessException;
	public String getContentSendChat(Integer id) throws DataAccessException;
	/**
	 * 警种类型标签 查询、新增、修改、删除
	 * @return
	 * @throws DataAccessException
	 */
	public List<PersonLabel> searchPersonLabel()throws DataAccessException;
	public int addpersonlabel(PersonLabel personlabel) throws DataAccessException;
	public int updatepersonlabel(PersonLabel personlabel) throws DataAccessException;
	public int cancelpersonlabel(PersonLabel personlabel) throws DataAccessException;
	public PersonLabel getPersonLabelByid(int id) throws DataAccessException;
	public int updateattributelabels(PersonLabel personlabel) throws DataAccessException;
	public PersonLabel getPersonLabelsByAttributesql(String attributesql) throws DataAccessException;
	/**
	 * 人员自定义标签 查询、新增、修改、删除
	 * @return
	 * @throws DataAccessException
	 */
	public List<CustomLabel> searchCustomLabel(CustomLabel customlabel)throws DataAccessException;
	public int addcustomlabel(CustomLabel customlabel) throws DataAccessException;
	public int updatecustomlabel(CustomLabel customlabel) throws DataAccessException;
	public int cancelcustomlabel(CustomLabel customlabel) throws DataAccessException;
	public CustomLabel getCustomLabelByid(int id) throws DataAccessException;
	/**
	 * 人员自定义档案 查询、新增、修改、删除
	 * @return
	 * @throws DataAccessException
	 */
	public List<CustomText> searchCustomtext(CustomText customtext)throws DataAccessException;
	public int addcustomtext(CustomText customtext) throws DataAccessException;
	public int updatecustomtext(CustomText customtext) throws DataAccessException;
	public int cancelcustomtext(CustomText customtext) throws DataAccessException;
	public CustomText getCustomtextByid(int id) throws DataAccessException;
	public int getCustomtextidBypersonnelid(int personnelid) throws DataAccessException;
	/**
	 * 更新人员标签
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public int updateAllPersonLabel(Personnel personnel) throws DataAccessException;
	public int updateCheckedPersonLabel(Personnel personnel) throws DataAccessException;
	public int updateSK(Personnel personnel) throws DataAccessException;
	public int updateSX(Personnel personnel) throws DataAccessException;
	
	/**
	 * 风险从业人员
	 */
	public NewPageModel searchCyPerson(Personnel personnel,NewPageModel pm) throws DataAccessException;
	
	public int addCyPerson(Personnel personnel) throws DataAccessException;
	
	public int updateCyPersonRisk(Personnel personnel) throws DataAccessException;
	/**
	 * 治安人员
	 */
	public NewPageModel searchZaPersonnel(Personnel personnel,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 政法委审查
	 */
	public NewPageModel searchZfwPersonnel(Personnel personnel,NewPageModel pm) throws DataAccessException;
	public Personnel getZfwPersonById(int id) throws DataAccessException;
	public int updateZfwPerson(Personnel personnel) throws DataAccessException;
	public int addZfwPerson(Personnel personnel) throws DataAccessException;

	/**
	 * 更新人员现住地址
	 */
	public int updateHomeAddress(Personnel personnel) throws DataAccessException;

	/**
	 * 更新人员手机号码
	 */
	public int updatePhone(Personnel personnel) throws DataAccessException;

	/**
	 * 更新涉赌前科标记
	 */
	public int updateHasSheduRecord(Personnel personnel) throws DataAccessException;

	/**
	 * 更新涉黄前科标记
	 */
	public int updateHasSechangRecord(Personnel personnel) throws DataAccessException;

	/**
	 * 获取住址历史记录
	 */
	public NewPageModel getHomeplaceHistory(int personnelid, NewPageModel pm) throws DataAccessException;

	/**
	 * 获取电话历史记录
	 */
	public NewPageModel getPhoneHistory(int personnelid, NewPageModel pm) throws DataAccessException;
}

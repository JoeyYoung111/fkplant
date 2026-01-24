package com.szrj.business.impl.personel;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.MapModel;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.personel.PersonnelDao;
import com.szrj.business.model.personel.AttributeLabel;
import com.szrj.business.model.personel.CustomLabel;
import com.szrj.business.model.personel.CustomText;
import com.szrj.business.model.personel.PersonLabel;
import com.szrj.business.model.personel.Personnel;

public class PersonnelDaoImpl extends BaseDaoiBatis implements PersonnelDao {

	public Personnel getPersonnelByCardnumber(String cardnumber)
			throws DataAccessException {
		return (Personnel)getSqlMapClientTemplate().queryForObject("personnel.getPersonnelByCardnumber", cardnumber);
	}

	public int add(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.add", personnel);
	}

	public int cancel(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.cancel", personnel);
	}

	public int findPersonInPersonnel(String cardnumber)
			throws DataAccessException {
		return  (Integer)getSqlMapClientTemplate().queryForObject("personnel.findPersonInPersonnel", cardnumber);
	}

	public Personnel getById(int id) throws DataAccessException {
		return (Personnel)getSqlMapClientTemplate().queryForObject("personnel.getById", id);
	}

	public int update(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.update", personnel);
	}

	public int countAllPersonnel(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("personnel.getAllPersonnel_count", personnel);
	}
	public NewPageModel getAllPersonnel(Personnel personnel, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.getAllPersonnel_count", personnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.getAllPersonnel", personnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public NewPageModel getWholePersonnel(Personnel personnel, NewPageModel pm)
		throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.getWholePersonnel_count", personnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.getWholePersonnel", personnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public int addcustomlabel(CustomLabel customlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addcustomlabel", customlabel);
	}

	public int addpersonlabel(PersonLabel personlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addpersonlabel", personlabel);
	}

	public int cancelcustomlabel(CustomLabel customlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.cancelcustomlabel", customlabel);
	}

	public int cancelpersonlabel(PersonLabel personlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.cancelpersonlabel", personlabel);
	}

	@SuppressWarnings("unchecked")
	public List<CustomLabel> searchCustomLabel(CustomLabel customlabel) throws DataAccessException {
		return  (List<CustomLabel>)getSqlMapClientTemplate().queryForList("personnel.searchCustomLabel",customlabel);
	}

	@SuppressWarnings("unchecked")
	public List<PersonLabel> searchPersonLabel() throws DataAccessException {
		return  (List<PersonLabel>)getSqlMapClientTemplate().queryForList("personnel.searchPersonLabel");
	}

	public int updatecustomlabel(CustomLabel customlabel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updatecustomlabel", customlabel);
	}

	public int updatepersonlabel(PersonLabel personlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updatepersonlabel", personlabel);
	}

	public CustomLabel getCustomLabelByid(int id) throws DataAccessException {
		return  (CustomLabel)getSqlMapClientTemplate().queryForObject("personnel.getCustomLabelByid", id);
	}

	public PersonLabel getPersonLabelByid(int id) throws DataAccessException {
		return  (PersonLabel)getSqlMapClientTemplate().queryForObject("personnel.getPersonLabelByid", id);
	}

	@SuppressWarnings("unchecked")
	public List<Personnel> getPersonInfoByIncontrollevel(Personnel personnel) throws DataAccessException {
		return  (List<Personnel>)getSqlMapClientTemplate().queryForList("wenGrade.getPersonInfoByIncontrollevel", personnel);
	}

	public int getCountByJointcontrollevel(Personnel personnel) throws DataAccessException {
		return  (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.getCountByJointcontrollevel", personnel);
	}

	@SuppressWarnings("unchecked")
	public List<MapModel> countAllMapPersonnel() throws DataAccessException {
		return  (List<MapModel>)getSqlMapClientTemplate().queryForList("personnel.countAllMapPersonnel");
	}

	@SuppressWarnings("unchecked")
	public List<MapModel> countAllTrendPersonnel() throws DataAccessException {
		return  (List<MapModel>)getSqlMapClientTemplate().queryForList("personnel.countAllTrendPersonnel");
	}

	@SuppressWarnings("unchecked")
	public List<MapModel> countAllpersonAndAllevent() throws DataAccessException {
		return  (List<MapModel>)getSqlMapClientTemplate().queryForList("personnel.countAllpersonAndAllevent");
	}
	public List<MapModel> countAllAddByAddtime() throws DataAccessException {
		return  (List<MapModel>)getSqlMapClientTemplate().queryForList("personnel.countAllAddByAddtime");
	}
	public List<SelectModel> getAllCountByIncontrollevel(String levelString) throws DataAccessException {
		return  (List<SelectModel>)getSqlMapClientTemplate().queryForList("wenGrade.getAllCountByIncontrollevel", levelString);
	}
	public List<SelectModel> getAllCountByJointcontrollevel(String levelString) throws DataAccessException {
		return  (List<SelectModel>)getSqlMapClientTemplate().queryForList("wenGrade.getAllCountByJointcontrollevel", levelString);
	}
	public List<SelectModel> getAllCountByAttributelabel(String levelString) throws DataAccessException {
		return  (List<SelectModel>)getSqlMapClientTemplate().queryForList("wenGrade.getAllCountByAttributelabel", levelString);
	}
	
	public List<Integer> getPCSCountByJointcontrollevel(Personnel personnel) throws DataAccessException {
		return  (List<Integer>)getSqlMapClientTemplate().queryForList("wenGrade.getPCSCountByJointcontrollevel", personnel);
	}

	public List<PieModel> countPersonByResponsiblepolice(Personnel personnel) throws DataAccessException {
		return  (List<PieModel>)getSqlMapClientTemplate().queryForList("wenGrade.countPersonByResponsiblepolice",personnel);
	}

	public int addattributelabel(AttributeLabel attributelabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addattributelabel", attributelabel);
	}

	public int cancelattributelabel(AttributeLabel attributelabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.cancelattributelabel", attributelabel);
	}

	public AttributeLabel getAttributeLabelByid(int id)
			throws DataAccessException {
		return  (AttributeLabel)getSqlMapClientTemplate().queryForObject("personnel.getAttributeLabelByid", id);
	}
	public PersonLabel getPersonLabelsByAttributesql(String attributesql)
	throws DataAccessException {
		return  (PersonLabel)getSqlMapClientTemplate().queryForObject("personnel.getPersonLabelsByAttributesql", attributesql);
	}

	public List<AttributeLabel> searchAttributeLabel()
			throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.searchAttributeLabel");
	}
	public List<AttributeLabel> searchAttributeLabelWithoutChildren()
	throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.searchAttributeLabelWithoutChildren");
	}
	public List<AttributeLabel> searchAllAttributeLabel()
	throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.searchAllAttributeLabel");
	}
	public List<AttributeLabel> searchAttributeLabelBySearch(String searchtext)
	throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.searchAttributeLabelBySearch",searchtext);
	}

	public int updateattributelabel(AttributeLabel attributelabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateattributelabel", attributelabel);
	}
	public int examineattributelabel(AttributeLabel attributelabel)throws DataAccessException {
       return (Integer)getSqlMapClientTemplate().update("personnel.examineattributelabel", attributelabel);
    }
	public List<AttributeLabel> getAttributeLabelByids(String attributelabel)
		     throws DataAccessException {
	     return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getAttributeLabelByids",attributelabel);
	}
	
	public int updateattributelabels(PersonLabel personlabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateattributelabels", personlabel);
	}
	
	@SuppressWarnings("unchecked")
	public List<Personnel> expandFxsjPerson(int cdtid) throws DataAccessException {
		return  (List<Personnel>)getSqlMapClientTemplate().queryForList("personnel.expandFxsjPerson",cdtid);
	}

	@SuppressWarnings("unchecked")
	public List<AttributeLabel> getAttributeLabelByParentid(int parentid) throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getAttributeLabelByParentid",parentid);
	}

	@SuppressWarnings("unchecked")
	public List<AttributeLabel> getChildrenLabelByParentid(int parentid) throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getChildrenLabelByParentid",parentid);
	}
	@SuppressWarnings("unchecked")
	public List<AttributeLabel> getChildrenLabelByParentid1(int parentid) throws DataAccessException {
		return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getChildrenLabelByParentid1",parentid);
	}
	public int updateAllPersonLabel(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateAllPersonLabel", personnel);
	}
	
	@SuppressWarnings("unchecked")
	public List<AttributeLabel> getAttributeLabelByDepartmentid(AttributeLabel attributelabel)throws DataAccessException{
		 return  (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getAttributeLabelByDepartmentid",attributelabel);
	}

	public int updateCheckedPersonLabel(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateCheckedPersonLabel", personnel);
	}

	public String getAttributeLabelnoexamine(AttributeLabel attributelabel) throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("personnel.getAttributeLabelnoexamine",attributelabel);
	}

	@SuppressWarnings("unchecked")
	public List<AttributeLabel> getAttributeLabelbyids(String ids) throws DataAccessException {
		return (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getAttributeLabelbyids",ids);
	}

	public String selectParentIds(HashMap map) throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("personnel.selectParentIds", map);
	}

	public String getUserCodeForSendChat(Integer id) throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("personnel.getUserCodeForSendChat",id);
	}

	public int updaterootid(AttributeLabel attributelabel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updaterootid", attributelabel);
	}

	public String getContentSendChat(Integer id) throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("personnel.getContentSendChat",id);
	}

	public int updateSK(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateSK", personnel);
	}
	public int updateSX(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateSX", personnel);
	}

	public List<AttributeLabel> getAttributeLabelbyRootid(int rootid)
			throws DataAccessException {
		return (List<AttributeLabel>)getSqlMapClientTemplate().queryForList("personnel.getAttributeLabelbyRootid",rootid);
	}

	public int addcustomtext(CustomText customtext) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addcustomtext", customtext);
	}

	public int cancelcustomtext(CustomText customtext)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.cancelcustomtext", customtext);
	}

	public CustomText getCustomtextByid(int id) throws DataAccessException {
		return (CustomText)getSqlMapClientTemplate().queryForObject("personnel.getCustomtextByid", id);
	}

	public int getCustomtextidBypersonnelid(int personnelid)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("personnel.getCustomtextidBypersonnelid", personnelid);
	}

	public List<CustomText> searchCustomtext(CustomText customtext) throws DataAccessException {
		return null;
	}

	public int updatecustomtext(CustomText customtext) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updatecustomtext", customtext);
	}

	public NewPageModel searchCyPerson(Personnel personnel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.searchCyPerson_count", personnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.searchCyPerson", personnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int addCyPerson(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addCyPerson", personnel);
	}

	public NewPageModel searchZaPersonnel(Personnel personnel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.searchZaPersonnel_count", personnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.searchZaPersonnel", personnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateCyPersonRisk(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateCyPersonRisk", personnel);
	}

	public NewPageModel searchZfwPersonnel(Personnel personnel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.searchZfwPersonnel_count", personnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.searchZfwPersonnel", personnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public Personnel getZfwPersonById(int id) throws DataAccessException {
		return (Personnel)getSqlMapClientTemplate().queryForObject("personnel.getZfwPersonById", id);
	}

	public int updateZfwPerson(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateZfwPerson", personnel);
	}

	public int addZfwPerson(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnel.addZfwPerson", personnel);
	}

	public int updateHomeAddress(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateHomeAddress", personnel);
	}

	public int updatePhone(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updatePhone", personnel);
	}

	public int updateHasSheduRecord(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateHasSheduRecord", personnel);
	}

	public int updateHasSechangRecord(Personnel personnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnel.updateHasSechangRecord", personnel);
	}

	@SuppressWarnings("unchecked")
	public NewPageModel getHomeplaceHistory(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.getHomeplaceHistory_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.getHomeplaceHistory", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public NewPageModel getPhoneHistory(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnel.getPhoneHistory_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnel.getPhoneHistory", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
}

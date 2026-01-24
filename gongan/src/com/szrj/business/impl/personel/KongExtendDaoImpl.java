package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.personel.KongExtendDao;
import com.szrj.business.model.personel.KongDailyControl;
import com.szrj.business.model.personel.KongExtend;


public class KongExtendDaoImpl extends BaseDaoiBatis implements KongExtendDao{

	public int add(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongextend.add", kongextend);
	}

	public int cancel(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.cancel", kongextend);
	}

	public NewPageModel searchKongPersonnel(KongExtend kongextend, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongextend.searchKongPersonnel_count", kongextend);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongextend.searchKongPersonnel", kongextend, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> searchKongPersonnelList(KongExtend kongextend) throws DataAccessException {
		return  (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.exportKongPersonnel", kongextend);
	}

	public int updateJSGK(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updateJSGK", kongextend);
	}

	public int updateKYTZ(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updateKYTZ", kongextend);
	}

	public int updateZP(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updateZP", kongextend);
	}

	public KongExtend getKongExtendById(int id) throws DataAccessException {
		return  (KongExtend) getSqlMapClientTemplate().queryForObject("kongextend.getKongExtendById", id);
	}

	public KongExtend getKongExtendBypersonnelid(int personnelid)
			throws DataAccessException {
		return  (KongExtend) getSqlMapClientTemplate().queryForObject("kongextend.getKongExtendBypersonnelid", personnelid);
	}

	public int updatecontroltime(KongExtend kongextend)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updatecontroltime", kongextend);
	}

	public int updateincontrollevel(KongExtend kongextend)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updateincontrollevel", kongextend);
	}

	public NewPageModel searchKongDailyControl(
			KongDailyControl kongdailycontrol, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongextend.searchdailycontrol_count", kongdailycontrol);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongextend.searchdailycontrol", kongdailycontrol, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int addkongdailycontrol(KongDailyControl kongdailycontrol)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongextend.addkongdailycontrol", kongdailycontrol);
	}

	public KongDailyControl searchdailycontrolbyid(int id)
			throws DataAccessException {
		return  (KongDailyControl) getSqlMapClientTemplate().queryForObject("kongextend.searchdailycontrolbyid", id);
	}

	public int cancelkongdailycontrol(KongDailyControl kongdailycontrol)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.cancelkongdailycontrol", kongdailycontrol);
	}

	public int updatekongdailycontrol(KongDailyControl kongdailycontrol)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updatekongdailycontrol", kongdailycontrol);
	}

	@SuppressWarnings("unchecked")
	public List<KongDailyControl> searchDailycontrolByControltype(KongDailyControl kongdailycontrol) throws DataAccessException {
		return (List<KongDailyControl>)getSqlMapClientTemplate().queryForList("kongextend.searchDailycontrolByControltype",kongdailycontrol);
	}

	public KongExtend exportPersonnelById(KongExtend kongextend) throws DataAccessException {
		return  (KongExtend) getSqlMapClientTemplate().queryForObject("kongextend.exportPersonnelById", kongextend);
	}


	public List<KongDailyControl> getNewDailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException {
		return (List<KongDailyControl>) getSqlMapClientTemplate().queryForList("kongextend.getNewDailycontrol",kongdailycontrol);
	}

	public List<KongDailyControl> exportAllDailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException{
		return (List<KongDailyControl>) getSqlMapClientTemplate().queryForList("kongextend.exportAllDailycontrol",kongdailycontrol);
	}
	
	public NewPageModel getAllDailycontrol(KongDailyControl kongdailycontrol,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongextend.getAllDailycontrol_count", kongdailycontrol);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongextend.getAllDailycontrol", kongdailycontrol, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> countpersonByJointtype() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.countpersonByJointtype");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countDistpersonByJointtype() throws DataAccessException {
		return (List<SelectModel>) getSqlMapClientTemplate().queryForList("kongextend.countDistpersonByJointtype");
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> countpersonByNativeplace() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.countpersonByNativeplace");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countDistpersonByNativeplace() throws DataAccessException {
		return (List<SelectModel>) getSqlMapClientTemplate().queryForList("kongextend.countDistpersonByNativeplace");
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> countpersonByPolice() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.countpersonByPolice");
	}

	public int reduction(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.reduction", kongextend);
	}

	public int tz(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.tz", kongextend);
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> checkMYPG() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.checkMYPG");
	}

	@SuppressWarnings("unchecked")
	public List<KongExtend> checkSRYZF() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.checkSRYZF");
	}
	
	@SuppressWarnings("unchecked")
	public List<KongExtend> checkSFYLR() throws DataAccessException {
		return (List<KongExtend>) getSqlMapClientTemplate().queryForList("kongextend.checkSFYLR");
	}

	public int updateKongTime(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.updateKongTime", kongextend);
	}

	public int gdKong(KongExtend kongextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongextend.gdKong", kongextend);
	}

}

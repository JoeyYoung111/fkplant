package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.KongControlPowerDao;
import com.szrj.business.model.personel.KongBackground;
import com.szrj.business.model.personel.KongControlPower;
import com.szrj.business.model.personel.KongPublicRelation;
import com.szrj.business.model.personel.KongPublicResume;

public class KongControlPowerDaoImpl extends BaseDaoiBatis implements KongControlPowerDao{

	public int addKongControlPower(KongControlPower kongcontrolpower)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongcontrolpower.addKongControlPower", kongcontrolpower);
	}

	public int addKongPublicResume(KongPublicResume kongpublicresume)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongcontrolpower.addKongPublicResume", kongpublicresume);
	}

	public int cancelKongControlPower(KongControlPower kongcontrolpower)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.cancelKongControlPower", kongcontrolpower);
	}

	public int cancelKongPublicResume(KongPublicResume kongpublicresume)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.cancelKongPublicResume", kongpublicresume);
	}

	public NewPageModel searchKongControlPower(
			KongControlPower kongcontrolpower, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongcontrolpower.searchKongControlPower_count", kongcontrolpower);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongcontrolpower.searchKongControlPower", kongcontrolpower, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchKongPublicResume(
			KongPublicResume kongpublicresume, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongcontrolpower.searchKongPublicResume_count", kongpublicresume);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongcontrolpower.searchKongPublicResume", kongpublicresume, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public NewPageModel searchZbPublicResume(
			KongPublicResume kongpublicresume, NewPageModel pm)
	throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongcontrolpower.searchZbPublicResume_count", kongpublicresume);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongcontrolpower.searchZbPublicResume", kongpublicresume, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateKongControlPower(KongControlPower kongcontrolpower)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.updateKongControlPower", kongcontrolpower);
	}

	public int updateKongPublicResume(KongPublicResume kongpublicresume)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.updateKongPublicResume", kongpublicresume);
	}

	public int addKongPublicRelation(KongPublicRelation kongpublicrelation)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongcontrolpower.addKongPublicRelation", kongpublicrelation);
	}

	public int cancelKongPublicRelation(KongPublicRelation kongpublicrelation)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.cancelKongPublicRelation", kongpublicrelation);
	}

	public NewPageModel searchKongPublicRelation(
			KongPublicRelation kongpublicrelation, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongcontrolpower.searchKongPublicRelation_count", kongpublicrelation);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongcontrolpower.searchKongPublicRelation", kongpublicrelation, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateKongPublicRelation(KongPublicRelation kongpublicrelation)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.updateKongPublicRelation", kongpublicrelation);
	}

	public KongControlPower getkongcontrolpowerbyid(int id)
			throws DataAccessException {
		
		return  (KongControlPower) getSqlMapClientTemplate().queryForObject("kongcontrolpower.getKongControlPowerById", id);
	}

	public KongPublicRelation getkongpublicrelationbyid(int id)
			throws DataAccessException {
		return  (KongPublicRelation) getSqlMapClientTemplate().queryForObject("kongcontrolpower.getKongPublicRelationById", id);
	}

	public KongPublicResume getkongpublicresumebyid(int id)
			throws DataAccessException {
		return  (KongPublicResume) getSqlMapClientTemplate().queryForObject("kongcontrolpower.getKongPublicResumeById", id);
	}

	public int addKongBackground(KongBackground kongbackground)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("kongcontrolpower.addKongBackground", kongbackground);
	}

	public int cancelKongBackground(KongBackground kongbackground)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.cancelKongBackground", kongbackground);
	}

	public KongBackground getkongbackgroundbyid(int id)
			throws DataAccessException {
		return  (KongBackground) getSqlMapClientTemplate().queryForObject("kongcontrolpower.getKongBackgroundById", id);
	}

	public NewPageModel searchKongBackground(KongBackground kongbackground,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("kongcontrolpower.searchKongBackground_count", kongbackground);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("kongcontrolpower.searchKongBackground", kongbackground, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateKongBackground(KongBackground kongbackground)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("kongcontrolpower.updateKongBackground", kongbackground);
	}

	@SuppressWarnings("unchecked")
	public List<KongBackground> getNewKongBackground(KongBackground kongbackground) throws DataAccessException {
		return (List<KongBackground>)getSqlMapClientTemplate().queryForList("kongcontrolpower.getNewKongBackground",kongbackground);
	}

	@SuppressWarnings("unchecked")
	public List<KongControlPower> exportKongcontrolpower(KongControlPower kongcontrolpower) throws DataAccessException {
		return (List<KongControlPower>)getSqlMapClientTemplate().queryForList("kongcontrolpower.exportKongcontrolpower",kongcontrolpower);
	}

	@SuppressWarnings("unchecked")
	public List<KongPublicRelation> exportPublicrelation(KongPublicRelation kongpublicrelation) throws DataAccessException {
		return (List<KongPublicRelation>)getSqlMapClientTemplate().queryForList("kongcontrolpower.exportPublicrelation",kongpublicrelation);
	}

	@SuppressWarnings("unchecked")
	public List<KongPublicResume> exportPublicresume(KongPublicRelation kongpublicrelation) throws DataAccessException {
		return (List<KongPublicResume>)getSqlMapClientTemplate().queryForList("kongcontrolpower.exportPublicresume",kongpublicrelation);
	}
}

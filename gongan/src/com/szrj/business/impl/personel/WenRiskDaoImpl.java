package com.szrj.business.impl.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.WenRiskDao;
import com.szrj.business.model.personel.WenRisk;

public class WenRiskDaoImpl extends BaseDaoiBatis implements WenRiskDao {

	public int add(WenRisk wenRisk) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("wenRisk.add", wenRisk);
	}

	public WenRisk getByPersonnelid(int personnelid) throws DataAccessException {
		return (WenRisk)getSqlMapClientTemplate().queryForObject("wenRisk.getByPersonnelid", personnelid);
	}

	public int update(WenRisk wenRisk) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenRisk.update", wenRisk);
	}

	public NewPageModel searchWenRisk(WenRisk wenRisk, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("wenRisk.searchWenRisk_count", wenRisk);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenRisk.searchWenRisk", wenRisk, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public WenRisk getByPersonnelid_zfw(int personnelid) throws DataAccessException {
		return (WenRisk)getSqlMapClientTemplate().queryForObject("wenRisk.getByPersonnelid_zfw", personnelid);
	}

	public NewPageModel searchWenRisk_zfw(WenRisk wenRisk, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("wenRisk.searchWenRisk_count_zfw", wenRisk);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenRisk.searchWenRisk_zfw", wenRisk, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
}

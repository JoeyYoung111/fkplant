package com.szrj.business.impl;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.TrailInformationDao;
import com.szrj.business.model.TrailInformation;

public class TrailInformationDaoImpl extends BaseDaoiBatis implements TrailInformationDao {

	public int add(TrailInformation trailInformation)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("trailInformation.add", trailInformation);
	}

	public int cancel(TrailInformation trailInformation) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("trailInformation.cancel", trailInformation);
	}

	public NewPageModel searchTrailInformation(
			TrailInformation trailInformation, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("trailInformation.searchTrailInformation_count", trailInformation);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("trailInformation.searchTrailInformation", trailInformation, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public TrailInformation getById(int id) throws DataAccessException {
		return (TrailInformation)getSqlMapClientTemplate().queryForObject("trailInformation.getById", id);
	}

}

package com.szrj.business.impl.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.RealityShowDao;
import com.szrj.business.model.personel.RealityShow;

public class RealityShowDaoImpl extends BaseDaoiBatis implements RealityShowDao {
	public int add(RealityShow realityShow) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("realityShow.add", realityShow);
	}

	public RealityShow getByPersonnelid(RealityShow realityShow) throws DataAccessException {
		return (RealityShow)getSqlMapClientTemplate().queryForObject("realityShow.getByPersonnelid", realityShow);
	}

	public int update(RealityShow realityShow) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("realityShow.update", realityShow);
	}

	public NewPageModel searchRealityShow(RealityShow realityShow, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("realityShow.searchRealityShow_count", realityShow);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("realityShow.searchRealityShow", realityShow, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RealityShow getByPersonnelid_zfw(RealityShow realityShow) throws DataAccessException {
		return (RealityShow)getSqlMapClientTemplate().queryForObject("realityShow.getByPersonnelid_zfw", realityShow);
	}

	public NewPageModel searchRealityShow_zfw(RealityShow realityShow,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("realityShow.searchRealityShow_count_zfw", realityShow);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("realityShow.searchRealityShow_zfw", realityShow, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
}

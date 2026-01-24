package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.WenVisitDao;
import com.szrj.business.model.personel.WenVisit;

public class WenVisitDaoImpl extends BaseDaoiBatis implements WenVisitDao {

	public int add(WenVisit wenVisit) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("wenVisit.add", wenVisit);
	}

	public int cancel(WenVisit wenVisit) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenVisit.cancel", wenVisit);
	}

	public WenVisit getById(int id) throws DataAccessException {
		return (WenVisit)getSqlMapClientTemplate().queryForObject("wenVisit.getById", id);
	}

	public NewPageModel searchWenVisit(WenVisit wenVisit, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("wenVisit.searchWenVisit_count", wenVisit);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenVisit.searchWenVisit", wenVisit, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(WenVisit wenVisit) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenVisit.update", wenVisit);
	}

	@SuppressWarnings("unchecked")
	public List<WenVisit> getListByPersonnelid(int personnelid)
			throws DataAccessException {
		return (List<WenVisit>)getSqlMapClientTemplate().queryForList("wenVisit.getListByPersonnelid",personnelid);
	}

	public NewPageModel searchWenVisit_zfw(WenVisit wenVisit, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("wenVisit.searchWenVisit_count_zfw", wenVisit);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenVisit.searchWenVisit_zfw", wenVisit, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public WenVisit getById_zfw(int id) throws DataAccessException {
		return (WenVisit)getSqlMapClientTemplate().queryForObject("wenVisit.getById_zfw", id);
	}

	public int update_zfw(WenVisit wenVisit) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenVisit.update_zfw", wenVisit);
	}
}

package com.szrj.business.impl.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.LeadsInfoDao;
import com.szrj.business.model.event.LeadsInfo;


public class LeadsInfoDaoImpl extends BaseDaoiBatis implements LeadsInfoDao{

	public int add(LeadsInfo leadsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("leadsInfo.add", leadsInfo);
	}

	public int cancel(LeadsInfo leadsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("leadsInfo.cancel", leadsInfo);
	}

	public LeadsInfo getById(int id) throws DataAccessException {
		return (LeadsInfo)getSqlMapClientTemplate().queryForObject("leadsInfo.getById", id);
	}

	public NewPageModel search(LeadsInfo leadsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("leadsInfo.search_count", leadsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("leadsInfo.search", leadsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(LeadsInfo leadsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("leadsInfo.update", leadsInfo);
	}

	public int search_count(LeadsInfo leadsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("leadsInfo.search_count", leadsInfo);
	}

	public NewPageModel searchSynthetic(LeadsInfo leadsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("leadsInfo.searchSynthetic_count", leadsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("leadsInfo.searchSynthetic", leadsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel search_zfw(LeadsInfo leadsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("leadsInfo.search_count_zfw", leadsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("leadsInfo.search_zfw", leadsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public LeadsInfo getById_zfw(int id) throws DataAccessException {
		return (LeadsInfo)getSqlMapClientTemplate().queryForObject("leadsInfo.getById_zfw", id);
	}

	public int update_zfw(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("leadsInfo.update_zfw", id);
	}
}

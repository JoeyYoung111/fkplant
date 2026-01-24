package com.szrj.business.impl.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.KeypersonnelDao;
import com.szrj.business.model.event.Keypersonnel;


public class KeypersonnelDaoImpl extends BaseDaoiBatis implements KeypersonnelDao{

	public int add(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("keypersonnel.add", keypersonnel);
	}

	public int cancel(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("keypersonnel.cancel", keypersonnel);
	}

	public NewPageModel search(Keypersonnel keypersonnel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("keypersonnel.search_count", keypersonnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("keypersonnel.search", keypersonnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int count_link(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("keypersonnel.count_link", keypersonnel);
	}

	public int updateLink(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("keypersonnel.updateLink", keypersonnel);
	}

	public int search_count(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("keypersonnel.search_count", keypersonnel);
	}

	public NewPageModel search_Zbevent(Keypersonnel keypersonnel,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("keypersonnel.search_count_Zbevent", keypersonnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("keypersonnel.search_Zbevent", keypersonnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public NewPageModel search_zfw(Keypersonnel keypersonnel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("keypersonnel.search_count_zfw", keypersonnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("keypersonnel.search_zfw", keypersonnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public Keypersonnel getById_zfw(int id) throws DataAccessException {
		return (Keypersonnel) getSqlMapClientTemplate().queryForObject("keypersonnel.getById_zfw", id);
	}

	public int update_zfw(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("keypersonnel.update_zfw", id);
	}

	public int updateKpImportance(Keypersonnel keypersonnel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("keypersonnel.updateKpImportance", keypersonnel);
	}
}

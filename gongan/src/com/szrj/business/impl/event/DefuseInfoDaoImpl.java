package com.szrj.business.impl.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.DefuseInfoDao;
import com.szrj.business.model.event.DefuseInfo;


public class DefuseInfoDaoImpl extends BaseDaoiBatis implements DefuseInfoDao{

	public int add(DefuseInfo defuseInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("defuseInfo.add", defuseInfo);
	}

	public int cancel(DefuseInfo defuseInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("defuseInfo.cancel", defuseInfo);
	}

	public DefuseInfo getById(int id) throws DataAccessException {
		return (DefuseInfo)getSqlMapClientTemplate().queryForObject("defuseInfo.getById", id);
	}

	public NewPageModel search(DefuseInfo defuseInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("defuseInfo.search_count", defuseInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("defuseInfo.search", defuseInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(DefuseInfo defuseInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("defuseInfo.update", defuseInfo);
	}

	public int search_count(DefuseInfo defuseInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("defuseInfo.search_count", defuseInfo);
	}

	public NewPageModel search_zfw(DefuseInfo defuseInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("defuseInfo.search_count_zfw", defuseInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("defuseInfo.search_zfw", defuseInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public DefuseInfo getById_zfw(int id) throws DataAccessException {
		return (DefuseInfo)getSqlMapClientTemplate().queryForObject("defuseInfo.getById_zfw", id);
	}

	public int update_zfw(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("defuseInfo.update_zfw", id);
	}
}

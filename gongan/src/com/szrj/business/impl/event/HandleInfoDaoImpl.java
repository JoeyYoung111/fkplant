package com.szrj.business.impl.event;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.HandleInfoDao;
import com.szrj.business.model.event.HandleInfo;

public class HandleInfoDaoImpl extends BaseDaoiBatis implements HandleInfoDao {

	public int add(HandleInfo handleInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("handleInfo.add", handleInfo);
	}

	public int cancel(HandleInfo handleInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("handleInfo.cancel", handleInfo);
	}

	public HandleInfo getById(int id) throws DataAccessException {
		return (HandleInfo)getSqlMapClientTemplate().queryForObject("handleInfo.getById", id);
	}

	public NewPageModel search(HandleInfo handleInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("handleInfo.search_count", handleInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("handleInfo.search", handleInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(HandleInfo handleInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("handleInfo.update", handleInfo);
	}

	@SuppressWarnings("unchecked")
	public List<HandleInfo> getHandleInfoNum(HandleInfo handleInfo) throws DataAccessException {
		return (List<HandleInfo>)getSqlMapClientTemplate().queryForList("handleInfo.getHandleInfoNum", handleInfo);
	}

	public NewPageModel searchSynthetic(HandleInfo handleInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("handleInfo.searchSynthetic_count", handleInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("handleInfo.searchSynthetic", handleInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

}

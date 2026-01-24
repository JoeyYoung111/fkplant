package com.szrj.business.impl.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.EventsInfoDao;
import com.szrj.business.model.event.EventsInfo;


public class EventsInfoDaoImpl extends BaseDaoiBatis implements EventsInfoDao{

	public int add(EventsInfo eventsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("eventsInfo.add", eventsInfo);
	}

	public int cancel(EventsInfo eventsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("eventsInfo.cancel", eventsInfo);
	}

	public EventsInfo getById(int id) throws DataAccessException {
		return (EventsInfo)getSqlMapClientTemplate().queryForObject("eventsInfo.getById", id);
	}

	public NewPageModel search(EventsInfo eventsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("eventsInfo.search_count", eventsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("eventsInfo.search", eventsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(EventsInfo eventsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("eventsInfo.update", eventsInfo);
	}

	public int search_count(EventsInfo eventsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("eventsInfo.search_count", eventsInfo);
	}

	public NewPageModel searchSynthetic(EventsInfo eventsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("eventsInfo.searchSynthetic_count", eventsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("eventsInfo.searchSynthetic", eventsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int countEventByWorkinfoid(EventsInfo eventsInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("eventsInfo.countEventByWorkinfoid", eventsInfo);
	}
	
	/**
	 * 政法委
	 */
	public NewPageModel search_zfw(EventsInfo eventsInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("eventsInfo.search_count_zfw", eventsInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("eventsInfo.search_zfw", eventsInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public EventsInfo getById_zfw(int id) throws DataAccessException {
		return (EventsInfo)getSqlMapClientTemplate().queryForObject("eventsInfo.getById_zfw", id);
	}

	public int update_zfw(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("eventsInfo.update_zfw", id);
	}
}

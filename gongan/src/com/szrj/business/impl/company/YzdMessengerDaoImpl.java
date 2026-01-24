package com.szrj.business.impl.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdMessengerDao;
import com.szrj.business.model.company.YzdMessenger;

public class YzdMessengerDaoImpl extends BaseDaoiBatis implements YzdMessengerDao {

	public int add(YzdMessenger messenger) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("messenger.add", messenger);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("messenger.cancel", id);
	}

	public YzdMessenger getById(int id) throws DataAccessException {
		return (YzdMessenger)getSqlMapClientTemplate().queryForObject("messenger.getById", id);
	}

	public NewPageModel searchYzdMessenger(YzdMessenger messenger, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("messenger.searchMessenger_count", messenger);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("messenger.searchMessenger", messenger, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(YzdMessenger messenger) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("messenger.update", messenger);
	}

}

package com.szrj.business.impl.sysapp;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.sysapp.SendMessageLogDao;
import com.szrj.business.model.sysapp.SendMessageLog;


public class SendMessageLogDaoImpl extends BaseDaoiBatis implements SendMessageLogDao{

	public int add(SendMessageLog sendMessageLog) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("sendMessageLog.add", sendMessageLog);
	}

	public NewPageModel search(SendMessageLog sendMessageLog, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("sendMessageLog.search_count", sendMessageLog);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("sendMessageLog.search", sendMessageLog, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
}

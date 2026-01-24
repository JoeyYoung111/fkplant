package com.szrj.business.impl;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.LogDao;
import com.szrj.business.model.Log;

/**
 *@author:华夏
 *@date:2020-2-24 上午09:27:41
 */
public class LogDaoImpl extends BaseDaoiBatis implements LogDao{
	
	public NewPageModel searchLog(Log log, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("log.searchLog_count", log);
	    pm.setTotal(total);
	    pm.setup();
	    pm.setRows(getSqlMapClientTemplate().queryForList("log.searchLog", log, pm.getStart(), pm.getTruepagesize()));
        return pm;
	}

	public int recordLog(int menuId, String operation, String operator,
			String operationTime, String operationResult, String memo) {
		Log log=new Log();
		log.setMenuId(menuId);
		log.setOperation(operation);
		log.setOperator(operator);
		log.setOperationTime(operationTime);
		log.setOperationResult(operationResult);
		log.setMemo(memo);
		return (Integer)getSqlMapClientTemplate().insert("log.add", log);
	}

	public NewPageModel searchEventLog(Log log, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("log.searchEventLog_count", log);
	    pm.setTotal(total);
	    pm.setup();
	    pm.setRows(getSqlMapClientTemplate().queryForList("log.searchEventLog", log, pm.getStart(), pm.getTruepagesize()));
        return pm;
	}

	public int recordEventLog(Log log) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("log.add", log);
	}
}

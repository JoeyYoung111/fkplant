package com.szrj.business.dao.sysapp;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.sysapp.SendMessageLog;

public interface SendMessageLogDao {
	
	/**
	 * 查询
	 * @param sendMessageLog
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(SendMessageLog sendMessageLog,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 * @param sendMessageLog
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(SendMessageLog sendMessageLog) throws DataAccessException;
}

package com.szrj.business.dao.sysapp;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.sysapp.SendMessage;

public interface SendMessageDao {
	
	/**
	 * 查询
	 * @param sendMessage
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(SendMessage sendMessage,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 * @param sendMessage
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(SendMessage sendMessage) throws DataAccessException;
}

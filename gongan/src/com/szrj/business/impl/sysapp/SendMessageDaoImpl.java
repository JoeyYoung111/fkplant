package com.szrj.business.impl.sysapp;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.sysapp.SendMessageDao;
import com.szrj.business.model.sysapp.SendMessage;


public class SendMessageDaoImpl extends BaseDaoiBatis implements SendMessageDao{

	public int add(SendMessage sendMessage) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("sendMessage.add", sendMessage);
	}

	public NewPageModel search(SendMessage sendMessage, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("sendMessage.search_count", sendMessage);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("sendMessage.search", sendMessage, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
}

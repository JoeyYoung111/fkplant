package com.szrj.business.impl.sysapp;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.sysapp.NoticeDao;
import com.szrj.business.model.sysapp.MessageRemind;
import com.szrj.business.model.sysapp.Notice;


public class NoticeDaoImpl extends BaseDaoiBatis implements NoticeDao{

	public int add(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("notice.add", notice);
	}

	public int cancel(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("notice.cancel", notice);
	}

	public Notice getById(int id) throws DataAccessException {
		return (Notice)getSqlMapClientTemplate().queryForObject("notice.getById", id);
	}

	public NewPageModel search(Notice notice, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("notice.search_count", notice);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("notice.search", notice, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("notice.update", notice);
	}

	@SuppressWarnings("unchecked")
	public List<MessageRemind> getNewMessageRemind(MessageRemind messageRemind) throws DataAccessException {
		return (List<MessageRemind>)getSqlMapClientTemplate().queryForList("notice.getNewMessageRemind",messageRemind);
	}
}

package com.szrj.business.impl.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdCheckDao;
import com.szrj.business.model.company.YzdCheck;

public class YzdCheckDaoImpl extends BaseDaoiBatis implements YzdCheckDao {

	public int add(YzdCheck check) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("check.add", check);
	}

	public int cancel(YzdCheck check) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("check.cancel", check);
	}

	public YzdCheck getById(int id) throws DataAccessException {
		return (YzdCheck)getSqlMapClientTemplate().queryForObject("check.getById", id);
	}

	public NewPageModel searchYzdCheck(YzdCheck check, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("check.searchCheck_count", check);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("check.searchCheck", check, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(YzdCheck check) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("check.update",check);
	}

}

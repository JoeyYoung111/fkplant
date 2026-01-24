package com.szrj.business.impl;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.ZdRoleDao;
import com.szrj.business.model.ZdRole;

public class ZdRoleDaoImpl extends BaseDaoiBatis implements ZdRoleDao{

	public int add(ZdRole zdRole) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zdRole.add", zdRole);
	}

	public NewPageModel searchZdRole(ZdRole zdRole, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("zdRole.searchZdRole_count", zdRole);
	    pm.setTotal(total);
	    pm.setup();
	    pm.setRows(getSqlMapClientTemplate().queryForList("zdRole.searchZdRole", zdRole, pm.getStart(), pm.getTruepagesize()));
        return pm;
	}

	public int update(ZdRole zdRole) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("zdRole.update", zdRole);
	}

	public int cancel(int id) throws DataAccessException {
		return getSqlMapClientTemplate().update("zdRole.cancel", id);
	}

	public ZdRole getById(int id) throws DataAccessException {
		return (ZdRole)getSqlMapClientTemplate().queryForObject("zdRole.getById",id);
	}
}

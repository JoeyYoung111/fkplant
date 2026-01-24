package com.szrj.business.impl;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.RoleAppbuttonDao;
import com.szrj.business.model.RoleAppbutton;

/**
 *@author:lt
 */
public class RoleAppbuttonDaoImpl extends BaseDaoiBatis implements RoleAppbuttonDao{

	public int add(RoleAppbutton roleAppbutton) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("roleAppbutton.add", roleAppbutton);
	}

	public int find(RoleAppbutton roleAppbutton) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("roleAppbutton.find", roleAppbutton);
	}

	public int updateAppbuttonIds(RoleAppbutton roleAppbutton) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("roleAppbutton.updateAppbuttonIds", roleAppbutton);
	}

	public RoleAppbutton getRoleAppbuttonByRoleid(int roleid) throws DataAccessException {
		return (RoleAppbutton)getSqlMapClientTemplate().queryForObject("roleAppbutton.getRoleAppbuttonByRoleid", roleid);
	}
}

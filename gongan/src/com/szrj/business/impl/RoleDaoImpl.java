package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.RoleDao;
import com.szrj.business.model.Role;

/**
 *@author:华夏
 *@date:2020-3-9 下午01:43:55
 */
public class RoleDaoImpl extends BaseDaoiBatis implements RoleDao{

	public int add(Role role) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("role.add", role);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("role.cancel", id);
	}

	public Role getById(int id) throws DataAccessException {
		return (Role)getSqlMapClientTemplate().queryForObject("role.getById", id);
	}

	public List<Role> getRoleList(Role role) throws DataAccessException {
		return (List<Role>)getSqlMapClientTemplate().queryForList("role.getRoleList",role);
	}

	public int update(Role role) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("role.update", role);
	}

}

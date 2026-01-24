package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.RoleUserDao;
import com.szrj.business.model.RoleUser;

/**
 *@author:华夏
 *@date:2020-3-13 上午09:50:49
 */
public class RoleUserDaoImpl extends BaseDaoiBatis implements RoleUserDao{

	public int add(RoleUser roleUser) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("roleUser.add", roleUser);
	}

	public int find(RoleUser roleUser) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("roleUser.find", roleUser);
	}

	public List<RoleUser> getRoleUserList(RoleUser roleUser)
			throws DataAccessException {
		return (List<RoleUser>)getSqlMapClientTemplate().queryForList("roleUser.getRoleUserList",roleUser);
	}

	public int update(RoleUser roleUser) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("roleUser.update", roleUser);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("roleUser.cancel", id);
	}
	public int updateRoleid(RoleUser roleUser) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("roleUser.updateRoleid", roleUser);
	}
}

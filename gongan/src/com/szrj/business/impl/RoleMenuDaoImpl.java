package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.RoleMenuDao;
import com.szrj.business.model.RoleMenu;

/**
 *@author:华夏
 *@date:2020-3-10 下午03:29:39
 */
public class RoleMenuDaoImpl extends BaseDaoiBatis implements RoleMenuDao{

	public int add(RoleMenu roleMenu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("roleMenu.add", roleMenu);
	}

	public int find(RoleMenu roleMenu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("roleMenu.find", roleMenu);
	}

	public List<RoleMenu> getRoleZiMenuList(RoleMenu roleMenu) throws DataAccessException {
		return (List<RoleMenu>)getSqlMapClientTemplate().queryForList("roleMenu.getRoleZiMenuList",roleMenu);
	}

	public int update(RoleMenu roleMenu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("roleMenu.update", roleMenu);
	}

	public RoleMenu findMenuButtons(RoleMenu roleMenu) throws DataAccessException {
		return (RoleMenu)getSqlMapClientTemplate().queryForObject("roleMenu.findMenuButtons", roleMenu);
	}

}

package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PageModel;
import com.ibatis.sqlmap.engine.execution.SqlExecutor;
import com.szrj.business.dao.UserDao;

import com.szrj.business.model.User;


public class UserDaoImpl extends BaseDaoiBatis implements UserDao{
	
	
	public int getUserInUse(String usercode) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("user.getUserInUse", usercode);
	}

	public int checkUserMsg(User user) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("user.checkUserMsg", user);
	}

	public User getUserByCodeAndPwd(User user) throws DataAccessException {
		return (User)getSqlMapClientTemplate().queryForObject("user.getUserByCodeAndPwd", user);
	}

	public User getById(int id) throws DataAccessException {
		return (User)getSqlMapClientTemplate().queryForObject("user.getById", id);
	}
	public int changePWD(User user) throws DataAccessException {
		return getSqlMapClientTemplate().update("user.changePWD", user);
	}

	public int add(User user) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("user.add", user);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("user.cancel", id);
	}

	public NewPageModel searchUser(User user, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("user.searchUser_count", user);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("user.searchUser", user, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(User user) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("user.update", user);
	}
	public List<User> getRoleUser(int roleid) throws DataAccessException {
		List<User> list = getSqlMapClientTemplate().queryForList("user.getRoleUser", roleid);
		return list;
	}
	public int revStop(User user) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("user.revStop", user);
	}

	public List<User> getUsersByDepartmentid(int departmentid)
			throws DataAccessException {
		List<User> list = getSqlMapClientTemplate().queryForList("user.getByDepartmentid", departmentid);
		return list;
	}

	public List<User> getByDepartmentidNotin(User user)
			throws DataAccessException {
		List<User> list = getSqlMapClientTemplate().queryForList("user.getByDepartmentidNotin", user);
		return list;
	}


	public List<User> getUserByIds(String departname) throws DataAccessException {
		List<User> list = getSqlMapClientTemplate().queryForList("user.getUserByIds", departname);
		return list;
	}

	public List<User> getUsersByDepartids(String departname) throws DataAccessException {
		return (List<User>)getSqlMapClientTemplate().queryForList("user.getUsersByDepartids", departname);
	}

	public User getByCardnumber(String cardnumber) throws DataAccessException {
		return (User)getSqlMapClientTemplate().queryForObject("user.getByCardnumber", cardnumber);
	}

}

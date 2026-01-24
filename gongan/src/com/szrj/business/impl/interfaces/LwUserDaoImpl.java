package com.szrj.business.impl.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.interfaces.LwUserDao;
import com.szrj.business.model.User;

public class LwUserDaoImpl extends BaseDaoiBatis implements LwUserDao {

	public List<User> getUsersByDepartmentLingwuid(String lingwuid)
			throws DataAccessException {
		List<User> list = getSqlMapClientTemplate().queryForList("lwuser.getUsersByDepartmentLingwuid", lingwuid);
		return list;
	}

}

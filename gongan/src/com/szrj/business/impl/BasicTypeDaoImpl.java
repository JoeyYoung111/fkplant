package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.BasicTypeDao;
import com.szrj.business.model.BasicType;

public class BasicTypeDaoImpl extends BaseDaoiBatis implements BasicTypeDao {

	public int add(BasicType basicType) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("basicType.add", basicType);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("basicType.cancel", id);
	}

	public List<BasicType> getAll() throws DataAccessException {
		return (List<BasicType>)getSqlMapClientTemplate().queryForList("basicType.getAll");
	}

	public int getTypeNameExit(BasicType basicType) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("basicType.getTypeNameExit", basicType);
	}

	public int update(BasicType basicType) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("basicType.update", basicType);
	}

	public BasicType getById(int id) throws DataAccessException {
		return (BasicType)getSqlMapClientTemplate().queryForObject("basicType.getById", id);
	}

}

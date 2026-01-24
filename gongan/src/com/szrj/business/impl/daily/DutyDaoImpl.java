package com.szrj.business.impl.daily;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.daily.DutyDao;
import com.szrj.business.model.daily.Duty;
import com.szrj.business.model.daily.Secret;

public class DutyDaoImpl extends BaseDaoiBatis implements DutyDao {

	public List<Duty> getAllDuty() throws DataAccessException {
		return (List<Duty>)getSqlMapClientTemplate().queryForList("duty.getAllDuty");
	}

	public Duty getByIdOrDepartid(Duty duty) throws DataAccessException {
		return (Duty)getSqlMapClientTemplate().queryForObject("duty.getByIdOrDepartid", duty);
	}

	public int update(Duty duty) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duty.update", duty);
	}

	public Secret getSecret() throws DataAccessException {
		return (Secret)getSqlMapClientTemplate().queryForObject("duty.getSecret");
	}

	public int updateSecret(Secret secret) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duty.updateSecret", secret);
	}

}

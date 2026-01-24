package com.szrj.business.dao.daily;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.daily.Duty;
import com.szrj.business.model.daily.Secret;

public interface DutyDao {
	public int update(Duty duty) throws DataAccessException;
	public Duty getByIdOrDepartid(Duty duty) throws DataAccessException;
	public List<Duty> getAllDuty() throws DataAccessException;
	
	public int updateSecret(Secret secret) throws DataAccessException;
	public Secret getSecret()throws DataAccessException;
}

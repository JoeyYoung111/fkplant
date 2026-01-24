package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.information.InfoJointPerson;

public interface InfoJointPersonDao {

	public int add(InfoJointPerson infoJointPerson) throws DataAccessException;
	
	public List<InfoJointPerson> searchJointPerson(Integer infoTId) throws DataAccessException;
	
	public Integer searchCount(Integer infoTId) throws DataAccessException;
	
}

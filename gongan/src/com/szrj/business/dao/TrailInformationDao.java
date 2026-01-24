package com.szrj.business.dao;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.TrailInformation;

public interface TrailInformationDao {
	public NewPageModel searchTrailInformation(TrailInformation trailInformation,NewPageModel pm) throws DataAccessException;
	
	public int add(TrailInformation trailInformation) throws DataAccessException;
	
	public int cancel(TrailInformation trailInformation) throws DataAccessException;
	
	public TrailInformation getById(int id) throws DataAccessException;
}

package com.szrj.business.dao.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.RealityShow;

public interface RealityShowDao {
	public RealityShow getByPersonnelid(RealityShow realityShow) throws DataAccessException;
	
	public int add(RealityShow realityShow) throws DataAccessException;
	
	public int update(RealityShow realityShow) throws DataAccessException;
	
	public NewPageModel searchRealityShow(RealityShow realityShow,NewPageModel pm) throws DataAccessException;

	public RealityShow getByPersonnelid_zfw(RealityShow realityShow) throws DataAccessException;
	
	public NewPageModel searchRealityShow_zfw(RealityShow realityShow,NewPageModel pm) throws DataAccessException;
}

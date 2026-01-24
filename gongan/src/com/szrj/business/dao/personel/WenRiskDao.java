package com.szrj.business.dao.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.WenRisk;

public interface WenRiskDao {
	public WenRisk getByPersonnelid(int personnelid) throws DataAccessException;
	
	public int add(WenRisk wenRisk) throws DataAccessException;
	
	public int update(WenRisk wenRisk) throws DataAccessException;
	
	public NewPageModel searchWenRisk(WenRisk wenRisk,NewPageModel pm) throws DataAccessException;
	
	public WenRisk getByPersonnelid_zfw(int personnelid) throws DataAccessException;
	
	public NewPageModel searchWenRisk_zfw(WenRisk wenRisk,NewPageModel pm) throws DataAccessException;
}

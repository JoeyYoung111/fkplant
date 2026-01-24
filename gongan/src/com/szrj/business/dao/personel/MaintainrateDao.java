package com.szrj.business.dao.personel;

import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.personel.Maintainrate;

public interface MaintainrateDao {
	/**
	 * @param personnelid
	 * @param personlabel
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Maintainrate maintainrate) throws DataAccessException;
	
	/**
	 * @param personnelid
	 * @param personlabel
	 * @return
	 * @throws DataAccessException
	 */
	public Maintainrate getMaintainrate(Maintainrate maintainrate) throws DataAccessException;
	
	/**
	 * @param id
	 * @param parameter1
	 * @param parameter2
	 * @param parameter3
	 * @param parameter4
	 * @param parameter5
	 * @param parameter6
	 * @param parameter7
	 * @param parameter8
	 * @param parameter9
	 * @param parameter10
	 * @return
	 * @throws DataAccessException
	 */
	public int update(Maintainrate maintainrate) throws DataAccessException;
	
	public int updateMaintainrateByPersonnelid(HashMap map) throws DataAccessException;
}

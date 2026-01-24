package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.personel.PersonnelPhotoDao;
import com.szrj.business.model.personel.PersonnelPhoto;

public class PersonnelPhotoDaoImpl extends BaseDaoiBatis implements PersonnelPhotoDao {

	public int add(PersonnelPhoto personnelPhoto) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnelPhoto.add", personnelPhoto);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelPhoto.cancel", id);
	}

	public PersonnelPhoto getById(int id) throws DataAccessException {
		return (PersonnelPhoto)getSqlMapClientTemplate().queryForObject("personnelPhoto.getById", id);
	}

	public List<PersonnelPhoto> getByPersonnelid(int personnelid)
			throws DataAccessException {
		return (List<PersonnelPhoto>)getSqlMapClientTemplate().queryForList("personnelPhoto.getByPersonnelid",personnelid);
	}

	public int update(PersonnelPhoto personnelPhoto) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelPhoto.update", personnelPhoto);
	}

	public PersonnelPhoto exportByPersonnelid(int personnelid) throws DataAccessException {
		return (PersonnelPhoto)getSqlMapClientTemplate().queryForObject("personnelPhoto.exportByPersonnelid", personnelid);
	}
}

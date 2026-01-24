package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.personel.PersonnelPhoto;

public interface PersonnelPhotoDao {
	/**
	 * 根据风险人员获取照片列表
	 * @param personnelid
	 * @return
	 * @throws DataAccessException
	 */
	public List<PersonnelPhoto> getByPersonnelid(int personnelid) throws DataAccessException;
	
	/**
	 * 根据id获取照片
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public PersonnelPhoto getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param personnelPhoto
	 * @return
	 * @throws DataAccessException
	 */
	public int add(PersonnelPhoto personnelPhoto) throws DataAccessException;
	
	/**
	 * 修改
	 * @param personnelPhoto
	 * @return
	 * @throws DataAccessException
	 */
	public int update(PersonnelPhoto personnelPhoto) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	public PersonnelPhoto exportByPersonnelid(int personnelid) throws DataAccessException;
	
}

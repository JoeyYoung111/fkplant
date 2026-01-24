package com.szrj.business.dao.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.Applylabel;

public interface ApplylabelDao {
	public int add(Applylabel applylabel) throws DataAccessException;
	
	public NewPageModel search(Applylabel applylabel,NewPageModel pm) throws DataAccessException;
	
	public int check(Applylabel applylabel) throws DataAccessException;
	
	public Applylabel getById(int personnelid) throws DataAccessException;
	
	/**
	 * 根据人员id与申请的一级标签获取未审核记录
	 * @param applylabel
	 * @return
	 * @throws DataAccessException
	 */
	public Applylabel getByPerson(Applylabel applylabel) throws DataAccessException;
}

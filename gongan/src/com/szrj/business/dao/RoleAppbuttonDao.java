package com.szrj.business.dao;

import org.springframework.dao.DataAccessException;
import com.szrj.business.model.RoleAppbutton;

public interface RoleAppbuttonDao {
	
	public int find(RoleAppbutton roleAppbutton) throws DataAccessException;
	
	/**
	 * 新增
	 * @author lt
	 * @param appButton
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(RoleAppbutton roleAppbutton) throws DataAccessException;
	
	public int updateAppbuttonIds(RoleAppbutton roleAppbutton) throws DataAccessException;
	
	public RoleAppbutton getRoleAppbuttonByRoleid(int roleid) throws DataAccessException;
}

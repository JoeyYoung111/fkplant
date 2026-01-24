package com.szrj.business.dao;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.ZdRole;

public interface ZdRoleDao {
	public NewPageModel searchZdRole(ZdRole zdRole,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 */
	public int add(ZdRole zdRole) throws DataAccessException;
	
	/**
	 * 删除
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 */
	public int update(ZdRole zdRole) throws DataAccessException;
	
	public ZdRole getById(int id) throws DataAccessException;
}

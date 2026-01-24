package com.szrj.business.dao.information;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.InfoAssign;

public interface InfoAssignDao {

	public int add(InfoAssign infoAssign) throws DataAccessException;
	
	public NewPageModel search(InfoAssign infoAssign, NewPageModel pm) throws DataAccessException;
	
	public int update(InfoAssign infoAssign) throws DataAccessException;
	
	public int cancel(Integer id) throws DataAccessException;
	
	public InfoAssign getById(Integer id) throws DataAccessException;
	
}

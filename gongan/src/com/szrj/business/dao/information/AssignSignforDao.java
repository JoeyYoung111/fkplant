package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.AssignSignfor;

public interface AssignSignforDao {

	public int add(AssignSignfor assignSignfor) throws DataAccessException;
	
	public NewPageModel search(AssignSignfor assignSignfor, NewPageModel pm) throws DataAccessException;
	
	public int update(AssignSignfor assignSignfor) throws DataAccessException;
	
	public int cancel(AssignSignfor assignSignfor) throws DataAccessException;
	
	public List<AssignSignfor> searchByassignid(AssignSignfor assignSignfor) throws DataAccessException;
	
	public AssignSignfor getById(Integer id) throws DataAccessException;
}

package com.szrj.business.dao.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.User;

public interface LwUserDao {
	public List<User> getUsersByDepartmentLingwuid(String lingwuid) throws DataAccessException; 
}

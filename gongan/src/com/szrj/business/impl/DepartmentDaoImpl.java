package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.DepartmentDao;
import com.szrj.business.model.Department;

public class DepartmentDaoImpl extends BaseDaoiBatis implements DepartmentDao{

	public int add(Department department) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("department.add", department);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("department.cancel", id);
	}

	@SuppressWarnings("unchecked")
	public List<Department> getDepartmentList(Department department) throws DataAccessException {
		return (List<Department>)getSqlMapClientTemplate().queryForList("department.getDepartmentList",department);
	}
	public NewPageModel getDepartmentList(Department department,NewPageModel pm)
	throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("department.getDepartmentList_count", department);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("department.getDepartmentList", department, pm.getStart(), pm.getTruepagesize()));
		return pm;
}
	public Department getById(int id) throws DataAccessException {
		return (Department)getSqlMapClientTemplate().queryForObject("department.getById", id);
	}

	public int update(Department department) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("department.update", department);
	}

	@SuppressWarnings("unchecked")
	public List<Department> getByParentid(int parentid) throws DataAccessException {
		return (List<Department>)getSqlMapClientTemplate().queryForList("department.getByParentid", parentid);
	}

	@SuppressWarnings("unchecked")
	public List<Department> getAllReceiver(Department department) throws DataAccessException {
		return (List<Department>)getSqlMapClientTemplate().queryForList("department.getAllReceiver",department);
	}

	@SuppressWarnings("unchecked")
	public List<String> getDepartmentListOrderbyid(Department department) throws DataAccessException {
		return (List<String>)getSqlMapClientTemplate().queryForList("department.getDepartmentListOrderbyid",department);
	}

	@SuppressWarnings("unchecked")
	public java.util.List<java.util.Map<String,Object>> getJiangyinPoliceStations() throws DataAccessException {
		return (java.util.List<java.util.Map<String,Object>>)getSqlMapClientTemplate().queryForList("department.getJiangyinPoliceStations");
	}
}

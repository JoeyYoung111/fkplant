package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.Department;

public interface DepartmentDao {
	/**
	 * 查询全部  分页
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel getDepartmentList(Department department,NewPageModel pm) throws DataAccessException;
	/**
	 * 查询全部  不分页
	 * @return
	 * @throws DataAccessException
	 */
	public List<Department> getDepartmentList(Department department) throws DataAccessException;
	
	/**
	 * 新增
	 * @param basicType
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Department department) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param basicType
	 * @return
	 * @throws DataAccessException
	 */
	public int update(Department department) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public Department getById(int id) throws DataAccessException;
	
	/**
	 * 根据父id获取
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public List<Department> getByParentid(int parentid) throws DataAccessException;
	
	/**
	 * 获取用户树
	 * @param department
	 * @return
	 * @throws DataAccessException
	 */
	public List<Department> getAllReceiver(Department department) throws DataAccessException;
	
	/**
	 * 获取部门(按照id排序)
	 * @param department
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> getDepartmentListOrderbyid(Department department) throws DataAccessException;

	/**
	 * 获取江阴派出所列表 (ID: 240-263)
	 * @return
	 * @throws DataAccessException
	 */
	public java.util.List<java.util.Map<String,Object>> getJiangyinPoliceStations() throws DataAccessException;
}

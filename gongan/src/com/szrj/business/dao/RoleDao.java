package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.Role;

/**
 *@author:华夏
 *@date:2020-3-9 下午01:37:54
 */
public interface RoleDao {
	
	/**
	 * 获取角色列表
	 * @return
	 * @throws DataAccessException
	 */
	public List<Role> getRoleList(Role role) throws DataAccessException;
	
	/**
	 * 根据id获取角色
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public Role getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param role
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Role role) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param role
	 * @return
	 * @throws DataAccessException
	 */
	public int update(Role role) throws DataAccessException;
}

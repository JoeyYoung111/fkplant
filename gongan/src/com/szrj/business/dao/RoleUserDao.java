package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.RoleUser;

/**
 *@author:华夏
 *@date:2020-3-12 下午04:14:28
 */
public interface RoleUserDao {
	/**
	 * 根据排序获取角色用户列表
	 * @param userFlag
	 * @param departmentid
	 * @param townshipid
	 * @return
	 * @throws DataAccessException
	 */
	public List<RoleUser> getRoleUserList(RoleUser roleUser) throws DataAccessException;
	
	/**
	 * 根据roleid及userid返回id
	 * @param roleid
	 * @param userid
	 * @return id or 0
	 * @throws DataAccessException
	 */
	public int find(RoleUser roleUser) throws DataAccessException;
	
	/**
	 * 新增
	 * @param roleUser
	 * @return
	 * @throws DataAccessException
	 */
	public int add(RoleUser roleUser) throws DataAccessException;
	
	/**
	 * 修改
	 * @param roleUser
	 * @return
	 * @throws DataAccessException
	 */
	public int update(RoleUser roleUser) throws DataAccessException;
	/**
	 * 修改
	 * @param roleUser
	 * @return
	 * @throws DataAccessException
	 */
	public int updateRoleid(RoleUser roleUser) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
}

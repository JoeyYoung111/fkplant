package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.RoleMenu;

/**
 *@author:华夏
 *@date:2020-3-10 下午03:09:44
 */
public interface RoleMenuDao {
	/**
	 * 根据角色id及父菜单id获取子菜单权限列表
	 * @param roleid
	 * @param parentId
	 * @return  RoleMenu RIGHT JOIN Menu
	 * @throws DataAccessException
	 */
	public List<RoleMenu> getRoleZiMenuList(RoleMenu roleMenu) throws DataAccessException;
	
	/**
	 * 新增
	 * @param roleMenu
	 * @return
	 * @throws DataAccessException
	 */
	public int add(RoleMenu roleMenu) throws DataAccessException;
	
	/**
	 * 更新权限状态
	 * @param id
	 * @param validflag
	 * @return
	 * @throws DataAccessException
	 */
	public int update(RoleMenu roleMenu) throws DataAccessException;
	
	/**
	 * 根据角色id及菜单id发现是否有过权限记录
	 * @param roleid
	 * @param menuid
	 * @return id   or    0
	 * @throws DataAccessException
	 */
	public int find(RoleMenu roleMenu) throws DataAccessException;
	
	/**
	 * 查询按钮权限
	 * @param roleMenu
	 * @return
	 * @throws DataAccessException
	 */
	public RoleMenu findMenuButtons(RoleMenu roleMenu) throws DataAccessException;
}

package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.PageModel;
import com.szrj.business.model.Menu;

public interface MenuDao {
	/**
	 * 查询
	 * @author xuxj
	 * @param menu
	 * @param pm
	 * @return PageModel
	 * @throws DataAccessException
	 */
	public NewPageModel searchMenu(Menu menu,NewPageModel pm) throws DataAccessException;
	/**
	 * 
	 * @return
	 * @throws DataAccessException
	 */
	public List<Menu> searchMenu1(Menu menu) throws DataAccessException;
	
	/**
	 * 根据ID获取菜单信息
	 * @author xuxj
	 * @param id
	 * @return Menu
	 * @throws DataAccessException
	 */
	public Menu getById(int id) throws DataAccessException;
	
	/**
	 * 获取所有主菜单
	 * @return List
	 * @throws DataAccessException
	 */
	public List<Menu> getZhuMenu() throws DataAccessException;
	
	/**
	 * 新增
	 * @author xuxj
	 * @param menu
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(Menu menu) throws DataAccessException;
	
	/**
	 * 删除
	 * @author xuxj
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @author xuxj
	 * @param menu
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(Menu menu) throws DataAccessException;
	
	
	
	/**
	 * 根据角色ID查询该角色拥有的功能
	 * @author xuxj
	 * @param roleid
	 * @return List
	 * @throws DataAccessException
	 */
	public List<Menu> getMenu(int roleid) throws DataAccessException;
	
	/**
	 * 获取所有使用中的主菜单
	 * @author xuxj
	 * @return List
	 * @throws DataAccessException
	 */
	public List<Menu> getAllZhu() throws DataAccessException;
	/**
	 * 根据当前登录人获取权限主菜单
	 * @param userid
	 * @return
	 * @throws DataAccessException
	 */
	public List<Menu> getRoleZhuMenu(int userid) throws DataAccessException;
	/**
	 * 根据当前登录人获取权限主菜单下权限子菜单
	 * @param menu
	 * @return
	 * @throws DataAccessException
	 */
	public List<Menu> getRoleZiMenu(Menu menu) throws DataAccessException;
	public List<String> searchbuttons() throws DataAccessException;
	
}

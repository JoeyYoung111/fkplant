package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PageModel;
import com.szrj.business.dao.MenuDao;
import com.szrj.business.model.Menu;

public class MenuDaoImpl extends BaseDaoiBatis implements MenuDao{

	public NewPageModel searchMenu(Menu menu, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("menu.searchMenu_count", menu);
	    pm.setTotal(total);
	    pm.setup();
	    pm.setRows(getSqlMapClientTemplate().queryForList("menu.searchMenu", menu, pm.getStart(), pm.getTruepagesize()));
        return pm;
	}
	public List<Menu> searchMenu1(Menu menu) throws DataAccessException {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.searchMenu1",menu);
        
	}
	public Menu getById(int id) throws DataAccessException {
		return (Menu)getSqlMapClientTemplate().queryForObject("menu.getById", id);
	}

	
	public List<Menu> getZhuMenu() throws DataAccessException {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.getZhuMenu");
	}

	public int add(Menu menu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("menu.add", menu);
	}

	public int cancel(int id) throws DataAccessException {
		return getSqlMapClientTemplate().update("menu.cancel", id);
	}

	public int update(Menu menu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("menu.update", menu);
	}

	

	public List<Menu> getMenu(int roleid) throws DataAccessException {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.getMenu", roleid);
	}

	
	public List<Menu> getAllZhu() throws DataAccessException {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.getAllZhu");
	}
	public List<Menu> getRoleZhuMenu(int userid) throws DataAccessException{
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.getRoleZhuMenu",userid);
	}
	public List<Menu> getRoleZiMenu(Menu menu) throws DataAccessException{
		return (List<Menu>)getSqlMapClientTemplate().queryForList("menu.getRoleZiMenu",menu);
	}
	public List<String> searchbuttons() throws DataAccessException {
		return (List<String>)getSqlMapClientTemplate().queryForList("menu.searchbuttons");
	}


}

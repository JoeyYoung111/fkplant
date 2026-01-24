package com.szrj.business.impl.goods;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.goods.DangerousItemDao;
import com.szrj.business.model.goods.DangerousItem;


public class DangerousItemDaoImpl extends BaseDaoiBatis implements DangerousItemDao{

	public int add(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("dangerousItem.add", dangerousItem);
	}

	public int cancel(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("dangerousItem.cancel", dangerousItem);
	}

	public DangerousItem getById(int id) throws DataAccessException {
		return (DangerousItem)getSqlMapClientTemplate().queryForObject("dangerousItem.getById", id);
	}

	public NewPageModel search(DangerousItem dangerousItem, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("dangerousItem.search_count", dangerousItem);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("dangerousItem.search", dangerousItem, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int search_count(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("dangerousItem.search_count", dangerousItem);
	}

	public int update(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("dangerousItem.update", dangerousItem);
	}

	public int generateCodenum() throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("dangerousItem.generateCodenum");
	}

	public NewPageModel searchItemByPerson(DangerousItem dangerousItem,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("dangerousItem.searchItemByPerson_count", dangerousItem);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("dangerousItem.searchItemByPerson", dangerousItem, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updatePersonByCodenum(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("dangerousItem.updatePersonByCodenum", dangerousItem);
	}

	public int cancelGoodsConnect(DangerousItem dangerousItem) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("dangerousItem.cancelGoodsConnect", dangerousItem);
	}
}

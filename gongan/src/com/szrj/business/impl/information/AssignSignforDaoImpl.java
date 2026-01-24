package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.AssignSignforDao;
import com.szrj.business.model.information.AssignSignfor;

public class AssignSignforDaoImpl extends BaseDaoiBatis implements AssignSignforDao {

	public int add(AssignSignfor assignSignfor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("AssignSignfor.add",assignSignfor);
	}

	public int cancel(AssignSignfor assignSignfor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("AssignSignfor.cancel", assignSignfor);
	}

	public int update(AssignSignfor assignSignfor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("AssignSignfor.update", assignSignfor);
	}

	public NewPageModel search(AssignSignfor assignSignfor, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("AssignSignfor.search_AssignSignfor_count", assignSignfor);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("AssignSignfor.search_AssignSignfor", assignSignfor));
		return pm;
	}
	
	public AssignSignfor getById(Integer id) throws DataAccessException{
		return (AssignSignfor)getSqlMapClientTemplate().queryForObject("AssignSignfor.getById",id);
	}

	@SuppressWarnings("unchecked")
	public List<AssignSignfor> searchByassignid(AssignSignfor assignSignfor) throws DataAccessException {
		return (List<AssignSignfor>)getSqlMapClientTemplate().queryForList("AssignSignfor.search_list", assignSignfor);
	}

}

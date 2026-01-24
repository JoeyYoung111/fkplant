package com.szrj.business.impl.information;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InfoAssignDao;
import com.szrj.business.model.information.InfoAssign;

public class InfoAssignDaoImpl extends BaseDaoiBatis implements InfoAssignDao {

	public int add(InfoAssign infoAssign) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("infoassign.add",infoAssign);
	}

	public int cancel(Integer id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("infoassign.cancel", id);
	}

	public NewPageModel search(InfoAssign infoAssign, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("infoassign.search_infoassign_count",infoAssign);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("infoassign.search_infoassign",infoAssign));
		return pm;
	}

	public int update(InfoAssign infoAssign) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("infoassign.update", infoAssign);
	}

	public InfoAssign getById(Integer id) throws DataAccessException {
		return (InfoAssign)getSqlMapClientTemplate().queryForObject("infoassign.getById", id);
	}
	
	

}

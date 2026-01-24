package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InformationDao;
import com.szrj.business.model.information.Information;

public class InformationDaoImpl extends BaseDaoiBatis implements InformationDao {

	public int add(Information information) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("information.add",information);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("information.cancel",id);
	}

	public Information getById(int id) throws DataAccessException {
		return (Information)getSqlMapClientTemplate().queryForObject("information.getInformationById",id);
	}

	public NewPageModel searchInformation(Information information, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("information.searchInformation_count", information);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("information.searchInformation", information, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(Information information) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("information.update", information);
	}
	
	public int updatePizhu(Information information) throws DataAccessException{
		return (Integer)getSqlMapClientTemplate().update("information.updatePizhu", information);
	}

	public int searchInformation_count(Information information) throws DataAccessException {
		return (Integer) getSqlMapClientTemplate().queryForObject("information.searchInformation_count", information);
	}
	
	public List<Information> getSendcountByDepttype(Information information) throws DataAccessException {
		return (List<Information>) getSqlMapClientTemplate().queryForList("information.getSendcountByDepttype", information);
	}

}

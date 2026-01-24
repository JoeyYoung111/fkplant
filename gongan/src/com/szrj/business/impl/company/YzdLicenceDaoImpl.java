package com.szrj.business.impl.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdLicenceDao;
import com.szrj.business.model.company.YzdLicence;

/**
 * @author 李昊
 * Sep 8, 2021
 */
public class YzdLicenceDaoImpl extends BaseDaoiBatis implements YzdLicenceDao {

	public int add(YzdLicence licence) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("licence.add",licence);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("licence.cancel",id);
	}

	public YzdLicence getById(int id) throws DataAccessException {
		return (YzdLicence)getSqlMapClientTemplate().queryForObject("licence.getById", id);
	}

	public int update(YzdLicence licence) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("licence.update",licence);
	}

	public int cancelValidFlag(int companyid) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("licence.cancelValidFlag", companyid);
	}

	public int updateCompanyName(YzdLicence licence) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("licence.updateCompanyName", licence);
	}

	public NewPageModel searchLicence(YzdLicence licence, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("licence.searchLicence_count", licence);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("licence.searchLicence",licence,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

}

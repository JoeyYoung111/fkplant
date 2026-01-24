package com.szrj.business.impl.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.ApplylabelDao;
import com.szrj.business.model.personel.Applylabel;

public class ApplylabelDaoImpl extends BaseDaoiBatis implements ApplylabelDao {

	public int add(Applylabel applylabel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("applylabel.add", applylabel);
	}

	public NewPageModel search(Applylabel applylabel, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("applylabel.search_count", applylabel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("applylabel.search", applylabel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int check(Applylabel applylabel) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("applylabel.check", applylabel);
	}

	public Applylabel getById(int personnelid) throws DataAccessException {
		return (Applylabel)getSqlMapClientTemplate().queryForObject("applylabel.getById", personnelid);
	}

	public Applylabel getByPerson(Applylabel applylabel) throws DataAccessException {
		return (Applylabel)getSqlMapClientTemplate().queryForObject("applylabel.getByPerson", applylabel);
	}
}

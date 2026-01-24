package com.szrj.business.impl.personel;

import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.personel.MaintainrateDao;
import com.szrj.business.model.personel.Maintainrate;

public class MaintainrateDaoImpl extends BaseDaoiBatis implements MaintainrateDao {

	public int add(Maintainrate maintainrate) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("maintainrate.add", maintainrate);
	}

	public Maintainrate getMaintainrate(Maintainrate maintainrate)
			throws DataAccessException {
		return (Maintainrate)getSqlMapClientTemplate().queryForObject("maintainrate.getMaintainrate", maintainrate);
	}

	public int update(Maintainrate maintainrate) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("maintainrate.update", maintainrate);
	}

	public int updateMaintainrateByPersonnelid(HashMap map)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("maintainrate.updateMaintainrateByPersonnelid", map);
	}
}

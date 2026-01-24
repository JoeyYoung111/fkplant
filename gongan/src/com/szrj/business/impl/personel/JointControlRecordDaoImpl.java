package com.szrj.business.impl.personel;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.JointControlRecordDao;
import com.szrj.business.model.personel.JointControlRecord;

public class JointControlRecordDaoImpl extends BaseDaoiBatis implements JointControlRecordDao{

	public int add(JointControlRecord jointcontrolrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("jointcontrolrecord.add", jointcontrolrecord);
	}

	public int cancel(JointControlRecord jointcontrolrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("jointcontrolrecord.cancel", jointcontrolrecord);
	}

	public JointControlRecord getJointControlRecordByid(int id)
			throws DataAccessException {
		return  (JointControlRecord) getSqlMapClientTemplate().queryForObject("jointcontrolrecord.getjointcontrolrecordrById", id);
	}

	public NewPageModel searchJointControlRecord(JointControlRecord jointcontrolrecord, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("jointcontrolrecord.searchJointControlRecord_count", jointcontrolrecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("jointcontrolrecord.searchJointControlRecord", jointcontrolrecord, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(JointControlRecord jointcontrolrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("jointcontrolrecord.update", jointcontrolrecord);
	}

	public int updateWenVisit(JointControlRecord jointControlRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("jointcontrolrecord.updateWenVisit", jointControlRecord);
	}

	public int unlinkWenVisit(int wenvisitid) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("jointcontrolrecord.unlinkWenVisit", wenvisitid);
	}

	public NewPageModel searchJointControlRecord_zfw(JointControlRecord jointcontrolrecord, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("jointcontrolrecord.searchJointControlRecord_count_zfw", jointcontrolrecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("jointcontrolrecord.searchJointControlRecord_zfw", jointcontrolrecord, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public JointControlRecord getJointControlRecordByid_zfw(int id) throws DataAccessException {
		return  (JointControlRecord) getSqlMapClientTemplate().queryForObject("jointcontrolrecord.getJointControlRecordByid_zfw", id);
	}

	public int update_zfw(JointControlRecord jointcontrolrecord) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("jointcontrolrecord.update_zfw", jointcontrolrecord);
	}
}

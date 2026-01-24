package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.information.InfoJointPersonDao;
import com.szrj.business.model.information.InfoJointPerson;

public class InfoJointPersonDaoImpl extends BaseDaoiBatis implements InfoJointPersonDao {

	public int add(InfoJointPerson infoJointPerson) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("infoJointPerson.add", infoJointPerson);
	}

	@SuppressWarnings("unchecked")
	public List<InfoJointPerson> searchJointPerson(Integer infoTId) throws DataAccessException {
		return (List<InfoJointPerson>)getSqlMapClientTemplate().queryForList("infoJointPerson.searchByinfoTId", infoTId);
	}

	public Integer searchCount(Integer infoTId) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("infoJointPerson.searchByinfoTId_count", infoTId);
	}

}

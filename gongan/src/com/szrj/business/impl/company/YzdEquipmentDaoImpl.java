package com.szrj.business.impl.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdEquipmentDao;
import com.szrj.business.model.company.YzdEquipment;

public class YzdEquipmentDaoImpl extends BaseDaoiBatis implements YzdEquipmentDao {

	public int add(YzdEquipment equipment) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("equipment.add", equipment);
	}

	public int cancel(YzdEquipment equipment) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("equipment.cancel", equipment);
	}

	public YzdEquipment getById(int id) throws DataAccessException {
		return (YzdEquipment)getSqlMapClientTemplate().queryForObject("equipment.getById", id);
	}

	public NewPageModel searchYzdEquipment(YzdEquipment equipment,NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("equipment.searchEquipment_count", equipment);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("equipment.searchEquipment",equipment,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	public int update(YzdEquipment equipment) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("equipment.update", equipment);
	}

}

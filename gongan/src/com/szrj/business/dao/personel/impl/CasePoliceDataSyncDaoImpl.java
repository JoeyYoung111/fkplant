package com.szrj.business.dao.personel.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.personel.CasePoliceDataSyncDao;
import com.szrj.business.model.Department;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;

/**
 * 案件/警情数据同步 DAO实现类
 */
public class CasePoliceDataSyncDaoImpl extends BaseDaoiBatis implements CasePoliceDataSyncDao {

	@Override
	@SuppressWarnings("unchecked")
	public List<XdAjxx> queryDailyNewCases() throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("casePoliceDataSync.queryDailyNewCases");
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<XdJqxx> queryDailyNewPoliceIncidents() throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("casePoliceDataSync.queryDailyNewPoliceIncidents");
	}

	@Override
	public Department getDepartmentByDepartcode(String departcode) throws DataAccessException {
		return (Department) getSqlMapClientTemplate().queryForObject("casePoliceDataSync.getDepartmentByDepartcode", departcode);
	}

	@Override
	public String getCurrentHandleUnitCode(int personnelId) throws DataAccessException {
		return (String) getSqlMapClientTemplate().queryForObject("casePoliceDataSync.getCurrentHandleUnitCode", personnelId);
	}

	@Override
	public int updateHandleUnitCode(int personnelId, String handleUnitCode) throws DataAccessException {
		HashMap<String, Object> params = new HashMap<>();
		params.put("personnelId", personnelId);
		params.put("handleUnitCode", handleUnitCode);
		return getSqlMapClientTemplate().update("casePoliceDataSync.updateHandleUnitCode", params);
	}

	@Override
	public String getUserCodesByDepartmentId(int departmentId) throws DataAccessException {
		return (String) getSqlMapClientTemplate().queryForObject("casePoliceDataSync.getUserCodesByDepartmentId", departmentId);
	}

	@Override
	public void updateCaseFlag(String id) throws DataAccessException {
		HashMap<String, Object> params = new HashMap<>();
		params.put("id", id);
		getSqlMapClientTemplate().update("casePoliceDataSync.updateCaseFlag", params);
	}

	@Override
	public void updatePoliceIncidentFlag(String id) throws DataAccessException {
		HashMap<String, Object> params = new HashMap<>();
		params.put("id", id);
		getSqlMapClientTemplate().update("casePoliceDataSync.updatePoliceIncidentFlag", params);
	}

	@Override
	public String getCurrentZslabel2(int personnelId) throws DataAccessException {
		return (String) getSqlMapClientTemplate().queryForObject("casePoliceDataSync.getCurrentZslabel2", personnelId);
	}

	@Override
	public void updateZslabel2(int personnelId, String zslabel2) throws DataAccessException {
		HashMap<String, Object> params = new HashMap<>();
		params.put("personnelId", personnelId);
		params.put("zslabel2", zslabel2);
		getSqlMapClientTemplate().update("casePoliceDataSync.updateZslabel2", params);
	}
}


package com.szrj.business.impl.event;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.AxisEvent;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.event.ContradictionInfoDao;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.ZbEventInfo;


public class ContradictionInfoDaoImpl extends BaseDaoiBatis implements ContradictionInfoDao{

	public NewPageModel searchContradictionInfo(ContradictionInfo contradictionInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("contradictionInfo.search_count", contradictionInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("contradictionInfo.search", contradictionInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int add(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("contradictionInfo.add", contradictionInfo);
	}

	public int cancel(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.cancel", contradictionInfo);
	}

	public ContradictionInfo getById(int id) throws DataAccessException {
		return (ContradictionInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.getById", id);
	}

	public int update(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.update", contradictionInfo);
	}

	public ContradictionInfo getCheckContradictionInfo(int id) throws DataAccessException {
		return (ContradictionInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.getCheckContradictionInfo", id);
	}

	public int check(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.check", contradictionInfo);
	}

	@SuppressWarnings("unchecked")
	public List<AxisEvent> searchTimeaxis(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (List<AxisEvent>)getSqlMapClientTemplate().queryForList("contradictionInfo.searchTimeaxis", contradictionInfo);
	}

	public ContradictionInfo getDetailById(int id) throws DataAccessException {
		return (ContradictionInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.getDetailById", id);
	}

	@SuppressWarnings("unchecked")
	public List<String> searchCdtname() throws DataAccessException {
		return (List<String>)getSqlMapClientTemplate().queryForList("contradictionInfo.searchCdtname");
	}

	@SuppressWarnings("unchecked")
	public List<ContradictionInfo> getCdtByPerson(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (List<ContradictionInfo>)getSqlMapClientTemplate().queryForList ("contradictionInfo.getCdtByPerson", contradictionInfo);
	}

	public int block(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.block", contradictionInfo);
	}

	public int updateTime(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.updateTime", contradictionInfo);
	}

	public int addZbEvent(ContradictionInfo contradictionInfo)throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("contradictionInfo.addZbEvent", contradictionInfo);
	}

	@SuppressWarnings("unchecked")
	public List<SelectModel> countByCdtresult() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countByCdtresult");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countByCdttype() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countByCdttype");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countByCdtlevel() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countByCdtlevel");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countBySsrs() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countBySsrs");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countPersonAndEventByDepartment() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countPersonAndEventByDepartment");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countEventPercentByDepartment() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countEventPercentByDepartment");
	}
	@SuppressWarnings("unchecked")
	public List<SelectModel> countAllTrendEvent() throws DataAccessException{
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList ("contradictionInfo.countAllTrendEvent");
	}
	
	/*政保事件详细信息*/
	public NewPageModel search_ZbEventInfo(ZbEventInfo zbEventInfo,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("contradictionInfo.search_count_ZbEventInfo", zbEventInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("contradictionInfo.search_ZbEventInfo", zbEventInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int add_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("contradictionInfo.add_ZbEventInfo", zbEventInfo);
	}

	public int cancel_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.cancel_ZbEventInfo", zbEventInfo);
	}

	public ZbEventInfo getById_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException {
		return (ZbEventInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.getById_ZbEventInfo", zbEventInfo);
	}

	public int update_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.update_ZbEventInfo", zbEventInfo);
	}

	public NewPageModel searchByKeyperson(ContradictionInfo contradictionInfo,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("contradictionInfo.search_countByKeyperson", contradictionInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("contradictionInfo.searchByKeyperson", contradictionInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public ContradictionInfo exportContradictionInfo(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (ContradictionInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.exportContradictionInfo", contradictionInfo);
	}

	public NewPageModel searchContradictionInfo_zfw(ContradictionInfo contradictionInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("contradictionInfo.search_count_zfw", contradictionInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("contradictionInfo.search_zfw", contradictionInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public ContradictionInfo getById_zfw(int id) throws DataAccessException {
		return (ContradictionInfo)getSqlMapClientTemplate().queryForObject("contradictionInfo.getById_zfw", id);
	}

	public int check_zfw(ContradictionInfo contradictionInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("contradictionInfo.check_zfw", contradictionInfo);
	}
}

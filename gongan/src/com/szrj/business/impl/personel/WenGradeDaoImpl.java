package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.WenGradeDao;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.WenGrade;
import com.szrj.business.model.personel.WenJointControlLevel;

public class WenGradeDaoImpl extends BaseDaoiBatis implements WenGradeDao {

	public int add(WenGrade wenGrade) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("wenGrade.add", wenGrade);
	}

	public int cancel(WenGrade wenGrade) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenGrade.cancel", wenGrade);
	}

	public WenGrade getById(int id) throws DataAccessException {
		return (WenGrade)getSqlMapClientTemplate().queryForObject("wenGrade.getById", id);
	}

	public NewPageModel searchWenGrade(WenGrade wenGrade, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("wenGrade.searchWenGrade_count", wenGrade);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenGrade.searchWenGrade", wenGrade, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public int countWenGrade(WenGrade wenGrade) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.searchWenGrade_count", wenGrade);
	}

	public int update(WenGrade wenGrade) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenGrade.update", wenGrade);
	}

	public int updatejointcontrollevelapply(WenGrade wenGrade)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenGrade.updatejointcontrollevelapply", wenGrade);
	}

	public int addjointcontrollevel(WenJointControlLevel jointcontrollevel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("wenGrade.addjointcontrollevel", jointcontrollevel);
	}

	public int examinejointcontrolleve(WenJointControlLevel jointcontrollevel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenGrade.examinejointcontrolleve", jointcontrollevel);
	}

	public WenJointControlLevel getjointcontrolleveById(int id)
			throws DataAccessException {
		return (WenJointControlLevel)getSqlMapClientTemplate().queryForObject("wenGrade.getjointcontrolleveById", id);
	}

	public List<WenJointControlLevel> searchjointcontrollevel(WenJointControlLevel jointcontrollevel) throws DataAccessException {
		return (List<WenJointControlLevel>)getSqlMapClientTemplate().queryForList("wenGrade.searchjointcontrollevel", jointcontrollevel);
	}

	public int updatejointcontrollevel(WenJointControlLevel jointcontrollevel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("wenGrade.updatejointcontrollevel", jointcontrollevel);
	}

	public int getjointcontrollevelCount(int personnelid)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.getjointcontrollevelCount", personnelid);
	}

	public WenJointControlLevel getjointcontrollevelNew(int personnelid)
			throws DataAccessException {
		return (WenJointControlLevel)getSqlMapClientTemplate().queryForObject("wenGrade.getjointcontrollevelNew", personnelid);
	}

	public List<WenGrade> exportWenGrade(WenGrade wenGrade)
			throws DataAccessException {
		return (List<WenGrade>)getSqlMapClientTemplate().queryForList("wenGrade.exportWenGrade", wenGrade);
	}

	@SuppressWarnings("unchecked")
	public List<Personnel> getRelationchart(WenGrade wenGrade) throws DataAccessException {
		return (List<Personnel>)getSqlMapClientTemplate().queryForList("wenGrade.getRelationchart", wenGrade);
	}
    public WenGrade getBypersonnelid(int personnelid)
			throws DataAccessException {
		return (WenGrade)getSqlMapClientTemplate().queryForObject("wenGrade.getBypersonnelid", personnelid);
	}

	public NewPageModel jointControllerList(WenJointControlLevel jointcontrollevel,NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.searchjointcontrollevel_count",jointcontrollevel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("wenGrade.searchjointcontrollevel", jointcontrollevel,pm.getStart(),pm.getTruepagesize()));
		return pm;
	}

	public int countTodayLevelAdjust() throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.countTodayLevelAdjust");
	}

	public int countTodayLevelUp() throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("wenGrade.countTodayLevelUp");
	}
}

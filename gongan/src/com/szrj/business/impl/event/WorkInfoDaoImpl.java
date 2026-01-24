package com.szrj.business.impl.event;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.WorkInfoDao;
import com.szrj.business.model.event.WorkInfo;


public class WorkInfoDaoImpl extends BaseDaoiBatis implements WorkInfoDao{

	public int add(WorkInfo workInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("workInfo.add", workInfo);
	}

	public int cancel(WorkInfo workInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("workInfo.cancel", workInfo);
	}

	public NewPageModel search(WorkInfo workInfo, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("workInfo.search_count", workInfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("workInfo.search", workInfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(WorkInfo workInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("workInfo.update", workInfo);
	}

	public WorkInfo getById(int id) throws DataAccessException {
		return (WorkInfo)getSqlMapClientTemplate().queryForObject("workInfo.getById", id);
	}

	public int sign(WorkInfo workInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("workInfo.sign", workInfo);
	}

	public int feedback(WorkInfo workInfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("workInfo.feedback", workInfo);
	}

	@SuppressWarnings("unchecked")
	public List<WorkInfo> getWorkInfoNum(WorkInfo workInfo) throws DataAccessException {
		return (List<WorkInfo>) getSqlMapClientTemplate().queryForList("workInfo.getWorkInfoNum",workInfo);
	}

	public int getMaxCode(WorkInfo workInfo) throws DataAccessException {
		return (Integer) getSqlMapClientTemplate().queryForObject("workInfo.getMaxCode", workInfo);
	}

	public WorkInfo getFeedback(int id) throws DataAccessException {
		return (WorkInfo)getSqlMapClientTemplate().queryForObject("workInfo.getFeedback", id);
	}
}

package com.szrj.business.impl.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.interfaces.YujingDao;
import com.szrj.business.model.interfaces.Yujing;

public class YujingDaoImpl extends BaseDaoiBatis implements YujingDao {

	@SuppressWarnings("unchecked")
	public List<Yujing> getYujingColumnListByModelId(String modelId)
			throws DataAccessException {
		return (List<Yujing>)getSqlMapClientTemplate().queryForList("yujing.getYujingColumnListByModelId",modelId);
	}
	@SuppressWarnings("unchecked")
	public List<Yujing> getYujingResultListByColumn(Yujing yujing)
			throws DataAccessException {
		return (List<Yujing>)getSqlMapClientTemplate().queryForList("yujing.getYujingResultListByColumn",yujing);
	}
}

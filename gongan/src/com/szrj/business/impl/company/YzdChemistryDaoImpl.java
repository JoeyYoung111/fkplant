package com.szrj.business.impl.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdChemistryDao;
import com.szrj.business.model.company.YzdChemical;
import com.szrj.business.model.company.YzdChemistry;

public class YzdChemistryDaoImpl extends BaseDaoiBatis implements YzdChemistryDao {

	public int add(YzdChemistry chemistry) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("chemistry.add", chemistry);
	}

	public int cancel(YzdChemistry chemistry) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("chemistry.cancel", chemistry);
	}

	public YzdChemistry getById(int id) throws DataAccessException {
		return (YzdChemistry)getSqlMapClientTemplate().queryForObject("chemistry.getById", id);
	}

	public NewPageModel searchYzdChemistry(YzdChemistry chemistry, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("chemistry.searchChemistry_count", chemistry);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("chemistry.searchChemistry", chemistry, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(YzdChemistry chemistry) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("chemistry.update", chemistry);
	}
	public NewPageModel searchYzdChemistry1(YzdChemistry chemistry, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("chemistry.searchChemistry_count1", chemistry);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("chemistry.searchChemistry1", chemistry, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int getByCardnumber(String cardnumber) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("chemistry.getByCardnumber", cardnumber);
	}

	public List<YzdChemistry> searchYzdChemistryList(YzdChemistry chemistry)
			throws DataAccessException {
		return (List<YzdChemistry>)getSqlMapClientTemplate().queryForList("chemistry.searchChemistry1",chemistry);
	}
	
	
}

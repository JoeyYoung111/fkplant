package com.szrj.business.impl.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.company.YzdChemicalDao;
import com.szrj.business.model.company.YzdChemical;

/**
 * @author 李昊
 * Sep 3, 2021
 */
public class YzdChemicalDaoImpl extends BaseDaoiBatis implements YzdChemicalDao {

	public int add(YzdChemical chemical) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("chemical.add", chemical);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("chemical.cancel", id);
	}

	public YzdChemical getById(int id) throws DataAccessException {
		return (YzdChemical)getSqlMapClientTemplate().queryForObject("chemical.getById", id);
	}

	public NewPageModel searchYzdChemical(YzdChemical chemical, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("chemical.searchChemical_count",chemical);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("chemical.searchChemical", chemical, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(YzdChemical chemical) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("chemical.update", chemical);
	}

	@SuppressWarnings("unchecked")
	public List<YzdChemical> getChemicalJSON(int companyid) throws DataAccessException {
		return (List<YzdChemical>)getSqlMapClientTemplate().queryForList("chemical.getChemicalJSON", companyid);
	}

	@SuppressWarnings("unchecked")
	public List<YzdChemical> getChemicalsByid(String idlist) {
		return (List<YzdChemical>)getSqlMapClientTemplate().queryForList("chemical.getChemicalsById",idlist);
	}

}

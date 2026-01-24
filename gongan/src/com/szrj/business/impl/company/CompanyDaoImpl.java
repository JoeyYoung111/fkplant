package com.szrj.business.impl.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.company.CompanyDao;
import com.szrj.business.model.company.Company;

/**
 * 
 * @author 李昊
 * Aug 25, 2021
 */
public class CompanyDaoImpl extends BaseDaoiBatis implements CompanyDao {

	public int add(Company company) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("company.add",company);
	}

	public NewPageModel searchCompany(Company company, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("company.searchCompany_count", company);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("company.searchCompany", company, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("company.cancel",id);
	}

	public Company getById(int id) throws DataAccessException {
		return (Company)getSqlMapClientTemplate().queryForObject("company.getById",id);
	}

	@SuppressWarnings("unchecked")
	public List<Company> getCompanyList(Company company) throws DataAccessException {
		return (List<Company>)getSqlMapClientTemplate().queryForList("company.searchCompany", company);
	}

	public int update(Company company) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("company.update", company);
	}

	public int updateFR(Company company) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("company.updateFR", company);
	}
	
	public int checkCompanycode(String companycode) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("company.search_code", companycode);
	}

	@SuppressWarnings("unchecked")
	public List<Company> getCompanyToJSON(Company company) throws DataAccessException {
		return (List<Company>)getSqlMapClientTemplate().queryForList("company.getCompanyToJSON", company);
	}

	public Integer getIdByName(String companyname) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("company.getIdByName", companyname);
	}

	@SuppressWarnings("unchecked")
	public List<SelectModel> countByAffecttype() throws DataAccessException {
		return (List<SelectModel>)getSqlMapClientTemplate().queryForList("company.countByAffecttype");
	}
	
	
}

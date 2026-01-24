package com.szrj.business.dao.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.model.company.Company;

/**
 * @author 李昊
 * Aug 25, 2021
 */
public interface CompanyDao {
	
	/**
	 * 查询全部 分页
	 * @param company
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchCompany(Company company,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return Company
	 * @throws DataAccessException
	 */
	public Company getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param company
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Company company) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改公司信息
	 * @param company
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(Company company) throws DataAccessException;
	
	/**
	 * 修改公司法人信息
	 * @return
	 */
	public int updateFR(Company company) throws DataAccessException;
	
	/**
	 * 查询全部 不分页
	 * @param company
	 * @return
	 * @throws DataAccessException
	 */
	public List<Company> getCompanyList(Company company) throws DataAccessException;
	
	/**
	 * 检查社会统一代码是否重复
	 * @param companycode
	 * @return
	 * @throws DataAccessException
	 */
	public int checkCompanycode(String companycode) throws DataAccessException;

	public List<Company> getCompanyToJSON(Company company) throws DataAccessException;
	
	public Integer getIdByName(String companyname) throws DataAccessException;
	
	public List<SelectModel> countByAffecttype() throws DataAccessException;
}

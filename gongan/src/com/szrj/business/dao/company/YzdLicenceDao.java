package com.szrj.business.dao.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdLicence;

/**
 * @author 李昊
 * Sep 8, 2021
 */
public interface YzdLicenceDao {

	/**
	 * 根据企业ID查询全部许可证
	 * @param licence
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchLicence(YzdLicence licence, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdLicence getById(int id) throws DataAccessException;

	/**
	 * 新增
	 * @param licence
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdLicence licence) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改基本信息
	 * @param licence
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdLicence licence) throws DataAccessException;
	
	/**
	 * 级联修改
	 * @return
	 */
	public int updateCompanyName(YzdLicence licence) throws DataAccessException;
	
	/**
	 * 级联删除
	 * @param companyid
	 * @return
	 * @throws DataAccessException
	 */
	public int cancelValidFlag(int companyid) throws DataAccessException;
}

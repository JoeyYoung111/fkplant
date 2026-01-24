package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.Information;

public interface InformationDao {

	/**
	 * 查询全部 分页
	 * @param Information
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchInformation(Information information,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return Information
	 * @throws DataAccessException
	 */
	public Information getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param Information
	 * @return
	 * @throws DataAccessException
	 */
	public int add(Information information) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改公司信息
	 * @param Information
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(Information information) throws DataAccessException;
	
	public int updatePizhu(Information information) throws DataAccessException;
	
	public int searchInformation_count(Information information) throws DataAccessException;
	
	public List<Information> getSendcountByDepttype(Information information) throws DataAccessException;
}

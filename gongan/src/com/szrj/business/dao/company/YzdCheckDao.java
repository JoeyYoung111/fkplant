package com.szrj.business.dao.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdCheck;

/**
 * 检查表
 * @author 李昊
 * Sep 22, 2021
 */
public interface YzdCheckDao {

	/**
	 * 查询全部 分页
	 * @param Check
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdCheck(YzdCheck Check, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdCheck getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param Check
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdCheck Check) throws DataAccessException;
	
	/**
	 * 删除
	 * @param Check
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(YzdCheck Check) throws DataAccessException;
	
	/**
	 * 修改
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdCheck Check) throws DataAccessException;
	
}

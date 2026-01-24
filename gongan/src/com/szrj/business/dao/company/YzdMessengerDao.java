package com.szrj.business.dao.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdMessenger;

/**
 * 办证人员信息
 * @author 李昊
 * Sep 3, 2021
 */
public interface YzdMessengerDao {

	/**
	 * 查询全部 分页
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdMessenger(YzdMessenger messenger, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdMessenger getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param messenger
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdMessenger messenger) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param messenger
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdMessenger messenger) throws DataAccessException;
	
	
}

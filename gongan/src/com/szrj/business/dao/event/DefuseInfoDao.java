package com.szrj.business.dao.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.DefuseInfo;

public interface DefuseInfoDao {
	
	/**
	 * 查询
	 * @param defuseInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(DefuseInfo defuseInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return DefuseInfo
	 * @throws DataAccessException
	 */
	public DefuseInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param defuseInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(DefuseInfo defuseInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param defuseInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(DefuseInfo defuseInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param defuseInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(DefuseInfo defuseInfo) throws DataAccessException;
	
	/**
	 * 计数
	 * @param defuseInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int search_count(DefuseInfo defuseInfo) throws DataAccessException;
	
	/**
	 * 政法委
	 */
	public NewPageModel search_zfw(DefuseInfo defuseInfo,NewPageModel pm) throws DataAccessException;
	public DefuseInfo getById_zfw(int id) throws DataAccessException;
	public int update_zfw(int id) throws DataAccessException;
}

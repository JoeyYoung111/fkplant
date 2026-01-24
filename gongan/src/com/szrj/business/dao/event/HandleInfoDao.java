package com.szrj.business.dao.event;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.HandleInfo;

public interface HandleInfoDao {

	/**
	 * 查询
	 * @param handleInfo
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel search(HandleInfo handleInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 综合查询
	 * @param handleInfo
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchSynthetic(HandleInfo handleInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return HandleInfo
	 * @throws DataAccessException
	 */
	public HandleInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param handleInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(HandleInfo handleInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param handleInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(HandleInfo handleInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param handleInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(HandleInfo handleInfo) throws DataAccessException;
	
	/**
	 * 计算数量
	 * @param handleInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public List<HandleInfo> getHandleInfoNum(HandleInfo handleInfo) throws DataAccessException;
}

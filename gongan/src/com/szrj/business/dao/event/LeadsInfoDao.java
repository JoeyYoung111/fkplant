package com.szrj.business.dao.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.LeadsInfo;

public interface LeadsInfoDao {
	
	/**
	 * 查询
	 * @author lt
	 * @param leadsInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(LeadsInfo leadsInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 综合查询
	 * @param leadsInfo
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchSynthetic(LeadsInfo leadsInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取情报线索信息
	 * @param id
	 * @return LeadsInfo
	 * @throws DataAccessException
	 */
	public LeadsInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param leadsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(LeadsInfo leadsInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param leadsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(LeadsInfo leadsInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param leadsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(LeadsInfo leadsInfo) throws DataAccessException;
	
	/**
	 * 计算情报线索数量
	 * @param leadsInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int search_count(LeadsInfo leadsInfo) throws DataAccessException;
	
	/**
	 * 政法委
	 */
	public NewPageModel search_zfw(LeadsInfo leadsInfo,NewPageModel pm) throws DataAccessException;
	public LeadsInfo getById_zfw(int id) throws DataAccessException;
	public int update_zfw(int id) throws DataAccessException;
}

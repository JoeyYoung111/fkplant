package com.szrj.business.dao.event;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.WorkInfo;

public interface WorkInfoDao {
	
	/**
	 * 查询
	 * @param workInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(WorkInfo workInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return WorkInfo
	 * @throws DataAccessException
	 */
	public WorkInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param workInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param workInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param workInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 签收
	 * @param workInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int sign(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 反馈
	 * @param workInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int feedback(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 获取各类单子数量
	 * @return
	 * @throws DataAccessException
	 */
	public List<WorkInfo> getWorkInfoNum(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 获取最大的编号
	 * @param workInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int getMaxCode(WorkInfo workInfo) throws DataAccessException;
	
	/**
	 * 根据ID获取反馈
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public WorkInfo getFeedback(int id) throws DataAccessException;
}

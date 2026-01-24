package com.szrj.business.dao;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.Log;

/**
 *@author:华夏
 *@date:2020-2-24 上午09:18:49
 */
public interface LogDao {
	
	/**
	 * 查询
	 * @param log
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel searchLog(Log log,NewPageModel pm) throws DataAccessException;
	
	public NewPageModel searchEventLog(Log log,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增日志
	 * @param menuId 操作菜单id
	 * @param operation 操作
	 * @param operator 操作人
	 * @param operationTime 操作时间
	 * @param operationResult 操作结果
	 * @param memo 备注
	 * @return int
	 * @throws DataAccessException
	 */
	public int recordLog(int menuId,String operation,String operator,String operationTime,String operationResult,String memo) throws DataAccessException;
	
	public int recordEventLog(Log log) throws DataAccessException;
}

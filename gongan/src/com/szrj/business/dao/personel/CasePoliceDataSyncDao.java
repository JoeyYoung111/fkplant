package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.Department;
import com.szrj.business.model.interfaces.XdAjxx;
import com.szrj.business.model.interfaces.XdJqxx;

/**
 * 案件/警情数据同步 DAO接口
 */
public interface CasePoliceDataSyncDao {

	/**
	 * 查询当日新增的案件数据
	 * @return 当日新增案件列表
	 * @throws DataAccessException 数据访问异常
	 */
	List<XdAjxx> queryDailyNewCases() throws DataAccessException;

	/**
	 * 查询当日新增的警情数据
	 * @return 当日新增警情列表
	 * @throws DataAccessException 数据访问异常
	 */
	List<XdJqxx> queryDailyNewPoliceIncidents() throws DataAccessException;

	/**
	 * 根据部门编码查询部门信息
	 * @param departcode 部门编码
	 * @return 部门信息
	 * @throws DataAccessException 数据访问异常
	 */
	Department getDepartmentByDepartcode(String departcode) throws DataAccessException;

	/**
	 * 查询人员当前的handle_unit_code字段值（实时查询，避免缓存）
	 * @param personnelId 人员ID
	 * @return handle_unit_code字段值
	 * @throws DataAccessException 数据访问异常
	 */
	String getCurrentHandleUnitCode(int personnelId) throws DataAccessException;

	/**
	 * 更新人员的handle_unit_code字段
	 * @param personnelId 人员ID
	 * @param handleUnitCode 新的handle_unit_code值
	 * @return 影响行数
	 * @throws DataAccessException 数据访问异常
	 */
	int updateHandleUnitCode(int personnelId, String handleUnitCode) throws DataAccessException;

	/**
	 * 根据部门ID获取该部门下所有用户的usercode（逗号分隔）
	 * @param departmentId 部门ID
	 * @return 用户usercode列表，逗号分隔
	 * @throws DataAccessException 数据访问异常
	 */
	String getUserCodesByDepartmentId(int departmentId) throws DataAccessException;

	/**
	 * 更新案件数据flag标志为已处理
	 * @param id 案件记录ID（UUID格式）
	 * @throws DataAccessException 数据访问异常
	 */
	void updateCaseFlag(String id) throws DataAccessException;

	/**
	 * 更新警情数据flag标志为已处理
	 * @param id 警情记录ID（UUID格式）
	 * @throws DataAccessException 数据访问异常
	 */
	void updatePoliceIncidentFlag(String id) throws DataAccessException;

	/**
	 * 查询人员当前的zslabel2字段值
	 * @param personnelId 人员ID
	 * @return zslabel2字段值
	 * @throws DataAccessException 数据访问异常
	 */
	String getCurrentZslabel2(int personnelId) throws DataAccessException;

	/**
	 * 更新人员的zslabel2字段
	 * @param personnelId 人员ID
	 * @param zslabel2 新的zslabel2值
	 * @throws DataAccessException 数据访问异常
	 */
	void updateZslabel2(int personnelId, String zslabel2) throws DataAccessException;
}


package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.personel.FxPersonnelAdd;

/**
 * 风险人员增量同步 DAO
 */
public interface FxPersonnelAddDao {

	/**
	 * 查询未处理的新增数据（增量）
	 * @return 未同步的数据列表
	 * @throws DataAccessException
	 */
	public List<FxPersonnelAdd> selectNotAdded() throws DataAccessException;

	/**
	 * 检查人员是否已存在于 p_personnel_t
	 * @param cardnumber 身份证号
	 * @return 存在的人员数量
	 * @throws DataAccessException
	 */
	public int checkPersonnelExists(String cardnumber) throws DataAccessException;

	/**
	 * 将数据插入 p_personnel_t
	 * @param entity 待插入的数据
	 * @return 影响行数
	 * @throws DataAccessException
	 */
	public int insertIntoPersonnel(FxPersonnelAdd entity) throws DataAccessException;

	/**
	 * 更新同步标记为 'added'
	 * @param id 记录ID（UUID格式）
	 * @return 影响行数
	 * @throws DataAccessException
	 */
	public int markAsAdded(String id) throws DataAccessException;
}


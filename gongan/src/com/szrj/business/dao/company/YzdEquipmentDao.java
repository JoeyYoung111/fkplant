package com.szrj.business.dao.company;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdEquipment;

/**
 * 设备信息
 * @author 李昊
 * Sep 18, 2021
 */
public interface YzdEquipmentDao {

	/**
	 * 查询全部 分页
	 * @param equipment
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdEquipment(YzdEquipment equipment, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdEquipment getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param equipment
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdEquipment equipment) throws DataAccessException;
	
	/**
	 * 删除
	 * @param equipment
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(YzdEquipment equipment) throws DataAccessException;
	
	/**
	 * 修改
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdEquipment equipment) throws DataAccessException;
	
}

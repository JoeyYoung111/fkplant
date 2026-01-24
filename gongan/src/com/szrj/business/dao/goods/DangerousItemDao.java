package com.szrj.business.dao.goods;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.goods.DangerousItem;

public interface DangerousItemDao {
	
	/**
	 * 查询
	 * @param defuseInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(DangerousItem dangerousItem,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return DangerousItem
	 * @throws DataAccessException
	 */
	public DangerousItem getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param dangerousItem
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(DangerousItem dangerousItem) throws DataAccessException;
	
	/**
	 * 删除
	 * @param dangerousItem
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(DangerousItem dangerousItem) throws DataAccessException;
	
	/**
	 * 修改
	 * @param dangerousItem
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(DangerousItem dangerousItem) throws DataAccessException;
	
	/**
	 * 计数
	 * @param dangerousItem
	 * @return
	 * @throws DataAccessException
	 */
	public int search_count(DangerousItem dangerousItem) throws DataAccessException;
	
	public int generateCodenum() throws DataAccessException;
	
	/**
	 * 根据人员查询物品
	 * @param defuseInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel searchItemByPerson(DangerousItem dangerousItem,NewPageModel pm) throws DataAccessException;
	
	public int updatePersonByCodenum(DangerousItem dangerousItem) throws DataAccessException;
	
	public int cancelGoodsConnect(DangerousItem dangerousItem) throws DataAccessException;
}

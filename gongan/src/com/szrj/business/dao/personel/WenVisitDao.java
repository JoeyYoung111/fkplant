package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.WenVisit;

public interface WenVisitDao {
	/**
	 * 查询
	 * @param wenVisit
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchWenVisit(WenVisit wenVisit,NewPageModel pm) throws DataAccessException;
	
	public List<WenVisit> getListByPersonnelid(int personnelid) throws DataAccessException;
	/**
	 * 根据id获取涉访涉诉经历
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public WenVisit getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param wenVisit
	 * @return
	 * @throws DataAccessException
	 */
	public int add(WenVisit wenVisit) throws DataAccessException;
	
	/**
	 * 修改
	 * @param wenVisit
	 * @return
	 * @throws DataAccessException
	 */
	public int update(WenVisit wenVisit) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(WenVisit wenVisit) throws DataAccessException;
	
	/**政法委**/
	public NewPageModel searchWenVisit_zfw(WenVisit wenVisit,NewPageModel pm) throws DataAccessException;
	public WenVisit getById_zfw(int id) throws DataAccessException;
	public int update_zfw(WenVisit wenVisit) throws DataAccessException;
}

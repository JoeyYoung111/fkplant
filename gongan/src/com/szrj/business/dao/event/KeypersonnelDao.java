package com.szrj.business.dao.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.Keypersonnel;

public interface KeypersonnelDao {
	
	/**
	 * 查询
	 * @author lt
	 * @param keypersonnel
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(Keypersonnel keypersonnel,NewPageModel pm) throws DataAccessException;
	public NewPageModel search_Zbevent(Keypersonnel keypersonnel,NewPageModel pm) throws DataAccessException;
	/**
	 * 新增
	 * @param keypersonnel
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(Keypersonnel keypersonnel) throws DataAccessException;
	
	/**
	 * 删除
	 * @param keypersonnel
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(Keypersonnel keypersonnel) throws DataAccessException;
	
	/**
	 * 检测是否已经存在关联
	 * @param keypersonnel
	 * @return
	 * @throws DataAccessException
	 */
	public int count_link(Keypersonnel keypersonnel) throws DataAccessException;
	
	/**
	 * 更新关联信息（新增工作交办管理关联）
	 * @param keypersonnel
	 * @return
	 * @throws DataAccessException
	 */
	public int updateLink(Keypersonnel keypersonnel) throws DataAccessException;
	
	/**
	 * 计算主要组织人员数量
	 * @param keypersonnel
	 * @return
	 * @throws DataAccessException
	 */
	public int search_count(Keypersonnel keypersonnel) throws DataAccessException;
	
	/**
	 * 政法委
	 */
	public NewPageModel search_zfw(Keypersonnel keypersonnel,NewPageModel pm) throws DataAccessException;
	public Keypersonnel getById_zfw(int id) throws DataAccessException;
	public int update_zfw(int id) throws DataAccessException;
	
	public int updateKpImportance(Keypersonnel keypersonnel) throws DataAccessException;
}

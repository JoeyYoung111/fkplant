package com.szrj.business.dao.event;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.EventsInfo;

public interface EventsInfoDao {
	
	/**
	 * 查询
	 * @author lt
	 * @param eventsInfo
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(EventsInfo eventsInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 综合查询
	 * @param eventsInfo
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchSynthetic(EventsInfo eventsInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取引发涉稳事件
	 * @param id
	 * @return EventsInfo
	 * @throws DataAccessException
	 */
	public EventsInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param eventsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(EventsInfo eventsInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param eventsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(EventsInfo eventsInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param eventsInfo
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(EventsInfo eventsInfo) throws DataAccessException;
	
	/**
	 * 计算涉稳事件数量
	 * @param eventsInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int search_count(EventsInfo eventsInfo) throws DataAccessException;
	
	public int countEventByWorkinfoid(EventsInfo eventsInfo) throws DataAccessException;
	
	/**
	 * 政法委
	 */
	public NewPageModel search_zfw(EventsInfo eventsInfo,NewPageModel pm) throws DataAccessException;
	public EventsInfo getById_zfw(int id) throws DataAccessException;
	public int update_zfw(int id) throws DataAccessException;
}

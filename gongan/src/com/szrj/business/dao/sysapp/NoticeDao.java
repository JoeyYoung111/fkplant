package com.szrj.business.dao.sysapp;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.sysapp.MessageRemind;
import com.szrj.business.model.sysapp.Notice;

public interface NoticeDao {
	
	/**
	 * 查询
	 * @param notice
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(Notice notice,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return Notice
	 * @throws DataAccessException
	 */
	public Notice getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param notice
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(Notice notice) throws DataAccessException;
	
	/**
	 * 删除
	 * @param notice
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(Notice notice) throws DataAccessException;
	
	/**
	 * 修改
	 * @param notice
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(Notice notice) throws DataAccessException;
	
	/**
	 * 获取最新的首页消息提醒
	 * @return
	 * @throws DataAccessException
	 */
	public List<MessageRemind> getNewMessageRemind(MessageRemind messageRemind) throws DataAccessException;
}

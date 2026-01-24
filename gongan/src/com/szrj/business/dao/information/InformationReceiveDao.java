package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.InformationReceive;

public interface InformationReceiveDao {

	/**
	 * 查询全部 分页
	 * @param Information
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchInformation(InformationReceive informationReceive,NewPageModel pm,String page) throws DataAccessException;
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return Information
	 * @throws DataAccessException
	 */
	public InformationReceive getById(int id) throws DataAccessException;
	
	/**
	 * 根据informationid查询已被转阅的部门
	 * @param informationid
	 * @return
	 * @throws DataAccessException
	 */
	public List<InformationReceive> searchByinformationid(InformationReceive informationReceive) throws DataAccessException;
	
	/**
	 * 新增
	 * @param informationSend
	 * @return
	 * @throws DataAccessException
	 */
	public int add(InformationReceive informationReceive) throws DataAccessException;
	
	/**
	 * 签收
	 * @param informationReceive
	 * @return
	 * @throws DataAccessException
	 */
	public int qianshou(InformationReceive informationReceive) throws DataAccessException;
	
	/**
	 * 反馈
	 * @param informationReceive
	 * @return
	 * @throws DataAccessException
	 */
	public int fankui(InformationReceive informationReceive) throws DataAccessException;
	
	public List<InformationReceive> rizhizhuanyue(String informationreceiveid) throws DataAccessException;
	
}

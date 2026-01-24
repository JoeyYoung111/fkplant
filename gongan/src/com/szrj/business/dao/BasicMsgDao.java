package com.szrj.business.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.BasicMsg;


/**
 *@author:王婷
 *@date:2021-07-14 
 */
public interface BasicMsgDao {	
	/**
	 * 查询
	 * @param basicMsg
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchBasicMsg(BasicMsg basicMsg,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取数据字典
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public BasicMsg getById(int id) throws DataAccessException;
	/**
	 * 根据memo获取数据字典
	 * @param memo
	 * @return
	 * @throws DataAccessException
	 */
	public BasicMsg getByMemo(String memo) throws DataAccessException;
	
	/**
	 * 根据basicType（数据类型）获取字典列表
	 * @param basicType
	 * @return List<BasicMsg>
	 * @throws DataAccessException
	 */
	public List<BasicMsg> getByType(int basicType) throws DataAccessException;
	/**
	 * 根据basicType和parentid（数据类型）获取字典列表
	 * @param basicType
	 * @return List<BasicMsg>
	 * @throws DataAccessException
	 */
	public List<BasicMsg> getBMByparenttype(BasicMsg basicMsg) throws DataAccessException;
    /**
	 * 新增
	 * @param bm
	 * @return
	 * @throws DataAccessException
	 */
	public int add(BasicMsg basicMsg) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param bm
	 * @return
	 * @throws DataAccessException
	 */
	public int update(BasicMsg basicMsg) throws DataAccessException;

	//根据父节点id查询信息，不要删
	public List<BasicMsg> getBMByParentIdToJSON(int parentid) throws DataAccessException;
	/**
	 * 根据名称查询是否存在重复
	 * @param basicMsg
	 * @return
	 * @throws DataAccessException
	 */
	public int getBasicNameExit(BasicMsg basicMsg) throws DataAccessException;

	public List<BasicMsg> getBasicNamesById(String idlist);
	
	public List<BasicMsg> selectChemicalName(Integer id) throws DataAccessException;
	
	public List<BasicMsg> getBMByParentBasicNameToJSON(String parentBasicName) throws DataAccessException;
	
	public String basicMsgQueryChildren(HashMap map) throws DataAccessException;
	
	public List<BasicMsg> getMsgByid(String idString) throws DataAccessException;
}

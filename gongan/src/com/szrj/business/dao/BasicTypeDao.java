package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.BasicType;

public interface BasicTypeDao {
	/**
	 * 查询全部
	 * @return
	 * @throws DataAccessException
	 */
	public List<BasicType> getAll() throws DataAccessException;
	
	/**
	 * 新增
	 * @param basicType
	 * @return
	 * @throws DataAccessException
	 */
	public int add(BasicType basicType) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @param basicType
	 * @return
	 * @throws DataAccessException
	 */
	public int update(BasicType basicType) throws DataAccessException;
	
	/**
	 * 根据id获取
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public BasicType getById(int id) throws DataAccessException;
	
	/**
	 * 根据basicTypeName查重
	 * @param basicType
	 * @return
	 * @throws DataAccessException
	 */
	public int getTypeNameExit(BasicType basicType) throws DataAccessException;
}

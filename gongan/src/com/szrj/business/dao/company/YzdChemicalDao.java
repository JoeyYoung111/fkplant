package com.szrj.business.dao.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdChemical;

/**
 * 化学品种类
 * @author 李昊
 * Sep 3, 2021
 */
public interface YzdChemicalDao {

	/**
	 * 查询全部 分页
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdChemical(YzdChemical chemical, NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据Id查询化学品种类
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdChemical getById(int id) throws DataAccessException;
	
	/**
	 * 根据companyid查询
	 */
	public List<YzdChemical> getChemicalJSON(int companyid) throws DataAccessException;
	
	/**
	 * 新增
	 * @param chemical
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdChemical chemical) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;

	/**
	 * 修改
	 * @param chemical
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdChemical chemical) throws DataAccessException;
	
	public List<YzdChemical> getChemicalsByid(String idlist);
	
}

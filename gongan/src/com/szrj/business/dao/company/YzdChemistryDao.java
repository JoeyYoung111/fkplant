package com.szrj.business.dao.company;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.company.YzdChemistry;

/**
 * 懂化学技术人员
 * @author 李昊
 * Sep 17, 2021
 */
public interface YzdChemistryDao {

	/**
	 * 查询全部 分页
	 * @param chemistry
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdChemistry(YzdChemistry chemistry, NewPageModel pm) throws DataAccessException;
	/**
	 * 右连接企业表 
	 * @param chemistry
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchYzdChemistry1(YzdChemistry chemistry, NewPageModel pm) throws DataAccessException;
	
	public List<YzdChemistry> searchYzdChemistryList(YzdChemistry chemistry) throws DataAccessException;
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public YzdChemistry getById(int id) throws DataAccessException;
	
	public int getByCardnumber(String cardnumber) throws DataAccessException;
	
	/**
	 * 新增
	 * @param chemistry
	 * @return
	 * @throws DataAccessException
	 */
	public int add(YzdChemistry chemistry) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(YzdChemistry chemistry) throws DataAccessException;
	
	/**
	 * 修改
	 * @param chemistry
	 * @return
	 * @throws DataAccessException
	 */
	public int update(YzdChemistry chemistry) throws DataAccessException;
	
}

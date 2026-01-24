package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.AppButton;

public interface AppButtonDao {
	/**
	 * 查询
	 * @author lt
	 * @param appButton
	 * @param pm
	 * @return PageModel
	 * @throws DataAccessException
	 */
	public NewPageModel searchAppButton(AppButton appButton,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 * @author lt
	 * @param appButton
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(AppButton appButton) throws DataAccessException;
	
	/**
	 * 删除
	 * @author lt
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;
	
	/**
	 * 修改
	 * @author lt
	 * @param appButton
	 * @return int
	 * @throws DataAccessException
	 */
	public int update(AppButton appButton) throws DataAccessException;
	
	public List<AppButton> getZhuButton() throws DataAccessException;
	
	public List<AppButton> searchAllAppButton(AppButton appButton) throws DataAccessException;
	
	public AppButton getById(int id) throws DataAccessException;
	
	public List<AppButton> getMainMobileButton(int roleid) throws DataAccessException;
	
	public List<AppButton> getMobileButtonByParentid(AppButton appButton) throws DataAccessException;
}

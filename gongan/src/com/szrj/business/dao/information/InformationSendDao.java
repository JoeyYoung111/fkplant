package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.InformationSend;

public interface InformationSendDao {
	
	/**
	 * 查询全部 分页
	 * @param Information
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchInformation(InformationSend informationSend,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return Information
	 * @throws DataAccessException
	 */
	public InformationSend getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param informationSend
	 * @return
	 * @throws DataAccessException
	 */
	public int add(InformationSend informationSend) throws DataAccessException;

	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(int id) throws DataAccessException;

	/**
	 * 新增工作批注时修改该ID
	 * @param informationSend
	 * @return
	 * @throws DataAccessException
	 */
	public int pizhuid(InformationSend informationSend) throws DataAccessException;
	
	public int ytpizhuid(InformationSend informationSend) throws DataAccessException;
	
	public int updatetopflag(InformationSend informationSend) throws DataAccessException;
	public int updatehideflag(InformationSend informationSend) throws DataAccessException;
	public int updatefollowflag(InformationSend informationSend) throws DataAccessException;
	public int updateValidflag(InformationSend informationSend) throws DataAccessException;
	public int changeSpecialid(InformationSend informationSend) throws DataAccessException;

	public List<InformationSend> searchAdd(Integer informationid) throws DataAccessException;
	public int searchInformationsend_count(InformationSend informationSend) throws DataAccessException;
	public int searchcountByflag(InformationSend informationSend) throws DataAccessException;
}

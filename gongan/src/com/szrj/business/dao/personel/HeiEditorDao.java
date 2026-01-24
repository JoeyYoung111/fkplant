package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;

import com.szrj.business.model.BasicMsg;
import com.szrj.business.model.personel.HeiEditor;
import com.szrj.business.model.personel.Personnel;

public interface HeiEditorDao {
	/**
	 * 查询
	 * @param basicMsg
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchHeiPersonnel(Personnel personnel,NewPageModel pm) throws DataAccessException;
	
	public List<HeiEditor> searchHeiPersonnelList(Personnel personnel) throws DataAccessException;
	public List<SelectModel> countDistpersonByIncontrolleve() throws DataAccessException;
	
	 /**
	 * 新增
	 * @param heieditor
	 * @return
	 * @throws DataAccessException
	 */
	public int add(HeiEditor heieditor) throws DataAccessException;
	/**
	 * 修改
	 * @param heieditor
	 * @return
	 * @throws DataAccessException
	 */
	public int update(HeiEditor heieditor) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(HeiEditor heieditor) throws DataAccessException;
	/**
	 * 根据人员id查询详情
	 * @param personnelid
	 * @return
	 * @throws DataAccessException
	 */
	public HeiEditor getBypersonnelid(int personnelid) throws DataAccessException;
	/**
	 * 根据id查询详情
	 * @param personnelid
	 * @return
	 * @throws DataAccessException
	 */
	public HeiEditor getHeiEditorById(int id) throws DataAccessException;
}

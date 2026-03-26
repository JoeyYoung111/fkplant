package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.Labelinfo;
import com.szrj.business.model.personel.PersonnelExtend;

public interface PersonnelExtendDao {
	/**
	 * 查询
	 * @param personnelExtend
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchPersonnelExtend(PersonnelExtend personnelExtend,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取通用扩展表
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public PersonnelExtend getById(int id) throws DataAccessException;
	
	public PersonnelExtend getByPersonnelid(PersonnelExtend personnelExtend) throws DataAccessException;
	
	/**
	 * 新增
	 * @param personnelExtend
	 * @return
	 * @throws DataAccessException
	 */
	public int add(PersonnelExtend personnelExtend) throws DataAccessException;
	
	public int update(PersonnelExtend personnelExtend) throws DataAccessException;
	/**
	 * 删除
	 * @param personnelExtend
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(PersonnelExtend personnelExtend) throws DataAccessException;
	
	public List<PersonnelExtend> exportPersonnelExtend(PersonnelExtend personnelExtend) throws DataAccessException;
	
	/**
	 * 根据人员ID列表查询人员基础信息（用于专项导出）
	 * @param personnelIds 人员ID列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<PersonnelExtend> exportPersonnelByIds(String personnelIds) throws DataAccessException;

	public int updateWorkExtend(PersonnelExtend personnelExtend) throws DataAccessException;
	
	/***************************人员标签信息******************************************/
	/**
	 * @param personnelid
	 * @param customlabelid
	 * @param validflag=2
	 * @return
	 * @throws DataAccessException
	 */
	public Labelinfo getLabelinfo(Labelinfo labelinfo) throws DataAccessException;
	
	/**
	 * @param personnelid
	 * @param customlabelid
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchLabelinfo(Labelinfo labelinfo,NewPageModel pm) throws DataAccessException;
	
	public int addLabelinfo(Labelinfo labelinfo) throws DataAccessException;
	/**
	 * @param id
	 * @param validflag
	 * @return
	 * @throws DataAccessException
	 */
	public int updateLabelinfoValidflag(Labelinfo labelinfo) throws DataAccessException;
}

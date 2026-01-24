package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.Personnel;
import com.szrj.business.model.personel.WenGrade;
import com.szrj.business.model.personel.WenJointControlLevel;

public interface WenGradeDao {
	/**
	 * 查询
	 * @param wenGrade
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchWenGrade(WenGrade wenGrade,NewPageModel pm) throws DataAccessException;
	public int countWenGrade(WenGrade wenGrade) throws DataAccessException;
	
	/**
	 * 根据id获取分类分级子表
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public WenGrade getById(int id) throws DataAccessException;
	public WenGrade getBypersonnelid(int personnelid) throws DataAccessException;
	/**
	 * 新增
	 * @param wenGrade
	 * @return
	 * @throws DataAccessException
	 */
	public int add(WenGrade wenGrade) throws DataAccessException;
	
	/**
	 * 修改
	 * @param wenGrade
	 * @return
	 * @throws DataAccessException
	 */
	public int update(WenGrade wenGrade) throws DataAccessException;
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(WenGrade wenGrade) throws DataAccessException;
	public int updatejointcontrollevelapply(WenGrade wenGrade) throws DataAccessException;
	
   /**
    * 联控记录调整  新增、修改、审核、查询
    * @param personnelid
    * @return
    * @throws DataAccessException
    */
	public List<WenJointControlLevel> searchjointcontrollevel(WenJointControlLevel jointcontrollevel) throws DataAccessException;
	public int addjointcontrollevel(WenJointControlLevel jointcontrollevel) throws DataAccessException;
	public int updatejointcontrollevel(WenJointControlLevel jointcontrollevel) throws DataAccessException;
	public int examinejointcontrolleve(WenJointControlLevel jointcontrollevel) throws DataAccessException;
	public WenJointControlLevel getjointcontrolleveById(int id) throws DataAccessException;
	public int getjointcontrollevelCount (int personnelid) throws DataAccessException;
	public WenJointControlLevel getjointcontrollevelNew(int personnelid) throws DataAccessException;
	public int countTodayLevelAdjust() throws DataAccessException;
	public int countTodayLevelUp() throws DataAccessException;
	
	public List<WenGrade> exportWenGrade(WenGrade wenGrade) throws DataAccessException;
	
	public List<Personnel> getRelationchart(WenGrade wenGrade) throws DataAccessException;

	public NewPageModel jointControllerList(WenJointControlLevel jointcontrollevel,NewPageModel pm) throws DataAccessException;
}

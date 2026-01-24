package com.szrj.business.dao.event;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.AxisEvent;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.model.event.ContradictionInfo;
import com.szrj.business.model.event.ZbEventInfo;

public interface ContradictionInfoDao {
	
	/**
	 * 查询
	 * @author lt
	 * @param contradictionInfo
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchContradictionInfo(ContradictionInfo contradictionInfo,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 根据id获取矛盾风险信息
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public ContradictionInfo getById(int id) throws DataAccessException;
	
	/**
	 * 新增
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int add(ContradictionInfo contradictionInfo) throws DataAccessException;
	public int addZbEvent(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 删除
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 修改
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int update(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 获取审查信息
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public ContradictionInfo getCheckContradictionInfo(int id) throws DataAccessException;
	
	/**
	 * 审查
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int check(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 查询时间轴
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public List<AxisEvent> searchTimeaxis(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 根据id获取矛盾风险详细信息
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public ContradictionInfo getDetailById(int id) throws DataAccessException;
	
	/**
	 * 获取数据库中所有矛盾风险名称
	 * @return
	 * @throws DataAccessException
	 */
	public List<String> searchCdtname() throws DataAccessException;
	
	/**
	 * 根据主要组织人员获取风险矛盾
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public List<ContradictionInfo> getCdtByPerson(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 屏蔽
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int block(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/**
	 * 更新 更新时间
	 * @param contradictionInfo
	 * @return
	 * @throws DataAccessException
	 */
	public int updateTime(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	public List<SelectModel> countByCdtresult() throws DataAccessException;
	public List<SelectModel> countByCdttype() throws DataAccessException;
	public List<SelectModel> countByCdtlevel() throws DataAccessException;
	public List<SelectModel> countBySsrs() throws DataAccessException;
	public List<SelectModel> countPersonAndEventByDepartment() throws DataAccessException;
	public List<SelectModel> countEventPercentByDepartment() throws DataAccessException;
	public List<SelectModel> countAllTrendEvent() throws DataAccessException;
	
	/*政保事件详细信息*/
	public NewPageModel search_ZbEventInfo(ZbEventInfo zbEventInfo,NewPageModel pm) throws DataAccessException;
	public int add_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException;
	public int cancel_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException;
	public int update_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException;
	public ZbEventInfo getById_ZbEventInfo(ZbEventInfo zbEventInfo) throws DataAccessException;
	public NewPageModel searchByKeyperson(ContradictionInfo contradictionInfo,NewPageModel pm) throws DataAccessException;
	
	/*导出打印*/
	public ContradictionInfo exportContradictionInfo(ContradictionInfo contradictionInfo) throws DataAccessException;
	
	/*政法委端审核页面*/
	public NewPageModel searchContradictionInfo_zfw(ContradictionInfo contradictionInfo,NewPageModel pm) throws DataAccessException;
	public ContradictionInfo getById_zfw(int id) throws DataAccessException;
	public int check_zfw(ContradictionInfo contradictionInfo) throws DataAccessException;
}

package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.ZaDu;
import com.szrj.business.model.personel.ZaChang;
import com.szrj.business.model.personel.ZaPei;
import com.szrj.business.model.personel.ZaExtend;
import com.szrj.business.model.personel.ZaCaseAddress;
import com.szrj.business.model.personel.HomeplaceHistory;
import com.szrj.business.model.personel.PhoneHistory;
import com.szrj.business.model.personel.ZaDuAjRel;
import com.szrj.business.model.personel.ZaDuJqRel;
import com.szrj.business.model.personel.ZaChangAjRel;
import com.szrj.business.model.personel.ZaChangJqRel;
import com.szrj.business.model.personel.ZaPeiAjRel;
import com.szrj.business.model.personel.ZaPeiJqRel;

public interface ZaExtendDao {
	
	public int add(ZaExtend zaExtend) throws DataAccessException;
	
	public int update(ZaExtend zaExtend) throws DataAccessException;
	
	public NewPageModel search(ZaExtend zaExtend,NewPageModel pm) throws DataAccessException;
	
	public ZaExtend getById(int personnelid) throws DataAccessException;
	
	// 涉赌相关
	public ZaDu getZaDuByPersonnelid(int personnelid) throws DataAccessException;
	public ZaDu getZaDuById(int duId) throws DataAccessException; // 根据ID查询涉赌记录
	public int addZaDu(ZaDu zaDu) throws DataAccessException;
	public int updateZaDu(ZaDu zaDu) throws DataAccessException;
	public NewPageModel searchZaDu(ZaDu zaDu,NewPageModel pm) throws DataAccessException;
	public int deleteZaDuById(int duId) throws DataAccessException; // 删除涉赌主表记录

	// 涉娼相关
	public ZaChang getZaChangByPersonnelid(int personnelid) throws DataAccessException;
	public ZaChang getZaChangById(int changId) throws DataAccessException; // 根据ID查询涉娼记录
	public int addZaChang(ZaChang zaChang) throws DataAccessException;
	public int updateZaChang(ZaChang zaChang) throws DataAccessException;
	public NewPageModel searchZaChang(ZaChang zaChang,NewPageModel pm) throws DataAccessException;
	public int deleteZaChangById(int changId) throws DataAccessException; // 删除涉娼主表记录

	// 陪侍相关
	public ZaPei getZaPeiByPersonnelid(int personnelid) throws DataAccessException;
	public ZaPei getZaPeiById(int peiId) throws DataAccessException; // 根据ID查询陪侍记录
	public int addZaPei(ZaPei zaPei) throws DataAccessException;
	public int updateZaPei(ZaPei zaPei) throws DataAccessException;
	public NewPageModel searchZaPei(ZaPei zaPei,NewPageModel pm) throws DataAccessException;
	public int deleteZaPeiById(int peiId) throws DataAccessException; // 删除陪侍主表记录

	// 涉案地址相关
	public int addCaseAddress(ZaCaseAddress address) throws DataAccessException;
	public int deleteCaseAddressByRecordId(int recordId, int recordType) throws DataAccessException;
	public List<ZaCaseAddress> getCaseAddressByRecordId(int recordId, int recordType) throws DataAccessException;

	// 住址历史相关
	public int addHomeplaceHistory(HomeplaceHistory history) throws DataAccessException;
	public List<HomeplaceHistory> getHomeplaceHistoryByPersonnelid(int personnelid) throws DataAccessException;

	// 电话历史相关
	public int addPhoneHistory(PhoneHistory history) throws DataAccessException;
	public List<PhoneHistory> getPhoneHistoryByPersonnelid(int personnelid) throws DataAccessException;

	// ========== 涉赌-案件关联 ==========
	public int batchInsertDuAjRel(List<ZaDuAjRel> relList) throws DataAccessException;
	public int deleteByDuId(int duId) throws DataAccessException;
	public int deleteDuRelByDuId(int duId) throws DataAccessException; // 删除涉赌的所有关联（案件+警情）
	public int updateDuAjRelValidflag(int duId, int validflag) throws DataAccessException; // 更新涉赌-案件关联validflag
	public int insertDuAjRel(int duId, int personnelid, int ajId, String addtime) throws DataAccessException;
	public List<Object> findAjByDuId(int duId) throws DataAccessException;
	public List<ZaDu> findDuByAjId(int ajId) throws DataAccessException;
	public List<Object> findAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉赌-警情关联 ==========
	public int batchInsertDuJqRel(List<ZaDuJqRel> relList) throws DataAccessException;
	public int deleteDuJqByDuId(int duId) throws DataAccessException;
	public int updateDuJqRelValidflag(int duId, int validflag) throws DataAccessException; // 更新涉赌-警情关联validflag
	public int insertDuJqRel(int duId, int personnelid, int jqId, String addtime) throws DataAccessException;
	public List<Object> findJqByDuId(int duId) throws DataAccessException;
	public List<ZaDu> findDuByJqId(int jqId) throws DataAccessException;
	public List<Object> findJqByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉娼-案件关联 ==========
	public int batchInsertChangAjRel(List<ZaChangAjRel> relList) throws DataAccessException;
	public int deleteByChangId(int changId) throws DataAccessException;
	public int deleteChangRelByChangId(int changId) throws DataAccessException; // 删除涉娼的所有关联（案件+警情）
	public int insertChangAjRel(int changId, int personnelid, int ajId, String addtime) throws DataAccessException;
	public int updateChangAjRelValidflag(int changId, int validflag) throws DataAccessException; // 更新涉娼-案件关联validflag
	public List<Object> findAjByChangId(int changId) throws DataAccessException;
	public List<ZaChang> findChangByAjId(int ajId) throws DataAccessException;
	public List<Object> findChangAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉娼-警情关联 ==========
	public int batchInsertChangJqRel(List<ZaChangJqRel> relList) throws DataAccessException;
	public int deleteChangJqByChangId(int changId) throws DataAccessException;
	public int insertChangJqRel(int changId, int personnelid, int jqId, String addtime) throws DataAccessException;
	public int updateChangJqRelValidflag(int changId, int validflag) throws DataAccessException; // 更新涉娼-警情关联validflag
	public List<Object> findJqByChangId(int changId) throws DataAccessException;
	public List<ZaChang> findChangByJqId(int jqId) throws DataAccessException;
	public List<Object> findChangJqByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 陪侍-案件关联 ==========
	public int batchInsertPeiAjRel(List<ZaPeiAjRel> relList) throws DataAccessException;
	public int insertPeiAjRel(int peiId, int personnelid, int ajId, String addtime) throws DataAccessException;
	public int updatePeiAjRelValidflag(int peiId, int validflag) throws DataAccessException; // 更新陪侍-案件关联validflag

	// ========== 导出相关查询 ==========
	/**
	 * 根据人员ID列表查询涉赌记录
	 * @param personnelIds 人员ID列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<ZaDu> getZaDuListByPersonnelIds(String personnelIds) throws DataAccessException;

	/**
	 * 根据人员ID列表查询涉娼记录
	 * @param personnelIds 人员ID列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<ZaChang> getZaChangListByPersonnelIds(String personnelIds) throws DataAccessException;

	/**
	 * 根据人员ID列表查询陪侍记录
	 * @param personnelIds 人员ID列表，逗号分隔
	 * @return
	 * @throws DataAccessException
	 */
	public List<ZaPei> getZaPeiListByPersonnelIds(String personnelIds) throws DataAccessException;

	/**
	 * 查询涉娼未成年案件的人员ID列表
	 * @return 人员ID列表
	 * @throws DataAccessException
	 */
	public List<Integer> getMinorCasePersonnelIds() throws DataAccessException;
	public int deleteByPeiId(int peiId) throws DataAccessException;
	public int deletePeiRelByPeiId(int peiId) throws DataAccessException; // 删除陪侍的所有关联（案件+警情）
	public List<Object> findAjByPeiId(int peiId) throws DataAccessException;
	public List<ZaPei> findPeiByAjId(int ajId) throws DataAccessException;
	public List<Object> findPeiAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 陪侍-警情关联 ==========
	public int batchInsertPeiJqRel(List<ZaPeiJqRel> relList) throws DataAccessException;
	public int deletePeiJqByPeiId(int peiId) throws DataAccessException;
	public int updatePeiJqRelValidflag(int peiId, int validflag) throws DataAccessException; // 更新陪侍-警情关联validflag
	public int insertPeiJqRel(int peiId, int personnelid, int jqId, String addtime) throws DataAccessException;
	public List<Object> findJqByPeiId(int peiId) throws DataAccessException;
	public List<ZaPei> findPeiByJqId(int jqId) throws DataAccessException;
	public List<Object> findPeiJqByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 前科判定相关 ==========
	/**
	 * 判断人员是否存在涉赌记录
	 * @param personnelId 人员ID
	 * @return true-存在涉赌记录, false-不存在
	 */
	public boolean existsDuByPersonnelId(int personnelId) throws DataAccessException;

	/**
	 * 判断人员是否存在涉娼记录
	 * @param personnelId 人员ID
	 * @return true-存在涉娼记录, false-不存在
	 */
	public boolean existsChangByPersonnelId(int personnelId) throws DataAccessException;

	/**
	 * 判断人员是否存在陪侍记录
	 * @param personnelId 人员ID
	 * @return true-存在陪侍记录, false-不存在
	 */
	public boolean existsPeiByPersonnelId(int personnelId) throws DataAccessException;
}

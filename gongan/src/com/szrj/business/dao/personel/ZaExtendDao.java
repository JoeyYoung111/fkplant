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
	public int addZaDu(ZaDu zaDu) throws DataAccessException;
	public int updateZaDu(ZaDu zaDu) throws DataAccessException;
	public NewPageModel searchZaDu(ZaDu zaDu,NewPageModel pm) throws DataAccessException;
	
	// 涉娼相关
	public ZaChang getZaChangByPersonnelid(int personnelid) throws DataAccessException;
	public int addZaChang(ZaChang zaChang) throws DataAccessException;
	public int updateZaChang(ZaChang zaChang) throws DataAccessException;
	public NewPageModel searchZaChang(ZaChang zaChang,NewPageModel pm) throws DataAccessException;

	// 陪侍相关
	public ZaPei getZaPeiByPersonnelid(int personnelid) throws DataAccessException;
	public int addZaPei(ZaPei zaPei) throws DataAccessException;
	public int updateZaPei(ZaPei zaPei) throws DataAccessException;
	public NewPageModel searchZaPei(ZaPei zaPei,NewPageModel pm) throws DataAccessException;

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
	public List<Object> findAjByDuId(int duId) throws DataAccessException;
	public List<ZaDu> findDuByAjId(int ajId) throws DataAccessException;
	public List<Object> findAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉赌-警情关联 ==========
	public int batchInsertDuJqRel(List<ZaDuJqRel> relList) throws DataAccessException;
	public int deleteDuJqByDuId(int duId) throws DataAccessException;
	public List<Object> findJqByDuId(int duId) throws DataAccessException;
	public List<ZaDu> findDuByJqId(int jqId) throws DataAccessException;
	public List<Object> findJqByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉娼-案件关联 ==========
	public int batchInsertChangAjRel(List<ZaChangAjRel> relList) throws DataAccessException;
	public int deleteByChangId(int changId) throws DataAccessException;
	public List<Object> findAjByChangId(int changId) throws DataAccessException;
	public List<ZaChang> findChangByAjId(int ajId) throws DataAccessException;
	public List<Object> findChangAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 涉娼-警情关联 ==========
	public int batchInsertChangJqRel(List<ZaChangJqRel> relList) throws DataAccessException;
	public int deleteChangJqByChangId(int changId) throws DataAccessException;
	public List<Object> findJqByChangId(int changId) throws DataAccessException;
	public List<ZaChang> findChangByJqId(int jqId) throws DataAccessException;
	public List<Object> findChangJqByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 陪侍-案件关联 ==========
	public int batchInsertPeiAjRel(List<ZaPeiAjRel> relList) throws DataAccessException;
	public int deleteByPeiId(int peiId) throws DataAccessException;
	public List<Object> findAjByPeiId(int peiId) throws DataAccessException;
	public List<ZaPei> findPeiByAjId(int ajId) throws DataAccessException;
	public List<Object> findPeiAjByPersonnelId(int personnelId) throws DataAccessException;

	// ========== 陪侍-警情关联 ==========
	public int batchInsertPeiJqRel(List<ZaPeiJqRel> relList) throws DataAccessException;
	public int deletePeiJqByPeiId(int peiId) throws DataAccessException;
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
}

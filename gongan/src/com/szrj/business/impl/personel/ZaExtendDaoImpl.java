package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.ZaExtendDao;
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

public class ZaExtendDaoImpl extends BaseDaoiBatis implements ZaExtendDao{

	public int add(ZaExtend zaExtend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.add", zaExtend);
	}

	public int update(ZaExtend zaExtend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("zaExtend.update", zaExtend);
	}

	public NewPageModel search(ZaExtend zaExtend, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.search_count", zaExtend);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("zaExtend.search", zaExtend, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public ZaExtend getById(int personnelid) throws DataAccessException {
		return (ZaExtend)getSqlMapClientTemplate().queryForObject("zaExtend.getById", personnelid);
	}

	public int addZaDu(ZaDu zaDu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addZaDu", zaDu);
	}

	public ZaDu getZaDuByPersonnelid(int personnelid)
			throws DataAccessException {
		return (ZaDu)getSqlMapClientTemplate().queryForObject("zaExtend.getZaDuByPersonnelid", personnelid);
	}

	public NewPageModel searchZaDu(ZaDu zaDu, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.searchZaDu_count", zaDu);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("zaExtend.searchZaDu", zaDu, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateZaDu(ZaDu zaDu) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("zaExtend.updateZaDu", zaDu);
	}
	
	public int addZaChang(ZaChang zaChang) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addZaChang", zaChang);
	}
	
	public ZaChang getZaChangByPersonnelid(int personnelid)
	throws DataAccessException {
		return (ZaChang)getSqlMapClientTemplate().queryForObject("zaExtend.getZaChangByPersonnelid", personnelid);
	}
	
	public NewPageModel searchZaChang(ZaChang zaChang, NewPageModel pm)
	throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.searchZaChang_count", zaChang);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("zaExtend.searchZaChang", zaChang, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public int updateZaChang(ZaChang zaChang) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("zaExtend.updateZaChang", zaChang);
	}

	// 陪侍相关
	public int addZaPei(ZaPei zaPei) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addZaPei", zaPei);
	}

	public ZaPei getZaPeiByPersonnelid(int personnelid) throws DataAccessException {
		return (ZaPei)getSqlMapClientTemplate().queryForObject("zaExtend.getZaPeiByPersonnelid", personnelid);
	}

	public NewPageModel searchZaPei(ZaPei zaPei, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.searchZaPei_count", zaPei);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("zaExtend.searchZaPei", zaPei, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateZaPei(ZaPei zaPei) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("zaExtend.updateZaPei", zaPei);
	}

	// 涉案地址相关
	public int addCaseAddress(ZaCaseAddress address) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addCaseAddress", address);
	}

	public int deleteCaseAddressByRecordId(int recordId, int recordType) throws DataAccessException {
		ZaCaseAddress param = new ZaCaseAddress();
		param.setRecordId(recordId);
		param.setRecordType(recordType);
		return getSqlMapClientTemplate().update("zaExtend.deleteCaseAddressByRecordId", param);
	}

	@SuppressWarnings("unchecked")
	public List<ZaCaseAddress> getCaseAddressByRecordId(int recordId, int recordType) throws DataAccessException {
		ZaCaseAddress param = new ZaCaseAddress();
		param.setRecordId(recordId);
		param.setRecordType(recordType);
		return getSqlMapClientTemplate().queryForList("zaExtend.getCaseAddressByRecordId", param);
	}

	// 住址历史相关
	public int addHomeplaceHistory(HomeplaceHistory history) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addHomeplaceHistory", history);
	}

	@SuppressWarnings("unchecked")
	public List<HomeplaceHistory> getHomeplaceHistoryByPersonnelid(int personnelid) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.getHomeplaceHistoryByPersonnelid", personnelid);
	}

	// 电话历史相关
	public int addPhoneHistory(PhoneHistory history) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("zaExtend.addPhoneHistory", history);
	}

	@SuppressWarnings("unchecked")
	public List<PhoneHistory> getPhoneHistoryByPersonnelid(int personnelid) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.getPhoneHistoryByPersonnelid", personnelid);
	}

	// ========== 涉赌-案件关联实现 ==========
	public int batchInsertDuAjRel(List<ZaDuAjRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertDuAjRel", relList);
		return relList.size();
	}

	public int deleteByDuId(int duId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deleteDuAjByDuId", duId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findAjByDuId(int duId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findAjByDuId", duId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaDu> findDuByAjId(int ajId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findDuByAjId", ajId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findAjByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findAjByPersonnelId", personnelId);
	}

	// ========== 涉赌-警情关联实现 ==========
	public int batchInsertDuJqRel(List<ZaDuJqRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertDuJqRel", relList);
		return relList.size();
	}

	public int deleteDuJqByDuId(int duId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deleteDuJqByDuId", duId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findJqByDuId(int duId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findJqByDuId", duId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaDu> findDuByJqId(int jqId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findDuByJqId", jqId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findJqByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findJqByPersonnelId", personnelId);
	}

	// ========== 涉娼-案件关联实现 ==========
	public int batchInsertChangAjRel(List<ZaChangAjRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertChangAjRel", relList);
		return relList.size();
	}

	public int deleteByChangId(int changId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deleteChangAjByChangId", changId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findAjByChangId(int changId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findAjByChangId", changId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaChang> findChangByAjId(int ajId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findChangByAjId", ajId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findChangAjByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findChangAjByPersonnelId", personnelId);
	}

	// ========== 涉娼-警情关联实现 ==========
	public int batchInsertChangJqRel(List<ZaChangJqRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertChangJqRel", relList);
		return relList.size();
	}

	public int deleteChangJqByChangId(int changId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deleteChangJqByChangId", changId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findJqByChangId(int changId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findJqByChangId", changId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaChang> findChangByJqId(int jqId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findChangByJqId", jqId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findChangJqByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findChangJqByPersonnelId", personnelId);
	}

	// ========== 陪侍-案件关联实现 ==========
	public int batchInsertPeiAjRel(List<ZaPeiAjRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertPeiAjRel", relList);
		return relList.size();
	}

	public int deleteByPeiId(int peiId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deletePeiAjByPeiId", peiId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findAjByPeiId(int peiId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findAjByPeiId", peiId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaPei> findPeiByAjId(int ajId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findPeiByAjId", ajId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findPeiAjByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findPeiAjByPersonnelId", personnelId);
	}

	// ========== 陪侍-警情关联实现 ==========
	public int batchInsertPeiJqRel(List<ZaPeiJqRel> relList) throws DataAccessException {
		getSqlMapClientTemplate().insert("zaExtend.batchInsertPeiJqRel", relList);
		return relList.size();
	}

	public int deletePeiJqByPeiId(int peiId) throws DataAccessException {
		return getSqlMapClientTemplate().update("zaExtend.deletePeiJqByPeiId", peiId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findJqByPeiId(int peiId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findJqByPeiId", peiId);
	}

	@SuppressWarnings("unchecked")
	public List<ZaPei> findPeiByJqId(int jqId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findPeiByJqId", jqId);
	}

	@SuppressWarnings("unchecked")
	public List<Object> findPeiJqByPersonnelId(int personnelId) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("zaExtend.findPeiJqByPersonnelId", personnelId);
	}

	// ========== 前科判定相关实现 ==========
	public boolean existsDuByPersonnelId(int personnelId) throws DataAccessException {
		Integer count = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.existsDuByPersonnelId", personnelId);
		return count != null && count > 0;
	}

	public boolean existsChangByPersonnelId(int personnelId) throws DataAccessException {
		Integer count = (Integer) getSqlMapClientTemplate().queryForObject("zaExtend.existsChangByPersonnelId", personnelId);
		return count != null && count > 0;
	}
}

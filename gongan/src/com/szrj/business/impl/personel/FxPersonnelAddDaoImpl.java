package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.personel.FxPersonnelAddDao;
import com.szrj.business.model.personel.FxPersonnelAdd;

/**
 * 风险人员增量同步 DAO 实现
 */
public class FxPersonnelAddDaoImpl extends BaseDaoiBatis implements FxPersonnelAddDao {

	@Override
	public List<FxPersonnelAdd> selectNotAdded() throws DataAccessException {
		return (List<FxPersonnelAdd>) getSqlMapClientTemplate().queryForList("fxPersonnelAdd.selectNotAdded");
	}

	@Override
	public int checkPersonnelExists(String cardnumber) throws DataAccessException {
		Integer count = (Integer) getSqlMapClientTemplate().queryForObject("fxPersonnelAdd.checkPersonnelExists", cardnumber);
		return count != null ? count : 0;
	}

	@Override
	public int insertIntoPersonnel(FxPersonnelAdd entity) throws DataAccessException {
		getSqlMapClientTemplate().insert("fxPersonnelAdd.insertIntoPersonnel", entity);
		// iBATIS insert 返回 null，这里返回 1 表示成功（如果失败会抛出异常）
		return 1;
	}

	@Override
	public int markAsAdded(String id) throws DataAccessException {
		return (Integer) getSqlMapClientTemplate().update("fxPersonnelAdd.markAsAdded", id);
	}
}


package com.szrj.business.impl.event;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.event.AuditRecordDao;
import com.szrj.business.model.event.AuditRecord;

public class AuditRecordDaoImpl extends BaseDaoiBatis implements AuditRecordDao {

	public int add(AuditRecord auditRecord) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("auditRecord.add", auditRecord);
	}

	public NewPageModel search(AuditRecord auditRecord, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("auditRecord.search_count", auditRecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("auditRecord.search", auditRecord, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

}

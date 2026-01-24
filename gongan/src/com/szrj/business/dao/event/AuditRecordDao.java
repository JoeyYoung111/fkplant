package com.szrj.business.dao.event;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.event.AuditRecord;

public interface AuditRecordDao {
	
	/**
	 * 查询
	 * @param auditRecord
	 * @param pm
	 * @return NewPageModel
	 * @throws DataAccessException
	 */
	public NewPageModel search(AuditRecord auditRecord,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 新增
	 * @param auditRecord
	 * @return int
	 * @throws DataAccessException
	 */
	public int add(AuditRecord auditRecord) throws DataAccessException;
}

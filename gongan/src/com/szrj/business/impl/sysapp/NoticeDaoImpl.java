package com.szrj.business.impl.sysapp;

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.sysapp.NoticeDao;
import com.szrj.business.model.sysapp.MessageRemind;
import com.szrj.business.model.sysapp.Notice;


public class NoticeDaoImpl extends BaseDaoiBatis implements NoticeDao{

	private static final Logger logger = Logger.getLogger(NoticeDaoImpl.class);

	public int add(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("notice.add", notice);
	}

	public int cancel(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("notice.cancel", notice);
	}

	public Notice getById(int id) throws DataAccessException {
		return (Notice)getSqlMapClientTemplate().queryForObject("notice.getById", id);
	}

	public NewPageModel search(Notice notice, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("notice.search_count", notice);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("notice.search", notice, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(Notice notice) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("notice.update", notice);
	}

	@SuppressWarnings("unchecked")
	public List<MessageRemind> getNewMessageRemind(MessageRemind messageRemind) throws DataAccessException {
//		logger.info("【DAO层】start getNewMessageRemind查询");
//		logger.info("【DAO层】parm - departmentid: " + messageRemind.getDepartmentid());
//		logger.info("【DAO层】parm - addoperatorid: " + messageRemind.getAddoperatorid());
//		logger.info("【DAO层】parm - isCheck: " + messageRemind.getIsCheck());
//		logger.info("【DAO层】parm - casePoliceReadFlag: " + messageRemind.getCasePoliceReadFlag());
//		logger.info("【DAO层】parm - lastReadTime: " + messageRemind.getLastReadTime());
//		logger.info("【DAO层】SQL change into departmentid(sys_department_t.id) as sys_department_t_new.id");

		List<MessageRemind> result = (List<MessageRemind>)getSqlMapClientTemplate().queryForList("notice.getNewMessageRemind",messageRemind);

//		logger.info("【DAO层】查询完成，返回结果数量: " + (result != null ? result.size() : 0));
		if (result != null && result.size() > 0) {
			for (MessageRemind msg : result) {
				if (msg.getMessagecontent() != null && msg.getMessagecontent().contains("新案件")) {
//					logger.info("【DAO层】找到新案件提醒: " + msg.getMessagecontent());
				}
				if (msg.getMessagecontent() != null && msg.getMessagecontent().contains("新警情")) {
//					logger.info("【DAO层】找到新警情提醒: " + msg.getMessagecontent());
				}
			}
		}
		return result;
	}
}

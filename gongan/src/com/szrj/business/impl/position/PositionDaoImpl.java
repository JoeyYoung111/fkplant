package com.szrj.business.impl.position;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.position.PositionDao;
import com.szrj.business.model.position.Position;
import com.szrj.business.model.position.PositionCard;
import com.szrj.business.model.position.PositionEvent;
import com.szrj.business.model.position.PositionPersonnel;
import com.szrj.business.model.position.PositionWorkRecord;

public class PositionDaoImpl extends BaseDaoiBatis implements PositionDao {
	/******** 政保阵地主表 *********/
	public NewPageModel searchPosition(Position position, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("position.searchPosition_count", position);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("position.searchPosition", position, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public Position getById(int id) throws DataAccessException {
		return (Position)getSqlMapClientTemplate().queryForObject("position.getById", id);
	}
	
	public int add(Position position) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("position.add", position);
	}
	
	public int update(Position position) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.update", position);
	}
	
	public int cancel(Position position) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.cancel", position);
	}
	/******** 政保阵地——登记证书 *********/
	public NewPageModel searchPositionCard(PositionCard positionCard,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("position.searchPositionCard_count", positionCard);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("position.searchPositionCard", positionCard, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public PositionCard getPositionCardById(int id) throws DataAccessException {
		return (PositionCard)getSqlMapClientTemplate().queryForObject("position.getPositionCardById", id);
	}
	
	public int addPositionCard(PositionCard positionCard)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("position.addPositionCard", positionCard);
	}
	
	public int updatePositionCard(PositionCard positionCard)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.updatePositionCard", positionCard);
	}
	
	public int cancelPositionCard(PositionCard positionCard)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.cancelPositionCard", positionCard);
	}
	
	@SuppressWarnings("unchecked")
	public List<PositionCard> getPositionCardListByPositionid(int positionid)
			throws DataAccessException {
		return (List<PositionCard>)getSqlMapClientTemplate().queryForList("position.getPositionCardListByPositionid", positionid);
	}
	/******** 政保阵地——人员情况（风险人员） *********/
	public NewPageModel searchPositionPersonnel(
			PositionPersonnel positionPersonnel, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("position.searchPositionPersonnel_count", positionPersonnel);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("position.searchPositionPersonnel", positionPersonnel, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public PositionPersonnel getPositionPersonnelById(int id)
			throws DataAccessException {
		return (PositionPersonnel)getSqlMapClientTemplate().queryForObject("position.getPositionPersonnelById", id);
	}
	
	public int addPositionPersonnel(PositionPersonnel positionPersonnel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("position.addPositionPersonnel", positionPersonnel);
	}
	
	public int updatePositionPersonnel(PositionPersonnel positionPersonnel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.updatePositionPersonnel", positionPersonnel);
	}

	public int cancelPositionPersonnel(PositionPersonnel positionPersonnel)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.cancelPositionPersonnel", positionPersonnel);
	}
	
	@SuppressWarnings("unchecked")
	public List<PositionPersonnel> getPositionPersonnelListByPositionid(
			int positionid) throws DataAccessException {
		return (List<PositionPersonnel>)getSqlMapClientTemplate().queryForList("position.getPositionPersonnelListByPositionid", positionid);
	}
	
	/***************政保阵地-主要活动*************************/
	
	public NewPageModel searchPositionEvent(PositionEvent positionEvent,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("position.searchPositionEvent_count", positionEvent);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("position.searchPositionEvent", positionEvent, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public PositionEvent getPositionEventById(int id) throws DataAccessException {
		return (PositionEvent)getSqlMapClientTemplate().queryForObject("position.getPositionEventById", id);
	}
	
	public int addPositionEvent(PositionEvent positionEvent)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("position.addPositionEvent", positionEvent);
	}
	
	public int updatePositionEvent(PositionEvent positionEvent)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.updatePositionEvent", positionEvent);
	}
	
	public int cancelPositionEvent(PositionEvent positionEvent)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.cancelPositionEvent", positionEvent);
	}
	
	@SuppressWarnings("unchecked")
	public List<PositionEvent> getPositionEventListByPositionid(int positionid)
			throws DataAccessException {
		return (List<PositionEvent>)getSqlMapClientTemplate().queryForList("position.getPositionEventListByPositionid", positionid);
	}
	
	/***************政保阵地-工作记录*************************/
	public NewPageModel searchPositionWorkRecord(PositionWorkRecord positionWorkRecord,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("position.searchPositionWorkRecord_count", positionWorkRecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("position.searchPositionWorkRecord", positionWorkRecord, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	public PositionWorkRecord getPositionWorkRecordById(int id) throws DataAccessException {
		return (PositionWorkRecord)getSqlMapClientTemplate().queryForObject("position.getPositionWorkRecordById", id);
	}
	
	public int addPositionWorkRecord(PositionWorkRecord positionWorkRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("position.addPositionWorkRecord", positionWorkRecord);
	}
	
	public int updatePositionWorkRecord(PositionWorkRecord positionWorkRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.updatePositionWorkRecord", positionWorkRecord);
	}
	
	public int cancelPositionWorkRecord(PositionWorkRecord positionWorkRecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("position.cancelPositionWorkRecord", positionWorkRecord);
	}
	
	@SuppressWarnings("unchecked")
	public List<PositionWorkRecord> getPositionWorkRecordListByPositionid(int positionid)
			throws DataAccessException {
		return (List<PositionWorkRecord>)getSqlMapClientTemplate().queryForList("position.getPositionWorkRecordListByPositionid", positionid);
	}
	
	

}

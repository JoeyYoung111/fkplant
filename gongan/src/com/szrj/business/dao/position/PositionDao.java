package com.szrj.business.dao.position;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.position.Position;
import com.szrj.business.model.position.PositionCard;
import com.szrj.business.model.position.PositionEvent;
import com.szrj.business.model.position.PositionPersonnel;
import com.szrj.business.model.position.PositionWorkRecord;

public interface PositionDao {
	/******** 政保阵地主表 *********/
	public NewPageModel searchPosition(Position position,NewPageModel pm) throws DataAccessException;
	public Position getById(int id) throws DataAccessException;
	public int add(Position position) throws DataAccessException;
	public int update(Position position) throws DataAccessException;
	public int cancel(Position position) throws DataAccessException;
	/******** 政保阵地——登记证书 *********/
	public NewPageModel searchPositionCard(PositionCard positionCard,NewPageModel pm) throws DataAccessException;
	public PositionCard getPositionCardById(int id) throws DataAccessException;
	public int addPositionCard(PositionCard positionCard) throws DataAccessException;
	public int updatePositionCard(PositionCard positionCard) throws DataAccessException;
	public int cancelPositionCard(PositionCard positionCard) throws DataAccessException;
	public List<PositionCard> getPositionCardListByPositionid(int positionid) throws DataAccessException;
	/******** 政保阵地——人员情况（风险人员） *********/
	public NewPageModel searchPositionPersonnel(PositionPersonnel positionPersonnel,NewPageModel pm) throws DataAccessException;
	public PositionPersonnel getPositionPersonnelById(int id) throws DataAccessException;
	public int addPositionPersonnel(PositionPersonnel positionPersonnel) throws DataAccessException;
	public int updatePositionPersonnel(PositionPersonnel positionPersonnel) throws DataAccessException;
	public int cancelPositionPersonnel(PositionPersonnel positionPersonnel) throws DataAccessException;
	public List<PositionPersonnel> getPositionPersonnelListByPositionid(int positionid) throws DataAccessException;
	/*********政保阵地-主要活动情况***************************/
	public NewPageModel searchPositionEvent(PositionEvent positionEvent,NewPageModel pm) throws DataAccessException;
	public PositionEvent getPositionEventById(int id) throws DataAccessException;
	public int addPositionEvent(PositionEvent positionEvent) throws DataAccessException;
	public int updatePositionEvent(PositionEvent positionEvent) throws DataAccessException;
	public int cancelPositionEvent(PositionEvent positionEvent) throws DataAccessException;
	public List<PositionEvent> getPositionEventListByPositionid(int positionid) throws DataAccessException;
	/*********政保阵地-工作记录***************************/
	public NewPageModel searchPositionWorkRecord(PositionWorkRecord positionWorkRecord,NewPageModel pm) throws DataAccessException;
	public PositionWorkRecord getPositionWorkRecordById(int id) throws DataAccessException;
	public int addPositionWorkRecord(PositionWorkRecord positionWorkRecord) throws DataAccessException;
	public int updatePositionWorkRecord(PositionWorkRecord positionWorkRecord) throws DataAccessException;
	public int cancelPositionWorkRecord(PositionWorkRecord positionWorkRecord) throws DataAccessException;
	public List<PositionWorkRecord> getPositionWorkRecordListByPositionid(int positionid) throws DataAccessException;
	
}

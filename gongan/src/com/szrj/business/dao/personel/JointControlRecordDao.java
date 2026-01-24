package com.szrj.business.dao.personel;

import org.springframework.dao.DataAccessException;
import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.JointControlRecord;

public interface JointControlRecordDao {
	public NewPageModel searchJointControlRecord(JointControlRecord jointcontrolrecord,NewPageModel pm) throws DataAccessException;
	
	public int add(JointControlRecord jointcontrolrecord) throws DataAccessException;
	
	public int update(JointControlRecord jointcontrolrecord) throws DataAccessException;
	
	public int cancel(JointControlRecord jointcontrolrecord) throws DataAccessException;
	
	public JointControlRecord getJointControlRecordByid(int id) throws DataAccessException;
	
	public int updateWenVisit(JointControlRecord jointControlRecord) throws DataAccessException;
	
	public int unlinkWenVisit(int wenvisitid) throws DataAccessException;

	/**政法委**/
	public NewPageModel searchJointControlRecord_zfw(JointControlRecord jointcontrolrecord,NewPageModel pm) throws DataAccessException;
	public JointControlRecord getJointControlRecordByid_zfw(int id) throws DataAccessException;
	public int update_zfw(JointControlRecord jointcontrolrecord) throws DataAccessException;
}

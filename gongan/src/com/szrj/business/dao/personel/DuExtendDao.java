package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.DuModel;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.szrj.business.model.personel.DuCheckRecord;
import com.szrj.business.model.personel.DuExtend;
import com.szrj.business.model.personel.Personnel;



public interface DuExtendDao {
	
	
	public NewPageModel searchDuPersonnel(DuExtend duextend,NewPageModel pm) throws DataAccessException;
	public int countDuPersonnel(DuExtend duextend) throws DataAccessException;
	
	public List<DuExtend> searchDuPersonnelList(DuExtend duextend) throws DataAccessException;
	
	public int addduextend(DuExtend duextend) throws DataAccessException;
	
	
	public int cancelduextend(DuExtend duextend) throws DataAccessException;
	
	public DuExtend getDuExtendBypersonnelid(int personnelid) throws DataAccessException;
	
	public int updatedupersonel(DuExtend duextend) throws DataAccessException;
	
	public int updateduextend(DuExtend duextend) throws DataAccessException;
	
	public int updateduextendXSBX(DuExtend duextend) throws DataAccessException;
	
	public NewPageModel searchducheckrecord(DuCheckRecord ducheckrecord,NewPageModel pm) throws DataAccessException;
	
	public int addducheckrecord(DuCheckRecord ducheckrecord) throws DataAccessException;
	
	public int updateducheckrecord(DuCheckRecord ducheckrecord) throws DataAccessException;
	
	public int cancelducheckrecord(DuCheckRecord ducheckrecord) throws DataAccessException;
	
	public DuCheckRecord getDuCheckRecordByid(int id) throws DataAccessException;
	
	public List<Personnel> countDuPersonByPersontype(DuExtend duextend) throws DataAccessException;
	
	public List<PieModel> countDuPersonByUnit(DuExtend duextend) throws DataAccessException;
	
	public List<PieModel> countDuPersonByJointcontrollevel(DuExtend duextend) throws DataAccessException;
	public List<DuModel> countDistDuPersonByJointcontrollevel() throws DataAccessException;

	public DuExtend exportxidurenyuan(DuExtend duExtend) throws DataAccessException;
	
	public List<DuCheckRecord> exportxiduLiankong(Integer personnelid) throws DataAccessException;
}

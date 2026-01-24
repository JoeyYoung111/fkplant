package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.DuModel;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.PieModel;
import com.szrj.business.dao.personel.DuExtendDao;
import com.szrj.business.model.personel.DuCheckRecord;
import com.szrj.business.model.personel.DuExtend;
import com.szrj.business.model.personel.Personnel;

public class DuExtendDaoImpl extends BaseDaoiBatis implements DuExtendDao{

	public int addduextend(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("duextend.add", duextend);
	}

	public int cancelduextend(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.cancelduextend", duextend);
	}

	public NewPageModel searchDuPersonnel(DuExtend duextend, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("duextend.searchDuExtend_count", duextend);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("duextend.searchDuExtend", duextend, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	public int countDuPersonnel(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("duextend.searchDuExtend_count", duextend);
	}

	public int updateduextend(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.updateduextend", duextend);
	}

	public DuExtend getDuExtendBypersonnelid(int personnelid)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return  (DuExtend) getSqlMapClientTemplate().queryForObject("duextend.getDuExtendBypersonnelid", personnelid);
	}

	public int updatedupersonel(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.updatedupersonel", duextend);
	}

	public int updateduextendXSBX(DuExtend duextend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.updateduextendXSBX", duextend);
	}

	public int addducheckrecord(DuCheckRecord ducheckrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("duextend.addducheckrecord", ducheckrecord);

	}

	public int cancelducheckrecord(DuCheckRecord ducheckrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.cancelducheckrecord", ducheckrecord);
	}

	public NewPageModel searchducheckrecord(DuCheckRecord ducheckrecord,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("duextend.searchducheckrecord_count", ducheckrecord);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("duextend.searchducheckrecord", ducheckrecord, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateducheckrecord(DuCheckRecord ducheckrecord)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("duextend.updateducheckrecord", ducheckrecord);
	}

	public DuCheckRecord getDuCheckRecordByid(int id) throws DataAccessException {
		return  (DuCheckRecord) getSqlMapClientTemplate().queryForObject("duextend.getDuCheckRecordByid", id);
	}

	@SuppressWarnings("unchecked")
	public List<DuExtend> searchDuPersonnelList(DuExtend duextend) throws DataAccessException {
		return  (List<DuExtend>) getSqlMapClientTemplate().queryForList("duextend.exportDuPersonnel", duextend);
	}

	@SuppressWarnings("unchecked")
	public List<Personnel> countDuPersonByPersontype(DuExtend duextend) throws DataAccessException {
		return  (List<Personnel>) getSqlMapClientTemplate().queryForList("duextend.countDuPersonByPersontype",duextend);
	}

	@SuppressWarnings("unchecked")
	public List<PieModel> countDuPersonByUnit(DuExtend duextend) throws DataAccessException {
		return  (List<PieModel>) getSqlMapClientTemplate().queryForList("duextend.countDuPersonByUnit",duextend);
	}

	@SuppressWarnings("unchecked")
	public List<PieModel> countDuPersonByJointcontrollevel(DuExtend duextend) throws DataAccessException {
		return  (List<PieModel>) getSqlMapClientTemplate().queryForList("duextend.countDuPersonByJointcontrollevel",duextend);
	}
	@SuppressWarnings("unchecked")
	public List<DuModel> countDistDuPersonByJointcontrollevel() throws DataAccessException {
		return  (List<DuModel>) getSqlMapClientTemplate().queryForList("duextend.countDistDuPersonByJointcontrollevel");
	}

	public DuExtend exportxidurenyuan(DuExtend duExtend) throws DataAccessException {
		return (DuExtend)getSqlMapClientTemplate().queryForObject("duextend.exportxidurenyuan",duExtend);
	}

	@SuppressWarnings("unchecked")
	public List<DuCheckRecord> exportxiduLiankong(Integer personnelid) throws DataAccessException {
		return (List<DuCheckRecord>)getSqlMapClientTemplate().queryForList("duextend.exportxiduLiankong", personnelid);
	}

}

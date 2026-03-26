package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.PersonnelExtendDao;
import com.szrj.business.model.personel.Labelinfo;
import com.szrj.business.model.personel.PersonnelExtend;
import com.szrj.business.model.personel.WenGrade;

public class PersonnelExtendDaoImpl extends BaseDaoiBatis implements PersonnelExtendDao {

	public int add(PersonnelExtend personnelExtend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnelExtend.add", personnelExtend);
	}

	public int cancel(PersonnelExtend personnelExtend)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelExtend.cancel", personnelExtend);
	}

	public PersonnelExtend getById(int id) throws DataAccessException {
		return (PersonnelExtend) getSqlMapClientTemplate().queryForObject("personnelExtend.getById", id);
	}
	public PersonnelExtend getByPersonnelid(PersonnelExtend personnelExtend)
		throws DataAccessException {
		return (PersonnelExtend) getSqlMapClientTemplate().queryForObject("personnelExtend.getByPersonnelid", personnelExtend);
	}
	public NewPageModel searchPersonnelExtend(PersonnelExtend personnelExtend,
			NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnelExtend.searchPersonnelExtend_count", personnelExtend);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnelExtend.searchPersonnelExtend", personnelExtend, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(PersonnelExtend personnelExtend)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelExtend.update", personnelExtend);
	}
	
	public List<PersonnelExtend> exportPersonnelExtend(
			PersonnelExtend personnelExtend) throws DataAccessException {
		return (List<PersonnelExtend>)getSqlMapClientTemplate().queryForList("personnelExtend.exportPersonnelExtend", personnelExtend);
	}
	public int updateWorkExtend(PersonnelExtend personnelExtend)
		throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelExtend.updateWorkExtend", personnelExtend);
	}
	/***************************人员标签信息******************************************/
	public int addLabelinfo(Labelinfo labelinfo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("personnelExtend.addLabelinfo", labelinfo);
	}

	public Labelinfo getLabelinfo(Labelinfo labelinfo)
			throws DataAccessException {
		return (Labelinfo) getSqlMapClientTemplate().queryForObject("personnelExtend.getLabelinfo", labelinfo);
	}

	public NewPageModel searchLabelinfo(Labelinfo labelinfo,NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("personnelExtend.searchLabelinfo_count", labelinfo);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("personnelExtend.searchLabelinfo", labelinfo, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updateLabelinfoValidflag(Labelinfo labelinfo)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("personnelExtend.updateLabelinfoValidflag", labelinfo);
	}

	@SuppressWarnings("unchecked")
	public List<PersonnelExtend> exportPersonnelByIds(String personnelIds) throws DataAccessException {
		if (personnelIds == null || personnelIds.trim().isEmpty()) {
			return new java.util.ArrayList<PersonnelExtend>();
		}
		return getSqlMapClientTemplate().queryForList("personnelExtend.exportPersonnelByIds", personnelIds);
	}
}

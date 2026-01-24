package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.dao.personel.HeiEditorDao;
import com.szrj.business.model.personel.HeiEditor;
import com.szrj.business.model.personel.Personnel;

public class HeiEditorDaoImpl extends BaseDaoiBatis implements HeiEditorDao{

	public int update(HeiEditor heieditor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("heieditor.update", heieditor);
	}

	public int add(HeiEditor heieditor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("heieditor.add", heieditor);
	}

	public int cancel(HeiEditor heieditor) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("heieditor.cancel", heieditor);
	}

	public NewPageModel searchHeiPersonnel(Personnel personnelr, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("heieditor.searchHeiPersonnel_count", personnelr);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("heieditor.searchHeiPersonnel", personnelr, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public HeiEditor getBypersonnelid(int personnelid)
			throws DataAccessException {
		return (HeiEditor)getSqlMapClientTemplate().queryForObject("heieditor.getBypersonnelid", personnelid);
	}

	public HeiEditor getHeiEditorById(int id) throws DataAccessException {
		// TODO Auto-generated method stub
		return (HeiEditor)getSqlMapClientTemplate().queryForObject("heieditor.getHeiEditorById", id);
	}

	public List<HeiEditor> searchHeiPersonnelList(Personnel personnel)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return ( List<HeiEditor>)getSqlMapClientTemplate().queryForList("heieditor.exportHeiPersonnel", personnel);
	}

	@SuppressWarnings("unchecked")
	public List<SelectModel> countDistpersonByIncontrolleve() throws DataAccessException {
		return (List<SelectModel>) getSqlMapClientTemplate().queryForList("heieditor.countDistpersonByIncontrolleve");
	}
}

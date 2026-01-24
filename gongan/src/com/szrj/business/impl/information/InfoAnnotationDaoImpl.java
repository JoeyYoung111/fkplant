package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InfoAnnotationDao;
import com.szrj.business.model.information.InfoAnnotation;

public class InfoAnnotationDaoImpl extends BaseDaoiBatis implements InfoAnnotationDao {

	public int add(InfoAnnotation info) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("infoannotation.add",info);
	}

	public InfoAnnotation searchinfo(InfoAnnotation info) throws DataAccessException {
		return (InfoAnnotation)getSqlMapClientTemplate().queryForObject("infoannotation.searchinfo",info);
	}
	
	public int qianshou(InfoAnnotation info) throws DataAccessException{
		return (Integer)getSqlMapClientTemplate().update("infoannotation.qianshou", info);
	}

	public NewPageModel searchAnnotation(InfoAnnotation info, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("infoannotation.searchinfo_count", info);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("infoannotation.searchinfo", info, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<InfoAnnotation> searchList(InfoAnnotation infoAnnotation) throws DataAccessException {
		return (List<InfoAnnotation>)getSqlMapClientTemplate().queryForList("infoannotation.searchList", infoAnnotation);
	}
	
	public InfoAnnotation getById(Integer id) throws DataAccessException{
		return (InfoAnnotation)getSqlMapClientTemplate().queryForObject("infoannotation.getbyId", id);
	}

}

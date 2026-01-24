package com.szrj.business.impl.personel;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.ControlFilesDao;
import com.szrj.business.model.personel.ControlFiles;
import org.springframework.dao.DataAccessException;

/**
 * @author szrj_huaxia
 * 风险人员-管控文件 数据访问实现类
 */
public class ControlFilesDaoImpl extends BaseDaoiBatis implements ControlFilesDao {

	@Override
	public void add(ControlFiles controlFiles) {
		getSqlMapClientTemplate().insert("controlfiles.add", controlFiles);
	}

	@Override
	public void update(ControlFiles controlFiles) {
		getSqlMapClientTemplate().update("controlfiles.update", controlFiles);
	}

	@Override
	public void cancel(ControlFiles controlFiles) {
		getSqlMapClientTemplate().update("controlfiles.cancel", controlFiles);
	}

	@Override
	public ControlFiles getById(int id) {
		return (ControlFiles)getSqlMapClientTemplate().queryForObject("controlfiles.getById", id);
	}

	@Override
	public ControlFiles getByPersonnelId(int personnelid) {
		return (ControlFiles)getSqlMapClientTemplate().queryForObject("controlfiles.getByPersonnelId", personnelid);
	}

	@Override
	public NewPageModel searchcontrolplan(int personnelid, NewPageModel pm) throws DataAccessException {
		// 查询总记录数
		int total = (Integer) getSqlMapClientTemplate().queryForObject("controlfiles.searchcontrolplan_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		// 查询分页数据
		pm.setRows(getSqlMapClientTemplate().queryForList("controlfiles.searchcontrolplan", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@Override
	public NewPageModel searchcontrolemergency(int personnelid, NewPageModel pm) throws DataAccessException {
		// 查询总记录数
		int total = (Integer) getSqlMapClientTemplate().queryForObject("controlfiles.searchcontrolemergency_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		// 查询分页数据
		pm.setRows(getSqlMapClientTemplate().queryForList("controlfiles.searchcontrolemergency", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}


}
package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.AppButtonDao;
import com.szrj.business.model.AppButton;

public class AppButtonDaoImpl extends BaseDaoiBatis implements AppButtonDao{

	public int add(AppButton appButton) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("appButton.add", appButton);
	}

	public int cancel(int id) throws DataAccessException {
		return getSqlMapClientTemplate().update("appButton.cancel", id);
	}

	public NewPageModel searchAppButton(AppButton appButton, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("appButton.searchAppButton_count", appButton);
	    pm.setTotal(total);
	    pm.setup();
	    pm.setRows(getSqlMapClientTemplate().queryForList("appButton.searchAppButton", appButton, pm.getStart(), pm.getTruepagesize()));
        return pm;
	}

	public int update(AppButton appButton) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("appButton.update", appButton);
	}

	@SuppressWarnings("unchecked")
	public List<AppButton> getZhuButton() throws DataAccessException {
		return (List<AppButton>)getSqlMapClientTemplate().queryForList("appButton.getZhuButton");
	}

	@SuppressWarnings("unchecked")
	public List<AppButton> searchAllAppButton(AppButton appButton) throws DataAccessException {
		return (List<AppButton>)getSqlMapClientTemplate().queryForList("appButton.searchAllAppButton",appButton);
	}

	public AppButton getById(int id) throws DataAccessException {
		return (AppButton)getSqlMapClientTemplate().queryForObject("appButton.getById",id);
	}

	@SuppressWarnings("unchecked")
	public List<AppButton> getMainMobileButton(int roleid)
			throws DataAccessException {
		return (List<AppButton>)getSqlMapClientTemplate().queryForList("appButton.getMainMobileButton",roleid);
	}

	@SuppressWarnings("unchecked")
	public List<AppButton> getMobileButtonByParentid(AppButton appButton) throws DataAccessException {
		return (List<AppButton>)getSqlMapClientTemplate().queryForList("appButton.getMobileButtonByParentid",appButton);
	}
}

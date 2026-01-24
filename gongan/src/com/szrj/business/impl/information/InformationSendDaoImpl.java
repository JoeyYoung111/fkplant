package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InformationSendDao;
import com.szrj.business.model.information.InformationSend;

public class InformationSendDaoImpl extends BaseDaoiBatis implements InformationSendDao {

	public int add(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("informationsend.add",informationSend);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.cancel",id);
	}

	public InformationSend getById(int id) throws DataAccessException {
		return (InformationSend)getSqlMapClientTemplate().queryForObject("informationsend.getById",id);
	}

	public NewPageModel searchInformation(InformationSend informationSend,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("informationsend.searchInformationsend_count", informationSend);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("informationsend.searchInformationsend", informationSend, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updatefollowflag(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.updatefollowflag",informationSend);
	}

	public int updatehideflag(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.updatehideflag",informationSend);
	}

	public int updatetopflag(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.updatetopflag",informationSend);
	}

	public int updateValidflag(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.updateValidflag",informationSend);
	}
	
	public int pizhuid(InformationSend informationSend) throws DataAccessException{
		return (Integer)getSqlMapClientTemplate().update("informationsend.pizhuid", informationSend);
	}
	
	public int ytpizhuid(InformationSend informationSend) throws DataAccessException{
		return (Integer)getSqlMapClientTemplate().update("informationsend.ytpizhuid", informationSend);
	}

	public int changeSpecialid(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationsend.changespecialid",informationSend);
	}

	@SuppressWarnings("unchecked")
	public List<InformationSend> searchAdd(Integer informationid) throws DataAccessException {
		return (List<InformationSend>)getSqlMapClientTemplate().queryForList("informationsend.searchAdd",informationid);
	}

	public int searchInformationsend_count(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("informationsend.searchInformationsend_count",informationSend);
	}

	public int searchcountByflag(InformationSend informationSend) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("informationsend.searchcountByflag",informationSend);
	}
}

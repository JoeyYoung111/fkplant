package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InformationSpecialDao;
import com.szrj.business.model.information.InformationSpecial;

public class InformationSpecialDaoImpl extends BaseDaoiBatis implements InformationSpecialDao{

	public int add(InformationSpecial informationSpecial) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("informationSpecial.add", informationSpecial);
	}

	@SuppressWarnings("unchecked")
	public NewPageModel searchRadio(InformationSpecial informationSpecial, NewPageModel pm) throws DataAccessException {
		int total = (Integer)getSqlMapClientTemplate().queryForObject("informationSpecial.searchRadio_count", informationSpecial);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("informationSpecial.searchRadio", informationSpecial, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int update(InformationSpecial informationSpecial) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationSpecial.update", informationSpecial);
	}

	public int changeCount(Integer id, String page) throws DataAccessException {
		if("add".equals(page)){
			return (Integer)getSqlMapClientTemplate().update("informationSpecial.addcount",id);
		}else if("reduce".equals(page)){
			return (Integer)getSqlMapClientTemplate().update("informationSpecial.reducecount",id);
		}
		return id;
	}

	@SuppressWarnings("unchecked")
	public List<InformationSpecial> searchSelect(InformationSpecial informationSpecial) throws DataAccessException {
		return (List<InformationSpecial>)getSqlMapClientTemplate().queryForList("informationSpecial.searchRadio", informationSpecial);
	}

}

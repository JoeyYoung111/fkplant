package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.information.InformationReceiveDao;
import com.szrj.business.model.information.InformationReceive;

public class InformationReceiveDaoImpl extends BaseDaoiBatis implements InformationReceiveDao {

	public int add(InformationReceive informationReceive) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("informationreceive.add",informationReceive);
	}

	public int fankui(InformationReceive informationReceive) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationreceive.fankui", informationReceive);
	}

	public InformationReceive getById(int id) throws DataAccessException {
		return (InformationReceive)getSqlMapClientTemplate().queryForObject("informationreceive.getById",id);
	}

	public int qianshou(InformationReceive informationReceive) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("informationreceive.qianshou", informationReceive);
	}

	public NewPageModel searchInformation(InformationReceive informationReceive, NewPageModel pm, String page) throws DataAccessException {
		if("1".equals(page)){
			int total = (Integer)getSqlMapClientTemplate().queryForObject("informationreceive.selectInfoReceive1_count", informationReceive);
			pm.setTotal(total);
			pm.setup();
			pm.setRows(getSqlMapClientTemplate().queryForList("informationreceive.selectInfoReceive1", informationReceive, pm.getStart(), pm.getTruepagesize()));
		}else{
			int total = (Integer)getSqlMapClientTemplate().queryForObject("informationreceive.selectInfoReceive2_count", informationReceive);
			pm.setTotal(total);
			pm.setup();
			pm.setRows(getSqlMapClientTemplate().queryForList("informationreceive.selectInfoReceive2", informationReceive, pm.getStart(), pm.getTruepagesize()));
		}
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<InformationReceive> searchByinformationid(InformationReceive informationReceive) throws DataAccessException {
		return (List<InformationReceive>)getSqlMapClientTemplate().queryForList("informationreceive.searchByinformationid", informationReceive);
	}

	@SuppressWarnings("unchecked")
	public List<InformationReceive> rizhizhuanyue(String informationreceiveid) throws DataAccessException {
		return (List<InformationReceive>)getSqlMapClientTemplate().queryForList("informationreceive.rizhizhuanyue", informationreceiveid);
	}

}

package com.szrj.business.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.BasicMsgDao;
import com.szrj.business.model.BasicMsg;

/**
 *@author:华夏
 *@date:2020-2-24 下午02:37:11
 */
public class BasicMsgDaoImpl extends BaseDaoiBatis implements BasicMsgDao{
	
	public NewPageModel searchBasicMsg(BasicMsg basicMsg, NewPageModel pm)
	throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("basicMsg.searchBasicMsg_count", basicMsg);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("basicMsg.searchBasicMsg", basicMsg, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int add(BasicMsg basicMsg) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("basicMsg.add", basicMsg);
	}

	public int cancel(int id) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("basicMsg.cancel", id);
	}

	public int update(BasicMsg basicMsg) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("basicMsg.update", basicMsg);
	}
	
	public BasicMsg getById(int id) throws DataAccessException {
		return (BasicMsg)getSqlMapClientTemplate().queryForObject("basicMsg.getById", id);
	}

	public List<BasicMsg> getByType(int basicType) throws DataAccessException {
		return(List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getBMByType",basicType);
	}

	public List<BasicMsg> getBMByparenttype(BasicMsg basicMsg)
			throws DataAccessException {
		return(List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getBMByparenttype",basicMsg);
	}

	public BasicMsg getnameBytype(BasicMsg basicMsg) throws DataAccessException {
		// TODO Auto-generated method stub
		return (BasicMsg)getSqlMapClientTemplate().queryForObject("basicMsg.getnameBytype", basicMsg);
	}


	public List<BasicMsg> getBMByParentIdToJSON(int parentid) throws DataAccessException {
		return (List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getBMByParentIdToJSON",parentid);
	}
	public int getBasicNameExit(BasicMsg basicMsg) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("basicMsg.getBasicNameExit", basicMsg);
	}
	
	public List<BasicMsg> getBasicNamesById(String idlist) throws DataAccessException {
		return (List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getBasicNamesById",idlist);
	}

	public BasicMsg getByMemo(String memo) throws DataAccessException {
		return (BasicMsg)getSqlMapClientTemplate().queryForObject("basicMsg.getByMemo", memo);
	}
	@SuppressWarnings("unchecked")
	public List<BasicMsg> selectChemicalName(Integer id) throws DataAccessException {
		return (List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.selectChemicalName",id);
	}

	@SuppressWarnings("unchecked")
	public List<BasicMsg> getBMByParentBasicNameToJSON(String parentBasicName) throws DataAccessException {
		String[] name = parentBasicName.split(",");
		String parentName = "";
		for(int i=0;i<name.length;i++){
			if(name[i]!=null && !"".equals(name[i])){
				if(!"".equals(parentName)){
					parentName += ",";
				}
				parentName += "'"+name[i]+"'";
			}
		}
		return (List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getBMByParentBasicNameToJSON","("+parentName+")");
	}

	public String basicMsgQueryChildren(HashMap map) throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("basicMsg.basicMsgQueryChildren", map);
	}

	@SuppressWarnings("unchecked")
	public List<BasicMsg> getMsgByid(String idString) throws DataAccessException {
		return (List<BasicMsg>)getSqlMapClientTemplate().queryForList("basicMsg.getMsgByid",idString);
	}
}

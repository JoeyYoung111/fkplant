package com.szrj.business.impl.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.information.InfoTimeLineDao;
import com.szrj.business.model.information.InfoTimeLine;

public class InfoTimeLineDaoImpl extends BaseDaoiBatis implements InfoTimeLineDao {

	@SuppressWarnings("unchecked")
	public List<InfoTimeLine> searchList(InfoTimeLine infoTimeLine)throws DataAccessException {
		return (List<InfoTimeLine>)getSqlMapClientTemplate().queryForList("infoTimeLine.search",infoTimeLine);
	}

	public int add(InfoTimeLine infoTimeLine) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("infoTimeLine.add", infoTimeLine);
	}

	public InfoTimeLine searchAdd(InfoTimeLine infoTimeLine) throws DataAccessException {
		return (InfoTimeLine)getSqlMapClientTemplate().queryForObject("infoTimeLine.searchAdd",infoTimeLine);
	}

}

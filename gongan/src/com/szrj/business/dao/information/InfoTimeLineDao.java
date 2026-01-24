package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.information.InfoTimeLine;

public interface InfoTimeLineDao {

	public List<InfoTimeLine> searchList(InfoTimeLine infoTimeLine) throws DataAccessException;
	
	public int add(InfoTimeLine infoTimeLine) throws DataAccessException;
	
}

package com.szrj.business.dao.interfaces;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.interfaces.Yujing;

public interface YujingDao {
	public List<Yujing> getYujingColumnListByModelId(String modelId) throws DataAccessException;
	
	public List<Yujing> getYujingResultListByColumn(Yujing yujing) throws DataAccessException;
}

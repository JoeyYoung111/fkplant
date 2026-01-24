package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.InformationSpecial;

public interface InformationSpecialDao {

	public int add(InformationSpecial informationSpecial) throws DataAccessException;
	
	public NewPageModel searchRadio(InformationSpecial informationSpecial, NewPageModel pm) throws DataAccessException;
	
	public int update(InformationSpecial informationSpecial) throws DataAccessException;
	
	public int changeCount(Integer id, String page) throws DataAccessException;
	
	public List<InformationSpecial> searchSelect(InformationSpecial informationSpecial) throws DataAccessException;
	
}

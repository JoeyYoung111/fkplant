package com.szrj.business.dao.information;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.information.InfoAnnotation;

public interface InfoAnnotationDao {
	
	public int add(InfoAnnotation info) throws DataAccessException;

	public InfoAnnotation searchinfo(InfoAnnotation info) throws DataAccessException;
	
	public int qianshou(InfoAnnotation info) throws DataAccessException;
	
	public NewPageModel searchAnnotation(InfoAnnotation info, NewPageModel pm) throws DataAccessException;
	
	public List<InfoAnnotation> searchList(InfoAnnotation infoAnnotation) throws DataAccessException;
	
	public InfoAnnotation getById(Integer id) throws DataAccessException;
}

package com.szrj.business.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.szrj.business.dao.FileDao;
import com.szrj.business.model.File;

public class FileDaoImpl extends BaseDaoiBatis implements FileDao{
	
	public int cancelFileById(int id) throws DataAccessException {
		return getSqlMapClientTemplate().delete("file.cancelFileById",id);
	}
	
	public File getFileById(int id) throws DataAccessException {
		return (File)getSqlMapClientTemplate().queryForObject("file.getFileById",id);
	}
	
	public int getFileIdByAllName(String fileallname) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("file.getFileIdByAllName",fileallname);
	}
	
	public int addFile(File file) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("file.add", file);
	}

	public File getFileMsgById(int id) throws DataAccessException {
		return (File)getSqlMapClientTemplate().queryForObject("file.getfileMsgById", id);
	}

	public int cancelFile(int id) throws DataAccessException {
		return getSqlMapClientTemplate().delete("file.cancelFile", id);
	}

	public List<File> getFileMsgByIdstr(String fileidstr)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return (List<File>)getSqlMapClientTemplate().queryForList("file.getfileMsgByIdstr", fileidstr);
	}
	public int deleteFile(String idstr) throws DataAccessException {
		// TODO Auto-generated method stub
		return getSqlMapClientTemplate().delete("file.deleteFile", idstr);
	}

	public File getFileMsgByIdstrs(String fileidstr) throws DataAccessException {
		return (File)getSqlMapClientTemplate().queryForObject("file.getfileMsgByIdstr", fileidstr);
	}

	public File getFileNames(String fileattachments) throws DataAccessException {
		return (File)getSqlMapClientTemplate().queryForObject("file.getFileNames", fileattachments);
	}
	
	

}

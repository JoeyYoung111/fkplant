package com.szrj.business.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.szrj.business.model.File;

public interface FileDao {
	
	/**
	 * 根据ID删除文件
	 * @author xjx
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancelFileById(int id) throws DataAccessException;
	
	/**
	 * 根据ID获取文件信息
	 * @author xjx
	 * @param id
	 * @return FileMsg
	 * @throws DataAccessException
	 */
	public File getFileById(int id) throws DataAccessException;
	
	/**
	 * 根据文件全名查询该文件ID
	 * @author xjx
	 * @param fileallname
	 * @return int
	 * @throws DataAccessException
	 */
	public int getFileIdByAllName(String fileallname) throws DataAccessException;
	
	/**
	 * 新增
	 * @author xjx
	 * @param file
	 * @return int
	 * @throws DataAccessException
	 */
	public int addFile(File file) throws DataAccessException;
	
	/**
	 * 根据ID查询文件信息
	 * @param id
	 * @return File
	 * @throws DataAccessException
	 */
	public File getFileMsgById(int id) throws DataAccessException;
	
	/**
	 * 删除文件
	 * @param id
	 * @return int
	 * @throws DataAccessException
	 */
	public int cancelFile(int id) throws DataAccessException;
	/**
	 * 
	 * @param idstr
	 * @return
	 * @throws DataAccessException
	 */
	public int deleteFile(String  idstr) throws DataAccessException;
	/**
	 * 
	 * @param fileidstr
	 * @return
	 * @throws DataAccessException
	 */
	public List<File>  getFileMsgByIdstr(String fileidstr)throws DataAccessException;
	/**
	 * 
	 * @param fileidstr
	 * @return
	 * @throws DataAccessException
	 */
	public File  getFileMsgByIdstrs(String fileidstr)throws DataAccessException;
	
	public File  getFileNames(String fileattachments)throws DataAccessException;
	
}

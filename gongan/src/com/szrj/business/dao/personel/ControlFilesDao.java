package com.szrj.business.dao.personel;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.ControlFiles;
import org.springframework.dao.DataAccessException;

/**
 * @author szrj_huaxia
 * 风险人员-管控文件 数据访问接口
 */
public interface ControlFilesDao {
	/**
	 * 添加管控文件
	 * @param controlFiles
	 * @return
	 */
	public void add(ControlFiles controlFiles);
	
	/**
	 * 修改管控文件
	 * @param controlFiles
	 * @return
	 */
	public void update(ControlFiles controlFiles);
	
	/**
	 * 删除管控文件
	 * @param controlFiles
	 * @return
	 */
	public void cancel(ControlFiles controlFiles);
	
	/**
	 * 根据ID获取管控文件
	 * @param id
	 * @return
	 */
	public ControlFiles getById(int id);
	
	/**
	 * 根据人员ID获取管控文件
	 * @param personnelid
	 * @return
	 */
	public ControlFiles getByPersonnelId(int personnelid);
	
	/**
	 * 查询管控文件列表
	 * @param personnelid
	 * @param pm
	 * @return
	 */
	public NewPageModel searchcontrolplan(int personnelid,NewPageModel pm) throws DataAccessException;
	public NewPageModel searchcontrolemergency(int personnelid,NewPageModel pm) throws DataAccessException;
	
}
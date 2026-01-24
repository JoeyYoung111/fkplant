package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.aladdin.model.SelectModel;
import com.szrj.business.model.personel.KongDailyControl;
import com.szrj.business.model.personel.KongExtend;

public interface KongExtendDao {

	/**
	 * 查询
	 * @param basicMsg
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchKongPersonnel(KongExtend kongextend,NewPageModel pm) throws DataAccessException;
	
	public List<KongExtend> searchKongPersonnelList(KongExtend kongextend) throws DataAccessException;
	
	 /**
	 * 新增  
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int add(KongExtend  kongextend) throws DataAccessException;
	/**
	 * 修改 指派信息
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int updateZP(KongExtend  kongextend) throws DataAccessException;
	/**
	 * 修改 
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int updateJSGK(KongExtend  kongextend) throws DataAccessException;
	/**
	 * 修改 可疑特征信息
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int updateKYTZ(KongExtend  kongextend) throws DataAccessException;
	
	/**
	 * 删除
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int cancel(KongExtend  kongextend) throws DataAccessException;
	
	public KongExtend getKongExtendBypersonnelid(int personnelid) throws DataAccessException;
	
	public KongExtend getKongExtendById(int id) throws DataAccessException;
	
	public int updatecontroltime(KongExtend  kongextend) throws DataAccessException;
	
	public int updateincontrollevel(KongExtend  kongextend) throws DataAccessException;
	
	public int reduction(KongExtend  kongextend) throws DataAccessException;
	/**
	 * 日常管控 查询、新增、修改、删除
	 * @param kongdailycontrol
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchKongDailyControl(KongDailyControl kongdailycontrol,NewPageModel pm) throws DataAccessException;
	public int addkongdailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException;
	public KongDailyControl searchdailycontrolbyid(int id) throws DataAccessException;
	public int updatekongdailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException;
	public int cancelkongdailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException;
	public List<KongDailyControl> getNewDailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException;
	public NewPageModel getAllDailycontrol(KongDailyControl kongdailycontrol,NewPageModel pm) throws DataAccessException;//所有人
	public List<KongDailyControl> exportAllDailycontrol(KongDailyControl kongdailycontrol) throws DataAccessException;
	public List<KongDailyControl> searchDailycontrolByControltype(KongDailyControl kongdailycontrol) throws DataAccessException;
	/**
	 * 导出涉恐人员信息
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public KongExtend exportPersonnelById(KongExtend  kongextend) throws DataAccessException;
	
	/**
	 * 按联控级别计算涉恐人员数量
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public List<KongExtend> countpersonByJointtype() throws DataAccessException;
	public List<SelectModel> countDistpersonByJointtype() throws DataAccessException;
	
	/**
	 * 按籍贯计算涉恐人员数量
	 * @param personnel
	 * @return
	 * @throws DataAccessException
	 */
	public List<KongExtend> countpersonByNativeplace() throws DataAccessException;
	public List<SelectModel> countDistpersonByNativeplace() throws DataAccessException;
	
	/**
	 * 按派出所计算涉恐人员数量
	 * @return
	 * @throws DataAccessException
	 */
	public List<KongExtend> countpersonByPolice() throws DataAccessException;
	
	/**
	 * 台账
	 * @param kongextend
	 * @return
	 * @throws DataAccessException
	 */
	public int tz(KongExtend  kongextend) throws DataAccessException;
	
	public List<KongExtend> checkMYPG() throws DataAccessException;
	public List<KongExtend> checkSRYZF() throws DataAccessException;
	public List<KongExtend> checkSFYLR() throws DataAccessException;
	
	public int updateKongTime(KongExtend  kongextend) throws DataAccessException;
	public int gdKong(KongExtend  kongextend) throws DataAccessException;
}

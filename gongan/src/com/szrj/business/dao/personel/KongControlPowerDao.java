package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.KongBackground;
import com.szrj.business.model.personel.KongControlPower;
import com.szrj.business.model.personel.KongPublicRelation;
import com.szrj.business.model.personel.KongPublicResume;


public interface KongControlPowerDao {
	/**
	 * 查询  公共/秘密管控力量
	 * @param kongcontrolpower
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchKongControlPower(KongControlPower kongcontrolpower,NewPageModel pm) throws DataAccessException;
	/**
	 * 新增  公共/秘密管控力量
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int addKongControlPower(KongControlPower kongcontrolpower) throws DataAccessException;
	/**
	 * 修改 公共/秘密管控力量
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int updateKongControlPower(KongControlPower kongcontrolpower) throws DataAccessException;
	/**
	 * 作废 公共/秘密管控力量
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int cancelKongControlPower(KongControlPower kongcontrolpower) throws DataAccessException;
	
	/**
	 * 查询详情
	 * @param id
	 * @return
	 * @throws DataAccessException
	 */
	public KongControlPower getkongcontrolpowerbyid(int id) throws DataAccessException;
	/**
	 * 查询  公共管控力量个人简历
	 * @param kongcontrolpower
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchKongPublicResume(KongPublicResume kongpublicresume,NewPageModel pm) throws DataAccessException;
	public NewPageModel searchZbPublicResume(KongPublicResume kongpublicresume,NewPageModel pm) throws DataAccessException;
	/**
	 * 新增  公共管控力量个人简历
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int addKongPublicResume(KongPublicResume kongpublicresume) throws DataAccessException;
	/**
	 * 修改 公共管控力量个人简历
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int updateKongPublicResume(KongPublicResume kongpublicresume) throws DataAccessException;
	/**
	 * 作废 公共管控力量个人简历
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int cancelKongPublicResume(KongPublicResume kongpublicresume) throws DataAccessException;
	public KongPublicResume getkongpublicresumebyid(int id) throws DataAccessException;
	/**
	 * 查询  公共管控力量家庭关系/社会关系
	 * @param kongcontrolpower
	 * @param pm
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchKongPublicRelation(KongPublicRelation kongpublicrelation,NewPageModel pm) throws DataAccessException;
	/**
	 * 新增  公共管控力量家庭关系/社会关系
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int addKongPublicRelation(KongPublicRelation kongpublicrelation) throws DataAccessException;
	/**
	 * 修改 公共管控力量家庭关系/社会关系
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int updateKongPublicRelation(KongPublicRelation kongpublicrelation) throws DataAccessException;
	/**
	 * 作废 公共管控力量家庭关系/社会关系
	 * @param kongcontrolpower
	 * @return
	 * @throws DataAccessException
	 */
	public int cancelKongPublicRelation(KongPublicRelation kongpublicrelation) throws DataAccessException;
	public KongPublicRelation getkongpublicrelationbyid(int id) throws DataAccessException;
	
	
	public NewPageModel searchKongBackground(KongBackground kongbackground,NewPageModel pm) throws DataAccessException;
	public int addKongBackground(KongBackground kongbackground) throws DataAccessException;
	public int updateKongBackground(KongBackground kongbackground) throws DataAccessException;
	public int cancelKongBackground(KongBackground kongbackground) throws DataAccessException;
	public KongBackground getkongbackgroundbyid(int id) throws DataAccessException;
	public List<KongBackground> getNewKongBackground(KongBackground kongbackground) throws DataAccessException;
	
	public List<KongControlPower> exportKongcontrolpower(KongControlPower kongcontrolpower) throws DataAccessException;
	public List<KongPublicRelation> exportPublicrelation(KongPublicRelation kongpublicrelation) throws DataAccessException;
	public List<KongPublicResume> exportPublicresume(KongPublicRelation kongpublicrelation) throws DataAccessException;
}

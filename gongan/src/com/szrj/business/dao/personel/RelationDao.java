package com.szrj.business.dao.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.model.NewPageModel;
import com.szrj.business.model.personel.Relation;
import com.szrj.business.model.personel.RelationBank;
import com.szrj.business.model.personel.RelationDriver;
import com.szrj.business.model.personel.RelationHouse;
import com.szrj.business.model.personel.RelationIdentity;
import com.szrj.business.model.personel.RelationLegal;
import com.szrj.business.model.personel.RelationPassport;
import com.szrj.business.model.personel.RelationPayment;
import com.szrj.business.model.personel.RelationPhone;
import com.szrj.business.model.personel.RelationTelnumber;
import com.szrj.business.model.personel.RelationVehicle;
import com.szrj.business.model.personel.RelationWifi;
import com.szrj.business.model.personel.SocialRelations;

public interface RelationDao {
	
	/**
	 * 风险人员  关联信息  查询、新增、修改、删除
	 * @param relation
	 * @return
	 * @throws DataAccessException
	 */
	public Relation searchrelation(int personnelid) throws DataAccessException;
	public int addrelation(Relation relation) throws DataAccessException;
	public int updaterelation(Relation relation) throws DataAccessException;
	public int cancelrelation(Relation relation) throws DataAccessException;
	public int getrelationcount(int personnelid) throws DataAccessException;
	public String getrelationtelnumber(int personnelid) throws DataAccessException;
	public int updaterelationbypersonnelid(Relation relation) throws DataAccessException;
	/**
	 * 银行账号  查询、新增、修改、删除
	 * @param relationbank
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationbank(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationbank(RelationBank relationbank) throws DataAccessException;
	public int updaterelationbank(RelationBank relationbank) throws DataAccessException;
	public int cancelrelationbank(RelationBank relationbank) throws DataAccessException;
	public RelationBank getrelationbankbyid(int id) throws DataAccessException;
	public String getbankaccount(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationbank_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationBank getrelationbankbyid_zfw(int id) throws DataAccessException;
	public int updaterelationbank_zfw(RelationBank relationbank) throws DataAccessException;
	/**
	 * 驾驶证件信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationdriver(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationdriver(RelationDriver relationdriver) throws DataAccessException;
	public int updaterelationdriver(RelationDriver relationdriver) throws DataAccessException;
	public int cancelrelationdriver(RelationDriver relationdriver) throws DataAccessException;
	public RelationDriver getrelationdriverbyid(int id) throws DataAccessException;
	public String getdrivertype(int personnelid) throws DataAccessException;
	List<RelationDriver> getdriverbypersonnelid(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationdriver_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationDriver getrelationdriverbyid_zfw(int id) throws DataAccessException;
	public int updaterelationdriver_zfw(RelationDriver relationdriver) throws DataAccessException;
	/**
	 * 房产信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationhouse(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationhouse(RelationHouse relationhouse) throws DataAccessException;
	public int updaterelationhouse(RelationHouse relationhouse) throws DataAccessException;
	public int cancelrelationhouse(RelationHouse relationhouse) throws DataAccessException;
	public RelationHouse getrelationhousebyid(int id) throws DataAccessException;
	public String gethousetype(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationhouse_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationHouse getrelationhousebyid_zfw(int id) throws DataAccessException;
	public int updaterelationhouse_zfw(RelationHouse relationhouse) throws DataAccessException;
	/**
	 * 虚拟身份信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationidentity(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationidentity(RelationIdentity relationidentity) throws DataAccessException;
	public int updaterelationidentity(RelationIdentity relationidentity) throws DataAccessException;
	public int cancelrelationidentity(RelationIdentity relationidentity) throws DataAccessException;
	public RelationIdentity getrelationidentitybyid(int id) throws DataAccessException;
	public String getidentitytype(int personnelid) throws DataAccessException;
	public List<RelationIdentity> getrelationidentitybypersonnelid(int personnelid) throws DataAccessException;

	/**政法委**/
	public NewPageModel searchrelationidentity_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationIdentity getrelationidentitybyid_zfw(int id) throws DataAccessException;
	public int updaterelationidentity_zfw(RelationIdentity relationidentity) throws DataAccessException;
	/**
	 * 法人组织信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationlegal(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationlegal(RelationLegal relationlegal) throws DataAccessException;
	public int updaterelationlegal(RelationLegal relationlegal) throws DataAccessException;
	public int cancelrelationlegal(RelationLegal relationlegal) throws DataAccessException;
	public RelationLegal getrelationlegalbyid(int id) throws DataAccessException;
	public String getlegalname(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationlegal_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationLegal getrelationlegalbyid_zfw(int id) throws DataAccessException;
	public int updaterelationlegal_zfw(RelationLegal relationlegal) throws DataAccessException;
	/**
	 * 护照信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationpassport(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationpassport(RelationPassport relationpassport) throws DataAccessException;
	public int updaterelationpassport(RelationPassport relationpassport) throws DataAccessException;
	public int cancelrelationpassport(RelationPassport relationpassport) throws DataAccessException;
	public RelationPassport getrelationpassportbyid(int id) throws DataAccessException;
	public String getpassporttype(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationpassport_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationPassport getrelationpassportbyid_zfw(int id) throws DataAccessException;
	public int updaterelationpassport_zfw(RelationPassport relationpassport) throws DataAccessException;
	/**
	 * 网络支付信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationpayment(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationpayment(RelationPayment relationpayment) throws DataAccessException;
	public int updaterelationpayment(RelationPayment relationpayment) throws DataAccessException;
	public int cancelrelationpayment(RelationPayment relationpayment) throws DataAccessException;
	public RelationPayment getrelationpaymentbyid(int id) throws DataAccessException;
	public String getpaymentname(int personnelid) throws DataAccessException;
	/**政法委**/
	public NewPageModel searchrelationpayment_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationPayment getrelationpaymentbyid_zfw(int id) throws DataAccessException;
	public int updaterelationpayment_zfw(RelationPayment relationpayment) throws DataAccessException;
	/**
	 * 使用手机信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationphone(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationphone(RelationPhone relationphone) throws DataAccessException;
	public int updaterelationphone(RelationPhone relationphone) throws DataAccessException;
	public int cancelrelationphone(RelationPhone relationphone) throws DataAccessException;
	public RelationPhone getrelationphonebyid(int id) throws DataAccessException;
	public String gettelbrand(int personnelid) throws DataAccessException;

	public NewPageModel searchrelationphone_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationPhone getrelationphonebyid_zfw(int id) throws DataAccessException;
	public int updaterelationphone_zfw(RelationPhone relationphone) throws DataAccessException;
	/**
	 * 手机号码信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationtelnumber(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationtelnumber(RelationTelnumber relationtelnumber) throws DataAccessException;
	public int updaterelationtelnumber(RelationTelnumber relationtelnumber) throws DataAccessException;
	public int cancelrelationtelnumber(RelationTelnumber relationtelnumber) throws DataAccessException;
	public RelationTelnumber getrelationtelnumberbyid(int id) throws DataAccessException;
	public String gettelnumber(int personnelid) throws DataAccessException;
	public List<RelationTelnumber> getRelationTelnumberByImsi(String imsi) throws DataAccessException;
	
	public NewPageModel searchrelationtelnumber_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationTelnumber getrelationtelnumberbyid_zfw(int id) throws DataAccessException;
	public int updaterelationtelnumber_zfw(RelationTelnumber relationtelnumber) throws DataAccessException;
	/**
	 * 检查手机号码是否已存在
	 * @param personnelid 人员ID
	 * @param telnumber 手机号码
	 * @return true-存在 false-不存在
	 * @throws DataAccessException
	 */
	public boolean checkTelnumberExists(int personnelid, String telnumber) throws DataAccessException;
	/**
	 * 交通工具信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationvehicle(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationvehicle(RelationVehicle relationvehicle) throws DataAccessException;
	public int updaterelationvehicle(RelationVehicle relationvehicle) throws DataAccessException;
	public int cancelrelationvehicle(RelationVehicle relationvehicle) throws DataAccessException;
	public RelationVehicle getrelationvehiclebyid(int id) throws DataAccessException;
	public String getvehicletype(int personnelid) throws DataAccessException;
	public List<RelationVehicle> getNewRelationvehicle(int personnelid) throws DataAccessException;
	public List<RelationVehicle> getRelationVehicleByVehiclenum(String vehiclenum) throws DataAccessException;

	public NewPageModel searchrelationvehicle_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationVehicle getrelationvehiclebyid_zfw(int id) throws DataAccessException;
	public int updaterelationvehicle_zfw(RelationVehicle relationvehicle) throws DataAccessException;
	/**
	 * wifi信息  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchrelationwifi(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addrelationwifi(RelationWifi relationwifi) throws DataAccessException;
	public int updaterelationwifi(RelationWifi relationwifi) throws DataAccessException;
	public int cancelrelationwifi(RelationWifi relationwifi) throws DataAccessException;
	public RelationWifi getrelationwifibyid(int id) throws DataAccessException;
	public String getssid(int personnelid) throws DataAccessException;

	/**政法委**/
	public NewPageModel searchrelationwifi_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public RelationWifi getrelationwifibyid_zfw(int id) throws DataAccessException;
	public int updaterelationwifi_zfw(RelationWifi relationwifi) throws DataAccessException;
	/**
	 * 社会关系  查询、新增、修改、删除
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel searchsocialrelations(int personnelid,NewPageModel pm) throws DataAccessException;
	public int addsocialrelations(SocialRelations socialrelations) throws DataAccessException;
	public int updatesocialrelations(SocialRelations socialrelations) throws DataAccessException;
	public int cancelsocialrelations(SocialRelations socialrelations) throws DataAccessException;
	public int updateriskpersonnel(SocialRelations socialrelations) throws DataAccessException;
	public SocialRelations getsocialrelationsbyid(int id) throws DataAccessException;
	public int getsocialrelationscount(SocialRelations socialrelations) throws DataAccessException;
	public List<SocialRelations> getsocialrelationsbycardnumber(SocialRelations socialrelations) throws DataAccessException;
	public SocialRelations getsocialrelationsname(String cardnumber) throws DataAccessException;
	public List<SocialRelations> getNewSocialrelations(int personnelid) throws DataAccessException;
	public List<SocialRelations> getSocialrelationsByPersonnelid(int personnelid) throws DataAccessException;
	public int getSocialrelationsCount(int personnelid) throws DataAccessException;

	public NewPageModel searchsocialrelations_zfw(int personnelid,NewPageModel pm) throws DataAccessException;
	public SocialRelations getsocialrelationsbyid_zfw(int id) throws DataAccessException;
	public int updatesocialrelations_zfw(SocialRelations socialrelations) throws DataAccessException;
	/**
	 * 轨迹信息 查询
	 * @param relationdriver
	 * @return
	 * @throws DataAccessException
	 */
	public NewPageModel gettrajectoryrecord(String phonenumber,NewPageModel pm) throws DataAccessException;
	
	/**
	 * 政法委
	 */
	public Relation searchrelation_zfw(int personnelid) throws DataAccessException;
}

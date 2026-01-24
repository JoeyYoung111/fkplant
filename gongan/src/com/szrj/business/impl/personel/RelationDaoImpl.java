package com.szrj.business.impl.personel;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.aladdin.dao.ibatis.BaseDaoiBatis;
import com.aladdin.model.NewPageModel;
import com.szrj.business.dao.personel.RelationDao;
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

public class RelationDaoImpl extends BaseDaoiBatis implements RelationDao{
	
	public NewPageModel gettrajectoryrecord(String phonenumber, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.gettrajectoryrecord_count", phonenumber);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.gettrajectoryrecord", phonenumber, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updaterelationbypersonnelid(Relation relation)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationbypersonnelid", relation);
	}

	@SuppressWarnings("unchecked")
	public List<SocialRelations> getsocialrelationsbycardnumber(SocialRelations socialrelations) throws DataAccessException {
		return  (List<SocialRelations>) getSqlMapClientTemplate().queryForList("relation.getsocialrelationsbycardnumber", socialrelations);
	}

	public int getsocialrelationscount(SocialRelations socialrelations)
			throws DataAccessException {
		return  (Integer) getSqlMapClientTemplate().queryForObject("relation.getsocialrelationscount", socialrelations);
	}

	public int updateriskpersonnel(SocialRelations socialrelations)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updateriskpersonnel", socialrelations);
	}

	public int addsocialrelations(SocialRelations socialrelations)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addsocialrelations", socialrelations);
	}

	public int cancelsocialrelations(SocialRelations socialrelations)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelsocialrelations", socialrelations);
	}

	public SocialRelations getsocialrelationsbyid(int id)
			throws DataAccessException {
		return (SocialRelations)getSqlMapClientTemplate().queryForObject("relation.getsocialrelationsbyid", id);
	}

	public NewPageModel searchsocialrelations(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchsocialrelations_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchsocialrelations", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}
	
	@SuppressWarnings("unchecked")
	public List<SocialRelations> getSocialrelationsByPersonnelid(
			int personnelid) throws DataAccessException {
		return (List<SocialRelations>)getSqlMapClientTemplate().queryForList("relation.searchsocialrelations", personnelid);
	}
	
	public int updatesocialrelations(SocialRelations socialrelations)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updatesocialrelations", socialrelations);
	}

	public int addrelation(Relation relation) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelation", relation);
	}

	public int addrelationbank(RelationBank relationbank)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationbank", relationbank);
	}

	public int addrelationdriver(RelationDriver relationdriver)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationdriver", relationdriver);
	}

	public int addrelationhouse(RelationHouse relationhouse)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationhouse", relationhouse);
	}

	public int addrelationidentity(RelationIdentity relationidentity)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationidentity", relationidentity);
	}

	public int addrelationlegal(RelationLegal relationlegal)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationlegal", relationlegal);
	}

	public int addrelationpassport(RelationPassport relationpassport)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationpassport", relationpassport);
	}

	public int addrelationpayment(RelationPayment relationpayment)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationpayment", relationpayment);
	}

	public int addrelationphone(RelationPhone relationphone)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationphone", relationphone);
	}

	public int addrelationtelnumber(RelationTelnumber relationtelnumber)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationtelnumber", relationtelnumber);
	}

	public int addrelationvehicle(RelationVehicle relationvehicle)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationvehicle", relationvehicle);
	}

	public int addrelationwifi(RelationWifi relationwifi)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().insert("relation.addrelationwifi", relationwifi);
	}

	public int cancelrelation(Relation relation) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelation", relation);
	}

	public int cancelrelationbank(RelationBank relationbank)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationbank", relationbank);
	}

	public int cancelrelationdriver(RelationDriver relationdriver)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationdriver", relationdriver);
	}

	public int cancelrelationhouse(RelationHouse relationhouse)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationhouse", relationhouse);
	}

	public int cancelrelationidentity(RelationIdentity relationidentity)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationidentity", relationidentity);
	}

	public int cancelrelationlegal(RelationLegal relationlegal)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationlegal", relationlegal);
	}

	public int cancelrelationpassport(RelationPassport relationpassport)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationpassport", relationpassport);
	}

	public int cancelrelationpayment(RelationPayment relationpayment)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationpayment", relationpayment);
	}

	public int cancelrelationphone(RelationPhone relationphone)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationphone", relationphone);
	}

	public int cancelrelationtelnumber(RelationTelnumber relationtelnumber)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationtelnumber", relationtelnumber);
	}

	public int cancelrelationvehicle(RelationVehicle relationvehicle)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationvehicle", relationvehicle);
	}

	public int cancelrelationwifi(RelationWifi relationwifi)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.cancelrelationwifi", relationwifi);
	}

	public Relation searchrelation(Relation relation) throws DataAccessException {
		return (Relation)getSqlMapClientTemplate().queryForObject("relation.searchrelation", relation);
	}

	public Relation searchrelation(int personnelid) throws DataAccessException {
		return (Relation)getSqlMapClientTemplate().queryForObject("relation.searchrelation", personnelid);
	}

	public NewPageModel searchrelationbank(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationbank_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationbank", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationdriver(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationdriver_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationdriver", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<RelationDriver> getdriverbypersonnelid(
			int personnelid) throws DataAccessException {
		return (List<RelationDriver>)getSqlMapClientTemplate().queryForList("relation.searchrelationdriver", personnelid);
	}
	
	public NewPageModel searchrelationhouse(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationhouse_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationhouse", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationidentity(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationidentity_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationidentity", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List<RelationIdentity> getrelationidentitybypersonnelid(
			int personnelid) throws DataAccessException {
		return (List<RelationIdentity>)getSqlMapClientTemplate().queryForList("relation.searchrelationidentity", personnelid);
	}
	
	public NewPageModel searchrelationlegal(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationlegal_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationlegal", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationpassport(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationpassport_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationpassport", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationpayment(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationpayment_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationpayment", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationphone(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationphone_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationphone", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationtelnumber(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationtelnumber_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationtelnumber", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationvehicle(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationvehicle_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationvehicle", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public NewPageModel searchrelationwifi(int personnelid, NewPageModel pm)
			throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationwifi_count", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationwifi", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updaterelation(Relation relation) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelation", relation);
	}

	public int updaterelationbank(RelationBank relationbank)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationbank", relationbank);
	}

	public int updaterelationdriver(RelationDriver relationdriver)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationdriver", relationdriver);
	}

	public int updaterelationhouse(RelationHouse relationhouse)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationhouse", relationhouse);
	}

	public int updaterelationidentity(RelationIdentity relationidentity)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationidentity", relationidentity);
	}

	public int updaterelationlegal(RelationLegal relationlegal)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationlegal", relationlegal);
	}

	public int updaterelationpassport(RelationPassport relationpassport)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationpassport", relationpassport);
	}

	public int updaterelationpayment(RelationPayment relationpayment)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationpayment", relationpayment);
	}

	public int updaterelationphone(RelationPhone relationphone)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationphone", relationphone);
	}

	public int updaterelationtelnumber(RelationTelnumber relationtelnumber)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationtelnumber", relationtelnumber);
	}

	public int updaterelationvehicle(RelationVehicle relationvehicle)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationvehicle", relationvehicle);
	}

	public int updaterelationwifi(RelationWifi relationwifi)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationwifi", relationwifi);
	}

	public RelationBank getrelationbankbyid(int id) throws DataAccessException {
		return (RelationBank)getSqlMapClientTemplate().queryForObject("relation.getrelationbankbyid", id);
	}

	public RelationDriver getrelationdriverbyid(int id)
			throws DataAccessException {
		return (RelationDriver)getSqlMapClientTemplate().queryForObject("relation.getrelationdriverbyid", id);
	}

	public RelationHouse getrelationhousebyid(int id)
			throws DataAccessException {
		return (RelationHouse)getSqlMapClientTemplate().queryForObject("relation.getrelationhousebyid", id);
	}

	public RelationIdentity getrelationidentitybyid(int id)
			throws DataAccessException {
		return (RelationIdentity)getSqlMapClientTemplate().queryForObject("relation.getrelationidentitybyid", id);
	}

	public RelationLegal getrelationlegalbyid(int id)
			throws DataAccessException {
		return (RelationLegal)getSqlMapClientTemplate().queryForObject("relation.getrelationlegalbyid", id);
	}

	public RelationPassport getrelationpassportbyid(int id)
			throws DataAccessException {
		return (RelationPassport)getSqlMapClientTemplate().queryForObject("relation.getrelationpassportbyid", id);
	}

	public RelationPayment getrelationpaymentbyid(int id)
			throws DataAccessException {
		return (RelationPayment)getSqlMapClientTemplate().queryForObject("relation.getrelationpaymentbyid", id);
	}

	public RelationPhone getrelationphonebyid(int id)
			throws DataAccessException {
		return (RelationPhone)getSqlMapClientTemplate().queryForObject("relation.getrelationphonebyid", id);
	}

	public RelationTelnumber getrelationtelnumberbyid(int id)
			throws DataAccessException {
		return (RelationTelnumber)getSqlMapClientTemplate().queryForObject("relation.getrelationtelnumberbyid", id);
	}

	public RelationVehicle getrelationvehiclebyid(int id)
			throws DataAccessException {
		return (RelationVehicle)getSqlMapClientTemplate().queryForObject("relation.getrelationvehiclebyid", id);
	}

	public RelationWifi getrelationwifibyid(int id) throws DataAccessException {
		return (RelationWifi)getSqlMapClientTemplate().queryForObject("relation.getrelationwifibyid", id);
	}

	public String getbankaccount(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getbankaccount", personnelid);
	}

	public String getdrivertype(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getdrivertype", personnelid);
	}

	public String gethousetype(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.gethousetype", personnelid);
	}

	public String getidentitytype(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getidentitytype", personnelid);
	}

	public String getlegalname(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getlegalname", personnelid);
	}

	public String getpassporttype(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getpassporttype", personnelid);
	}

	public String getpaymentname(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getpaymentname", personnelid);
	}

	public String getssid(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getssid", personnelid);
	}

	public String gettelbrand(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.gettelbrand", personnelid);
	}

	public String gettelnumber(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.gettelnumber", personnelid);
	}

	public String getvehicletype(int personnelid) throws DataAccessException {
		return  (String) getSqlMapClientTemplate().queryForObject("relation.getvehicletype", personnelid);
	}

	public int getrelationcount(int personnelid) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("relation.getrelationcount", personnelid);
	}

	public SocialRelations getsocialrelationsname(String cardnumber) throws DataAccessException {
		return (SocialRelations)getSqlMapClientTemplate().queryForObject("relation.getsocialrelationsname", cardnumber);
	}

	public String getrelationtelnumber(int personnelid)
			throws DataAccessException {
		return (String)getSqlMapClientTemplate().queryForObject("relation.getrelationtelnumber", personnelid);
	}

	@SuppressWarnings("unchecked")
	public List<SocialRelations> getNewSocialrelations(int personnelid) throws DataAccessException {
		return  (List<SocialRelations>) getSqlMapClientTemplate().queryForList("relation.getNewSocialrelations", personnelid);
	}

	@SuppressWarnings("unchecked")
	public List<RelationVehicle> getNewRelationvehicle(int personnelid) throws DataAccessException {
		return  (List<RelationVehicle>) getSqlMapClientTemplate().queryForList("relation.getNewRelationvehicle", personnelid);
	}

	public int getSocialrelationsCount(int personnelid) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("relation.getSocialrelationsCount", personnelid);
	}

	@SuppressWarnings("unchecked")
	public List<RelationTelnumber> getRelationTelnumberByImsi(String imsi) throws DataAccessException {
		return  (List<RelationTelnumber>) getSqlMapClientTemplate().queryForList("relation.getRelationTelnumberByImsi", imsi);
	}

	@SuppressWarnings("unchecked")
	public List<RelationVehicle> getRelationVehicleByVehiclenum(String vehiclenum) throws DataAccessException {
		return  (List<RelationVehicle>) getSqlMapClientTemplate().queryForList("relation.getRelationVehicleByVehiclenum", vehiclenum);
	}

	public Relation searchrelation_zfw(int personnelid) throws DataAccessException {
		return (Relation)getSqlMapClientTemplate().queryForObject("relation.searchrelation_zfw", personnelid);
	}

	public NewPageModel searchrelationtelnumber_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationtelnumber_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationtelnumber_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationTelnumber getrelationtelnumberbyid_zfw(int id) throws DataAccessException {
		return (RelationTelnumber)getSqlMapClientTemplate().queryForObject("relation.getrelationtelnumberbyid_zfw", id);
	}

	public int updaterelationtelnumber_zfw(RelationTelnumber relationtelnumber) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationtelnumber_zfw", relationtelnumber);
	}

	public boolean checkTelnumberExists(int personnelid, String telnumber) throws DataAccessException {
		java.util.Map<String, Object> params = new java.util.HashMap<String, Object>();
		params.put("personnelid", personnelid);
		params.put("telnumber", telnumber);
		Integer count = (Integer)getSqlMapClientTemplate().queryForObject("relation.checkTelnumberExists", params);
		return count != null && count > 0;
	}

	public NewPageModel searchrelationphone_zfw(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationphone_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationphone_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationPhone getrelationphonebyid_zfw(int id) throws DataAccessException {
		return (RelationPhone)getSqlMapClientTemplate().queryForObject("relation.getrelationphonebyid_zfw", id);
	}

	public int updaterelationphone_zfw(RelationPhone relationphone) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationphone_zfw", relationphone);
	}

	public NewPageModel searchrelationwifi_zfw(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationwifi_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationwifi_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationWifi getrelationwifibyid_zfw(int id) throws DataAccessException {
		return (RelationWifi)getSqlMapClientTemplate().queryForObject("relation.getrelationwifibyid_zfw", id);
	}

	public int updaterelationwifi_zfw(RelationWifi relationwifi) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationwifi_zfw", relationwifi);
	}

	public NewPageModel searchrelationvehicle_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationvehicle_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationvehicle_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationVehicle getrelationvehiclebyid_zfw(int id) throws DataAccessException {
		return (RelationVehicle)getSqlMapClientTemplate().queryForObject("relation.getrelationvehiclebyid_zfw", id);
	}

	public int updaterelationvehicle_zfw(RelationVehicle relationvehicle) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationvehicle_zfw", relationvehicle);
	}

	public NewPageModel searchrelationbank_zfw(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationbank_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationbank_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationBank getrelationbankbyid_zfw(int id) throws DataAccessException {
		return (RelationBank)getSqlMapClientTemplate().queryForObject("relation.getrelationbankbyid_zfw", id);
	}

	public int updaterelationbank_zfw(RelationBank relationbank) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationbank_zfw", relationbank);
	}

	public NewPageModel searchrelationidentity_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationidentity_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationidentity_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationIdentity getrelationidentitybyid_zfw(int id) throws DataAccessException {
		return (RelationIdentity)getSqlMapClientTemplate().queryForObject("relation.getrelationidentitybyid_zfw", id);
	}

	public int updaterelationidentity_zfw(RelationIdentity relationidentity) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationidentity_zfw", relationidentity);
	}

	public NewPageModel searchrelationpayment_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationpayment_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationpayment_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationPayment getrelationpaymentbyid_zfw(int id) throws DataAccessException {
		return (RelationPayment)getSqlMapClientTemplate().queryForObject("relation.getrelationpaymentbyid_zfw", id);
	}

	public int updaterelationpayment_zfw(RelationPayment relationpayment) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationpayment_zfw", relationpayment);
	}

	public NewPageModel searchrelationhouse_zfw(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationhouse_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationhouse_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationHouse getrelationhousebyid_zfw(int id) throws DataAccessException {
		return (RelationHouse)getSqlMapClientTemplate().queryForObject("relation.getrelationhousebyid_zfw", id);
	}

	public int updaterelationhouse_zfw(RelationHouse relationhouse) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationhouse_zfw", relationhouse);
	}

	public NewPageModel searchrelationlegal_zfw(int personnelid, NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationlegal_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationlegal_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationLegal getrelationlegalbyid_zfw(int id) throws DataAccessException {
		return (RelationLegal)getSqlMapClientTemplate().queryForObject("relation.getrelationlegalbyid_zfw", id);
	}

	public int updaterelationlegal_zfw(RelationLegal relationlegal) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationlegal_zfw", relationlegal);
	}

	public NewPageModel searchrelationdriver_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationdriver_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationdriver_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public RelationDriver getrelationdriverbyid_zfw(int id) throws DataAccessException {
		return (RelationDriver)getSqlMapClientTemplate().queryForObject("relation.getrelationdriverbyid_zfw", id);
	}

	public int updaterelationdriver_zfw(RelationDriver relationdriver) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationdriver_zfw", relationdriver);
	}

	public RelationPassport getrelationpassportbyid_zfw(int id) throws DataAccessException {
		return (RelationPassport)getSqlMapClientTemplate().queryForObject("relation.getrelationpassportbyid_zfw", id);
	}

	public NewPageModel searchrelationpassport_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchrelationpassport_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchrelationpassport_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public int updaterelationpassport_zfw(RelationPassport relationpassport) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updaterelationpassport_zfw", relationpassport);
	}

	public NewPageModel searchsocialrelations_zfw(int personnelid,NewPageModel pm) throws DataAccessException {
		int total = (Integer) getSqlMapClientTemplate().queryForObject("relation.searchsocialrelations_count_zfw", personnelid);
		pm.setTotal(total);
		pm.setup();
		pm.setRows(getSqlMapClientTemplate().queryForList("relation.searchsocialrelations_zfw", personnelid, pm.getStart(), pm.getTruepagesize()));
		return pm;
	}

	public SocialRelations getsocialrelationsbyid_zfw(int id) throws DataAccessException {
		return (SocialRelations)getSqlMapClientTemplate().queryForObject("relation.getsocialrelationsbyid_zfw", id);
	}

	public int updatesocialrelations_zfw(SocialRelations socialrelations) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().update("relation.updatesocialrelations_zfw", socialrelations);
	}
}

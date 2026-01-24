package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *人员关联信息表 p_relation_t
 */
public class Relation {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private String telnumber;//手机号码  手机号码（PN）
	private String telephone;//使用手机  品牌型号
	private String relatedwifi;//关联WiFi   路由SSID
	private String relatedvehicle;//交通工具   车辆类型
	private String bankaccount;//银行账号   开户行
	private String netidentity;//虚拟身份   虚拟身份类型
	private String netpayment;//网络支付   支付机构名称
	private String relatedhouse;//涉及房产  房产类型
	private String relatedlegal;//法人组织   机构名称
	private String relateddriver;//驾驶证件   驾驶证件类型
	private String relatedpassport;//护照情况    护照类型
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String relationname;
	private String relationvalue;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getTelnumber() {
		return telnumber;
	}
	public void setTelnumber(String telnumber) {
		this.telnumber = telnumber;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getRelatedwifi() {
		return relatedwifi;
	}
	public void setRelatedwifi(String relatedwifi) {
		this.relatedwifi = relatedwifi;
	}
	public String getRelatedvehicle() {
		return relatedvehicle;
	}
	public void setRelatedvehicle(String relatedvehicle) {
		this.relatedvehicle = relatedvehicle;
	}
	public String getBankaccount() {
		return bankaccount;
	}
	public void setBankaccount(String bankaccount) {
		this.bankaccount = bankaccount;
	}
	public String getNetidentity() {
		return netidentity;
	}
	public void setNetidentity(String netidentity) {
		this.netidentity = netidentity;
	}
	public String getNetpayment() {
		return netpayment;
	}
	public void setNetpayment(String netpayment) {
		this.netpayment = netpayment;
	}
	public String getRelatedhouse() {
		return relatedhouse;
	}
	public void setRelatedhouse(String relatedhouse) {
		this.relatedhouse = relatedhouse;
	}
	public String getRelatedlegal() {
		return relatedlegal;
	}
	public void setRelatedlegal(String relatedlegal) {
		this.relatedlegal = relatedlegal;
	}
	public String getRelateddriver() {
		return relateddriver;
	}
	public void setRelateddriver(String relateddriver) {
		this.relateddriver = relateddriver;
	}
	public String getRelatedpassport() {
		return relatedpassport;
	}
	public void setRelatedpassport(String relatedpassport) {
		this.relatedpassport = relatedpassport;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getAddoperator() {
		return addoperator;
	}
	public void setAddoperator(String addoperator) {
		this.addoperator = addoperator;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getUpdateoperator() {
		return updateoperator;
	}
	public void setUpdateoperator(String updateoperator) {
		this.updateoperator = updateoperator;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getRelationname() {
		return relationname;
	}
	public void setRelationname(String relationname) {
		this.relationname = relationname;
	}
	public String getRelationvalue() {
		return relationvalue;
	}
	public void setRelationvalue(String relationvalue) {
		this.relationvalue = relationvalue;
	}
	
}

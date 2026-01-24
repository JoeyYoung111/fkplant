package com.szrj.business.model.company;

/**
 * 设备信息 c_yzd_equipment_t
 * @author 李昊
 * Aug 24, 2021
 */
public class YzdEquipment {
	/*---------------数据库字段---------------------*/
	private int id;			//ID自增
	private int companyid;	//风险单位id
	private int equipmentname;//设备名称:存数据字典id
	private String makecompany;	//制造厂商
	private String equipmentbrand;//品牌
	private String equipmenttype;//型号
	private String equipmentpower;//功率
	private String buydate;		//购买日期
	private String useyear;		//使用年限
	private String usestatus;	//使用情况:自用、租借、购销
	private String purpose;		//用途
	private String usestate;	//使用状态:正常、停用、报废
	private String leasecompany;//出租企业
	private String lesseecompany;//承租企业
	private String sellcompany;	//出售企业
	private String buycompany;	//购买企业
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	/*--------------非数据库中字段------------------*/
	private String emsg;
	/*--------------get/set方法--------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCompanyid() {
		return companyid;
	}
	public void setCompanyid(int companyid) {
		this.companyid = companyid;
	}
	public int getEquipmentname() {
		return equipmentname;
	}
	public void setEquipmentname(int equipmentname) {
		this.equipmentname = equipmentname;
	}
	public String getMakecompany() {
		return makecompany;
	}
	public void setMakecompany(String makecompany) {
		this.makecompany = makecompany;
	}
	public String getEquipmentbrand() {
		return equipmentbrand;
	}
	public void setEquipmentbrand(String equipmentbrand) {
		this.equipmentbrand = equipmentbrand;
	}
	public String getEquipmenttype() {
		return equipmenttype;
	}
	public void setEquipmenttype(String equipmenttype) {
		this.equipmenttype = equipmenttype;
	}
	public String getEquipmentpower() {
		return equipmentpower;
	}
	public void setEquipmentpower(String equipmentpower) {
		this.equipmentpower = equipmentpower;
	}
	public String getBuydate() {
		return buydate;
	}
	public void setBuydate(String buydate) {
		this.buydate = buydate;
	}
	public String getUseyear() {
		return useyear;
	}
	public void setUseyear(String useyear) {
		this.useyear = useyear;
	}
	public String getUsestatus() {
		return usestatus;
	}
	public void setUsestatus(String usestatus) {
		this.usestatus = usestatus;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getUsestate() {
		return usestate;
	}
	public void setUsestate(String usestate) {
		this.usestate = usestate;
	}
	public String getLeasecompany() {
		return leasecompany;
	}
	public void setLeasecompany(String leasecompany) {
		this.leasecompany = leasecompany;
	}
	public String getLesseecompany() {
		return lesseecompany;
	}
	public void setLesseecompany(String lesseecompany) {
		this.lesseecompany = lesseecompany;
	}
	public String getSellcompany() {
		return sellcompany;
	}
	public void setSellcompany(String sellcompany) {
		this.sellcompany = sellcompany;
	}
	public String getBuycompany() {
		return buycompany;
	}
	public void setBuycompany(String buycompany) {
		this.buycompany = buycompany;
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
	public String getEmsg() {
		return emsg;
	}
	public void setEmsg(String emsg) {
		this.emsg = emsg;
	}
}

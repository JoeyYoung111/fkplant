package com.szrj.business.model.position;

/**
 * @author jygacsk
 *	政保阵地——组织登记卡
 */
public class Organization {
	/*************数据库字段**********************/
	private int id;					//主键id
	private String orgName;			//组织名称
	private String orgType;			//组织级别
	private String orgClass;		//组织类别
	private String orgForeignName;	//外文名称
	private String inProvince;		//是否省内组织
	private String isRegister;		//是否登记注册
	private String createTime;		//成立日期
	private String createAddress;	//成立地点
	private String address;			//详细地址
	private String activeLevel;		//活跃程度<有填写提示>
	private String activeRange;		//活动范围<有填写提示>
	private String activeWay;		//活动方式<有填写提示>
	private String activeWayDetails;//活动方式简要描述
	private String isForeignConnections;//是否与境外存在勾连<有填写提示>
	private String orgGeneral;		//组织概况
	private String proposition;		//政治主张及利益诉求
	private String finance;			//财务状况
	private String subsidize;		//接受资助请情况
	private String controlTime;		//管控时间
	private String controlUnit;		//管控单位
	private String controlPolice;	//管控民警
	private String controlPhone;	//联系电话(长号)
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	/*************非数据库字段********************/
	private String unitname;
	private String policename;
	private String starttime;
	private String endtime;
	private int personnelid;
	//显示权限 0-全部 1-派出所 2-民警
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段 
	/**************get/set方法*******************/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getOrgForeignName() {
		return orgForeignName;
	}
	public void setOrgForeignName(String orgForeignName) {
		this.orgForeignName = orgForeignName;
	}
	public String getInProvince() {
		return inProvince;
	}
	public void setInProvince(String inProvince) {
		this.inProvince = inProvince;
	}
	public String getIsRegister() {
		return isRegister;
	}
	public void setIsRegister(String isRegister) {
		this.isRegister = isRegister;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getCreateAddress() {
		return createAddress;
	}
	public void setCreateAddress(String createAddress) {
		this.createAddress = createAddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getActiveLevel() {
		return activeLevel;
	}
	public void setActiveLevel(String activeLevel) {
		this.activeLevel = activeLevel;
	}
	public String getActiveRange() {
		return activeRange;
	}
	public void setActiveRange(String activeRange) {
		this.activeRange = activeRange;
	}
	public String getActiveWay() {
		return activeWay;
	}
	public void setActiveWay(String activeWay) {
		this.activeWay = activeWay;
	}
	public String getActiveWayDetails() {
		return activeWayDetails;
	}
	public void setActiveWayDetails(String activeWayDetails) {
		this.activeWayDetails = activeWayDetails;
	}
	public String getIsForeignConnections() {
		return isForeignConnections;
	}
	public void setIsForeignConnections(String isForeignConnections) {
		this.isForeignConnections = isForeignConnections;
	}
	public String getOrgGeneral() {
		return orgGeneral;
	}
	public void setOrgGeneral(String orgGeneral) {
		this.orgGeneral = orgGeneral;
	}
	public String getProposition() {
		return proposition;
	}
	public void setProposition(String proposition) {
		this.proposition = proposition;
	}
	public String getFinance() {
		return finance;
	}
	public void setFinance(String finance) {
		this.finance = finance;
	}
	public String getSubsidize() {
		return subsidize;
	}
	public void setSubsidize(String subsidize) {
		this.subsidize = subsidize;
	}
	public String getControlTime() {
		return controlTime;
	}
	public void setControlTime(String controlTime) {
		this.controlTime = controlTime;
	}
	public String getControlUnit() {
		return controlUnit;
	}
	public void setControlUnit(String controlUnit) {
		this.controlUnit = controlUnit;
	}
	public String getControlPolice() {
		return controlPolice;
	}
	public void setControlPolice(String controlPolice) {
		this.controlPolice = controlPolice;
	}
	public String getControlPhone() {
		return controlPhone;
	}
	public void setControlPhone(String controlPhone) {
		this.controlPhone = controlPhone;
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
	public String getOrgType() {
		return orgType;
	}
	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getPolicename() {
		return policename;
	}
	public void setPolicename(String policename) {
		this.policename = policename;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public int getPersonFilter() {
		return personFilter;
	}
	public void setPersonFilter(int personFilter) {
		this.personFilter = personFilter;
	}
	public int getUnitFilter() {
		return unitFilter;
	}
	public void setUnitFilter(int unitFilter) {
		this.unitFilter = unitFilter;
	}
	public String getOrgClass() {
		return orgClass;
	}
	public void setOrgClass(String orgClass) {
		this.orgClass = orgClass;
	}
	
}

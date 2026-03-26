package com.szrj.business.model.personel;

public class ZaPei {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;		//人员主表id

	// 基本采集信息
	private String collectSource;	//采集来源(案件/警情/日常工作发现)
	private String collectDate;		//采集日期
	private String activityVenue;	//活动场所
	private String otherMemo;		//其他备注(陪侍情况)

	// 现住地结构化字段
	private String homeProvince;	//现住-省
	private String homeCity;		//现住-地级市
	private String homeCounty;		//现住-县级市/区
	private String homeTown;		//现住-镇/街道
	private Integer homePoliceStationId;	//现住-所属派出所ID(关联sys_department_t_new.id)
	private String homePoliceStationName;	//派出所名称(非数据库字段,用于展示)
	private String homeDetail;		//现住-详细地址
	private String homeLng;			//现住-经度
	private String homeLat;			//现住-纬度

	// 审计字段
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//角色标签
	private int validflag;			//状态标识   1：正常 0:作废
	private int hasShechangRecord;	//涉黄前科 0-否 1-是
    // 关联信息字段（非数据库字段，用于列表展示）
    private String relAjIds;		//关联的案件ID列表，逗号分隔
    private String relJqIds;		//关联的警情ID列表，逗号分隔

	/*---------------------------------------非数据库中字段-------------------------------------*/

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
	public String getCollectSource() {
		return collectSource;
	}
	public void setCollectSource(String collectSource) {
		this.collectSource = collectSource;
	}
	public String getCollectDate() {
		return collectDate;
	}
	public void setCollectDate(String collectDate) {
		this.collectDate = collectDate;
	}
	public String getActivityVenue() {
		return activityVenue;
	}
	public void setActivityVenue(String activityVenue) {
		this.activityVenue = activityVenue;
	}
	public String getOtherMemo() {
		return otherMemo;
	}
	public void setOtherMemo(String otherMemo) {
		this.otherMemo = otherMemo;
	}
	public String getHomeProvince() {
		return homeProvince;
	}
	public void setHomeProvince(String homeProvince) {
		this.homeProvince = homeProvince;
	}
	public String getHomeCity() {
		return homeCity;
	}
	public void setHomeCity(String homeCity) {
		this.homeCity = homeCity;
	}
	public String getHomeCounty() {
		return homeCounty;
	}
	public void setHomeCounty(String homeCounty) {
		this.homeCounty = homeCounty;
	}
	public String getHomeTown() {
		return homeTown;
	}
	public void setHomeTown(String homeTown) {
		this.homeTown = homeTown;
	}
	public Integer getHomePoliceStationId() {
		return homePoliceStationId;
	}
	public void setHomePoliceStationId(Integer homePoliceStationId) {
		this.homePoliceStationId = homePoliceStationId;
	}
	public String getHomePoliceStationName() {
		return homePoliceStationName;
	}
	public void setHomePoliceStationName(String homePoliceStationName) {
		this.homePoliceStationName = homePoliceStationName;
	}
	public String getHomeDetail() {
		return homeDetail;
	}
	public void setHomeDetail(String homeDetail) {
		this.homeDetail = homeDetail;
	}
	public String getHomeLng() {
		return homeLng;
	}
	public void setHomeLng(String homeLng) {
		this.homeLng = homeLng;
	}
	public String getHomeLat() {
		return homeLat;
	}
	public void setHomeLat(String homeLat) {
		this.homeLat = homeLat;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getHasShechangRecord() {
		return hasShechangRecord;
	}
	public void setHasShechangRecord(int hasShechangRecord) {
		this.hasShechangRecord = hasShechangRecord;
	}
	public String getRelAjIds() {
		return relAjIds;
	}
	public void setRelAjIds(String relAjIds) {
		this.relAjIds = relAjIds;
	}
	public String getRelJqIds() {
		return relJqIds;
	}
	public void setRelJqIds(String relJqIds) {
		this.relJqIds = relJqIds;
	}
}


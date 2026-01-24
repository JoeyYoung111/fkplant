package com.szrj.business.model.personel;

public class ZaDu {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;		//人员主表id
	private String lssdqk;			//历史涉赌情况
	private String chsj;			//处罚时间
	private String chjg;			//查获经过
	private String cfjg;			//处罚结果
	private String clxq;			//处理详情
	private String dbfs;			//赌博方式(数据字典)
	private String dbbw;			//赌博部位(数据字典)
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	private int validflag;			//状态标识   1：正常 0:作废

	// 新增字段
	private String personAttribute;	//涉赌人员属性(数据字典)
	private String collectSource;	//采集来源(案件/警情/日常工作发现)
	private String otherMemo;		//其他备注

	// 现住地结构化字段
	private String homeProvince;	//现住-省
	private String homeCity;		//现住-地级市
	private String homeCounty;		//现住-县级市/区
	private String homeTown;		//现住-镇/街道
	private Integer homePoliceStationId;	//现住-所属派出所ID(关联sys_department_t_new.id)
	private String homePoliceStationName;	//派出所���称(非数据库字段,用于展示)
	private String homeDetail;		//现住-详细地址
	private String homeLng;			//现住-经度
	private String homeLat;			//现住-纬度

	// 其他新增字段
	private int hasSheduRecord;		//涉赌前科 0-否 1-是
    private String phone;
	private String caseAddressList;	//涉案地址列表，多个地址用逗号分隔
	private String collectDate;		//采集日期

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
	public String getLssdqk() {
		return lssdqk;
	}
	public void setLssdqk(String lssdqk) {
		this.lssdqk = lssdqk;
	}
	public String getChsj() {
		return chsj;
	}
	public void setChsj(String chsj) {
		this.chsj = chsj;
	}
	public String getChjg() {
		return chjg;
	}
	public void setChjg(String chjg) {
		this.chjg = chjg;
	}
	public String getCfjg() {
		return cfjg;
	}
	public void setCfjg(String cfjg) {
		this.cfjg = cfjg;
	}
	public String getClxq() {
		return clxq;
	}
	public void setClxq(String clxq) {
		this.clxq = clxq;
	}
	public String getDbfs() {
		return dbfs;
	}
	public void setDbfs(String dbfs) {
		this.dbfs = dbfs;
	}
	public String getDbbw() {
		return dbbw;
	}
	public void setDbbw(String dbbw) {
		this.dbbw = dbbw;
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
	
	// 新增字段的getter/setter
    public String getPersonAttribute() {
		return personAttribute;
	}
	public void setPersonAttribute(String personAttribute) {
		this.personAttribute = personAttribute;
	}
	public String getCollectSource() {
		return collectSource;
	}
	public void setCollectSource(String collectSource) {
		this.collectSource = collectSource;
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
	public int getHasSheduRecord() {
		return hasSheduRecord;
	}
	public void setHasSheduRecord(int hasSheduRecord) {
		this.hasSheduRecord = hasSheduRecord;
	}
	public String getCaseAddressList() {
		return caseAddressList;
	}
	public void setCaseAddressList(String caseAddressList) {
		this.caseAddressList = caseAddressList;
	}
	public String getCollectDate() {
		return collectDate;
	}
	public void setCollectDate(String collectDate) {
		this.collectDate = collectDate;
	}
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

	// VO层方法：将逗号分隔的字符串转换为List
	public java.util.List<String> getCaseAddressArray() {
		if (caseAddressList == null || caseAddressList.trim().isEmpty()) {
			return java.util.Collections.emptyList();
		}
		return java.util.Arrays.asList(caseAddressList.split("，"));
	}

	// VO层方法：将List转换为逗号分隔的字符串
	public void setCaseAddressArray(java.util.List<String> list) {
		if (list == null || list.isEmpty()) {
			this.caseAddressList = null;
		} else {
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < list.size(); i++) {
				if (i > 0) {
					sb.append("，");
				}
				sb.append(list.get(i));
			}
			this.caseAddressList = sb.toString();
		}
	}

}

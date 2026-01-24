package com.szrj.business.model.personel;

/**
 * 住址历史记录表 (p_homeplace_history_t)
 */
public class HomeplaceHistory {
	private int id;
	private int personnelid;		//关联人员ID
	private String province;		//省
	private String city;			//地级市
	private String county;			//县级市/区
	private String town;			//镇/街道
	private Integer policeStationId;	//所属派出所ID(关联sys_department_t_new.id)
	private String policeStationName;	//派出所名称(非数据库字段,用于展示)
	private String detailAddress;	//详细地址
	private String longitude;		//经度
	private String latitude;		//纬度
	private String startDate;		//开始时间
	private String endDate;			//结束时间
	private int validflag;			//状态 1有效 0无效
	private String addoperator;		//添加人
	private String addtime;			//添加时间

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
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public Integer getPoliceStationId() {
		return policeStationId;
	}
	public void setPoliceStationId(Integer policeStationId) {
		this.policeStationId = policeStationId;
	}
	public String getPoliceStationName() {
		return policeStationName;
	}
	public void setPoliceStationName(String policeStationName) {
		this.policeStationName = policeStationName;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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

	/**
	 * 获取完整地址
	 */
	public String getFullAddress() {
		StringBuilder sb = new StringBuilder();
		if (province != null) sb.append(province);
		if (city != null) sb.append(city);
		if (county != null) sb.append(county);
		if (town != null) sb.append(town);
		if (detailAddress != null) sb.append(detailAddress);
		return sb.toString();
	}
}


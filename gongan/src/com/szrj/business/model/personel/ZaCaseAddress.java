package com.szrj.business.model.personel;

/**
 * 涉案地址详情表 (p_zaperson_case_address_t)
 * 用于涉赌/涉娼多个涉案地址
 */
public class ZaCaseAddress {
	private int id;
	private int recordId;			//关联背景表ID (p_zaperson_du_t 或 p_zaperson_chang_t 的 id)
	private int recordType;			//类型 1-涉赌 2-涉娼
	private String province;		//省
	private String city;			//地级市
	private String county;			//县级市/区
	private String town;			//镇/街道
	private String detailAddress;	//详细地址(店名)
	private String longitude;		//经度
	private String latitude;		//纬度
	private int validflag;			//状态 1有效 0无效
	private String addtime;			//添加时间

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRecordId() {
		return recordId;
	}
	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}
	public int getRecordType() {
		return recordType;
	}
	public void setRecordType(int recordType) {
		this.recordType = recordType;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
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


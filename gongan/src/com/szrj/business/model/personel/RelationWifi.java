package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *人员关联信息-关联WIFI表 p_relation_wifi_t
 */
public class RelationWifi {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private String relatedtype;//关联地址类型  必选，现住地、工作地、其他
	private String relateddetail;//关联地址详情
	private String ssid;//路由SSID
	private String mac;//路由MAC
	private String longitude;//经度坐标
	private String latitude;//纬度坐标
	private int isactivate;//是否停用  0-否 1-是
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
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
	public String getRelatedtype() {
		return relatedtype;
	}
	public void setRelatedtype(String relatedtype) {
		this.relatedtype = relatedtype;
	}
	public String getRelateddetail() {
		return relateddetail;
	}
	public void setRelateddetail(String relateddetail) {
		this.relateddetail = relateddetail;
	}
	public String getSsid() {
		return ssid;
	}
	public void setSsid(String ssid) {
		this.ssid = ssid;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
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
	public int getIsactivate() {
		return isactivate;
	}
	public void setIsactivate(int isactivate) {
		this.isactivate = isactivate;
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
	
}

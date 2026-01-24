package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *人员关联信息-驾驶证件表 p_relation_driver_t
 */
public class RelationDriver {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private String drivertype;//准驾证类别  必选，数据字典，存汉字
	private String driverno;//驾驶证编号
	private String driveraddress;//驾驶证申领地
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
	public String getDrivertype() {
		return drivertype;
	}
	public void setDrivertype(String drivertype) {
		this.drivertype = drivertype;
	}
	public String getDriverno() {
		return driverno;
	}
	public void setDriverno(String driverno) {
		this.driverno = driverno;
	}
	public String getDriveraddress() {
		return driveraddress;
	}
	public void setDriveraddress(String driveraddress) {
		this.driveraddress = driveraddress;
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

package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *人员关联信息-交通工具表 p_relation_vehicle_t
 */
public class RelationVehicle {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private String gainorigin;//获取来源  必选，走访排查、信息查询、技术分析
	private String vehicletype;//车辆类别  数据字典，存汉字
	private String vehicleorigin;//车辆来源  数据字典，存汉字
	private String vehiclenum;//车辆号牌
	private String vehiclebrand;//品牌型号
	private String vehiclecolor;//车辆颜色
	private String vehiclephoto;//车辆照片
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
	public String getGainorigin() {
		return gainorigin;
	}
	public void setGainorigin(String gainorigin) {
		this.gainorigin = gainorigin;
	}
	public String getVehicletype() {
		return vehicletype;
	}
	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}
	public String getVehicleorigin() {
		return vehicleorigin;
	}
	public void setVehicleorigin(String vehicleorigin) {
		this.vehicleorigin = vehicleorigin;
	}
	public String getVehiclenum() {
		return vehiclenum;
	}
	public void setVehiclenum(String vehiclenum) {
		this.vehiclenum = vehiclenum;
	}
	public String getVehiclebrand() {
		return vehiclebrand;
	}
	public void setVehiclebrand(String vehiclebrand) {
		this.vehiclebrand = vehiclebrand;
	}
	public String getVehiclecolor() {
		return vehiclecolor;
	}
	public void setVehiclecolor(String vehiclecolor) {
		this.vehiclecolor = vehiclecolor;
	}
	public String getVehiclephoto() {
		return vehiclephoto;
	}
	public void setVehiclephoto(String vehiclephoto) {
		this.vehiclephoto = vehiclephoto;
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

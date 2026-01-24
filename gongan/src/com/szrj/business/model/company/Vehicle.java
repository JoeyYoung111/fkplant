package com.szrj.business.model.company;

/**
 * 风险车辆基本信息 v_vehicle_t
 * @author 李昊
 * Sep 24, 2021
 */
public class Vehicle {
	/*-------------数据库中字段------------------*/
	private int id;					//自增ID
	private int companyid;			//所属单位id
	private String companyname;		//单位名称
	private int vehiclecategory;	//车辆大类 存数据字典id
	private String vehicleno;		//牌照
	private String vehiclebrand;	//品牌型号
	private String vehiclecolor;	//车辆颜色
	private String vehicletype;		//车辆类型
	private String useNature;		//使用性质
	private String transportNo;		//道路运输编号
	private String allowrange;		//许可范围
	private String relatedtype;		//涉及品种(易制毒化学品目录选择,多选)
	private String engineno;		//发动机号
	private String identificationCode;//车辆识别代码
	private String attachments;		//附件(运输证照片)
	private int validflag;	//状态标识 1:正常 0:作废
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String updateoperator;//最新修改人:包括修改、删除修改此字段信息
	private String updatetime;	//最新修改时间
	private String memo;		//备注信息
	/*-------------非数据库中字段---------------------------*/
	private String vehiclecategoryMsg;
	private String relatedtypeMsg;
	private String filenames;
	private String cnameSearch;
	/*----------------get/set方法------------------------------*/
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
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public int getVehiclecategory() {
		return vehiclecategory;
	}
	public void setVehiclecategory(int vehiclecategory) {
		this.vehiclecategory = vehiclecategory;
	}
	public String getVehicleno() {
		return vehicleno;
	}
	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
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
	public String getVehicletype() {
		return vehicletype;
	}
	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}
	public String getUseNature() {
		return useNature;
	}
	public void setUseNature(String useNature) {
		this.useNature = useNature;
	}
	public String getTransportNo() {
		return transportNo;
	}
	public void setTransportNo(String transportNo) {
		this.transportNo = transportNo;
	}
	public String getAllowrange() {
		return allowrange;
	}
	public void setAllowrange(String allowrange) {
		this.allowrange = allowrange;
	}
	public String getRelatedtype() {
		return relatedtype;
	}
	public void setRelatedtype(String relatedtype) {
		this.relatedtype = relatedtype;
	}
	public String getEngineno() {
		return engineno;
	}
	public void setEngineno(String engineno) {
		this.engineno = engineno;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
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
	public String getVehiclecategoryMsg() {
		return vehiclecategoryMsg;
	}
	public void setVehiclecategoryMsg(String vehiclecategoryMsg) {
		this.vehiclecategoryMsg = vehiclecategoryMsg;
	}
	public String getRelatedtypeMsg() {
		return relatedtypeMsg;
	}
	public void setRelatedtypeMsg(String relatedtypeMsg) {
		this.relatedtypeMsg = relatedtypeMsg;
	}
	public String getFilenames() {
		return filenames;
	}
	public void setFilenames(String filenames) {
		this.filenames = filenames;
	}
	public String getIdentificationCode() {
		return identificationCode;
	}
	public void setIdentificationCode(String identificationCode) {
		this.identificationCode = identificationCode;
	}
	public String getCnameSearch() {
		return cnameSearch;
	}
	public void setCnameSearch(String cnameSearch) {
		this.cnameSearch = cnameSearch;
	}
	
}

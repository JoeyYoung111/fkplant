package com.szrj.business.model.personel;

public class CustomLabel {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personlabel;//人员类型标签
	private int parentid;//父节点
	private String customlabel;//自定义标签
	private String labledescription;//自定义标签描述
	private int validflag;//状态标识
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String personlabelname;//人员类型名称
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonlabel() {
		return personlabel;
	}
	public void setPersonlabel(int personlabel) {
		this.personlabel = personlabel;
	}
	
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getCustomlabel() {
		return customlabel;
	}
	public void setCustomlabel(String customlabel) {
		this.customlabel = customlabel;
	}
	public String getLabledescription() {
		return labledescription;
	}
	public void setLabledescription(String labledescription) {
		this.labledescription = labledescription;
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
	public String getPersonlabelname() {
		return personlabelname;
	}
	public void setPersonlabelname(String personlabelname) {
		this.personlabelname = personlabelname;
	}
	
	
}

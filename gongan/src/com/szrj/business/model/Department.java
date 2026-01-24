package com.szrj.business.model;

public class Department {
private int id;
private String departname;
private String lingwuid;//领悟接口部门id
private String departcode;         
private String departtype;
private int parentid;
private int validflag;
private String addoperator;
private String addtime;
private String updateoperator;
private String updatetime;
private String memo;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getDepartname() {
	return departname;
}
public void setDepartname(String departname) {
	this.departname = departname;
}
public String getDeparttype() {
	return departtype;
}
public void setDeparttype(String departtype) {
	this.departtype = departtype;
}
public int getParentid() {
	return parentid;
}
public void setParentid(int parentid) {
	this.parentid = parentid;
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
public String getDepartcode() {
	return departcode;
}
public void setDepartcode(String departcode) {
	this.departcode = departcode;
}
public String getLingwuid() {
	return lingwuid;
}
public void setLingwuid(String lingwuid) {
	this.lingwuid = lingwuid;
}



}

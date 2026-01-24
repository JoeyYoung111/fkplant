package com.szrj.business.model;

public class BasicType {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//id	
	private String basicTypeName;//数据字典名称
	private int isexternal;//是否存在外联，0-不存在 1-存在
	private int externalid;//外联基础数据类型
	private int istree;
	private int validflag;//状态标识 0：作废 1：正常
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String memo;//备注信息
	private int parentid;//父节点
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String basicTypeName1;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBasicTypeName() {
		return basicTypeName;
	}
	public void setBasicTypeName(String basicTypeName) {
		this.basicTypeName = basicTypeName;
	}
	public int getIsexternal() {
		return isexternal;
	}
	public void setIsexternal(int isexternal) {
		this.isexternal = isexternal;
	}
	public int getExternalid() {
		return externalid;
	}
	public void setExternalid(int externalid) {
		this.externalid = externalid;
	}
	
	public int getIstree() {
		return istree;
	}
	public void setIstree(int istree) {
		this.istree = istree;
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
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getBasicTypeName1() {
		return basicTypeName1;
	}
	public void setBasicTypeName1(String basicTypeName1) {
		this.basicTypeName1 = basicTypeName1;
	}
	
}

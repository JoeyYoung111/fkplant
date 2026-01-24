package com.szrj.business.model;

public class BasicMsg {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int    id;					//id
	private String basicName;			//数据名称
	private int    validflag;			//状态标识 0：作废 1：正常
	private String addoperator;			//添加人
	private String addtime;				//添加时间
	private String memo;				//备注信息
	private int    basicType;			//数据类型
	private int    parentid;		    //父节点
	private int    sort;				//排序编号
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String parentName;			//父节点名称
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBasicType() {
		return basicType;
	}
	public void setBasicType(int basicType) {
		this.basicType = basicType;
	}
	public String getBasicName() {
		return basicName;
	}
	public void setBasicName(String basicName) {
		this.basicName = basicName;
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
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
}

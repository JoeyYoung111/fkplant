package com.szrj.business.model;

/**
 * APP按钮表
 * @author lt
 */
public class AppButton {
	/*---------------------数据库中字段--------------------------------*/
	private int id;				//ID
	private String btnname;		//按钮名称
	private String icon;		//按钮图标
	private int parentid;		//父按钮ID
	private int orderno;		//显示顺序
	private int btntype;		//按钮类型（1：主按钮，2：子按钮）
	private int validflag;		//状态标识
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	/*---------------------非数据库中字段------------------------------*/
	private String parentname;	//主按钮名称
	private int roleId;			//用户id
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBtnname() {
		return btnname;
	}
	public void setBtnname(String btnname) {
		this.btnname = btnname;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public int getBtntype() {
		return btntype;
	}
	public void setBtntype(int btntype) {
		this.btntype = btntype;
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
	public String getParentname() {
		return parentname;
	}
	public void setParentname(String parentname) {
		this.parentname = parentname;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
}

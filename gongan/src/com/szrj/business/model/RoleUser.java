package com.szrj.business.model;
/**
 *
 *@author 作者：wangting
 *@version 创建时间：Feb 26, 2020  1:35:45 PM
 * 类说明
 */
public class RoleUser {
	/*---------------------数据库中字段--------------------------------*/
	private int id;			//ID
	private int roleid;		//角色ID
	private int userid;		//账号ID
	private String addoperator;			//操作人
	private String addtime;		//操作时间
	private int validflag;	//标识状态
	private String memo;		//备注信息
	/*---------------------非数据库中字段------------------------------*/
	private int departmentid;	//部门id
	private int	townshipid;		//乡镇id
	private int	userFlag;		//馆内/外
	private String userName;   //账号名称
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
	}
	public int getTownshipid() {
		return townshipid;
	}
	public void setTownshipid(int townshipid) {
		this.townshipid = townshipid;
	}
	public int getUserFlag() {
		return userFlag;
	}
	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}


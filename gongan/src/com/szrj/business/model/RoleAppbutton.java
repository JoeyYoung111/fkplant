package com.szrj.business.model;

/**
 * 角色移动端按钮表 sys_role_appbutton_t
 * @author lt
 *
 */
public class RoleAppbutton {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int roleid;				//角色ID
	private String appbuttonIds;	//菜单ID
	private String addoperator;		//操作人
	private String addtime;			//操作时间
	private int validflag;			//标识状态
	private String memo;			//备注信息
	/*---------------------非数据库中字段------------------------------*/
	private String buttonsName;		//按钮名称
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
	public String getAppbuttonIds() {
		return appbuttonIds;
	}
	public void setAppbuttonIds(String appbuttonIds) {
		this.appbuttonIds = appbuttonIds;
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
	public String getButtonsName() {
		return buttonsName;
	}
	public void setButtonsName(String buttonsName) {
		this.buttonsName = buttonsName;
	}
	
}

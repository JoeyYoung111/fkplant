package com.szrj.business.model;

/**
 * 角色菜单表 sys_role_menu_t
 * @author wangting
 *
 */
public class RoleMenu {
	/*---------------------数据库中字段--------------------------------*/
	private int id;			//ID
	private int roleid;		//角色ID
	private int menuid;		//菜单ID
	private String addoperator;			//操作人
	private String addtime;		//操作时间
	private int validflag;	//标识状态
	private String memo;		//备注信息
	private String buttons;     //按钮管理
	/*---------------------非数据库中字段------------------------------*/
	private String menuName;//菜单名称
	private int parentId;	//父菜单ID
	private String button;   //菜单中按钮管理
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
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
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
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getButtons() {
		return buttons;
	}
	public void setButtons(String buttons) {
		this.buttons = buttons;
	}
	public String getButton() {
		return button;
	}
	public void setButton(String button) {
		this.button = button;
	}
	
}

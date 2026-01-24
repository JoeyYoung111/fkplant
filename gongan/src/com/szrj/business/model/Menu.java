package com.szrj.business.model;

import java.util.List;

import javax.swing.Spring;

/**
 * 菜单表
 * @author xuxj
 */
public class Menu {
	/*---------------------数据库中字段--------------------------------*/
	private int id;				//ID
	private String menuname;	//菜单名称
	private int parentid;		//父菜单ID
	private String url;			//菜单URL
	private int orderno;		//显示顺序
	private int menutype;		//菜单类型（1：主菜单，2：子菜单）
	private int validflag;		//状态标识
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String icon;
	private String buttons;     //按钮管理
	/*---------------------非数据库中字段------------------------------*/
	private String parentname;	//主菜单名称
	private String bnname;		//功能按钮名称
	private List<Menu>sublist;	//主菜单下的子菜单
	private int roleid;			//菜单所属角色
	private List<RoleMenu>ziList;////主菜单下的子菜单权限
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public int getMenutype() {
		return menutype;
	}
	public void setMenutype(int menutype) {
		this.menutype = menutype;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	
	public String getParentname() {
		return parentname;
	}
	public void setParentname(String parentname) {
		this.parentname = parentname;
	}
	public String getBnname() {
		return bnname;
	}
	public void setBnname(String bnname) {
		this.bnname = bnname;
	}
	public List<Menu> getSublist() {
		return sublist;
	}
	public void setSublist(List<Menu> sublist) {
		this.sublist = sublist;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public List<RoleMenu> getZiList() {
		return ziList;
	}
	public void setZiList(List<RoleMenu> ziList) {
		this.ziList = ziList;
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
	public String getButtons() {
		return buttons;
	}
	public void setButtons(String buttons) {
		this.buttons = buttons;
	}
	
}

package com.szrj.business.model.sysapp;

//首页消息提醒
public class MessageRemind {
	private String messagecontent;
	/*---------------------查询条件-------------------------------*/
	private int departmentid;				//部门id
	private int addoperatorid;
	private int isCheck;					//是否有审核权限
	/*---------------------get/set方法-------------------------------*/
	public String getMessagecontent() {
		return messagecontent;
	}
	public void setMessagecontent(String messagecontent) {
		this.messagecontent = messagecontent;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
	}
	public int getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(int isCheck) {
		this.isCheck = isCheck;
	}
	
}

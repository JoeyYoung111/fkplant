package com.szrj.business.model.mobileInterface;
/**
 *@author:lt
 */
public class TestUserinfo {
	/*---------------------数据库中字段--------------------------------*/
	private int    id; 							//id
	private String username;					//用户名
	private String remark;						//备注
	/*---------------------非数据库中字段------------------------------*/
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}

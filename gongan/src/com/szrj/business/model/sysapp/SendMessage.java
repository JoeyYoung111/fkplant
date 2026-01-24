package com.szrj.business.model.sysapp;
/**
 * 发送短信
 * @author lt
 */

public class SendMessage {
	/*---------------------数据库中字段--------------------------------*/
	private Integer id;				//ID
	private int smstype;			//短信发送类型(1-模板发送 2-自定义发送)
	private String smstext;			//短信内容
	private int sendFlag;			//发送给（1-单位 2-个人）
	private String receiveids;		//接收单位或个人id
	private String sendtime;		//发送时间
	private String sendoperator;	//发送人
	private int sendoperatorid;		//发送人id
	/*---------------------非数据库中字段------------------------------*/
	private String usernames;		//接收个人名
	private String departnames;		//接收部门名
	/*---------------------get/set方法-------------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public int getSmstype() {
		return smstype;
	}
	public void setSmstype(int smstype) {
		this.smstype = smstype;
	}
	public String getSmstext() {
		return smstext;
	}
	public void setSmstext(String smstext) {
		this.smstext = smstext;
	}
	public int getSendFlag() {
		return sendFlag;
	}
	public void setSendFlag(int sendFlag) {
		this.sendFlag = sendFlag;
	}
	public String getReceiveids() {
		return receiveids;
	}
	public void setReceiveids(String receiveids) {
		this.receiveids = receiveids;
	}
	public String getSendtime() {
		return sendtime;
	}
	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}
	public String getSendoperator() {
		return sendoperator;
	}
	public void setSendoperator(String sendoperator) {
		this.sendoperator = sendoperator;
	}
	public int getSendoperatorid() {
		return sendoperatorid;
	}
	public void setSendoperatorid(int sendoperatorid) {
		this.sendoperatorid = sendoperatorid;
	}
	public String getUsernames() {
		return usernames;
	}
	public void setUsernames(String usernames) {
		this.usernames = usernames;
	}
	public String getDepartnames() {
		return departnames;
	}
	public void setDepartnames(String departnames) {
		this.departnames = departnames;
	}
}

package com.szrj.business.model.sysapp;
/**
 * 发送短信日志
 * @author lt
 */

public class SendMessageLog {
	/*---------------------数据库中字段--------------------------------*/
	private Integer id;				//ID
	private int sendmessageid;		//发送短信id
	private String sendperson;		//发送人
	private String sendtime;		//发送时间
	private int sendflag;			//是否发送成功（0-未发送 1-已发送）
	/*---------------------非数据库中字段------------------------------*/
	private String smstype;			//短信发送类型
	private String smstext;			//短信内容
	/*---------------------get/set方法-------------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public int getSendmessageid() {
		return sendmessageid;
	}
	public void setSendmessageid(int sendmessageid) {
		this.sendmessageid = sendmessageid;
	}
	public String getSendperson() {
		return sendperson;
	}
	public void setSendperson(String sendperson) {
		this.sendperson = sendperson;
	}
	public String getSendtime() {
		return sendtime;
	}
	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}
	public int getSendflag() {
		return sendflag;
	}
	public void setSendflag(int sendflag) {
		this.sendflag = sendflag;
	}
	public String getSmstype() {
		return smstype;
	}
	public void setSmstype(String smstype) {
		this.smstype = smstype;
	}
	public String getSmstext() {
		return smstext;
	}
	public void setSmstext(String smstext) {
		this.smstext = smstext;
	}
}

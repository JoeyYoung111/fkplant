package com.szrj.business.model;

public class ZdRole {
	/*---------------------数据库中字段--------------------------------*/
	private int id;				//ID
	private int xtjzdid;		//巡特警中队id
	private int pcsid;			//派出所id
	private int validflag;		//删除标志
	/*---------------------非数据库中字段------------------------------*/
	private String xtjzdname;	//巡特警中队名称
	private String pcsname;		//派出所名称
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getXtjzdid() {
		return xtjzdid;
	}
	public void setXtjzdid(int xtjzdid) {
		this.xtjzdid = xtjzdid;
	}
	public int getPcsid() {
		return pcsid;
	}
	public void setPcsid(int pcsid) {
		this.pcsid = pcsid;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getXtjzdname() {
		return xtjzdname;
	}
	public void setXtjzdname(String xtjzdname) {
		this.xtjzdname = xtjzdname;
	}
	public String getPcsname() {
		return pcsname;
	}
	public void setPcsname(String pcsname) {
		this.pcsname = pcsname;
	}
}

package com.szrj.business.model.event;

public class AuditRecord {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private String examineman;		//审核人
	private String examinetime;		//审核时间
	private String examineopinion;	//审核反馈意见
	private String result;			//审核结果
	/*---------------------非数据库中字段------------------------------*/
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCdtid() {
		return cdtid;
	}
	public void setCdtid(int cdtid) {
		this.cdtid = cdtid;
	}
	public String getExamineman() {
		return examineman;
	}
	public void setExamineman(String examineman) {
		this.examineman = examineman;
	}
	public String getExaminetime() {
		return examinetime;
	}
	public void setExaminetime(String examinetime) {
		this.examinetime = examinetime;
	}
	public String getExamineopinion() {
		return examineopinion;
	}
	public void setExamineopinion(String examineopinion) {
		this.examineopinion = examineopinion;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
}

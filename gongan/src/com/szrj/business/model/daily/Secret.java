package com.szrj.business.model.daily;

public class Secret {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id; 
	private String secret_text;//保密内容
	private int validflag;//状态标识   1：正常 0:作废 
	private String addoperator;//添加人 
	private String addtime;//添加时间 
	private String updateoperator;//最新修改人 
	private String updatetime;//最新修改时间 
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSecret_text() {
		return secret_text;
	}
	public void setSecret_text(String secret_text) {
		this.secret_text = secret_text;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
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
	public String getUpdateoperator() {
		return updateoperator;
	}
	public void setUpdateoperator(String updateoperator) {
		this.updateoperator = updateoperator;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}

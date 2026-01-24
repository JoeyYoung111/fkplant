package com.szrj.business.model.personel;

public class KongPublicRelation {
	private int id;
	private int controlpowerid;//人员主表id
	private int relationtype;//关系类型1-家庭关系2-社会关系
	private String appellation;//称谓
	private String relationname;//姓名
	private String politicalposition;//政治表现
	private String workdetails;//现在工作地点、部门及职务
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getControlpowerid() {
		return controlpowerid;
	}
	public void setControlpowerid(int controlpowerid) {
		this.controlpowerid = controlpowerid;
	}
	public int getRelationtype() {
		return relationtype;
	}
	public void setRelationtype(int relationtype) {
		this.relationtype = relationtype;
	}
	public String getAppellation() {
		return appellation;
	}
	public void setAppellation(String appellation) {
		this.appellation = appellation;
	}
	public String getRelationname() {
		return relationname;
	}
	public void setRelationname(String relationname) {
		this.relationname = relationname;
	}
	public String getPoliticalposition() {
		return politicalposition;
	}
	public void setPoliticalposition(String politicalposition) {
		this.politicalposition = politicalposition;
	}
	public String getWorkdetails() {
		return workdetails;
	}
	public void setWorkdetails(String workdetails) {
		this.workdetails = workdetails;
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

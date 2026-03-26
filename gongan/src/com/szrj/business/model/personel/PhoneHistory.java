package com.szrj.business.model.personel;

/**
 * 电话号码历史记录表 (p_phonenum_history_t)
 */
public class PhoneHistory {
	private int id;
	private int personnelid;		//关联人员ID
	private String phone;			//电话号码
	private String phoneType;		//号码类型(手机/座机)
	private String operator;		//运营商
	private String startDate;		//开始使用时间
	private String endDate;			//结束使用时间
	private int validflag;			//状态 1有效 0无效
	private String addoperator;		//添加人
	private String addtime;			//添加时间

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhoneType() {
		return phoneType;
	}
	public void setPhoneType(String phoneType) {
		this.phoneType = phoneType;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
}


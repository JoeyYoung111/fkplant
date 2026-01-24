package com.szrj.business.model.personel;

public class PersonLabel {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private String personlabel;//人员类型标签
	private String attributelabels;//人员属性标签id拼接
	private int validflag;//状态标识
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
	public String getPersonlabel() {
		return personlabel;
	}
	public void setPersonlabel(String personlabel) {
		this.personlabel = personlabel;
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
	public String getAttributelabels() {
		return attributelabels;
	}
	public void setAttributelabels(String attributelabels) {
		this.attributelabels = attributelabels;
	}
	
	
}

package com.szrj.business.model.personel;

public class AttributeLabel {
	private int id;
	private String attributelabel;//属性标签描述
	private int parentid;//父节点
	private int rootid;//根节点id
	private int examineflag;//审核标记 0-未审核 1-审核通过 2-审核不通过
	private String failreason;//审核不通过理由
	private String departmentid;//责任审核部门id  一级标签必选
	private String departname;//责任审核部门名称
	private int validflag;//状态标识
	private int adddepartmentid;//添加部门id
	private int addoperatorid;//添加人id
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String examineman;//审核人
	private String examinetime;//审核时间
	private String memo;//备注信息
	
	private String ids;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getAttributelabel() {
		return attributelabel;
	}
	public void setAttributelabel(String attributelabel) {
		this.attributelabel = attributelabel;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	

	public int getAdddepartmentid() {
		return adddepartmentid;
	}
	public void setAdddepartmentid(int adddepartmentid) {
		this.adddepartmentid = adddepartmentid;
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
	public int getExamineflag() {
		return examineflag;
	}
	public void setExamineflag(int examineflag) {
		this.examineflag = examineflag;
	}
	public String getFailreason() {
		return failreason;
	}
	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}


	public String getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(String departmentid) {
		this.departmentid = departmentid;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	
}

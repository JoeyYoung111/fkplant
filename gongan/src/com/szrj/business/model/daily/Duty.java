package com.szrj.business.model.daily;

public class Duty {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id; 
	private int departid;//部门id 
	private String departname;//部门名称 
	private String dp_leader;//扎口组织督导所领导 
	private String kong_leader;//反恐工作-分管领导 
	private String kong_police;//反恐工作-社区民警 
	private String wen_leader;//涉稳风险人员、事件管控工作-分管领导 
	private String wen_police;//涉稳风险人员、事件管控工作-社区民警 
	private String wen_fu_police;//涉稳风险人员、事件管控工作-岗位辅警 
	private String du_leader;//禁毒工作-分管领导 
	private String du_fu_police;//禁毒工作-岗位辅警 
	private int validflag;//状态标识   1：正常 0:作废 
	private String addoperator;//添加人 
	private String addtime;//添加时间 
	private String updateoperator;//最新修改人 
	private String updatetime;//最新修改时间 
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String field;
	private String fieldString;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDepartid() {
		return departid;
	}
	public void setDepartid(int departid) {
		this.departid = departid;
	}
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}
	public String getDp_leader() {
		return dp_leader;
	}
	public void setDp_leader(String dp_leader) {
		this.dp_leader = dp_leader;
	}
	public String getKong_leader() {
		return kong_leader;
	}
	public void setKong_leader(String kong_leader) {
		this.kong_leader = kong_leader;
	}
	public String getKong_police() {
		return kong_police;
	}
	public void setKong_police(String kong_police) {
		this.kong_police = kong_police;
	}
	public String getWen_leader() {
		return wen_leader;
	}
	public void setWen_leader(String wen_leader) {
		this.wen_leader = wen_leader;
	}
	public String getWen_police() {
		return wen_police;
	}
	public void setWen_police(String wen_police) {
		this.wen_police = wen_police;
	}
	public String getWen_fu_police() {
		return wen_fu_police;
	}
	public void setWen_fu_police(String wen_fu_police) {
		this.wen_fu_police = wen_fu_police;
	}
	public String getDu_leader() {
		return du_leader;
	}
	public void setDu_leader(String du_leader) {
		this.du_leader = du_leader;
	}
	public String getDu_fu_police() {
		return du_fu_police;
	}
	public void setDu_fu_police(String du_fu_police) {
		this.du_fu_police = du_fu_police;
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
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getFieldString() {
		return fieldString;
	}
	public void setFieldString(String fieldString) {
		this.fieldString = fieldString;
	}
	
}

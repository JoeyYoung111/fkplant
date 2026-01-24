package com.szrj.business.model.personel;

public class HeiEditor {
	private int id;
	private int personnelid;
	private int incontrolleve; //在控状态1-关注中 2-已打击
	private String editableid;
	private String editablename;
	private int validflag;
	private String addoperator;
	private int addoperatorid;
	private int departmentid;
	private String addtime;
	private String updateoperator;
	private String updatetime;
	private String memo;
	
	private String heieditorid;//临时存放数据id
	private String editableid1;//新增可编辑人id
	private String editablename1;//新增可编辑人name
	
	
	//导出类
	private Personnel exportPersonnel=new Personnel();
	private Relation exportRelation=new Relation();
	private RealityShow exportRealityShow=new RealityShow();
	
	public String getEditableid1() {
		return editableid1;
	}
	public void setEditableid1(String editableid1) {
		this.editableid1 = editableid1;
	}
	public String getEditablename1() {
		return editablename1;
	}
	public void setEditablename1(String editablename1) {
		this.editablename1 = editablename1;
	}
	public String getHeieditorid() {
		return heieditorid;
	}
	public void setHeieditorid(String heieditorid) {
		this.heieditorid = heieditorid;
	}
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
	public int getIncontrolleve() {
		return incontrolleve;
	}
	public void setIncontrolleve(int incontrolleve) {
		this.incontrolleve = incontrolleve;
	}
	public String getEditableid() {
		return editableid;
	}
	public void setEditableid(String editableid) {
		this.editableid = editableid;
	}
	public String getEditablename() {
		return editablename;
	}
	public void setEditablename(String editablename) {
		this.editablename = editablename;
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
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public Personnel getExportPersonnel() {
		return exportPersonnel;
	}
	public void setExportPersonnel(Personnel exportPersonnel) {
		this.exportPersonnel = exportPersonnel;
	}
	public Relation getExportRelation() {
		return exportRelation;
	}
	public void setExportRelation(Relation exportRelation) {
		this.exportRelation = exportRelation;
	}
	public RealityShow getExportRealityShow() {
		return exportRealityShow;
	}
	public void setExportRealityShow(RealityShow exportRealityShow) {
		this.exportRealityShow = exportRealityShow;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
	}
	
	
	
}

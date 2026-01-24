package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *风险人员基本信息主表-照片 p_personnel_photo_t
 */
public class PersonnelPhoto {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private int fileid;//照片附件id
	private int defaultflag;//是否默认  0-否 1-是
	private int validflag;//状态标识 1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String fileName;		//文件名称
	private String fileallName;		//文件全名
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
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
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public int getDefaultflag() {
		return defaultflag;
	}
	public void setDefaultflag(int defaultflag) {
		this.defaultflag = defaultflag;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileallName() {
		return fileallName;
	}
	public void setFileallName(String fileallName) {
		this.fileallName = fileallName;
	}
	
}

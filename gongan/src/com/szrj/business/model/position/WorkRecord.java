package com.szrj.business.model.position;

/**
 * @author huaxia
 *	a_work_record_t 民警工作记载
 */
public class WorkRecord {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private String recordtype;//记载类型
	private int recordid;//记载id
	private String worktype;//工作方式
	private String worktime;//工作时间
	private String workplace;//工作地点
	private String workrecord;//工作记录
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息

	private String fileattachments;//文件附件

	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String file_ids;//文件附件对应id
	private String filesname;//文件附件名称

	private String filesaddtime;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRecordtype() {
		return recordtype;
	}
	public void setRecordtype(String recordtype) {
		this.recordtype = recordtype;
	}
	public int getRecordid() {
		return recordid;
	}
	public void setRecordid(int recordid) {
		this.recordid = recordid;
	}
	public String getWorktype() {
		return worktype;
	}
	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}
	public String getWorktime() {
		return worktime;
	}
	public void setWorktime(String worktime) {
		this.worktime = worktime;
	}
	public String getWorkplace() {
		return workplace;
	}
	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}
	public String getWorkrecord() {
		return workrecord;
	}
	public void setWorkrecord(String workrecord) {
		this.workrecord = workrecord;
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
	
	public String getFileattachments() {
		return fileattachments;
	}
	
	public void setFileattachments(String fileattachments) {
		this.fileattachments = fileattachments;
	}
	
	public String getFilesname() {
		return filesname;
	}
	
	public void setFilesname(String filesname) {
		this.filesname = filesname;
	}
	
	public String getFilesaddtime() {
		return filesaddtime;
	}
	
	public void setFilesaddtime(String filesaddtime) {
		this.filesaddtime = filesaddtime;
	}

	public String getFile_ids() {
		return file_ids;
	}

	public void setFile_ids(String file_ids) {
		this.file_ids = file_ids;
	}


}

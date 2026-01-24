package com.szrj.business.model;

/**
 * 文件表
 * @author xuxj
 */
public class File {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private String fileName;		//文件名称
	private String fileallName;		//文件全名
	private int validflag;			//状态标识
	private String addOperator;		//操作人
	private String addTime;	//操作时间
	/*---------------------非数据库中字段------------------------------*/
	private String fileattachments;
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getAddOperator() {
		return addOperator;
	}
	public void setAddOperator(String addOperator) {
		this.addOperator = addOperator;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getFileattachments() {
		return fileattachments;
	}
	public void setFileattachments(String fileattachments) {
		this.fileattachments = fileattachments;
	}
	
	
}

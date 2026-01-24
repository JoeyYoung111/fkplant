package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *风险背景子表-涉稳 p_wen_risk_t
 */
public class WenRisk {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID 
	private int personnelid;//人员主表id 
	private String conflictdetails;//矛盾风险产生的经过、详情 
	private String riskappeal;//目前风险状态及人员诉求 
	private String fileattachments;//文件附件 
	private String videoattachments;//视频附件 
	private int validflag;//状态标识   1：正常 0:作废 
	private String addoperator;//添加人 
	private String addtime;//添加时间 
	private String updateoperator;//最新修改人 
	private String updatetime;//最新修改时间 
	private String memo;//备注信息 
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String filesname;//文件附件名称
	private String videosname;//视频附件名称
	private String videosallname;//视频附件全名称
	private String filesaddtime;
	private String videosaddtime;
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
	public String getConflictdetails() {
		return conflictdetails;
	}
	public void setConflictdetails(String conflictdetails) {
		this.conflictdetails = conflictdetails;
	}
	public String getRiskappeal() {
		return riskappeal;
	}
	public void setRiskappeal(String riskappeal) {
		this.riskappeal = riskappeal;
	}
	public String getFileattachments() {
		return fileattachments;
	}
	public void setFileattachments(String fileattachments) {
		this.fileattachments = fileattachments;
	}
	public String getVideoattachments() {
		return videoattachments;
	}
	public void setVideoattachments(String videoattachments) {
		this.videoattachments = videoattachments;
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
	public String getFilesname() {
		return filesname;
	}
	public void setFilesname(String filesname) {
		this.filesname = filesname;
	}
	public String getVideosname() {
		return videosname;
	}
	public void setVideosname(String videosname) {
		this.videosname = videosname;
	}
	public String getVideosallname() {
		return videosallname;
	}
	public void setVideosallname(String videosallname) {
		this.videosallname = videosallname;
	}
	public String getFilesaddtime() {
		return filesaddtime;
	}
	public void setFilesaddtime(String filesaddtime) {
		this.filesaddtime = filesaddtime;
	}
	public String getVideosaddtime() {
		return videosaddtime;
	}
	public void setVideosaddtime(String videosaddtime) {
		this.videosaddtime = videosaddtime;
	}
	
}

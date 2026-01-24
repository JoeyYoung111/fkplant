package com.szrj.business.model.sysapp;
/**
 * 通知公告表
 * @author lt
 */

public class Notice {
	/*---------------------数据库中字段--------------------------------*/
	private Integer id;				//ID
	private String noticetype;		//类型（通知、公告、知识）
	private String noticetitle;		//标题
	private String noticetext;		//通知内容
	private String attachments;		//通知附件
	private String departids;		//发送部门id
	private int validflag;			//状态标识
	private int addoperatorid;		//添加人id
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	/*---------------------非数据库中字段------------------------------*/
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	private String departnames;		//发送部门名s
	/*---------------------get/set方法-------------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNoticetype() {
		return noticetype;
	}
	public void setNoticetype(String noticetype) {
		this.noticetype = noticetype;
	}
	public String getNoticetitle() {
		return noticetitle;
	}
	public void setNoticetitle(String noticetitle) {
		this.noticetitle = noticetitle;
	}
	public String getNoticetext() {
		return noticetext;
	}
	public void setNoticetext(String noticetext) {
		this.noticetext = noticetext;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
	}
	public String getDepartids() {
		return departids;
	}
	public void setDepartids(String departids) {
		this.departids = departids;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public String getFileids() {
		return fileids;
	}
	public void setFileids(String fileids) {
		this.fileids = fileids;
	}
	public String getFilenames() {
		return filenames;
	}
	public void setFilenames(String filenames) {
		this.filenames = filenames;
	}
	public String getDepartnames() {
		return departnames;
	}
	public void setDepartnames(String departnames) {
		this.departnames = departnames;
	}
}

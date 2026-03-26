package com.szrj.business.model.sysapp;

//首页消息提醒
public class MessageRemind {
	private Integer id;						//消息ID（来自p_case_police_message_t.id，用于删除时更新read_flag）
	private Integer personnelid;			//人员ID（来自p_case_police_message_t.personnelid）
	private String messageType;				//消息类型（'aj'-案件，'jj'-警情，其他消息类型为null）
	private String messagecontent;
	/*---------------------查询条件-------------------------------*/
	private int departmentid;				//部门id
	private int addoperatorid;
	private int isCheck;					//是否有审核权限
	private int casePoliceReadFlag;			//案件警情已读标志 0-未读 1-已读
	private String lastReadTime;			//最后已读时间
	/*---------------------get/set方法-------------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(Integer personnelid) {
		this.personnelid = personnelid;
	}
	public String getMessageType() {
		return messageType;
	}
	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}
	public String getMessagecontent() {
		return messagecontent;
	}
	public void setMessagecontent(String messagecontent) {
		this.messagecontent = messagecontent;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
	}
	public int getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(int isCheck) {
		this.isCheck = isCheck;
	}
	public int getCasePoliceReadFlag() {
		return casePoliceReadFlag;
	}
	public void setCasePoliceReadFlag(int casePoliceReadFlag) {
		this.casePoliceReadFlag = casePoliceReadFlag;
	}
	public String getLastReadTime() {
		return lastReadTime;
	}
	public void setLastReadTime(String lastReadTime) {
		this.lastReadTime = lastReadTime;
	}

}

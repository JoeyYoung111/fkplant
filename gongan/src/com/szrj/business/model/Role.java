package com.szrj.business.model;

/**
 * 角色表 sys_role_t
 * @author wangting
 *
 */
public class Role {
	/*---------------------数据库中字段--------------------------------*/
	private int id;						//ID
	private String rolename;			//角色名称
	private int msgFilter;//数据过滤 是/否
	private int fieldFilter;//0-全部 1-派出所 2-民警
	private int validflag;				//标识状态
	private String addoperator;			//操作人
	private String addtime;		//操作时间
	private String memo;
	private int eventFilter;
	/*---------------------非数据库中字段------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	
	public int getMsgFilter() {
		return msgFilter;
	}
	public void setMsgFilter(int msgFilter) {
		this.msgFilter = msgFilter;
	}
	public int getFieldFilter() {
		return fieldFilter;
	}
	public void setFieldFilter(int fieldFilter) {
		this.fieldFilter = fieldFilter;
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
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getEventFilter() {
		return eventFilter;
	}
	public void setEventFilter(int eventFilter) {
		this.eventFilter = eventFilter;
	}
	
}

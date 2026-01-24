package com.szrj.business.model;

/**
 * 用户表 sys_user_t
 * @author wangting
 */
public class User {
	/*-------------------------数据库中字段----------------------------------------------------*/
	private int    id;					//ID
	
	private String usercode;			//登录账号
    private String userpassword;		//密码
    private String staffName;			//用户名称
    private String sexes;//性别
    private String cardnumber;//身份证号
    private String alarmsignal;//警号
    private String contactnumber;//联系电话
    private int    roleid;              //关联角色表
    private int    departmentid;		//部门id 
    private int    before_departmentid;	//用户之前部门
	private String dpName;              //部门名称
    private int    validflag;			//标识状态 0：作废 
	private String addoperator;			//添加人
	private String addtime;				//添加时间
	private String memo;				//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private int msgFilter;//数据过滤 是/否
	private int fieldFilter;//0-全部 1-派出所 2-民警
	private String departname;
	private String rolename;
	private int roleuserId;				//role_user表的id
	private int eventFilter;
	private String departcode;			//部门编码
	/*-----------------------------------------get/set方法------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getUserpassword() {
		return userpassword;
	}
	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getAlarmsignal() {
		return alarmsignal;
	}
	public void setAlarmsignal(String alarmsignal) {
		this.alarmsignal = alarmsignal;
	}
	public String getContactnumber() {
		return contactnumber;
	}
	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
	}
	public String getDpName() {
		return dpName;
	}
	public void setDpName(String dpName) {
		this.dpName = dpName;
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
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public int getEventFilter() {
		return eventFilter;
	}
	public void setEventFilter(int eventFilter) {
		this.eventFilter = eventFilter;
	}
	public int getBefore_departmentid() {
		return before_departmentid;
	}
	public void setBefore_departmentid(int before_departmentid) {
		this.before_departmentid = before_departmentid;
	}
	public int getRoleuserId() {
		return roleuserId;
	}
	public void setRoleuserId(int roleuserId) {
		this.roleuserId = roleuserId;
	}
	public String getDepartcode() {
		return departcode;
	}
	public void setDepartcode(String departcode) {
		this.departcode = departcode;
	}
	
}
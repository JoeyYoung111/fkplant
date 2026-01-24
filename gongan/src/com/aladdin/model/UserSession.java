package com.aladdin.model;

public class UserSession{
	/*---------------------UserSession包含的参数（注意：最好要保证下面的参数都是整个系统唯一的参数名）--------------------------------*/
	private int loginUserID;
    private String loginUserCode;
    private String loginUserName;
    private int loginUserRoleid;
    private int loginUserDepartmentid;
    private String loginUserDepartname;
    private int loginRoleMsgFilter;
    private int loginRoleFieldFilter;
    private String loginContactnumber;
    private int loginRoleEventFilter;
    private String loginUserCardnumber;
    private String loginPoliceCode;
    private String loginDepartcode;
    /*---------------------构造函数（用于封装UserSession的值）--------------------------------*/
    //账号id、账号、姓名、角色id、部门id、部门名称、角色数据过滤（是/否）、数据过滤字段、手机号
    public UserSession(int loginUserID, String loginUserCode, String loginUserName,int loginUserRoleid,int loginUserDepartmentid, String loginUserDepartname,int loginRoleMsgFilter,int loginRoleFieldFilter,String loginContactnumber,int loginRoleEventFilter,String loginUserCardnumber,String loginPoliceCode,String loginDepartcode) {
        this.loginUserID = loginUserID;
        this.loginUserCode = loginUserCode;
        this.loginUserName = loginUserName;
        this.loginUserRoleid = loginUserRoleid;
        this.loginUserDepartmentid = loginUserDepartmentid;
        this.loginUserDepartname = loginUserDepartname;
        this.loginRoleMsgFilter = loginRoleMsgFilter;
        this.loginRoleFieldFilter = loginRoleFieldFilter;
        this.loginContactnumber=loginContactnumber;
        this.loginRoleEventFilter=loginRoleEventFilter;
        this.loginUserCardnumber=loginUserCardnumber;
        this.loginPoliceCode=loginPoliceCode;
        this.loginDepartcode=loginDepartcode;
    }
    /*---------------------get/set鏂规硶-------------------------------*/
	public int getLoginUserID() {
		return loginUserID;
	}
	public void setLoginUserID(int loginUserID) {
		this.loginUserID = loginUserID;
	}
	
	public String getLoginUserDepartname() {
		return loginUserDepartname;
	}
	public void setLoginUserDepartname(String loginUserDepartname) {
		this.loginUserDepartname = loginUserDepartname;
	}
	public String getLoginUserCode() {
		return loginUserCode;
	}
	public void setLoginUserCode(String loginUserCode) {
		this.loginUserCode = loginUserCode;
	}
	public String getLoginUserName() {
		return loginUserName;
	}
	public int getLoginUserDepartmentid() {
		return loginUserDepartmentid;
	}
	public void setLoginUserDepartmentid(int loginUserDepartmentid) {
		this.loginUserDepartmentid = loginUserDepartmentid;
	}

	public int getLoginRoleMsgFilter() {
		return loginRoleMsgFilter;
	}
	public void setLoginRoleMsgFilter(int loginRoleMsgFilter) {
		this.loginRoleMsgFilter = loginRoleMsgFilter;
	}
	public int getLoginRoleFieldFilter() {
		return loginRoleFieldFilter;
	}
	public void setLoginRoleFieldFilter(int loginRoleFieldFilter) {
		this.loginRoleFieldFilter = loginRoleFieldFilter;
	}
	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}
	public int getLoginUserRoleid() {
		return loginUserRoleid;
	}
	public void setLoginUserRoleid(int loginUserRoleid) {
		this.loginUserRoleid = loginUserRoleid;
	}
	public String getLoginContactnumber() {
		return loginContactnumber;
	}
	public void setLoginContactnumber(String loginContactnumber) {
		this.loginContactnumber = loginContactnumber;
	}
	public int getLoginRoleEventFilter() {
		return loginRoleEventFilter;
	}
	public void setLoginRoleEventFilter(int loginRoleEventFilter) {
		this.loginRoleEventFilter = loginRoleEventFilter;
	}
	public String getLoginUserCardnumber() {
		return loginUserCardnumber;
	}
	public void setLoginUserCardnumber(String loginUserCardnumber) {
		this.loginUserCardnumber = loginUserCardnumber;
	}
	public String getLoginPoliceCode() {
		return loginPoliceCode;
	}
	public void setLoginPoliceCode(String loginPoliceCode) {
		this.loginPoliceCode = loginPoliceCode;
	}
	public String getLoginDepartcode() {
		return loginDepartcode;
	}
	public void setLoginDepartcode(String loginDepartcode) {
		this.loginDepartcode = loginDepartcode;
	}
}

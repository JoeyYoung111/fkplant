package com.aladdin.model;

/**
 * 用户操作日志
 * @author lihao
 *
 */
public class UserActionLog {

	private Long Num_ID;				//32   记录标识
	private String Reg_ID;				//12   应用系统/资源库标识
	private String User_ID;				//18   用户标识
	private String Organization;		//100  单位名称
	private String Organization_ID;		//12  *单位机构代码
	private String User_Name;			//30   用户名
	private String Operate_Time;		//14   操作时间 YYYYMMDDhhmmss，24小时制格式
	private String Terminal_ID;			//40   终端标识
	private int Operate_Type;			//1    操作类型 0:登录 1:查询 2：新增 3：修改 4：删除
	private String Operate_Result;		//1    操作结果 1：成功 0:失败
	private String Error_Code;			//4   *失败原因代码
	private String Operate_Name;		//30  *功能模块名称
	private String Operate_Condition;	//3000 操作条件
	
	public Long getNum_ID() {
		return Num_ID;
	}
	public void setNum_ID(Long num_ID) {
		Num_ID = num_ID;
	}
	public String getReg_ID() {
		return Reg_ID;
	}
	public void setReg_ID(String reg_ID) {
		Reg_ID = reg_ID;
	}
	public String getUser_ID() {
		return User_ID;
	}
	public void setUser_ID(String user_ID) {
		User_ID = user_ID;
	}
	public String getOrganization() {
		return Organization;
	}
	public void setOrganization(String organization) {
		Organization = organization;
	}
	public String getOrganization_ID() {
		return Organization_ID;
	}
	public void setOrganization_ID(String organization_ID) {
		Organization_ID = organization_ID;
	}
	public String getUser_Name() {
		return User_Name;
	}
	public void setUser_Name(String user_Name) {
		User_Name = user_Name;
	}
	public String getOperate_Time() {
		return Operate_Time;
	}
	public void setOperate_Time(String operate_Time) {
		Operate_Time = operate_Time;
	}
	public String getTerminal_ID() {
		return Terminal_ID;
	}
	public void setTerminal_ID(String terminal_ID) {
		Terminal_ID = terminal_ID;
	}
	public int getOperate_Type() {
		return Operate_Type;
	}
	public void setOperate_Type(int operate_Type) {
		Operate_Type = operate_Type;
	}
	public String getOperate_Result() {
		return Operate_Result;
	}
	public void setOperate_Result(String operate_Result) {
		Operate_Result = operate_Result;
	}
	public String getError_Code() {
		return Error_Code;
	}
	public void setError_Code(String error_Code) {
		Error_Code = error_Code;
	}
	public String getOperate_Name() {
		return Operate_Name;
	}
	public void setOperate_Name(String operate_Name) {
		Operate_Name = operate_Name;
	}
	public String getOperate_Condition() {
		return Operate_Condition;
	}
	public void setOperate_Condition(String operate_Condition) {
		Operate_Condition = operate_Condition;
	}
	
}
